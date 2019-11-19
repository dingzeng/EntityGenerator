using System;
using System.Collections.Generic;

namespace EntityGenerator
{
    public class ConnectionInfo
    {
        public string Server { get; set; }

        public int Port { get; set; }

        public string UserId { get; set; }

        public string Password { get; set; }

        public List<ProjectInfo> Projects { get; set; }
    }

    public class ProjectInfo
    {
        public string Database { get; set; }

        public string Table { get; set; }

        public string Output { get; set; }

        public string ProtoFile { get; set; }

        public string Namespace { get; set; }
    }
}