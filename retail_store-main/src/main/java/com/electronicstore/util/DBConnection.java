package com.electronicstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce_db?useSSL=false&serverTimezone=UTC"; // Database URL
    private static final String USER = "root"; // MySQL username
    private static final String PASSWORD = ""; // MySQL password (update if necessary)

public static Connection getConnection() throws SQLException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    } catch (ClassNotFoundException e) {
        throw new SQLException("MySQL Driver not found.", e);
    }
}


    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Restore the no-argument closeConnection method
    public static void closeConnection() {
        // Implementation to close the static connection if needed
    }

}
