package com.electronicstore.dao;

import com.electronicstore.model.Category;
import com.electronicstore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    /**
     * Fetch all categories from the database.
     */
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name, description FROM categories";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(new Category(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    /**
     * Delete a category by ID.
     * Any products in this category (and their dependent rows) will be cascade‑deleted.
     */
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Add a new category.
     */
    public boolean addCategory(String name, String description) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, description);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
