package com.electronicstore.dao;

import com.electronicstore.model.Product;
import com.electronicstore.model.Category; // Import Category model
import com.electronicstore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Fetch all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM categories"; // SQL query to fetch categories

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                categories.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Fetch products by category
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT id, name, description, price, image_url FROM products WHERE category_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Fetch all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT id, name, description, price, image_url FROM products";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Fetch new arrivals
    public List<Product> getNewArrivals() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.description, p.price, p.image_url " +
                       "FROM products p JOIN new_arrivals na ON p.id = na.product_id " +
                       "ORDER BY na.added_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get product by its ID
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT id, name, description, price, image_url FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    /**
     * Delete a product by its ID.
     * Relies on FK constraints in your schema to cascade-delete related rows if needed.
     */
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Add a new product into the database.
     *
     * @param categoryId  the category FK
     * @param name        product name
     * @param description product description
     * @param price       product price
     * @param imageUrl    path/URL to the saved image (e.g. "images/products/xyz.jpg")
     * @param stock       initial stock count
     * @return true if insertion succeeded
     */
    public boolean addProduct(int categoryId, String name, String description,
                              double price, String imageUrl, int stock) {
        String sql = "INSERT INTO products (category_id, name, description, price, image_url, stock) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setDouble(4, price);
            ps.setString(5, imageUrl);
            ps.setInt(6, stock);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
