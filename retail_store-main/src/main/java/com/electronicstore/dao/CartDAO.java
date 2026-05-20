package com.electronicstore.dao;

import com.electronicstore.model.Cart;
import com.electronicstore.model.Product;
import com.electronicstore.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    public void clearCart(int userId) {
        String query = "DELETE FROM cart WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<Cart> getCartItemsByUserId(int userId) {
        List<Cart> cartItems = new ArrayList<>();
        String query = "SELECT product_id, quantity FROM cart WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                // Assuming you have a method to fetch Product by ID
                Product product = new ProductDAO().getProductById(productId);
                cartItems.add(new Cart(product, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
}
