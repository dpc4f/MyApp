using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;
using System.Diagnostics;
using System.Linq;

namespace TasksInDotNet
{
    public partial class MainForm : Form
    {
        #region Member Variables
        private long _grandTotal;
        private readonly TaskScheduler uiContextTaskScheduler;
        #endregion

        #region Constructor and Finalizers
        public MainForm()
        {
            InitializeComponent();
            uiContextTaskScheduler = TaskScheduler.FromCurrentSynchronizationContext();
        }
        #endregion

        #region Control Event Handlers

        private void btnSumUsingFor_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            for (var i = 0 ; i < 1000000; i++)
            {
                _grandTotal += i + 1;
            }
            stopwatch.Stop();
            MessageBox.Show(String.Format("Sum total of all the numbers in the array is {0}. It took {1} miliseconds to perform this sum.", _grandTotal, stopwatch.ElapsedMilliseconds));
            //resetting sumTotal for next button click
            _grandTotal = 0;
        }

        private void ClearResultLabel()
        {
            lblTotal.Text = string.Empty;
        }

        private void btnNormalThreading_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            List<Thread> threadList = new List<Thread>();

            for (var i = 0L; i < 10; i++)
            {
                var threadStart = new ParameterizedThreadStart(AddNumbersWithoutThreadSynchronization);
                var thread = new Thread(threadStart);
                thread.Start(i * 100000 + 1);
                threadList.Add(thread);    
            }

            foreach (var curthread in threadList)
            {
                //wait for each thread to finish one by one.
                curthread.Join();
            }
            MessageBox.Show(String.Format("Sum total of all the numbers in the array is {0}. It took {1} miliseconds to perform this sum.", _grandTotal, stopwatch.ElapsedMilliseconds));
            //resettting sumTotal for next button click
            _grandTotal = 0;
        }

        private void btnWithSync_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            long counter = 0;
            List<Thread> threadList = new List<Thread>();

            for (var i = 0L; i < 10; i++)
            {
                var threadStart = new ParameterizedThreadStart(AddNumbersWithSynchronization);
                var thread = new Thread(threadStart);
                thread.Start(i * 100000 + 1);
                threadList.Add(thread);
            }

            foreach (var threadf in threadList)
            {
                //wait for each thread to finish one by one.
                threadf.Join();
            }
            stopwatch.Stop();
            MessageBox.Show(String.Format("Sum total of all the numbers in the array is {0}. It took {1} miliseconds to perform this sum.", _grandTotal, stopwatch.ElapsedMilliseconds));
            //resettting _grandTotal for next button click
            _grandTotal = 0;
        }

        #endregion

        #region Methods

        private void AddNumbersWithoutThreadSynchronization(object lowerBound)
        {
            //Below line if uncommented will result in an invalidOperationException
            //as lblTotal is owned by the UI thread and you can not updated it from a background thread.
            //lblTotal.Text = "2";
            var subTotal = 0L;
            var counter = 0;
            long temp = (long)lowerBound;
            while (counter < 100000)
            {
                subTotal += temp;
                temp++;
                counter++;
            }
            _grandTotal += subTotal;
        }

        private void AddNumbersWithSynchronization(object lowerBound)
        {
            //You might want to uncomment this line to simulate the UI hung up issue.
            //Thread.Sleep(5000);
            var subTotal = 0L;
            var counter = 0;
            long temp = (long)lowerBound;
            while (counter < 100000)
            {
                subTotal += temp;
                temp++;
                counter++;
            }
            Interlocked.Add(ref _grandTotal, subTotal);
        }

        #endregion

        
        private void btnWithTasks_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            long degreeofParallelism = 10;
            long lowerbound = 0;
            long upperBound = 0;
            List<Task<long>> tasks = new List<Task<long>>();
            long countOfNumbersToBeAddedByOneTask = 100000; //1 lakh
            Stopwatch sw = new Stopwatch();
            sw.Start();
            for (int spawnedThreadNumber = 1; spawnedThreadNumber <= degreeofParallelism; spawnedThreadNumber++)
            {
                lowerbound = ++upperBound;
                upperBound = countOfNumbersToBeAddedByOneTask * spawnedThreadNumber;
                //copying the values to be passed to task in local variables to avoid closure variable
                //issue. You can safely ignore this concept for now to avoid a detour. For now you
                //can assume that I've done a bad programming by creating two new local variables unnecessarily.
                var lowerLimit = lowerbound;
                var upperLimit = upperBound;
                
                tasks.Add(Task.Run(() => AddNumbersBetweenLimits(lowerLimit, upperLimit)));
            }
            var tsk = Task.WhenAll(tasks).ContinueWith(task => { _grandTotal = CreateFinalSum(tasks); });
            tsk.Wait();
            MessageBox.Show(String.Format("Sum total of all the numbers in the array is {0}. It took {1} miliseconds to perform this sum.", _grandTotal, sw.ElapsedMilliseconds));
        }

        private long CreateFinalSum(List<Task<long>> tasks)
        {
            // Thread.Sleep(5000);
            var finalValue = tasks.Sum(task => task.Result);
            // MessageBox.Show("Sum is : " + finalValue);
            // sw.Stop();

            return finalValue;
        }

        private void CreateFinalSumWithCancellationHandling(List<Task<long>> tasks)
        {
            long grandTotal = 0;
            foreach (var task in tasks)
            {
                if (task.Result < 0)
                {
                    MessageBox.Show("Task was cancelled mid way. Sum opertion couldn't complete.");
                    return;
                }
                grandTotal += task.Result;
            }
            var finalValue = tasks.Sum(task => task.Result);
            MessageBox.Show("Sum is : " + finalValue);
        }

        private static long AddNumbersBetweenLimits(long lowerLimitInclusive, long upperLimitInclusive)
        {
            long sumTotal = 0;
            for (long i = lowerLimitInclusive; i <= upperLimitInclusive; i++)
            {
                sumTotal += i;
            }

            return sumTotal;
        }

        private long AddNumbersBetweenLimitsWithCancellation(long lowerLimitInclusive, long upperLimitInclusive, CancellationToken token)
        {
            long sumTotal = 0;
            for (long i = lowerLimitInclusive; i <= upperLimitInclusive; i++)
            {
                //deliberately added a sleep statement to emulate a long running task
                //this will give the user a chance to cancel the partial summation tasks in the middle when they are not yet complete.
                Thread.Sleep(1000);
                if (token.IsCancellationRequested)
                {
                    sumTotal = -1;//set some invalid value so that calling function can detect that method was cancelled mid way.
                    break;
                }
                sumTotal += i;
            }

            return sumTotal;
        }

        private void btnClickMe_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Hey! You UI is responding :-)");
        }

        CancellationTokenSource ts = new CancellationTokenSource();

        private void btnTasksWithCancellation_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            if (ts.IsCancellationRequested)
            {
                MessageBox.Show("Task was already cancelled. Please restart the application.");
                return;
            }
            long degreeofParallelism = 10;
            long lowerbound = 0;
            long upperBound = 0;
            List<Task<long>> tasks = new List<Task<long>>();
            long countOfNumbersToBeAddedByOneTask = 100000; //1 lakh

            for (int spawnedThreadNumber = 1; spawnedThreadNumber <= degreeofParallelism; spawnedThreadNumber++)
            {
                lowerbound = ++upperBound;
                upperBound = countOfNumbersToBeAddedByOneTask * spawnedThreadNumber;
                //copying the values to be passed to task in local variables to avoid closure variable
                //issue. You can safely ignore this concept for now to avoid a detour. For now you
                //can assume that I've done bad programming by creating two new local variables unnecessarily.
                var lowerLimit = lowerbound;
                var upperLimit = upperBound;

                tasks.Add(Task.Run(() => AddNumbersBetweenLimitsWithCancellation(lowerLimit, upperLimit, ts.Token)));

            }

            Task.WhenAll(tasks).ContinueWith(task => CreateFinalSumWithCancellationHandling(tasks));
        }

        private void btnCancelTasks_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            lblTotal.Text = "Task Cancellation Initiated.";
            Thread.Sleep(1000);
            ts.Cancel();
        }

        private void btnUpdateUiControl_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            var threadStart = new ThreadStart(UpdateLabelTextAsync);
            var thread = new Thread(threadStart);
            thread.Start();
        }

        delegate void UpdateUi();

        private void UpdateLabelTextAsync()
        {
            UpdateUi functionUi = UpdateLabelControl;
            //do work which doesn't involve UI controls.
            //.....
            //.....
            //.....
            //.....
            //Now we have to update UI control so special handling required.
            //InvokeRequired == true means you are on a non-UI thread.
            if (lblTotal.InvokeRequired)
                lblTotal.BeginInvoke(functionUi);
        }

        private void UpdateLabelControl()
        {
            lblTotal.Text = "Changed the text from background thread.";
        }

        private void btnUpdateUiTpl_Click(object sender, EventArgs e)
        {
            ClearResultLabel();
            long degreeofParallelism = 10;
            long lowerbound = 0;
            long upperBound = 0;
            List<Task<long>> tasks = new List<Task<long>>();
            long countOfNumbersToBeAddedByOneTask = 100000; //1 lakh
            for (int spawnedThreadNumber = 1; spawnedThreadNumber <= degreeofParallelism; spawnedThreadNumber++)
            {
                lowerbound = ++upperBound;
                upperBound = countOfNumbersToBeAddedByOneTask * spawnedThreadNumber;
                //copying the values to be passed to task in local variables to avoid closure variable
                //issue. You can safely ignore this concept for now to avoid a detour. For now you
                //can assume that I've done a bad programming by creating two new local variables unnecessarily.
                var lowerLimit = lowerbound;
                var upperLimit = upperBound;

                tasks.Add(Task.Run(() => AddNumbersBetweenLimits(lowerLimit, upperLimit)));
            }
            Task.WhenAll(tasks).ContinueWith(ContinuationAction, tasks, uiContextTaskScheduler);
        }

        private void ContinuationAction(Task task, object o)
        {
            var partialSumTasks = (List<Task<long>>) o;
            var finalValue = partialSumTasks.Sum(eachtask => eachtask.Result);
            lblTotal.Text = "Sum is : " + finalValue;
        }

        private void btnLongRunningWork_Click(object sender, EventArgs e)
        {
            PerformLongWork();
        }

        private void PerformLongWork()
        {
            //this simulates some long work like a web service call or 
            //reading a huge from from disk
            Thread.Sleep(5000);
            //do some long work here
        }

        private void btnLongWorkWithThreading_Click(object sender, EventArgs e)
        {
            var threadStart = new ThreadStart(PerformLongWork);
            var thread = new Thread(threadStart);
            thread.Start();
            //Now main GUI thread starts waiting for the work to complete
            //GUI thread is still busy unable to do any real UI work
            thread.Join();
        }

        public bool isThreadPoolWorkComplete = false;
        private void btnLongWorkWithThreadpool_Click(object sender, EventArgs e)
        {
            ThreadPool.QueueUserWorkItem(PerformLengthyWork, null);
            //Now main GUI thread starts waiting for the work to complete
            //GUI thread is still busy unable to do any real UI work
            while (!isThreadPoolWorkComplete)
            {
                Thread.Sleep(1000);
                //keep waiting as threadpool thread has not finished its job
            }
        }

        private void PerformLengthyWork(object input)
        {
            //this simulates some long work like a web service call or 
            //reading a huge from from disk
            Thread.Sleep(5000);
            //do some long work here
        }
    }
}
