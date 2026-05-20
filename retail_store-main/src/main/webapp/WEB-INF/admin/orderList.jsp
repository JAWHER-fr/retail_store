<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Orders</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
</head>
<body class="bg-gray-100 font-sans min-h-screen flex flex-col">
  <!-- Navbar -->
  <nav class="bg-gray-800 shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-white">Manage Orders</h1>
      <a href="<c:url value='/adminDashboard'/>" class="text-blue-400 hover:underline">
        <i class="fas fa-arrow-left"></i> Dashboard
      </a>
    </div>
  </nav>

  <main class="container mx-auto px-4 py-8 flex-1">
    <!-- Orders Section -->
    <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
      <c:forEach var="o" items="${orders}">
        <div class="bg-white p-6 rounded-lg shadow-lg flex flex-col">
          <h3 class="text-xl font-semibold text-gray-800">Order #<c:out value="${o.id}"/></h3>
          <div class="text-gray-600 mt-2">
            <p><strong>User ID:</strong> <c:out value="${o.userName}"/></p>
            <p><strong>Total Price:</strong> Dt<c:out value="${o.totalPrice}"/></p>
            <p><strong>Status:</strong> <c:out value="${o.status}"/></p>
            <p><strong>Created At:</strong> <fmt:formatDate value="${o.createdAt}" pattern="yyyy-MM-dd HH:mm"/></p>
          </div>
          <div class="mt-4 space-x-2">
            <c:if test="${o.status != 'Delivered'}">
              <form action="<c:url value='/admin/markOrderDone'/>" method="post" class="inline">
                <input type="hidden" name="id" value="${o.id}"/>
                <button type="submit" 
                        class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 transition">
                  <i class="fas fa-check"></i> Mark as Done
                </button>
              </form>
            </c:if>
            <form action="<c:url value='/admin/deleteOrder'/>" method="post" class="inline"
                  onsubmit="return confirm('Delete order #${o.id}?');">
              <input type="hidden" name="id" value="${o.id}"/>
              <button type="submit"
                      class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition">
                <i class="fas fa-trash"></i> Remove
              </button>
            </form>
          </div>
        </div>
      </c:forEach>
    </section>
  </main>
</body>
</html>
