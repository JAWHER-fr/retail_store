package com.electronicstore.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.electronicstore.util.DBConnection;

public class AdminDAO {

    public int getUserCount() {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getProductCount() {
        return getCount("SELECT COUNT(*) FROM products");
    }

    public int getCategoryCount() {
        return getCount("SELECT COUNT(*) FROM categories");
    }

    public int getOrderCount() {
        return getCount("SELECT COUNT(*) FROM orders");
    }

    private int getCount(String query) {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
