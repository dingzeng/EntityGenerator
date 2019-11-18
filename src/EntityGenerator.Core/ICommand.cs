using System;

namespace EntityGenerator.Core
{
    public interface ICommand
    {
        void Execute(string[] args);
    }
}
