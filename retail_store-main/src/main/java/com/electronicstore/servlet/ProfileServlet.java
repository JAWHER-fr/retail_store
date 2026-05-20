package com.electronicstore.servlet;

import com.electronicstore.dao.UserDAO;
import com.electronicstore.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        User user = userDAO.getUserById(userId);

        // Photo par défaut si non définie
        if (user.getProfilePhoto() == null || user.getProfilePhoto().isEmpty()) {
            user.setProfilePhoto("images/profiles/default.svg");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }
}
