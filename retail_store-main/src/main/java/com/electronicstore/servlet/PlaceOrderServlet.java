package com.electronicstore.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

import com.electronicstore.model.Cart;
import com.electronicstore.model.OrderItem;
import com.electronicstore.model.Order;
import com.electronicstore.dao.CartDAO;
import com.electronicstore.dao.UserDAO;
import com.electronicstore.util.DBConnection;
import com.electronicstore.util.EmailService;

public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAO();
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🛑 Step 1: Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        List<Cart> cartItems = cartDAO.getCartItemsByUserId(userId);

        // 🛑 Step 2: Vérifier si le panier est vide
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=Cart is empty");
            return;
        }

        Connection conn          = null;
        PreparedStatement orderStmt     = null;
        PreparedStatement orderItemStmt = null;
        PreparedStatement stockStmt     = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Transaction

            // 📝 Step 3: Insérer la commande dans `orders`
            String insertOrderSQL = "INSERT INTO orders (user_id, total_price) VALUES (?, ?)";
            orderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);

            double totalPrice = cartItems.stream()
                    .mapToDouble(c -> c.getProduct().getPrice() * c.getQuantity())
                    .sum();

            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalPrice);
            orderStmt.executeUpdate();

            // Récupérer l'ID de la commande générée
            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 📝 Step 4: Insérer les articles dans `order_items`
            String insertOrderItemSQL = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            orderItemStmt = conn.prepareStatement(insertOrderItemSQL);

            List<OrderItem> orderItemList = new ArrayList<>();
            for (Cart cartItem : cartItems) {
                OrderItem orderItem = new OrderItem(
                        0,
                        orderId,
                        cartItem.getProduct(),
                        cartItem.getQuantity(),
                        cartItem.getProduct().getPrice()
                );
                orderItemList.add(orderItem);

                orderItemStmt.setInt(1, orderId);
                orderItemStmt.setInt(2, cartItem.getProduct().getId());
                orderItemStmt.setInt(3, cartItem.getQuantity());
                orderItemStmt.setDouble(4, cartItem.getProduct().getPrice());
                orderItemStmt.executeUpdate();
            }

            // ✅ Step 4.5: Mettre à jour le stock des produits
            String updateStockSQL = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";
            stockStmt = conn.prepareStatement(updateStockSQL);

            for (Cart cartItem : cartItems) {
                int productId = cartItem.getProduct().getId();
                int quantity  = cartItem.getQuantity();

                stockStmt.setInt(1, quantity);
                stockStmt.setInt(2, productId);
                stockStmt.setInt(3, quantity); // sécurité : stock suffisant
                int updated = stockStmt.executeUpdate();

                // Si stock insuffisant → annuler toute la commande
                if (updated == 0) {
                    conn.rollback();
                    response.sendRedirect(request.getContextPath() +
                            "/cart?error=Stock insuffisant pour : " + cartItem.getProduct().getName());
                    return;
                }
            }

            // 🛑 Step 5: Vider le panier
            cartDAO.clearCart(userId);
            conn.commit(); // Valider la transaction

            // ✅ Step 6: Email de confirmation
            String userEmail = (String) session.getAttribute("user");
            String userName  = userDAO.getUserNameById(userId);
            EmailService.sendOrderConfirmation(userEmail, userName, orderId, totalPrice);


            request.setAttribute("order", new Order(orderId, userId, userName, totalPrice, "Pending", new Date()));
            request.setAttribute("orderItems", orderItemList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/orderConfirmation.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/checkout?error=Failed to place order");
        } finally {
            try {
                if (orderStmt     != null) orderStmt.close();
                if (orderItemStmt != null) orderItemStmt.close();
                if (stockStmt     != null) stockStmt.close();
                if (conn          != null) conn.close();
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }
}