package com.electronicstore.servlet;

import com.electronicstore.dao.ProductDAO;
import com.electronicstore.model.Product;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        // Show all products instead of just new arrivals
        List<Product> productList = productDAO.getAllProducts();

        request.setAttribute("products", productList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
