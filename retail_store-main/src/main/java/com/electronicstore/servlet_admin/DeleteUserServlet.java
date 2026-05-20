package com.electronicstore.servlet_admin;

import com.electronicstore.dao.UserDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // parse user ID from form
        String idParam = request.getParameter("userId");
        if (idParam != null) {
            int userId = Integer.parseInt(idParam);
            // delete user (cascades carts/orders)
            userDAO.deleteUser(userId);
        }
        // redirect back to the list
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
