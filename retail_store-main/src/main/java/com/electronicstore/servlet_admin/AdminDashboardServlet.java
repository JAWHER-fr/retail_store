package com.electronicstore.servlet_admin;

import java.io.IOException;
import com.electronicstore.dao.AdminDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── PROTECTION ADMIN ──────────────────────────────────────────────
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null
                || !"admin".equals(session.getAttribute("role"))) {
            // Pas admin → rediriger vers login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // ─────────────────────────────────────────────────────────────────

        // Récupérer les statistiques
        int userCount     = adminDAO.getUserCount();
        int productCount  = adminDAO.getProductCount();
        int categoryCount = adminDAO.getCategoryCount();
        int orderCount    = adminDAO.getOrderCount();

        // Passer les données à la JSP
        request.setAttribute("userCount",     userCount);
        request.setAttribute("productCount",  productCount);
        request.setAttribute("categoryCount", categoryCount);
        request.setAttribute("orderCount",    orderCount);

        // Afficher le dashboard
        request.getRequestDispatcher("/WEB-INF/admin/adminDashboard.jsp")
                .forward(request, response);
    }
}