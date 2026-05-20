package com.electronicstore.util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDBConnection {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("Test Successful: Connected to Database!");
            } else {
                System.out.println("Test Failed: Unable to connect.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}
