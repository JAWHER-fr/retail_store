package com.electronicstore.servlet_admin;

import com.electronicstore.dao.ProductDAO;
import com.electronicstore.model.Product;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // fetch all products
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);

        // forward to JSP
        request.getRequestDispatcher("/WEB-INF/admin/productList.jsp")
               .forward(request, response);
    }
}
