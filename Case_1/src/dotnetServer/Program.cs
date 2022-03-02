using System;

namespace dotnetServer
{
    class Program
    {  
        static void Main(string[] args)
        {
            AdoController sqlTester = new AdoController();
            Timer timer = new Timer();
            timer.start();
            sqlTester.executeQuery1();
            timer.stop();
            Console.WriteLine("Query 1:" + timer.getTime());
            timer.start();
            sqlTester.executeQuery2();
            timer.stop();
            Console.WriteLine("Query 1:" + timer.getTime());
            
        }
    }
}