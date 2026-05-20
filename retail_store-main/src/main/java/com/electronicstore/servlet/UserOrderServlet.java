package com.electronicstore.servlet;

import com.electronicstore.dao.OrderDAO;
import com.electronicstore.model.Order;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class UserOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer l'ID de l'utilisateur connecté
        int userId = (int) session.getAttribute("userId");

        // Récupérer ses commandes
        List<Order> orders = orderDAO.getOrdersByUser(userId);

        // Passer les commandes à la JSP
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/myOrders.jsp")
                .forward(request, response);
    }
}