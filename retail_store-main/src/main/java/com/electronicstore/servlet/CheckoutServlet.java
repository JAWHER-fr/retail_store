package com.electronicstore.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import com.electronicstore.model.Cart;
import com.electronicstore.dao.CartDAO;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAO(); // DAO for fetching cart data from DB

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        // Fetch cart items from the database instead of session
        List<Cart> cartItems = cartDAO.getCartItemsByUserId(userId);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("cart?error=Cart is empty");
            return;
        }

        // Debugging log
        System.out.println("Proceeding to checkout for user ID " + userId + " with " + cartItems.size() + " items.");

        request.setAttribute("cartItems", cartItems);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/checkout.jsp");
        dispatcher.forward(request, response);
    }
}
