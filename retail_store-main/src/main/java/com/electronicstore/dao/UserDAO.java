package com.electronicstore.dao;

import com.electronicstore.model.User;
import com.electronicstore.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("profile_photo")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateProfile(int id, String fullName, String phoneNumber, String address, String gender) {
        String sql = "UPDATE users SET full_name=?, phone_number=?, address=?, gender=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phoneNumber);
            ps.setString(3, address);
            ps.setString(4, gender);
            ps.setInt(5, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Modifier le mot de passe */
    public boolean updatePassword(int id, String oldPassword, String newPassword) {
        // D'abord récupérer le hash actuel
        User user = getUserById(id);
        if (user == null) return false;

        // Vérifier l'ancien mot de passe
        if (!BCrypt.checkpw(oldPassword, user.getPassword())) {
            return false; // ancien mot de passe incorrect
        }

        // Hasher le nouveau mot de passe
        String hashedNew = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));

        String sql = "UPDATE users SET password=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedNew);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Modifier la photo de profil */
    public boolean updateProfilePhoto(int id, String photoPath) {
        String sql = "UPDATE users SET profile_photo=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, photoPath);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    /** Récupérer le nom d'un utilisateur par son ID */
    public String getUserNameById(int id) {
        String sql = "SELECT full_name FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("full_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    /** Récupérer tous les utilisateurs (admin) */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("profile_photo")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    /** Supprimer un utilisateur par son ID */
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}