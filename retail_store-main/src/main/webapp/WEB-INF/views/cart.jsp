<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.electronicstore.model.Cart, com.electronicstore.model.Product, javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%
    // Retrieve error message and cart items from request
    String errorMsg = (String) request.getAttribute("errorMsg");
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new java.util.ArrayList<>();
    }

    // Get userEmail for navbar
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">

    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-600 to-pink-500 p-5 text-white shadow-lg rounded-b-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-600">Electronic Store</h1>
            <div>
                <a href="<c:url value='/index.jsp'/>" class="hover:underline px-4">Home</a>
                <a href="<c:url value='/shop'/>" class="hover:underline px-4">Shop</a>
                
                <% if (userEmail != null) { %>
                    <a href="LogoutServlet" class="text-gray-700 px-4">Logout</a>
                <% } else { %>
                    <a href="login" class="text-gray-700 px-4">Login</a>
                    <a href="register" class="text-gray-700 px-4">Register</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Page Header or Error Message -->
    <div class="container mx-auto mt-10 text-center">
        <c:choose>
            <c:when test="${not empty errorMsg}">
                <p class="text-gray-600 text-xl">${errorMsg}</p>
            </c:when>
            <c:otherwise>
                <h2 class="text-2xl font-bold mb-4">Your Cart</h2>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Cart Items -->
    <main class="container mx-auto mt-4 p-4">
        <div class="bg-gray-800 shadow-md rounded-lg p-6">
            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <% double totalPrice = 0;
                           for (Cart cartItem : cartItems) {
                               Product product = cartItem.getProduct();
                               double lineTotal = product.getPrice() * cartItem.getQuantity();
                               totalPrice += lineTotal;
                        %>
                            <div class="bg-gray-900 border border-gray-700 p-4 rounded-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                                <img src="<%= product.getImageUrl() %>"
                                     class="w-full h-48 object-cover mb-3 rounded-md"
                                     alt="<%= product.getName() %>">
                                <h3 class="text-lg font-semibold text-white"><%= product.getName() %></h3>
                                <p class="text-pink-300"><%= product.getPrice() %> Dt</p>
                                <p class="text-pink-300">Qty: <%= cartItem.getQuantity() %></p>
                                <p class="text-pink-300">Total: <%= lineTotal %> Dt</p>
                                <form action="<c:url value='/RemoveFromCartServlet'/>" method="post">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>"/>
                                    <button type="submit"
                                            class="mt-2 bg-red-500 text-white px-4 py-2 rounded">
                                        Remove
                                    </button>
                                </form>
                            </div>
                        <% } %>
                    </div>

                    <!-- Checkout Section -->
                    <div class="mt-6 flex justify-between items-center">
                        <h3 class="text-xl font-bold text-pink-400">Grand Total: <%= totalPrice %> Dt</h3>
                        <a href="<c:url value='/checkout'/>"
                           class="bg-blue-600 text-white px-4 py-2 rounded">
                            Proceed to Checkout
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- When cart is empty, errorMsg already shown above -->
                    <div class="mt-6 text-center">
                        <a href="<c:url value='/shop'/>"
                           class="bg-gray-600 text-white px-4 py-2 rounded">
                            Continue Shopping
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>
