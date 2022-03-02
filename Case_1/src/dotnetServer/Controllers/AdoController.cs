using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
class AdoController
{
    public static readonly String[] CANTONS = new String[10] {"Abangares", "Acosta (San José, CR)",
                                        "Alajuela (Alajuela, CR)", "Alajuelita (San José, CR)",
                                        "Alvarado (Cartago, CR)", "Aserrí (San José, CR)",
                                        "Atenas (Alajuela, CR)", "Bagaces (Guanacaste, CR)",
                                        "Matina (Limón, CR)", "Montes de Oca (San José, CR)"};
    public void executeQuery1()
        {
            for (int threadIndex = 0; threadIndex < 9; threadIndex++)
            {
                Thread thr = new Thread(new ThreadStart(() => {query1(threadIndex);}));
                thr.Start();
            }
            //Thread thrName = new Thread(new ThreadStart(function name));
        }
        public void query1(int pThreadIndex)
        {
            SqlConnection con = null;
            try
            {
                // Creating Connection  
                con = new SqlConnection("Data Source=localhost;Initial Catalog=master;User ID=sa;Password=Guayaboscr123;database=Case_1;");
                // writing sql query  
                SqlCommand cmd = new SqlCommand("Query1", con);  
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;
                param = cmd.Parameters.Add("@cantonName", SqlDbType.VarChar, 63);
                param.Value = CANTONS[pThreadIndex];
                // Execute the command.
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader(); 
                // Display the result of the operation.
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Console.WriteLine("{0}\t{1}\t{2}", reader.GetString(0),
                            reader.GetString(1), reader.GetString(2));
                    }
                }
                else
                {
                    Console.WriteLine("No rows found.");
                    Console.WriteLine("ThreadIndex:" + pThreadIndex + "\nCanton: " + CANTONS[pThreadIndex]);
                }
                reader.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("OOPs, something went wrong." + e);
                Console.WriteLine("\n\npThreadIndex:" + pThreadIndex + "\nCantons lenght: " + CANTONS.Length);
            }
            // Closing the connection  
            finally
            {
                con.Close();
            }
        }
}