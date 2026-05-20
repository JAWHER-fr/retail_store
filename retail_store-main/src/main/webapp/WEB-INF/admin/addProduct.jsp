<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.util.List,com.electronicstore.model.Category" %>

<%
    // categories list was set in AddProductServlet#doGet
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
  <div class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-6">Add New Product</h2>

    <form action="<%= ctx %>/admin/addProduct"
          method="post"
          enctype="multipart/form-data"
          class="bg-white p-6 rounded-lg shadow-md space-y-4">

      <!-- Category -->
      <div>
        <label for="categoryId" class="block font-medium">Category:</label>
        <select id="categoryId" name="categoryId" required
                class="mt-1 block w-full border-gray-300 rounded">
          <option value="">-- Select Category --</option>
          <% for (Category c : categories) { %>
            <option value="<%= c.getId() %>"><%= c.getName() %></option>
          <% } %>
        </select>
      </div>

      <!-- Name -->
      <div>
        <label for="name" class="block font-medium">Product Name:</label>
        <input type="text" id="name" name="name" required
               class="mt-1 block w-full border-gray-300 rounded" />
      </div>

      <!-- Description -->
      <div>
        <label for="description" class="block font-medium">Description:</label>
        <textarea id="description" name="description" rows="4" required
                  class="mt-1 block w-full border-gray-300 rounded"></textarea>
      </div>

      <!-- Price -->
      <div>
        <label for="price" class="block font-medium">Price (DT):</label>
        <input type="number" id="price" name="price" step="0.01" required
               class="mt-1 block w-full border-gray-300 rounded" />
      </div>

      <!-- Stock -->
      <div>
        <label for="stock" class="block font-medium">Stock Quantity:</label>
        <input type="number" id="stock" name="stock" min="0" required
               class="mt-1 block w-full border-gray-300 rounded" />
      </div>

      <!-- Image Upload -->
      <div>
        <label for="image" class="block font-medium">Product Image:</label>
        <input type="file" id="image" name="image" accept="image/*"
               class="mt-1 block w-full" />
      </div>

      <!-- Submit -->
      <div class="flex items-center space-x-4 mt-6">
        <button type="submit"
                class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          Add Product
        </button>
        <a href="<%= ctx %>/admin/products"
           class="text-gray-600 hover:underline">&larr; Back to Products</a>
      </div>
    </form>
  </div>
</body>
</html>
