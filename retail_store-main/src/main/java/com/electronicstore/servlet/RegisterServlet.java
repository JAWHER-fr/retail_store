package com.electronicstore.servlet;

import com.electronicstore.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    
    // Handles GET request
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    // Handles POST request
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract user input from the registration form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Check if the email already exists in the database
        try (Connection connection = DBConnection.getConnection()) {
            String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(checkEmailQuery)) {
                preparedStatement.setString(1, email);
                ResultSet resultSet = preparedStatement.executeQuery();
                
                if (resultSet.next()) {
                    request.setAttribute("errorMessage", "Email already in use.");
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
            }

            // Insert the new user into the database
            DBConnection.closeConnection();

            String insertQuery = "INSERT INTO users (full_name, email, password, phone_number, address, gender) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setString(1, fullName);
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, password); // We will hash the password later
                preparedStatement.setString(4, phoneNumber);
                preparedStatement.setString(5, address);
                preparedStatement.setString(6, gender);
                preparedStatement.executeUpdate();
            }

            // Redirect to login page after successful registration
            DBConnection.closeConnection();

            response.sendRedirect("login");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error. Please try again.");
            request.getRequestDispatcher("login").forward(request, response);
        }
    }
}
