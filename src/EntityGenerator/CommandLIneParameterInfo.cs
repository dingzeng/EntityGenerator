using System;

namespace EntityGenerator
{
    public class CommandLineParameterInfo
    {
        public string Server { get; set; }

        public int Port { get; set; }

        public string UserId { get; set; }

        public string Password { get; set; }

        public string Database { get; set; }

        public string Table { get; set; }

        public string OutputPath { get; set; }

        public string ProtoFileOutputPath { get; set; }

        public string Namespace { get; set; }
    }
}