package com.case1;

import com.case1.Controllers.JDBCController;
/**
 * Aseni app to improve democracy
 * It will make some operations in the database, showing variety of topics and methods
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println("Case 1 - Aseni for you and our democracy World!");
        System.out.println("Author: Luis Diego Mora Aguilar, 2018147110");
        JDBCController jdbcManager = new JDBCController();
        jdbcManager.executeQuery1();
    }
}
