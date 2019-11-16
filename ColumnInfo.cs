using System;

namespace EntityGenerator
{
    public enum PrimaryKeyType
    {
        Not,
        AutoIncrement,
        ExplicitKey
    }
    public class ColumnInfo
    {
        /// <summary>
        /// 
        /// </summary>
        public string TableName { get; set; }

        public string ColumnName { get; set; }

        public object DefaultValue { get; set; }

        public bool IsNullable { get; set; }

        public bool IsPrimaryKey { get; set; }

        public PrimaryKeyType PrimaryKeyType { get; set; }

        public string DataType { get; set; }

        public string Comment { get; set; }
    }
}