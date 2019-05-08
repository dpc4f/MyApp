using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1000_
{
    class Program
    {
        static int N_MAX = 1000;
        static void Main(string[] args)
        {
            BigInt[] bigInts = new BigInt[N_MAX];
            for (int i = 0; i < N_MAX; ++i)
                bigInts[i] = new BigInt((i + 1).ToString());
            BigInt ret = bigInts[0];
            for (int i = 1; i < N_MAX; ++i)
            {
                ret = ret.Multiple(bigInts[i]);
            }
            ret.PrintValue();

            Console.ReadLine();
        }
    }
}
