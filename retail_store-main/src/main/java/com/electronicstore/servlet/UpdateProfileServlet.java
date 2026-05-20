package com.electronicstore.servlet;

import com.electronicstore.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UpdateProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId    = (int) session.getAttribute("userId");
        String fullName    = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address     = request.getParameter("address");
        String gender      = request.getParameter("gender");

        boolean success = userDAO.updateProfile(userId, fullName, phoneNumber, address, gender);

        if (success) {
            // Mettre à jour le nom en session
            session.setAttribute("fullName", fullName);
            response.sendRedirect(request.getContextPath() + "/profile?success=profile");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=profile");
        }
    }
}