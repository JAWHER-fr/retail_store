<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
</head>
<body class="bg-gray-900 text-gray-300 font-sans min-h-screen flex flex-col">
  <!-- Navbar -->
  <nav class="bg-gray-800 shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-white">Manage Categories</h1>
      <a href="<c:url value='/adminDashboard'/>" class="text-blue-400 hover:underline">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
      </a>
    </div>
  </nav>

  <main class="container mx-auto px-4 py-8 flex-1">
    <!-- Add New Category Form -->
    <section class="mb-8 bg-gray-800 p-6 rounded-lg shadow">
      <h2 class="text-xl font-semibold mb-4">Add New Category</h2>
      <form action="<c:url value='/admin/addCategory'/>" method="post" class="flex flex-col sm:flex-row gap-4">
        <input type="text"
               name="name"
               placeholder="Category Name"
               required
               class="flex-1 p-2 border rounded"/>
        <input type="text"
               name="description"
               placeholder="Description (optional)"
               class="flex-2 p-2 border rounded"/>
        <button type="submit"
                class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 transition">
          <i class="fas fa-plus"></i> Add
        </button>
      </form>
    </section>

    <!-- List of Categories -->
    <section class="bg-gray-800 p-6 rounded-lg shadow">
      <h2 class="text-xl font-semibold mb-4">Existing Categories</h2>
      <table class="min-w-full divide-y divide-gray-600">
        <thead>
          <tr>
            <th class="px-4 py-2 text-left">ID</th>
            <th class="px-4 py-2 text-left">Name</th>
            <th class="px-4 py-2 text-left">Description</th>
            <th class="px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-700">
          <c:forEach var="cat" items="${categories}">
            <tr>
              <td class="px-4 py-2"><c:out value="${cat.id}"/></td>
              <td class="px-4 py-2"><c:out value="${cat.name}"/></td>
              <td class="px-4 py-2"><c:out value="${cat.description}"/></td>
              <td class="px-4 py-2 text-center">
                <form action="<c:url value='/admin/deleteCategory'/>" method="post"
                      onsubmit="return confirm('Delete category \'${cat.name}\'?');">
                  <input type="hidden" name="id" value="${cat.id}"/>
                  <button type="submit"
                          class="text-red-500 hover:text-red-700 text-2xl font-bold">
                    &times;
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </section>
  </main>
</body>
</html>
