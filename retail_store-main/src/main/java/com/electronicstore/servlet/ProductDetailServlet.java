package com.electronicstore.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import com.electronicstore.dao.ProductDAO;
import com.electronicstore.model.Product;

public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        try {
            if (idParam != null && !idParam.isEmpty()) {
                int productId = Integer.parseInt(idParam);  // Parse product ID from the request
                ProductDAO productDAO = new ProductDAO();  // Create ProductDAO object
                
                // Fetch the product by its ID from the database
                Product product = productDAO.getProductById(productId);  

                if (product != null) {
                    request.setAttribute("product", product);  // Set the product as a request attribute
                    // Forward to the product detail page (productDetail.jsp)
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/productDetail.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // Redirect to index page if no product found for the given ID
                    response.sendRedirect("index.jsp");
                }
            } else {
                // Redirect to index page if no ID is provided in the request
                response.sendRedirect("index.jsp");
            }
        } catch (NumberFormatException e) {
            // In case of an invalid ID format, redirect to the index page
            response.sendRedirect("index.jsp");
        }
    }
}
