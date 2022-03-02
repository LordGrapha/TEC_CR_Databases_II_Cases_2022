package com.case1.Controllers;

import java.sql.*;
import com.case1.Utils.C3p0DataSource;
import com.case1.Utils.ThreadCache;

/**
 * JDBCController
 */
public class JDBCController {

    
    final int TOTALTHREADS = 10;

    final String QUERY2 =   "SELECT c.name, COUNT(d.id) as deliverables FROM Cantons as c " +
                            "INNER JOIN [dbo].[CantonsXDeliverables] as cxd ON c.id = cxd.cantonId " +
                            "INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableid = d.id " +
                            "WHERE c.politicPartiesSupport <= (SELECT FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties]) " +
                            "GROUP BY c.name;";
    final String[] CANTONS = {"Abangares", "Acosta (San José, CR)",
                                "Alajuela (Alajuela, CR)", "Alajuelita (San José, CR)",
                                "Alvarado (Cartago, CR)", "Aserrí (San José, CR)",
                                "Atenas (Alajuela, CR)", "Bagaces (Guanacaste, CR)",
                                "Barva (Heredia, CR)", "Belén (Heredia, CR)"};
    private int countFinishedThreads;

    private ThreadCache cache;

    public JDBCController(){
        this.countFinishedThreads = 0;
        this.cache = new ThreadCache(TOTALTHREADS);
    }

    public void executeQuery1() throws InterruptedException{
        countFinishedThreads = 0;
        for (int threadIndex = 0; threadIndex < TOTALTHREADS; threadIndex++) {
            final int cantonIndex = threadIndex;
            Thread thread = new Thread(){
                public void run(){
                    try {
                        query1(cantonIndex);
                        countFinishedThreads++;
                    } catch (InterruptedException e) {
                        System.out.println("Thread " + String.valueOf(cantonIndex) + " is dead");
                        e.printStackTrace();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
              };
              thread.start();
        }
        while(this.countFinishedThreads < TOTALTHREADS){
            Thread.sleep(10);
        }
    }

    //SP call and retrieve data
    private void query1(int pCantonIndex) throws InterruptedException{
        String call = "{call Query1(?)}";
        // Open a connection
        try (Connection conn = DriverManager.getConnection(C3p0DataSource.DB_URL,       //not using a pool, it creates a connection here
                                            C3p0DataSource.USER, C3p0DataSource.PASS);
        CallableStatement stmt = conn.prepareCall(call);) {
            stmt.setString(1, CANTONS[pCantonIndex]);
            stmt.execute();
            ResultSet rs = stmt.getResultSet();
            
            // Extract data from result set
            while (rs.next()) {
                // Retrieve by column name
                System.out.println("Deliverable: " + rs.getString("name"));
                System.out.println("Canton: " + rs.getString("name"));
                System.out.println("Politic Party: " + rs.getString("name") + "\n");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void executeQuery2() throws InterruptedException{
        countFinishedThreads = 0;
        for (int threadIndex = 0; threadIndex < TOTALTHREADS; threadIndex++) {
            final Thread thread = new Thread(){
                public void run(){
                    try {
                        query2();
                        countFinishedThreads++;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
              };
              thread.start();
        }
        while(this.countFinishedThreads < TOTALTHREADS){
            Thread.sleep(10);
        }
    }

    //Inline query and retrieve data.
    private void query2() throws SQLException{
        Connection con = null;
        try {
            con = C3p0DataSource.getConnection();   //Here it asks for a connection to the pool.
            
            CallableStatement cstmt = con.prepareCall("{call dbo.Query1(?)}");
            // Execute a stored procedure that returns some data.
            cstmt.setString("cantonName", "Abangares");
            ResultSet rs = cstmt.executeQuery(); 
            // Extract data from result set
                while (rs.next()) {
                    // Retrieve by column name
                    System.out.println("Deliverable: " + rs.getString("name"));
                    System.out.println("Canton: " + rs.getString("name"));
                    System.out.println("PoliticParty: " + rs.getString("name"));
                }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if(con != null){
                con.close();        //When the connection closes, it releases it to the pool so other one can ask it again.
            }
        }
    }

    public void executeQuery3() throws InterruptedException{
        final HibernateController orm = new HibernateController();
        countFinishedThreads = 0;
        for (int threadIndex = 0; threadIndex < TOTALTHREADS; threadIndex++) {
            final Thread thread = new Thread(){
                public void run(){
                    try {
                        orm.query3();
                        countFinishedThreads++;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
              };
              cache.put(threadIndex, thread);           //Here cache is doing it's job with threads
              thread.start();
        }
        while(this.countFinishedThreads < TOTALTHREADS){
            Thread.sleep(10);
        }
        
    }
}