using System;
using EntityGenerator.Cli.Commands;
using EntityGenerator.Core;

namespace EntityGenerator.Cli
{
    public class CommandFactory
    {
        public static ICommand CreateCommand(string command)
        {
            switch(command){
                case "generate": return new GenerateCommand();
                case "config": return new ConfigureCommand();
                default : throw new Exception("need command");
            }
        }
    }
}