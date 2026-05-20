<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null) {
        sessionObj.invalidate(); // Destroy session
    }
    response.sendRedirect("index.jsp"); // Redirect to home page
%>
