package com.electronicstore.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class DatabaseCleanupListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Enumeration<java.sql.Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            java.sql.Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistered JDBC driver: " + driver);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("Abandoned connection cleanup shutdown.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
