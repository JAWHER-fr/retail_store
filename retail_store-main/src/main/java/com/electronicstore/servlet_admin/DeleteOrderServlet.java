package com.electronicstore.servlet_admin;

import com.electronicstore.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        try {
            int orderId = Integer.parseInt(idParam);
            orderDAO.deleteOrder(orderId);
        } catch (NumberFormatException ignored) { }
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }
}
