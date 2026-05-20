package com.electronicstore.servlet;

import com.electronicstore.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UpdatePasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId        = (int) session.getAttribute("userId");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Vérifier que les nouveaux mots de passe correspondent
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/profile?error=passwordmatch");
            return;
        }

        // Vérifier longueur minimum
        if (newPassword.length() < 6) {
            response.sendRedirect(request.getContextPath() + "/profile?error=passwordshort");
            return;
        }

        boolean success = userDAO.updatePassword(userId, oldPassword, newPassword);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/profile?success=password");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=oldpassword");
        }
    }
}