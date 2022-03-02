package com.case1;
import com.case1.Controllers.JDBCController;
import com.case1.Utils.Timer;

/**
 * Aseni app to improve democracy
 * It will make some operations in the database, showing variety of topics and methods
 */
public class App 
{
    public static void main( String[] args ) throws InterruptedException
    {
        System.out.println("Case 1 - Aseni for you and our democracy World!");
        System.out.println("Author: Luis Diego Mora Aguilar, 2018147110");
        JDBCController jdbcManager = new JDBCController();
        Timer timer = new Timer();
        //Query 1
        timer.start();
        jdbcManager.executeQuery1();
        timer.stop();
        System.out.println("\n\nQuery 1 - 10 Threads took: " + timer.getMiliSeconds() + "ms\n\n");
        // Query 2
        timer.start();
        jdbcManager.executeQuery2();
        timer.stop();
        System.out.println("\n\nQuery 2 - 10 Threads with Pool took: " + timer.getMiliSeconds() + "ms\n\n");
        // Query 3
        timer.start();
        jdbcManager.executeQuery2();
        timer.stop();
        System.out.println("\n\nQuery 3 - ORM - 10 Threads with Pool and Cache took: " + timer.getMiliSeconds() + "ms\n\n");

    }
}
