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
    public String QUERY2 =      "SELECT c.name, COUNT(d.id) as deliverables FROM Cantons as c " +
                                "INNER JOIN [dbo].[CantonsXDeliverables] as cxd ON c.id = cxd.cantonId " +
                                "INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableid = d.id " +
                                "WHERE c.politicPartiesSupport <= (SELECT FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties]) " +
                                "GROUP BY c.name;";
    private int threadCounter = 0;
    public void executeQuery1()
        {
            this.threadCounter = 0;
            for (int threadIndex = 0; threadIndex < 9; threadIndex++)
            {
                Thread thr = new Thread(new ThreadStart(() => {query1(threadIndex);}));
                thr.Start();
            }
            while(this.threadCounter < 9){
                Thread.Sleep(10);
            }
            
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
            threadCounter++;
        }
    }

    public void executeQuery2()
        {
            this.threadCounter = 0;
            for (int threadIndex = 0; threadIndex < 9; threadIndex++)
            {
                Thread thr = new Thread(new ThreadStart(() => {query2();}));
                thr.Start();
            }
            while (this.threadCounter < 9)
            {
                Thread.Sleep(10);
            }
        }
    public void query2()
    {
        SqlConnection con = null;
        try
        {
            // Creating Connection  
            con = new SqlConnection("Data Source=localhost;Initial Catalog=master;User ID=sa;Password=Guayaboscr123;database=Case_1;");
            // writing sql query  
            SqlCommand cmd = new SqlCommand(QUERY2, con);  
            // Execute the command.
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader(); 
            // Display the result of the operation.
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Console.WriteLine("{0}\t{1}\t", reader.GetString(0),
                        reader.GetInt32(1));
                }
            }
            else
            {
                Console.WriteLine("No rows found.");
            }
            reader.Close();
        }
        catch (Exception e)
        {
            Console.WriteLine("OOPs, something went wrong." + e);
        }
        // Closing the connection  
        finally
        {
            con.Close();
            threadCounter++;
        }
    }
}