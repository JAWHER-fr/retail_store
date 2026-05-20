<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Cart" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
    String userFullName = (sessionObj != null) ? (String) sessionObj.getAttribute("fullName") : "";
    String userPhone = (sessionObj != null) ? (String) sessionObj.getAttribute("phone") : "";
    String userAddress = (sessionObj != null) ? (String) sessionObj.getAttribute("address") : "";

    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");

    if (cartItems == null || cartItems.isEmpty()) {
        response.sendRedirect("cart?error=Cart is empty");
        return;
    }

    double totalPrice = 0;
    for (Cart cartItem : cartItems) {
        totalPrice += cartItem.getProduct().getPrice() * cartItem.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">

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

    <!-- Checkout Form -->
    <main class="container mx-auto mt-10 p-4">
        <h2 class="text-2xl font-bold mb-4">Checkout</h2>
        <div class="bg-white text-gray-800 shadow-md rounded-lg p-6">
            <form action="placeOrder" method="post">

                <!-- Order Summary -->
                <div class="mb-6">
                    <h3 class="text-xl font-semibold mb-2">Order Summary</h3>
                    <div class="bg-gray-100 p-4 rounded-lg">
                        <%
                            for (Cart cartItem : cartItems) {
                        %>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-700"><%= cartItem.getProduct().getName() %> (x<%= cartItem.getQuantity() %>)</span>
                            <span class="text-gray-700">₹<%= cartItem.getProduct().getPrice() * cartItem.getQuantity() %></span>
                        </div>
                        <% } %>
                        <div class="flex justify-between font-bold">
                            <span>Total</span>
                            <span>₹<%= totalPrice %></span>
                        </div>
                    </div>
                </div>

                <!-- Place Order Button -->
                <div class="text-center">
                    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">Place Order</button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>
