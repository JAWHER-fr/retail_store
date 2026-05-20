package com.electronicstore.servlet_admin;

import com.electronicstore.dao.UserDAO;
import com.electronicstore.model.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminUserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // fetch all users
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);

        // forward to JSP
        request.getRequestDispatcher("/WEB-INF/admin/userList.jsp")
               .forward(request, response);
    }
}
