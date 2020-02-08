using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace SampleWindowsService
{
    public partial class Service1 : ServiceBase
    {
        private const int TIME_ELAPSE = 24 * 60 * 1000; // 24 minutes
        private const int TIME_IN_45_SEC = 45 * 1000; // 45 seconds
        private const string path = "D:\\restart_time.csv";
        private Timer timer = null; // timer to write time elapse
        private Timer timer2 = null;

        public Service1()
        {
            InitializeComponent();
            timer = new Timer(TIME_ELAPSE);
            timer.AutoReset = true;
            timer.Elapsed += new ElapsedEventHandler(timer_elasped);
        }

        protected override void OnStart(string[] args)
        {
            try
            {
                timer.Start();
                File.Delete(path); // delete the file if existed
            }
            catch (Exception ex)
            {
                //log anywhere
                Console.WriteLine("Error: {0}", ex.Message);
            }
        }

        private void timer_elasped(object sender, ElapsedEventArgs e)
        {
            try
            {
                using (FileStream fs = File.Create(path))
                {
                    // writing data in string
                    string dataasstring = TIME_ELAPSE.ToString(); //your data
                    byte[] info = new UTF8Encoding(true).GetBytes(dataasstring);
                    fs.Write(info, 0, info.Length);

                    // writing data in bytes already
                    byte[] data = new byte[] { 0x0 };
                    fs.Write(data, 0, data.Length);

                    timer2 = new Timer();
                    timer2.Interval = TIME_IN_45_SEC;
                    timer2.Elapsed += timer2_Elapsed;
                    timer2.Start(); // restart the laptop
                }

            }
            catch (Exception ex){
                Console.WriteLine("Error: {0}", ex.Message);
            }
        }

        void timer2_Elapsed(object sender, ElapsedEventArgs e)
        {
            timer2.Enabled = timer.Enabled = false;

            string strCmdText = "/c shutdown -f -r -t 0";
            System.Diagnostics.Process.Start("CMD.exe", strCmdText);
        }
            
        protected override void OnStop()
        {
            if (timer != null)
            {
                timer.Stop();
            }
        }
    }
}
