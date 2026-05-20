<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">
<%
    if (request.getParameter("redirected") == null) {
        response.sendRedirect("ProductServlet?redirected=true");
    }
%>
    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-600 to-pink-500 p-5 text-white shadow-lg rounded-b-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-300">Electronic Store</h1>
            <div>
                <a href="index.jsp" class="hover:underline px-4">Home</a>
                <a href="shop" class="hover:underline px-4">Shop</a>
               
                
                <%
                    HttpSession sessionObj = request.getSession(false);
                    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
                    if (userEmail != null) {
                %>
                    <a href="LogoutServlet" class="hover:underline px-4">Logout</a>
                <% } else { %>
                    <a href="login" class="hover:underline px-4">Login</a>
                    <a href="register" class="hover:underline px-4">Register</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Session Validation -->
    <div class="container mx-auto mt-10 text-center">
        <%
            if (userEmail != null) {
        %>
            <h4 class="text-3xl font-bold text-pink-400">Welcome, <%= userEmail %>!</h4>
        <% } else { %>
            <h2 class="text-3xl font-bold text-white">Welcome to Our Store!</h2>
            <p class="text-gray-300 mt-2">Explore the latest electronics and gadgets.</p>
        <% } %>
    </div>

    <!-- Product Showcase -->
    <main class="container mx-auto mt-10 p-4">
        <section class="mb-8">
            <h2 class="text-2xl font-bold mb-4 text-white">Product List</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) { 
                        for (Product product : products) { 
                %>
                    <div class="bg-gray-800 border border-gray-700 p-4 rounded-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                        <a href="ProductDetailServlet?id=<%= product.getId() %>">
                            <img class="w-full h-48 object-cover mb-2 rounded-md" src="<%= product.getImageUrl() %>" alt="Product Image">
                            <h3 class="text-lg font-semibold text-white"><%= product.getName() %></h3>
                            <p class="text-pink-300">₹<%= product.getPrice() %></p>
                        </a>
                    </div>
                <% } } else { %>
                    <p class="text-gray-400">No products available.</p>
                <% } %>
            </div>
        </section>
    </main>

</body>
</html>
