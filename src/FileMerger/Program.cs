using System;
using System.IO;
using System.Text;

namespace FileMerger
{
    class Program
    {
        static void Main(string[] args)
        {
            string dir = args[0];
            string output = args[1];
            var files = Directory.GetFiles(dir, "*", SearchOption.AllDirectories);

            StringBuilder builder = new StringBuilder();
            foreach (var f in files)
            {
                var content = File.ReadAllText(f);
                builder.AppendLine(content);
            }

            File.WriteAllText(output, builder.ToString());
            Console.WriteLine("ok");
            Console.ReadKey();
        }
    }
}
