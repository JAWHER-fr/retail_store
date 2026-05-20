package com.electronicstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sessionObj = request.getSession(false);
        if (sessionObj != null) {
            sessionObj.invalidate(); // Destroy session
        }
        response.sendRedirect("index.jsp"); // Redirect to home page
    }
}
