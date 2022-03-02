package com.case1.Controllers;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.jdbc.Work;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.case1.Entities.Cantons;

public class HibernateController {

    public void query3() {
         
        Configuration config = new Configuration();
        config.setProperty("hibernate.connection.driver_class", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
        config.setProperty("hibernate.connection.url", "jdbc:sqlserver://localhost:1433;" +
                                                        "databaseName=Case_1;" +
                                                        "encrypt=true;trustServerCertificate=true");
        config.setProperty("hibernate.connection.username", "sa");
        config.setProperty("hibernate.connection.password", "Guayaboscr123");
        config.setProperty("hibernate.dialect", "org.hibernate.dialect.SQLServerDialect");
        //Connection pool config
        config.setProperty("hibernate.c3p0.min_size", "5");             //Minimum amount of connections
        config.setProperty("hibernate.c3p0.max_size", "10");            //Maximum amount of connections
        config.setProperty("hibernate.c3p0.timeout", "300");            //Seconds before discarding an unused connection
        config.setProperty("hibernate.c3p0.max_statements", "50");      //Number of prepared statements will be cached
        config.setProperty("hibernate.c3p0.idle_test_period", "3000");  //Seconds before a connection is automatically validated  
        config.addAnnotatedClass(Cantons.class);

        try {
            SessionFactory sessionFactory = config.buildSessionFactory();
            Session session = sessionFactory.getSessionFactory().openSession();
            session.doWork(
                new Work() {
                    public void execute(Connection conn) throws SQLException 
                    { 
                        CallableStatement stmt = conn.prepareCall("{call Query3}");
                        stmt.execute();
                        ResultSet rs = stmt.getResultSet();
                        // Extract data from result set
                        while (rs.next()) {
                            // Retrieve by column name
                            System.out.println("PoliticParty: " + rs.getString("PoliticParty"));
                            System.out.println("Action: " + rs.getString("Action"));
                            System.out.println("MinCanton: " + rs.getString("MinCanton"));
                            System.out.println("Deliverables: " + rs.getInt("deliverables"));
                            System.out.println("MaxCanton: " + rs.getString("MaxCanton"));
                            System.out.println("Deliverables: " + rs.getInt("deliverables") + "\n");
                        }
                        conn.close();
                    }
                }
            );
            session.close();
            sessionFactory.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
