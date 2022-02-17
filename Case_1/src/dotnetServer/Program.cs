using System;
using System.Data.SqlClient;
using System.Threading;

namespace dotnetServer
{
    class Program
    {
        static void Main(string[] args)
        {
            new Program().bringPoliticParties();
            new Program().startThreads();
        }
        public void bringPoliticParties()
        {
            SqlConnection con = null;
            try
            {
                // Creating Connection  
                con = new SqlConnection("Data Source=localhost;Initial Catalog=master;User ID=sa;Password=Guayaboscr123;database=Case_1;");
                // writing sql query  
                SqlCommand cm = new SqlCommand("SELECT * FROM PoliticParties;", con);  
                // Opening Connection  
                con.Open();
                // Executing the SQL query  
                SqlDataReader sdr = cm.ExecuteReader();
                // Iterating Data  
                while (sdr.Read())
                {
                    // Displaying Record  
                    Console.WriteLine(sdr["id"] + " " + sdr["name"] + " " + sdr["flagPictureUrl"]); 
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("OOPs, something went wrong." + e);
            }
            // Closing the connection  
            finally
            {
                con.Close();
            }
        }

        public void startThreads()
        {
            //Thread thrName = new Thread(new ThreadStart(function name));
            Thread thr = new Thread(new ThreadStart(new Program().testThread));
            Thread thr2 = new Thread(new ThreadStart(new Program().testThread2));
            thr.Start();
            Console.WriteLine("First Thread has done");
            thr2.Start();
        }

        public void testThread()
        {
            for (int z = 0; z < 10; z++) {
                Console.WriteLine("First Thread");
                Thread.Sleep(2000);
            }
        }
        public void testThread2()
        {
            for (int z = 0; z < 10; z++) {
                Console.WriteLine("Second Thread");
                Thread.Sleep(2000);
            }
        }
    }
}