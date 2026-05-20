package com.electronicstore.servlet_admin;

import com.electronicstore.dao.ProductDAO;
import com.electronicstore.model.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.nio.file.Path;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 5,        // 5 MB
    maxRequestSize = 1024 * 1024 * 10     // 10 MB
)
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch categories for the dropdown
        List<Category> categories = productDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/admin/addProduct.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read form fields
        int categoryId    = Integer.parseInt(request.getParameter("categoryId"));
        String name       = request.getParameter("name");
        String description= request.getParameter("description");
        double price      = Double.parseDouble(request.getParameter("price"));
        int stock         = Integer.parseInt(request.getParameter("stock"));

        // Handle image upload
        Part filePart = request.getPart("image");
        String imageUrl = "";
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
            // Where to save: <webapp>/images/products/
            String uploadDir = request.getServletContext().getRealPath("") 
                             + File.separator + "images" 
                             + File.separator + "products";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }
            String filePath = uploadDir + File.separator + fileName;
            filePart.write(filePath);

            // Relative URL for DB
            imageUrl = "images/products/" + fileName;
        }

        // Insert into DB
        productDAO.addProduct(categoryId, name, description, price, imageUrl, stock);

        // Redirect back to products list
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
