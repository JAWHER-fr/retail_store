package com.electronicstore.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.electronicstore.util.DBConnection;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle POST request (form submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Récupérer le rôle depuis la base de données
                String role = rs.getString("role");

                // Créer la session et stocker les infos
                HttpSession session = request.getSession();
                session.setAttribute("user",     email);
                session.setAttribute("userId",   rs.getInt("id"));
                session.setAttribute("fullName", rs.getString("full_name"));
                session.setAttribute("role",     role);

                // Rediriger selon le rôle
                if ("admin".equals(role)) {
                    // ✅ URL correct selon web.xml → /adminDashboard
                    response.sendRedirect(request.getContextPath() + "/adminDashboard");
                } else {
                    // Client normal → accueil
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }

            } else {
                // Email ou mot de passe incorrect
                out.println("<h3 style='color:red;'>Email ou mot de passe incorrect. Veuillez réessayer !</h3>");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").include(request, response);
            }

            DBConnection.closeConnection();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Une erreur est survenue. Veuillez réessayer plus tard.</h3>");
        }
    }

    // Handle GET request (page load)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
}