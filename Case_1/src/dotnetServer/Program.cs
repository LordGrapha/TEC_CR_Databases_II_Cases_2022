namespace dotnetServer
{
    class Program
    {  
        static void Main(string[] args)
        {
            AdoController sqlTester = new AdoController();
            sqlTester.executeQuery1();
        }
    }
}