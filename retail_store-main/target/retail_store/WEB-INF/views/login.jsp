<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>  
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></link>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center">User Login</h2>

        <%-- Display error message if login fails --%>
        <% 
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="POST">
            <div class="mb-4">
                <label for="email" class="block text-gray-700 font-medium mb-2">Email</label>
                <input type="email" id="email" name="email" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
            </div>
            <div class="mb-4">
                <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                <input type="password" id="password" name="password" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
            </div>
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center">
                    <input type="checkbox" id="remember" name="remember" class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                    <label for="remember" class="ml-2 block text-gray-900">Remember Me</label>
                </div>
                <div>
                    <a href="#" class="text-blue-500 hover:underline">Forgot Password?</a>
                </div>
            </div>
            <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">Login</button>
        </form>
    </div>

    <!-- Navbar
    <nav class="bg-white shadow-md p-4">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-600">Retail Clothing Store</h1>
            <div>
                <a href="index" class="text-gray-700 px-4">Home</a>
                <a href="shop" class="text-gray-700 px-4">Shop</a>
                <a href="about" class="text-gray-700 px-4">About</a>
                <a href="contact" class="text-gray-700 px-4">Contact</a>
                <a href="cart" class="text-gray-700 px-4">Cart</a>
            </div>
        </div>
    </nav> -->
</body>
</html>