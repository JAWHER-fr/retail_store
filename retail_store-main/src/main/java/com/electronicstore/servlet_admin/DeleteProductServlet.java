package com.electronicstore.servlet_admin;

import com.electronicstore.dao.ProductDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read the product ID from the form
        String idParam = request.getParameter("productId");
        if (idParam != null) {
            int productId = Integer.parseInt(idParam);
            // Delete the product (cascades on related tables if FKs are set)
            productDAO.deleteProduct(productId);
        }
        // Redirect back to the product list
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
