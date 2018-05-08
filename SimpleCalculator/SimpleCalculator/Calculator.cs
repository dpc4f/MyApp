using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleCalculator
{
    /// <summary>
    /// Will modify later (if possible) for big numbers which exceed the range of 64-bit
    /// </summary>
    class Calculator
    { 
        public const int ADD = 1;
        public const int SUBTRACT = 2;
        public const int MUL = 3;
        public const int DIVIDE = 4;

        public static double Calculate(double d1, double d2, int nOp)
        {
            double retVal = 0f;
            switch (nOp)
            {
                case ADD:
                    retVal = Add(d1, d2);
                    break;
                case SUBTRACT:
                    retVal = Subtract(d1, d2);
                    break;
                case MUL:
                    retVal = Mul(d1, d2);
                    break;
                case DIVIDE:
                    retVal = Divide(d1, d2);
                    break;
                default:
                    break;
            }

            return retVal;
        }

        private static double Add(double d1, double d2)
        {
            return d1 + d2;
        }

        private static double Subtract(double d1, double d2)
        {
            return d1 - d2;
        }

        private static double Mul(double d1, double d2)
        {
            return d1 * d2;
        }

        private static double Divide(double d1, double d2)
        {
            if (d2 == 0)
                throw new Exception("Divided by zero");

            return d1 / d2;
        }
    }
}
