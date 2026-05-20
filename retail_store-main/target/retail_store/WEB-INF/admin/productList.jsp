<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Product" %>

<%
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("products");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800 font-sans min-h-screen flex flex-col">
  <!-- Navbar -->
  <nav class="bg-gray-800 shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-white">Manage Products</h1>
      <a href="${pageContext.request.contextPath}/adminDashboard" class="text-blue-400 hover:underline">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
      </a>
    </div>
  </nav>

  <div class="container mx-auto px-4 py-8 flex-1">
    <!-- Add New Product -->
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-semibold text-gray-800">Product Management</h2>
      <a href="<%= ctx %>/admin/addProduct"
         class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600">
        + Add New Product
      </a>
    </div>

    <!-- Product Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
    <% if (products != null && !products.isEmpty()) {
         for (Product p : products) { %>
        <div class="bg-white rounded-lg shadow-md p-4 flex flex-col items-center">
          <div class="w-full h-40 bg-gray-100 rounded-md mb-4 flex justify-center items-center">
            <% String img = p.getImageUrl(); %>
            <% if (img != null && !img.isEmpty()) { %>
              <img src="<%= ctx + "/" + img %>" alt="Product Image"
                   class="object-contain max-h-full max-w-full rounded"/>
            <% } else { %>
              <span class="text-gray-500">No Image</span>
            <% } %>
          </div>
          <h3 class="text-lg font-semibold text-gray-800 mb-2"><%= p.getName() %></h3>
          <p class="text-sm text-gray-600 mb-4"><%= p.getDescription() %></p>
          <p class="text-xl font-bold text-green-600 mb-4">₹<%= String.format("%.2f", p.getPrice()) %></p>
          <form method="post"
                action="<%= ctx %>/admin/deleteProduct"
                onsubmit="return confirm('Delete product \' <%= p.getName() %> \' ?');">
            <input type="hidden" name="productId" value="<%= p.getId() %>" />
            <button type="submit"
                    class="text-red-500 hover:text-red-700 text-2xl font-bold">
              &times; Remove
            </button>
          </form>
        </div>
      <%   }
     } else { %>
      <div class="col-span-full text-center text-gray-500">
        No products found.
      </div>
     <% } %>
    </div>

    <!-- Back to Dashboard -->
    <div class="mt-8 text-center">
      <a href="<%= ctx %>/adminDashboard"
         class="text-blue-400 hover:underline">&larr; Back to Dashboard</a>
    </div>
  </div>
</body>
</html>
