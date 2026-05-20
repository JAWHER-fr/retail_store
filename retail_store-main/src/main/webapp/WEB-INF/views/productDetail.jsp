<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" import="com.electronicstore.model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">

<%
    // Use the implicit 'session' object rather than re-getting it twice
    String userEmail = session != null
        ? (String) session.getAttribute("user")
        : null;
%>

<!-- Navbar -->
<nav class="bg-gradient-to-r from-purple-700 to-pink-600 p-5 shadow-lg text-white">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-3xl font-extrabold italic tracking-widest">Electronic Store</h1>
        <div class="space-x-4">
            <a href="<c:url value='/index.jsp'/>" class="hover:underline">Home</a>
            <a href="<c:url value='/shop'/>" class="hover:underline">Shop</a>
            <a href="<c:url value='/cart'/>" class="hover:underline">Cart</a>
            <% if (userEmail != null) { %>
                <a href="LogoutServlet" class="hover:underline">Logout</a>
            <% } else { %>
                <a href="login" class="hover:underline">Login</a>
                <a href="register" class="hover:underline">Register</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Welcome Section -->
<div class="container mx-auto mt-10 text-center">
    <c:choose>
      <c:when test="${not empty userEmail}">
        <h2 class="text-3xl font-bold text-blue-700">Welcome, ${userEmail}!</h2>
        <a href="<c:url value='/LogoutServlet'/>"
           class="mt-4 inline-block bg-red-500 text-white px-4 py-2 rounded">
          Logout
        </a>
      </c:when>
      <c:otherwise>
        <h2 class="text-3xl font-bold text-gray-300">Welcome to Our Store!</h2>
        <p class="text-gray-400 mt-2">Explore the latest Electronic Items.</p>
      </c:otherwise>
    </c:choose>
</div>

<!-- Product Detail Section -->
<main class="container mx-auto mt-10 p-4">
    <c:if test="${empty product}">
       <c:redirect url="/index.jsp"/>
    </c:if>
    <div class="bg-gray-800 p-6 rounded-xl shadow-lg">
        <div class="flex flex-col md:flex-row">
            <img class="w-full md:w-1/2 h-64 object-cover rounded-md mb-4 md:mb-0"
                 src="${product.imageUrl}" alt="Detailed view of ${product.name}">
            <div class="md:ml-6">
                <h2 class="text-3xl font-bold text-white mb-2">${product.name}</h2>
                <p class="text-pink-400 text-xl mb-4">Dt${product.price}</p>
                <p class="text-gray-300 mb-4">${product.description}</p>
                <form action="<c:url value='/CartServlet'/>" method="post">
                    <input type="hidden" name="productId" value="${product.id}"/>
                    <label for="quantity" class="block text-gray-300 mb-2">Quantity:</label>
                    <!-- Quantity input field with updated styling for better contrast -->
                    <input type="number" id="quantity" name="quantity" min="1" value="1"
                           class="border border-gray-400 bg-gray-700 text-white px-2 py-1 rounded w-20 focus:outline-none focus:ring-2 focus:ring-blue-500"/>
                    <button type="submit"
                            class="bg-blue-600 text-white px-4 py-2 rounded mt-4 hover:bg-blue-700 transition">
                        Add to Cart
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>

</body>
</html>
