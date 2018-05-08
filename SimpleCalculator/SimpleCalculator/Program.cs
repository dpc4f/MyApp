using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleCalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("---\t\t SIMPLE COMPUTATION APPLICATION \t\t---");
            Console.WriteLine("1. Please specify the operator (1: Adding, 2: Subtracting, 3: Multiplying, 4: Dividing)");
            Console.Write("\t");
            string op = Console.ReadLine();

            int nOp = 0;
            try
            {
                nOp = Int32.Parse(op);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                Console.ReadLine();

                return;
            }

            if (nOp < 1 || nOp > 4)
            {
                Console.WriteLine("Invalid value input.");
                Console.ReadLine();
            }

            double d1 = 0f;
            double d2 = 0f;

            try
            {
                Console.WriteLine("Input the 1st operand: ");
                Console.Write("\t");
                string operand1 = Console.ReadLine();
                d1 = Double.Parse(operand1);

                Console.WriteLine("Input the 2nd operand: ");
                Console.Write("\t");
                string operand2 = Console.ReadLine();
                d2 = Double.Parse(operand2);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                Console.ReadLine();

                return;
            }

            Console.WriteLine("The result is: ");
            Console.Write("\t");
            Console.WriteLine(Calculator.Calculate(d1, d2, nOp));
            Console.ReadLine();
        }
    }
}
