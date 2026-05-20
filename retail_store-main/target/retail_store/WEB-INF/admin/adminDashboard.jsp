<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int userCount     = request.getAttribute("userCount")     != null ? (Integer) request.getAttribute("userCount")     : 0;
    int productCount  = request.getAttribute("productCount")  != null ? (Integer) request.getAttribute("productCount")  : 0;
    int categoryCount = request.getAttribute("categoryCount") != null ? (Integer) request.getAttribute("categoryCount") : 0;
    int orderCount    = request.getAttribute("orderCount")    != null ? (Integer) request.getAttribute("orderCount")    : 0;
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
</head>
<body class="bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white min-h-screen flex">

  <!-- Sidebar -->
  <aside class="w-64 bg-black/70 backdrop-blur-lg border-r border-white/10 min-h-screen px-6 py-8">
    <h1 class="text-3xl font-bold text-cyan-400 mb-10">Admin Panel</h1>
    <nav class="space-y-4 text-lg">
      <a href="<%= request.getContextPath() %>/admin/users" class="flex items-center text-white hover:text-cyan-400">
        <i class="fas fa-users mr-3"></i> Users
      </a>
      <a href="<%= request.getContextPath() %>/admin/categories" class="flex items-center text-white hover:text-yellow-300">
        <i class="fas fa-th-list mr-3"></i> Categories
      </a>
      <a href="<%= request.getContextPath() %>/admin/products" class="flex items-center text-white hover:text-purple-300">
        <i class="fas fa-box mr-3"></i> Products
      </a>
      <a href="<%= request.getContextPath() %>/admin/orders" class="flex items-center text-white hover:text-red-300">
        <i class="fas fa-shopping-cart mr-3"></i> Orders
      </a>
      <a href="<c:url value='/'/>" class="flex items-center text-white hover:text-green-300">
        <i class="fas fa-home mr-3"></i> Home
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 p-10">
    <h2 class="text-4xl font-bold mb-8 text-white">Dashboard Overview</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">

      <!-- Users -->
      <a href="<%= request.getContextPath() %>/admin/users" class="block">
        <div class="bg-white/5 backdrop-blur-md p-6 rounded-2xl border border-white/10 shadow-lg hover:shadow-cyan-500/30 transition duration-300">
          <div class="flex items-center">
            <div class="p-4 bg-cyan-600/20 text-cyan-400 rounded-full shadow-md">
              <i class="fas fa-users fa-2x"></i>
            </div>
            <div class="ml-5">
              <h3 class="text-lg font-medium">Total Users</h3>
              <p class="text-3xl font-bold text-white"><%= userCount %></p>
            </div>
          </div>
        </div>
      </a>

      <!-- Categories -->
      <a href="<%= request.getContextPath() %>/admin/categories" class="block">
        <div class="bg-white/5 backdrop-blur-md p-6 rounded-2xl border border-white/10 shadow-lg hover:shadow-yellow-400/30 transition duration-300">
          <div class="flex items-center">
            <div class="p-4 bg-yellow-600/20 text-yellow-300 rounded-full shadow-md">
              <i class="fas fa-th-list fa-2x"></i>
            </div>
            <div class="ml-5">
              <h3 class="text-lg font-medium">Total Categories</h3>
              <p class="text-3xl font-bold text-white"><%= categoryCount %></p>
            </div>
          </div>
        </div>
      </a>

      <!-- Products -->
      <a href="<%= request.getContextPath() %>/admin/products" class="block">
        <div class="bg-white/5 backdrop-blur-md p-6 rounded-2xl border border-white/10 shadow-lg hover:shadow-purple-400/30 transition duration-300">
          <div class="flex items-center">
            <div class="p-4 bg-purple-600/20 text-purple-300 rounded-full shadow-md">
              <i class="fas fa-box fa-2x"></i>
            </div>
            <div class="ml-5">
              <h3 class="text-lg font-medium">Total Products</h3>
              <p class="text-3xl font-bold text-white"><%= productCount %></p>
            </div>
          </div>
        </div>
      </a>

      <!-- Orders -->
      <a href="<%= request.getContextPath() %>/admin/orders" class="block">
        <div class="bg-white/5 backdrop-blur-md p-6 rounded-2xl border border-white/10 shadow-lg hover:shadow-red-400/30 transition duration-300">
          <div class="flex items-center">
            <div class="p-4 bg-red-600/20 text-red-400 rounded-full shadow-md">
              <i class="fas fa-shopping-cart fa-2x"></i>
            </div>
            <div class="ml-5">
              <h3 class="text-lg font-medium">Total Orders</h3>
              <p class="text-3xl font-bold text-white"><%= orderCount %></p>
            </div>
          </div>
        </div>
      </a>

    </div>
  </main>

</body>
</html>
