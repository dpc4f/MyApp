using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.IO.Pipes;


namespace pipeClient_2
{
    public partial class Form1 : Form
    {
        private const int TIME_ELAPSE = 49 * 1000; // 49 seconds
        private const int RESTART_NOW = 7960; // 7.96 second
        private const int TIME_NOTIFY = 1250; // 1250 milisecond
        private Timer timer = null; // timer to check restarting time
        private Timer timer2 = null; // timer to do restarting laptop after showing notification diaglog
        private Timer timer3 = null; // timer to notify by displaying a modal dialog
        private const string path = "D:\\restart_time.csv";
        const int N_TIMES = 10;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            timer = new Timer();
            timer.Interval = TIME_ELAPSE; // 49s to check restarting time
            timer.Tick += timer_Tick;
            timer.Enabled = true;
        }

        void timer_Tick(object sender, EventArgs e)
        {
            try
            {
                string contents = "";
                using (var sr = new StreamReader(path))
                {
                    contents = sr.ReadToEnd();
                    if (contents.Length > 0)
                    {
                        timer2 = new Timer();
                        timer2.Interval = RESTART_NOW;
                        timer2.Tick += timer2_Tick;
                        timer2.Enabled = true;

                        this.TopMost = true;
                        timer3 = new Timer();
                        timer3.Interval = TIME_NOTIFY;
                        timer3.Tick += timer3_Tick;
                        timer3.Enabled = true;

                        MessageBox.Show("The laptop will restart right now ...");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.ToString());
            }
        }

        void timer3_Tick(object sender, EventArgs e)
        {
            timer3.Enabled = false;

            // show notification
            //Form2 frm = new Form2();
            //frm.TopMost = true;
            //frm.ShowDialog();
            // make a sound
            for (int i = 0; i < N_TIMES; ++i)
            {
                Console.Beep(500, 715);
            }
        }

        void timer2_Tick(object sender, EventArgs e)
        {
            timer2.Enabled = timer.Enabled = false;

            string strCmdText = "/c shutdown -f -r -t 0";
            System.Diagnostics.Process.Start("CMD.exe", strCmdText);
        }
    }
}
