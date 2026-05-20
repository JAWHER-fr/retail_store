<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.electronicstore.model.User"%>

<%
    @SuppressWarnings("unchecked")
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Users</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-gray-300 font-sans min-h-screen flex flex-col">
  <!-- Navbar -->
  <nav class="bg-gray-800 shadow-md">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-white">Manage Users</h1>
      <a href="${pageContext.request.contextPath}/adminDashboard" class="text-blue-400 hover:underline">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
      </a>
    </div>
  </nav>

  <div class="container mx-auto px-4 py-8 flex-1">
    <h2 class="text-2xl font-bold mb-6">Registered Users</h2>

    <table class="min-w-full bg-gray-800 rounded-lg shadow overflow-hidden">
      <thead class="bg-gray-700 text-gray-300">
        <tr>
          <th class="px-4 py-2">ID</th>
          <th class="px-4 py-2">Name</th>
          <th class="px-4 py-2">Email</th>
          <th class="px-4 py-2">Phone</th>
          <th class="px-4 py-2">Address</th>
          <th class="px-4 py-2">Gender</th>
          <th class="px-4 py-2">Actions</th>
        </tr>
      </thead>
      <tbody>
      <% if (users != null && !users.isEmpty()) {
           for (User u : users) { %>
        <tr class="border-t border-gray-600">
          <td class="px-4 py-2"><%= u.getId() %></td>
          <td class="px-4 py-2"><%= u.getFullName() %></td>
          <td class="px-4 py-2"><%= u.getEmail() %></td>
          <td class="px-4 py-2"><%= u.getPhoneNumber() %></td>
          <td class="px-4 py-2"><%= u.getAddress() %></td>
          <td class="px-4 py-2"><%= u.getGender() %></td>
          <td class="px-4 py-2">
            <form method="post"
                  action="<%= request.getContextPath() %>/admin/deleteUser"
                  onsubmit="return confirm('Are you sure you want to delete this user?');">
              <input type="hidden" name="userId" value="<%= u.getId() %>" />
              <button type="submit"
                      class="text-red-500 hover:text-red-700 text-2xl font-bold">
                &times;
              </button>
            </form>
          </td>
        </tr>
      <%   }
         } else { %>
        <tr>
          <td colspan="7" class="px-4 py-2 text-center text-gray-500">
            No users found.
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>

    <div class="mt-6">
      <a href="${pageContext.request.contextPath}/adminDashboard"
         class="text-blue-400 hover:underline">&larr; Back to Dashboard</a>
    </div>
  </div>
</body>
</html>
