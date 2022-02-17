using System;
using System.Data.SqlClient;
namespace dotnetServer
{
    class Program
    {
        static void Main(string[] args)
        {
            new Program().bringPoliticParties();
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
    }
}