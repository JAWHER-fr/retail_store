<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.electronicstore.model.Category" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;

    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">

    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-700 to-pink-600 p-5 shadow-lg text-white">
        <div class="container mx-auto flex justify-between items-center">
            <a class="text-3xl font-extrabold italic tracking-widest" href="index">Electronic Store</a>
            <div class="space-x-4">
                <a href="index.jsp" class="hover:underline">Home</a>
                <a href="shop" class="hover:underline">Shop</a>
       
                <a class="hover:text-gray-300" href="CartServlet">
                    <i class="fas fa-shopping-cart"></i>
                </a>
                <% if (userEmail != null) { %>
                    <a class="hover:text-gray-300" href="LogoutServlet">Logout</a>
                <% } else { %>
                    <a class="hover:text-gray-300" href="login">Login</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Session Validation -->
    <div class="container mx-auto mt-10 text-center">
        <% if (userEmail != null) { %>
            <h2 class="text-3xl font-bold text-blue-700">Welcome, <%= userEmail %>!</h2>
            <a href="LogoutServlet" class="mt-4 inline-block bg-red-500 text-white px-4 py-2 rounded">Logout</a>
        <% } else { %>
            <h2 class="text-3xl font-bold text-gray-300">Welcome to Our Store!</h2>
            <p class="text-gray-400 mt-2">Explore the latest Electronic Items.</p>
        <% } %>
    </div>

    <!-- Shop Page Content -->
    <div class="container mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row">
            
            <!-- Filter Section -->
            <aside class="w-full md:w-1/4 mb-8 md:mb-0">
                <h2 class="text-xl font-bold mb-4">Categories</h2>
                <ul class="space-y-2">
                    <li><a class="block text-gray-300 hover:text-gray-400" href="shop">All Products</a></li>
                    <% if (categories != null && !categories.isEmpty()) {
                        for (Category category : categories) { %>
                            <li>
                                <a class="block text-gray-300 hover:text-gray-400"
                                   href="shop?category=<%= category.getId() %>">
                                    <%= category.getName() %>
                                </a>
                            </li>
                    <%  }
                       } else { %>
                        <li><span class="text-gray-500">No categories available</span></li>
                    <% } %>
                </ul>
            </aside>

            <!-- Product Listing -->
            <main class="w-full md:w-3/4">
                <h2 class="text-xl font-bold mb-4">Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    <% if (products != null && !products.isEmpty()) {
                        for (Product product : products) { %>
                            <div class="bg-gray-800 text-white shadow-md rounded-lg overflow-hidden">
                                <img src="<%= product.getImageUrl() %>"
                                     alt="Product Image"
                                     class="w-full h-48 object-cover"/>
                                <div class="p-4">
                                    <h3 class="text-lg font-bold text-white"><%= product.getName() %></h3>
                                    <p class="text-gray-400">Dt<%= product.getPrice() %></p>
                                    <a href="ProductDetailServlet?id=<%= product.getId() %>"
                                       class="mt-2 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 inline-block">
                                        View Details
                                    </a>
                                </div>
                            </div>
                    <%   }
                       } else { %>
                        <p class="text-gray-600">No products available.</p>
                    <% } %>
                </div>
            </main>
        </div>
    </div>

</body>
</html>
