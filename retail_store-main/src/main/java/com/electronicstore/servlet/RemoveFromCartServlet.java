package com.electronicstore.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.electronicstore.util.DBConnection;

public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null) {
            response.sendRedirect("cart?error=Invalid product");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int productId = Integer.parseInt(productIdStr);

        try (Connection conn = DBConnection.getConnection()) {
            String deleteQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, productId);
                pstmt.executeUpdate();
            }

            response.sendRedirect("cart"); // Redirect to CartViewServlet
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("cart?error=Database%20error");
        }
    }
}
