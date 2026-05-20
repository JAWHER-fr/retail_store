package com.electronicstore.dao;

import com.electronicstore.model.Order;
import com.electronicstore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /** Récupérer toutes les commandes (admin) */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.user_id, u.full_name, o.total_price, o.status, o.created_at " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.id " +
                "ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getDouble("total_price"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /** ✅ Récupérer les commandes d'un utilisateur spécifique */
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.user_id, u.full_name, o.total_price, o.status, o.created_at " +
                "FROM orders o " +
                "JOIN users u ON o.user_id = u.id " +
                "WHERE o.user_id = ? " +
                "ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getDouble("total_price"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /** Marquer une commande comme livrée */
    public boolean markAsDone(int orderId) {
        String sql = "UPDATE orders SET status = 'Delivered' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Supprimer une commande */
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}