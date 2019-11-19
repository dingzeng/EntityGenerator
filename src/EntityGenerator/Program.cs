using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace EntityGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args == null || args.Length < 1 || string.IsNullOrEmpty(args[0]))
            {
                Console.WriteLine("缺少参数");
                return;
            }

            var configFilePath = args[0];
            if (!File.Exists(configFilePath))
            {
                Console.WriteLine("指定的文件不存在");
                return;
            }

            var configContent = File.ReadAllText(configFilePath);
            var options = JsonConvert.DeserializeObject<List<ConnectionInfo>>(configContent);

            Console.WriteLine("开始生成:");
            foreach (var opt in options)
            {
                foreach (var p in opt.Projects)
                {
                    Console.WriteLine($"-----------------Database:{p.Database},Tables:{p.Table}--------------------------------");
                    var tables = GetColumnInfos(opt.Server, opt.Port, opt.UserId, opt.Password, p.Database, p.Table);
                    GenerateEntityFiles(tables, p.Output, p.Namespace);
                    if (!string.IsNullOrEmpty(p.ProtoFile))
                    {
                        GenerateGrpcDTOMessage(tables, p.ProtoFile, p.Namespace);
                    }
                    Console.WriteLine();
                }
            }
            Console.WriteLine("生成完成，按任意键退出...");
            Console.ReadKey();
        }

        private static Dictionary<string, List<ColumnInfo>> GetColumnInfos(string server, int port, string userId, string password, string database, string table)
        {
            var result = new Dictionary<string, List<ColumnInfo>>();

            var connectionString = $"database={database};server={server};uid={userId};pwd={password};port={port};";
            using (IDbConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                string condition = $"WHERE TABLE_SCHEMA = '{database}' ";
                if (!string.IsNullOrEmpty(table) && table != "*")
                {
                    condition += $"AND TABLE_NAME = '{table}'";
                }
                command.CommandText = $"SELECT * FROM `information_schema`.`COLUMNS` {condition} ORDER BY ORDINAL_POSITION";

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var column = new ColumnInfo();
                        column.TableName = Convert.ToString(reader["TABLE_NAME"]);
                        column.ColumnName = Convert.ToString(reader["COLUMN_NAME"]);
                        column.DefaultValue = reader["COLUMN_DEFAULT"];
                        column.IsNullable = Convert.ToString(reader["IS_NULLABLE"]) == "YES";
                        column.IsPrimaryKey = Convert.ToString(reader["COLUMN_KEY"]) == "PRI";
                        if (column.IsPrimaryKey)
                        {
                            column.PrimaryKeyType =
                            Convert.ToString(reader["EXTRA"]) == "auto_increment" ? PrimaryKeyType.AutoIncrement : PrimaryKeyType.ExplicitKey;
                        }
                        else
                        {
                            column.PrimaryKeyType = PrimaryKeyType.Not;
                        }
                        column.DataType = Convert.ToString(reader["DATA_TYPE"]);
                        column.Comment = Convert.ToString(reader["COLUMN_COMMENT"]);


                        if (result.ContainsKey(column.TableName))
                        {
                            result[column.TableName].Add(column);
                        }
                        else
                        {
                            result.Add(column.TableName, new List<ColumnInfo>() { column });
                        }
                    }
                }
            }

            return result;
        }

        private static void GenerateEntityFiles(Dictionary<string, List<ColumnInfo>> tables, string outputPath, string classNamespace)
        {
            foreach (var table in tables)
            {
                var code = GetEntityClassCode(table.Key, classNamespace, table.Value);
                var className = GetClassOrPropertyName(table.Key);

                if (!Directory.Exists(outputPath))
                {
                    Directory.CreateDirectory(outputPath);
                }
                var filename = Path.Combine(outputPath, $"{className}.Generated.cs");
                File.WriteAllText(filename, code);
                Console.WriteLine($"Entity Class: {table.Key}");
            }
        }

        private static void GenerateGrpcDTOMessage(Dictionary<string, List<ColumnInfo>> tables, string outputPath, string csharpNamespace)
        {
            var now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("/*");
            builder.AppendLine("\t本文件代码由代码生成工具自动生成，请不要手动修改");
            builder.AppendLine("\t生成时间：" + now);
            builder.AppendLine("*/");
            builder.AppendLine("syntax = \"proto3\";");
            builder.AppendLine($"option csharp_namespace = \"{csharpNamespace}\";");
            builder.AppendLine();
            foreach (var table in tables)
            {
                var code = GetGrpcMessageCode(table.Key, table.Value);
                builder.AppendLine(code);
                Console.WriteLine($"Grpc Message: {table.Key}");
            }
            File.WriteAllText(outputPath, builder.ToString());
        }

        private static string GetEntityClassCode(string tableName, string classNamespace, List<ColumnInfo> columns)
        {
            var now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string className = GetClassOrPropertyName(tableName);
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("/*");
            builder.AppendLine("\t本文件代码由代码生成工具自动生成，请不要手动修改");
            builder.AppendLine("\t生成时间：" + now);
            builder.AppendLine("*/");

            builder.AppendLine("using System;");
            builder.AppendLine("using Tripod.Framework.DapperExtentions.Attributes;");
            builder.AppendLine("using Tripod.Framework.Common;");
            builder.AppendLine();

            builder.AppendLine($"namespace {classNamespace}.Model");
            builder.AppendLine("{");
            builder.AppendLine($"\t[Table(\"{tableName}\")]");
            builder.AppendLine($"\tpublic partial class {className} : Entity");
            builder.AppendLine("\t{");
            for (int i = 0; i < columns.Count; i++)
            {
                var col = columns[i];
                builder.AppendLine("\t\t/// <summary>");
                builder.AppendLine($"\t\t/// {col.Comment}");
                builder.AppendLine("\t\t/// <summary>");
                if (col.IsPrimaryKey)
                {
                    var attributeName = col.PrimaryKeyType == PrimaryKeyType.AutoIncrement ? "Key" : "ExplicitKey";
                    builder.AppendLine($"\t\t[{attributeName}]");
                }
                var typeName = GetClassTypeName(col.DataType, col.IsNullable);
                var propName = GetClassOrPropertyName(col.ColumnName);
                builder.AppendLine($"\t\tpublic {typeName} {propName} {{ get; set; }}");
                if (i != columns.Count - 1)
                {
                    builder.AppendLine();
                }
            }
            builder.AppendLine("\t}");
            builder.AppendLine("}");

            return builder.ToString();
        }

        private static string GetGrpcMessageCode(string tableName, List<ColumnInfo> columns)
        {
            string className = GetClassOrPropertyName(tableName);
            StringBuilder builder = new StringBuilder();
            builder.AppendLine($"message {className}DTO {{");
            for (int i = 0; i < columns.Count; i++)
            {
                var col = columns[i];
                var typeName = GetProtoTypeName(col.DataType);
                var propName = GetClassOrPropertyName(col.ColumnName);
                builder.AppendLine($"\t{typeName} {propName} = {i + 1};");
            }
            builder.AppendLine("}");
            return builder.ToString();
        }

        // user_id -> UserId
        // item_cls -> ItemCls
        private static string GetClassOrPropertyName(string dbTableOrColumnName)
        {
            Regex regex = new Regex("_[a-z]");
            var newSource = regex.Replace(dbTableOrColumnName, (match) =>
            {
                return match.Value.ToUpper().Replace("_", "");
            });
            return char.ToUpper(newSource[0]) + newSource.Substring(1);
        }

        private static string GetClassTypeName(string columnType, bool isNullable)
        {
            switch (columnType)
            {
                case "char":
                case "text":
                case "mediumtext":
                case "longtext":
                case "json":
                case "varchar": return "string";

                case "tinyint":
                case "smallint":
                case "int": return isNullable ? "int?" : "int";

                case "timestamp":
                case "bigint": return isNullable ? "long?" : "long";

                case "decimal": return isNullable ? "decimal?" : "decimal";
                case "double": return isNullable ? "double?" : "double";
                case "float": return isNullable ? "float?" : "float";

                case "date":
                case "datetime": return isNullable ? "DateTime?" : "DateTime";
            }
            return string.Empty;
        }

        private static string GetProtoTypeName(string columnType)
        {
            switch (columnType)
            {
                case "tinyint":
                case "smallint":
                case "int": return "int32";
                case "timestamp":
                case "bigint": return "int64";
                case "double": return "double";
                case "float": return "float";
                default: return "string";
            }
        }
    }
}
