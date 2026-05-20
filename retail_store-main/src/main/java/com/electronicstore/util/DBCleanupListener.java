package com.electronicstore.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebListener
public class DBCleanupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialization logic if needed
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Deregister JDBC driver
        try {
            DriverManager.deregisterDriver(DriverManager.getDriver("jdbc:mysql://localhost:3306/ecommerce_db"));
            System.out.println("JDBC Driver deregistered.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Close any remaining connections
        DBConnection.closeConnection();
    }
}
