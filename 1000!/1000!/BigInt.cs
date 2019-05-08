using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1000_
{
    /*
     *          123
        	     23
            --------
                369	 
               246
            --------
               2829
     * */
    class BigInt
    {
        public string s;

        public BigInt(string input)
        {
            // check valid string
            if (input.All(Char.IsDigit) == false)
                return;

            // assign the value
            s = input;
        }

        public BigInt Add(BigInt bi)
        {
            if (s.Length < bi.s.Length)
            {
                ZeroLeftPadding(bi.s.Length - s.Length);
            }
            if (s.Length > bi.s.Length)
            {
                bi.ZeroLeftPadding(s.Length - bi.s.Length);
            }

            string ret = "";
            int r, e, t, u;
            e = 0;
            for (int i=s.Length-1; i>=0; --i)
            {
                Int32.TryParse(s[i].ToString(), out t);
                Int32.TryParse(bi.s[i].ToString(), out u);
                r = t + u + e;
                e = r / 10;
                r = r % 10;
                ret = r.ToString() + ret;
            }
            if (e > 0) ret = e.ToString() + ret;

            return new BigInt(ret);
        }

        public BigInt Multiple(int n)
        {
            string ret = "";
            int r, e, t;
            e = 0;
            for (int i=s.Length-1; i>=0; --i)
            {
                
                Int32.TryParse(s[i].ToString(), out t);
                r = t * n + e;
                e = r / 10;
                r = r % 10;
                ret = r.ToString() + ret;
            }
            if (e > 0) ret = e.ToString() + ret;

            return new BigInt(ret);
        }

        public BigInt Multiple(BigInt bi)
        {
            BigInt[] middle_result = new BigInt[s.Length];
            for (int i=s.Length-1; i>=0; --i)
            {
                int n = 0;
                Int32.TryParse(s[i].ToString(), out n);
                middle_result[i] = bi.Multiple(n);
                middle_result[i].ZeroRightPadding(s.Length - 1 - i);
            }
            BigInt ret = new BigInt("0");
            for (int i=0; i<s.Length; ++i)
            {
                ret = ret.Add(middle_result[i]);
            }

            return ret;
        }

        public void ZeroRightPadding(int n)
        {
            for (int i=0; i<n; ++i)
            {
                s += "0";
            }
        }

        public void ZeroLeftPadding(int n)
        {
            for (int i=0; i<n; ++i)
            {
                s = "0" + s;
            }
        }

        public void PrintValue()
        {
            int k = s.Length % 3;
            for (int i = 0; i < s.Length-1; ++i)
            {
                Console.Write(s[i]);
                if ((i + 1 - k) % 3 == 0) Console.Write(',');
            }
            Console.Write(s[s.Length - 1]);
        }
    }
}
