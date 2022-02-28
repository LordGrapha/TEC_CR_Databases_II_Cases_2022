package com.case1.Controllers;

import java.sql.*;

/**
 * JDBCController
 */
public class JDBCController {

    static final String DB_URL = "jdbc:sqlserver://localhost:1433;" +
                                 "databaseName=Case_1;" +
                                 "encrypt=true;trustServerCertificate=true";
    static final String USER = "sa";
    static final String PASS = "Guayaboscr123";
    static final String QUERY = "SELECT * FROM Cantons";

    public static void main(String[] args) {
        
    }

    public void executeQuery1(){
        for (int threadIndex = 0; threadIndex < 10; threadIndex++) {
            Thread thread = new Thread(){
                public void run(){
                  System.out.println("Thread Running");
                  query1();
                }
              };
            
              thread.start();
        }
    }

    public void query1(){
        // Open a connection
        try(Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(QUERY);) {
            // Extract data from result set
                while (rs.next()) {
                    // Retrieve by column name
                    System.out.print("ID: " + rs.getInt("id"));
                    System.out.print(", Name: " + rs.getString("name") + "\n");
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}