package com.case1.Utils;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3p0DataSource {

    public final static String DB_URL =     "jdbc:sqlserver://localhost:1433;" +
                                            "databaseName=Case_1;" +
                                            "encrypt=true;trustServerCertificate=true";

    public final static String DRIVER =     "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    public final static String USER =       "sa";
    public final static String PASS =       "Guayaboscr123";

    private static ComboPooledDataSource cpds = new ComboPooledDataSource();

    //Here the Pool is configured with the respective config to connect SQL Server and the Auth credentials.
    //Also it has the max and min pool size to manage the db connections.
    static {
        try {
            cpds.setDriverClass(DRIVER);
            cpds.setJdbcUrl(DB_URL);
            cpds.setUser(USER);
            cpds.setPassword(PASS);
            cpds.setMaxPoolSize(8);
            cpds.setMinPoolSize(5);
            
        } catch (PropertyVetoException e) {
            // handle the exception
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return cpds.getConnection();
    }

    private C3p0DataSource(){}
    
}