package com.electronicstore.servlet_admin;

import com.electronicstore.dao.OrderDAO;
import com.electronicstore.model.Order;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminOrderListServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/admin/orderList.jsp")
           .forward(req, resp);
    }
}
