package com.electronicstore.servlet;



import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.electronicstore.util.DBConnection;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        if (productIdStr == null || quantityStr == null) {
            response.sendRedirect("ProductDetailServlet?id=" + productIdStr + "&error=Invalid%20product");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        int quantity = Integer.parseInt(quantityStr);

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Check if product already in cart
            String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(checkQuery)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, productId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Update quantity
                    int newQuantity = rs.getInt("quantity") + quantity;
                    String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setInt(1, newQuantity);
                        updateStmt.setInt(2, userId);
                        updateStmt.setInt(3, productId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Insert new item into cart
                    String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, productId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.executeUpdate();
                    }
                }
            }

            conn.commit(); 
            DBConnection.closeConnection(conn);

            response.sendRedirect("cart");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ProductDetailServlet?id=" + productIdStr + "&error=Database%20error");
        }
    }
}
