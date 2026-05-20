package com.electronicstore.servlet;

import com.electronicstore.dao.ProductDAO;
import com.electronicstore.model.Product;
import javax.servlet.ServletException;
import com.electronicstore.model.Category; // Import Category model
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ShopServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 

            throws ServletException, IOException {

        String categoryIdStr = request.getParameter("category");
        List<Category> categoryList = productDAO.getAllCategories(); // Fetch categories
        List<Product> productList;
        request.setAttribute("categories", categoryList); // Set categories in request


        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr);
                productList = productDAO.getProductsByCategory(categoryId);
            } catch (NumberFormatException e) {
                productList = productDAO.getAllProducts();
            }
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("products", productList); 

        request.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(request, response);
    }
}
