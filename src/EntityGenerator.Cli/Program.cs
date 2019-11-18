using System;

namespace EntityGenerator.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            var command = CommandFactory.CreateCommand(args[0]);
            command.Execute(args);
        }
    }
}
