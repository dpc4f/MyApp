using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SimpleLinq
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Data> ld = new List<Data>();

            Data d1 = new Data();
            d1.ID = "1";
            d1.Desc = "This is record one.";
            ld.Add(d1);

            Data d2 = new Data();
            d2.ID = "2";
            d2.Desc = "This is record two.";
            ld.Add(d2);

            Print(ld);

            var ld2 = ld.Select(x => { ReplaceIDString(ref x.ID); return x; }).ToList();

            Print(ld2);

            Console.ReadLine();
        }

        static void ReplaceIDString(ref string ID)
        {
            switch (ID)
            {
                case "1":
                    ID = "ID1";
                    break;
                case "2":
                    ID = "ID2";
                    break;
                default:
                    break;
            }
        }

        static void Print(List<Data> ld)
        {
            foreach (Data d in ld)
            {
                Console.WriteLine("ID: {0}, Description: {1}", d.ID, d.Desc);
            }
            Console.WriteLine();
        }

        static  void PrintStr(List<string> ls)
        {
            foreach (var i in ls)
            {
                Console.Write(i + " ");
            }
            Console.WriteLine();
        }
    }

    public static class Extensions
    {
        public static string ReplaceIDString(this string ID)
        {
            string ret = "";
            switch (ID)
            {
                case "1":
                    ret = "ID1";
                    break;
                case "2":
                    ret = "ID2";
                    break;
                default:
                    break;
            }
            return ret;
        }
    }



    struct Data
    {
        public string ID;
        public string Desc;
    }
}
