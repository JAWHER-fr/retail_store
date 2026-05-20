<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Order" %>
<%@ page import="com.electronicstore.model.OrderItem" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
    String userFullName = (sessionObj != null) ? (String) sessionObj.getAttribute("fullName") : "N/A";
    String userPhone = (sessionObj != null) ? (String) sessionObj.getAttribute("phone") : "N/A";
    String userAddress = (sessionObj != null) ? (String) sessionObj.getAttribute("address") : "N/A";

    Order order = (Order) request.getAttribute("order"); // Fetch order details
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems"); // Fetch ordered items

    if (order == null || orderItems == null) {
        response.sendRedirect("index?error=Invalid Order Details");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-700 to-pink-600 p-4 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-600">Electronic Store</h1>
            <div>
                <a href="index.jsp" class="text-gray-200 px-4 hover:text-gray-300">Home</a>
                <a href="shop" class="text-gray-200 px-4 hover:text-gray-300">Shop</a>
             
                <% if (userEmail != null) { %>
                    <a href="LogoutServlet" class="text-gray-200 px-4 hover:text-gray-300">Logout</a>
                <% } else { %>
                    <a href="login" class="text-gray-200 px-4 hover:text-gray-300">Login</a>
                    <a href="register" class="text-gray-200 px-4 hover:text-gray-300">Register</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Order Confirmation -->
    <main class="container mx-auto mt-10 p-4">
        <div class="bg-white shadow-md rounded-lg p-6">
            <div class="text-center">
                <i class="fas fa-check-circle text-green-500 text-5xl mb-4"></i>
                <h3 class="text-xl font-semibold mb-2">Thank you for your order!</h3>
                <p class="text-gray-700 mb-4">Your order has been placed successfully. You will receive a confirmation email shortly.</p>
                <a href="shop" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">Continue Shopping</a>
            </div>
        </div>
    </main>

    <!-- Order Details -->
    <main class="container mx-auto mt-10 p-4">
        <h2 class="text-2xl font-bold mb-4">Order Details</h2>
        <div class="bg-white shadow-md rounded-lg p-6">
            <div class="mb-6">
                <h3 class="text-xl font-semibold mb-2">Order Summary</h3>
                <div class="bg-gray-100 p-4 rounded-lg">
                    <%
                        double totalPrice = 0;
                        if (orderItems != null && !orderItems.isEmpty()) {
                            for (OrderItem orderItem : orderItems) {
                                totalPrice += orderItem.getPrice() * orderItem.getQuantity();
                    %>
                    <div class="flex justify-between mb-2">
                        <span class="text-gray-700"><%= orderItem.getProduct().getName() %> (x<%= orderItem.getQuantity() %>)</span>
                        <span class="text-gray-700">₹<%= orderItem.getPrice() * orderItem.getQuantity() %></span>
                    </div>
                    <% 
                            } 
                    %>
                    <div class="flex justify-between font-bold">
                        <span>Total</span>
                        <span>₹<%= totalPrice %></span>
                    </div>
                    <% } else { %>
                        <p class="text-gray-600">No items found in this order.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </main>

</body>
</html>
