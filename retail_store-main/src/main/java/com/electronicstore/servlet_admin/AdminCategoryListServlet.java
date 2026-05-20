package com.electronicstore.servlet_admin;

import com.electronicstore.dao.CategoryDAO;
import com.electronicstore.model.Category;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminCategoryListServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch all categories
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Forward to JSP for rendering
        request.getRequestDispatcher("/WEB-INF/admin/categoryList.jsp")
               .forward(request, response);
    }
}
