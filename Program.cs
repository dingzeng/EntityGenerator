using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using MySql.Data.MySqlClient;

namespace EntityGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var param = ParseCommandLineParameterInfo(args);
            // var param = new CommandLineParameterInfo()
            // {
            //     Server = "192.168.0.102",
            //     Database = "db_tripod_archive",
            //     Table = "branch",
            //     Port = 33306,
            //     UserId = "root",
            //     Password = "123456",
            //     OutputPath = "../",
            //     Namespace = "Tripod.Service.System.Model"
            // };

            var tables = GetColumnInfos(param);

            Console.WriteLine("开始生成:");
            GenerateEntityFiles(tables, param.OutputPath, param.Namespace);
            Console.WriteLine("生成完成，按任意键退出...");

            Console.ReadKey();
        }

        private static CommandLineParameterInfo ParseCommandLineParameterInfo(string[] args)
        {
            Dictionary<string, string> source = new Dictionary<string, string>();
            for (int i = 0; i < args.Length; i += 2)
            {
                if (args.Length > i + 1)
                {
                    source.Add(args[i], args[i + 1]);
                }
            }

            var commandLineParameterInfo = new CommandLineParameterInfo();
            if (source.TryGetValue("--server", out string server))
            {
                commandLineParameterInfo.Server = server;
            }
            else
            {
                Console.Write("请输入数据库服务器地址(默认为：localhost):");
                var input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                {
                    commandLineParameterInfo.Server = "localhost";
                }
                else
                {
                    commandLineParameterInfo.Server = input;
                }
            }

            // port
            if (source.TryGetValue("--port", out string port))
            {
                commandLineParameterInfo.Port = Convert.ToInt32(port);
            }
            else
            {
                Console.Write("请输入数据库服务器端口号(默认为为:3306):");
                var input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                {
                    commandLineParameterInfo.Port = 3306;
                }
                else
                {
                    commandLineParameterInfo.Port = Convert.ToInt32(input);
                }
            }

            // uid
            if (source.TryGetValue("--uid", out string uid))
            {
                commandLineParameterInfo.UserId = uid;
            }
            else
            {
                Console.Write("请输入数据库用户名:");
                var input = Console.ReadLine();
                commandLineParameterInfo.UserId = input;
            }

            // pwd
            if (source.TryGetValue("--pwd", out string pwd))
            {
                commandLineParameterInfo.Password = pwd;
            }
            else
            {
                Console.Write("请输入数据库密码:");
                var input = Console.ReadLine();
                commandLineParameterInfo.Password = input;
            }

            // database
            if (source.TryGetValue("--database", out string database))
            {
                commandLineParameterInfo.Database = database;
            }
            else
            {
                Console.Write("请输入数据库名称:");
                var input = Console.ReadLine();
                commandLineParameterInfo.Database = input;
            }

            if (source.TryGetValue("--table", out string table))
            {
                commandLineParameterInfo.Table = table;
            }
            else
            {
                Console.Write("请输入要生成的表名称(为空将生成数据库中所有的表):");
                commandLineParameterInfo.Table = Console.ReadLine();
            }

            // namespace
            if (source.TryGetValue("--namespace", out string classNamespace))
            {
                commandLineParameterInfo.Namespace = classNamespace;
            }
            else
            {
                Console.Write("请输入类命名空间：");
                var input = Console.ReadLine();
                commandLineParameterInfo.Namespace = input;
            }

            // output
            if (source.TryGetValue("--output", out string output))
            {
                commandLineParameterInfo.OutputPath = output;
            }
            else
            {
                Console.Write("请输入输出目录路径(默认为当前工作目录)：");
                var input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                {

                    commandLineParameterInfo.OutputPath = "./";
                }
                else
                {
                    commandLineParameterInfo.OutputPath = input;
                }
            }

            return commandLineParameterInfo;
        }

        private static Dictionary<string, List<ColumnInfo>> GetColumnInfos(CommandLineParameterInfo info)
        {
            var result = new Dictionary<string, List<ColumnInfo>>();

            var connectionString = $"database={info.Database};server={info.Server};uid={info.UserId};pwd={info.Password};port={info.Port};";
            using (IDbConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                string condition = $"WHERE TABLE_SCHEMA = '{info.Database}' ";
                if (!string.IsNullOrEmpty(info.Table))
                {
                    condition += $"AND TABLE_NAME = '{info.Table}'";
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
                var path = Directory.Exists(outputPath) ? outputPath : Path.GetFullPath(outputPath);
                var filename = Path.Combine(path, $"{className}.cs");
                File.WriteAllText(filename, code);
                Console.WriteLine($"{table.Key} ok");
            }
        }

        private static string GetEntityClassCode(string tableName, string classNamespace, List<ColumnInfo> columns)
        {
            string className = GetClassOrPropertyName(tableName);
            StringBuilder builder = new StringBuilder();

            builder.AppendLine("using System;");
            builder.AppendLine("using Tripod.Framework.DapperExtentions.Attributes;");
            builder.AppendLine("using Tripod.Framework.Common;");
            builder.AppendLine();

            builder.AppendLine($"namespace {classNamespace}");
            builder.AppendLine("{");
            builder.AppendLine($"\t[Table(\"{tableName}\")]");
            builder.AppendLine($"\tpublic class {className} : Entity");
            builder.AppendLine("\t{");
            foreach (var col in columns)
            {
                builder.AppendLine("\t\t/// <summary>");
                builder.AppendLine($"\t\t/// {col.Comment}");
                builder.AppendLine("\t\t/// <summary>");
                if (col.IsPrimaryKey)
                {
                    var attributeName = col.PrimaryKeyType == PrimaryKeyType.AutoIncrement ? "Key" : "ExplicitKey";
                    builder.AppendLine($"\t\t[{attributeName}]");
                }
                var typeName = GetTypeName(col.DataType, col.IsNullable);
                var propName = GetClassOrPropertyName(col.ColumnName);
                builder.AppendLine($"\t\tpublic {typeName} {propName} {{ get; set; }}");
                builder.AppendLine();
            }
            builder.AppendLine("\t}");
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

        private static string GetTypeName(string columnType, bool isNullable)
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
    }
}
