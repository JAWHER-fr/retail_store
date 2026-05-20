<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
    if (userEmail == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String fullName = (String) sessionObj.getAttribute("fullName");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Commandes | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white min-h-screen font-sans">

    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-600 to-pink-500 p-5 text-white shadow-lg rounded-b-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-300">Electronic Store</h1>
            <div>
                <a href="<%= request.getContextPath() %>/index.jsp" class="hover:underline px-4">Home</a>
                <a href="<%= request.getContextPath() %>/shop" class="hover:underline px-4">Shop</a>
                <a href="<%= request.getContextPath() %>/myOrders" class="hover:underline px-4 text-yellow-300 font-bold">Mes Commandes</a>

            </div>
        </div>
    </nav>

    <!-- Contenu principal -->
    <div class="container mx-auto mt-10 px-4 pb-16">

        <!-- Titre -->
        <div class="mb-8">
            <h2 class="text-3xl font-bold text-white">
                <i class="fas fa-shopping-bag text-pink-400 mr-3"></i>Mes Commandes
            </h2>
            <p class="text-gray-400 mt-1">Bonjour <span class="text-pink-400 font-semibold"><%= fullName != null ? fullName : userEmail %></span>, voici l'historique de vos commandes.</p>
        </div>

        <% if (orders == null || orders.isEmpty()) { %>
            <div class="text-center mt-20">
                <div class="text-8xl mb-6">📦</div>
                <h3 class="text-2xl font-bold text-gray-300 mb-3">Aucune commande pour l'instant</h3>
                <p class="text-gray-500 mb-8">Vous n'avez pas encore passé de commande.</p>
                <a href="<%= request.getContextPath() %>/shop"
                   class="bg-gradient-to-r from-purple-600 to-pink-500 text-white px-8 py-3 rounded-full font-bold hover:opacity-90 transition">
                    <i class="fas fa-shopping-cart mr-2"></i>Commencer vos achats
                </a>
            </div>

        <% } else { %>
            <!-- Statistiques -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
                <div class="bg-white/5 border border-white/10 rounded-2xl p-5 text-center">
                    <p class="text-3xl font-bold text-purple-400"><%= orders.size() %></p>
                    <p class="text-gray-400 mt-1">Total commandes</p>
                </div>
                <div class="bg-white/5 border border-white/10 rounded-2xl p-5 text-center">
                    <%
                        long delivered = orders.stream().filter(o -> "Delivered".equals(o.getStatus())).count();
                    %>
                    <p class="text-3xl font-bold text-green-400"><%= delivered %></p>
                    <p class="text-gray-400 mt-1">Livrées</p>
                </div>
                <div class="bg-white/5 border border-white/10 rounded-2xl p-5 text-center">
                    <%
                        long pending = orders.stream().filter(o -> !"Delivered".equals(o.getStatus())).count();
                    %>
                    <p class="text-3xl font-bold text-yellow-400"><%= pending %></p>
                    <p class="text-gray-400 mt-1">En cours</p>
                </div>
            </div>

            <!-- Liste des commandes -->
            <div class="space-y-4">
                <% for (Order order : orders) {
                    String statusColor = "Delivered".equals(order.getStatus())
                        ? "bg-green-500/20 text-green-400 border-green-500/30"
                        : "bg-yellow-500/20 text-yellow-400 border-yellow-500/30";
                    String statusIcon = "Delivered".equals(order.getStatus()) ? "fa-check-circle" : "fa-clock";
                %>
                <div class="bg-white/5 border border-white/10 rounded-2xl p-6 hover:border-purple-500/40 transition duration-300">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">

                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full bg-purple-600/20 text-purple-400 flex items-center justify-center text-xl">
                                <i class="fas fa-box"></i>
                            </div>
                            <div>
                                <p class="font-bold text-white text-lg">Commande #<%= order.getId() %></p>
                                <p class="text-gray-400 text-sm">
                                    <i class="fas fa-calendar-alt mr-1"></i>
                                    <%= sdf.format(order.getCreatedAt()) %>
                                </p>
                            </div>
                        </div>

                        <div class="flex items-center gap-6">
                            <div class="text-right">
                                <p class="text-gray-400 text-sm">Total</p>
                                <p class="text-pink-400 font-bold text-xl">
                                    <%= String.format("%.2f", order.getTotalPrice()) %> DT
                                </p>
                            </div>
                            <span class="px-4 py-2 rounded-full border text-sm font-semibold <%= statusColor %>">
                                <i class="fas <%= statusIcon %> mr-1"></i>
                                <%= "Delivered".equals(order.getStatus()) ? "Livrée" : "En cours" %>
                            </span>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>

</body>
</html>