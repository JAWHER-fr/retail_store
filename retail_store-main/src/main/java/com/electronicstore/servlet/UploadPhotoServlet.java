package com.electronicstore.servlet;

import com.electronicstore.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@MultipartConfig(
        maxFileSize    = 2 * 1024 * 1024,  // 2 MB max
        maxRequestSize = 5 * 1024 * 1024   // 5 MB max request
)
public class UploadPhotoServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        Part filePart = request.getPart("profilePhoto");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath() + "/profile?error=nophoto");
            return;
        }

        // Vérifier le type de fichier
        String contentType = filePart.getContentType();
        if (!contentType.startsWith("image/")) {
            response.sendRedirect(request.getContextPath() + "/profile?error=notimage");
            return;
        }

        // Récupérer l'extension du fichier
        String originalName = filePart.getSubmittedFileName();
        String extension = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();

        // Vérifier les extensions autorisées
        if (!extension.equals(".jpg") && !extension.equals(".jpeg")
                && !extension.equals(".png") && !extension.equals(".gif")) {
            response.sendRedirect(request.getContextPath() + "/profile?error=badextension");
            return;
        }

        // Nom unique pour le fichier : user_ID.extension
        String fileName = "user_" + userId + extension;

        // Chemin de sauvegarde dans le projet
        String uploadDir = getServletContext().getRealPath("/images/profiles/");
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) uploadFolder.mkdirs();

        // Sauvegarder le fichier
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(uploadDir, fileName), StandardCopyOption.REPLACE_EXISTING);
        }

        // Chemin relatif à stocker en BD
        String photoPath = "images/profiles/" + fileName;

        // Mettre à jour en base de données
        boolean success = userDAO.updateProfilePhoto(userId, photoPath);

        if (success) {
            // Mettre à jour la session
            session.setAttribute("profilePhoto", photoPath);
            response.sendRedirect(request.getContextPath() + "/profile?success=photo");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=photosave");
        }
    }
}