<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.electronicstore.model.User" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    User user = (User) request.getAttribute("user");
    String success = request.getParameter("success");
    String error   = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .tab-btn { transition: all 0.2s; }
        .tab-btn.active {
            background: linear-gradient(135deg, #7c3aed, #db2777);
            color: white;
        }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .photo-hover:hover .photo-overlay { opacity: 1; }
        .photo-overlay { opacity: 0; transition: opacity 0.3s; }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white min-h-screen font-sans">

    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-600 to-pink-500 p-5 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-300">Electronic Store</h1>
            <div>
                <a href="<%= request.getContextPath() %>/index.jsp" class="hover:underline px-4">Home</a>
                <a href="<%= request.getContextPath() %>/shop" class="hover:underline px-4">Shop</a>
                <a href="<%= request.getContextPath() %>/myOrders" class="hover:underline px-4">Mes Commandes</a>
                <a href="<%= request.getContextPath() %>/profile" class="hover:underline px-4 text-yellow-300 font-bold">Profil</a>

            </div>
        </div>
    </nav>

    <div class="container mx-auto mt-10 px-4 pb-16 max-w-4xl">

        <!-- Messages succès / erreur -->
        <% if ("profile".equals(success)) { %>
            <div class="bg-green-500/20 border border-green-500/40 text-green-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-check-circle"></i> Profil mis à jour avec succès !
            </div>
        <% } else if ("password".equals(success)) { %>
            <div class="bg-green-500/20 border border-green-500/40 text-green-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-check-circle"></i> Mot de passe modifié avec succès !
            </div>
        <% } else if ("photo".equals(success)) { %>
            <div class="bg-green-500/20 border border-green-500/40 text-green-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-check-circle"></i> Photo de profil mise à jour !
            </div>
        <% } else if ("oldpassword".equals(error)) { %>
            <div class="bg-red-500/20 border border-red-500/40 text-red-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> Ancien mot de passe incorrect !
            </div>
        <% } else if ("passwordmatch".equals(error)) { %>
            <div class="bg-red-500/20 border border-red-500/40 text-red-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> Les mots de passe ne correspondent pas !
            </div>
        <% } else if ("passwordshort".equals(error)) { %>
            <div class="bg-red-500/20 border border-red-500/40 text-red-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> Le mot de passe doit contenir au moins 6 caractères !
            </div>
        <% } else if ("notimage".equals(error) || "badextension".equals(error)) { %>
            <div class="bg-red-500/20 border border-red-500/40 text-red-400 px-5 py-3 rounded-xl mb-6 flex items-center gap-3">
                <i class="fas fa-exclamation-circle"></i> Format invalide ! Utilisez JPG, PNG ou GIF uniquement.
            </div>
        <% } %>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">

            <!-- Sidebar gauche -->
            <div class="md:col-span-1">
                <div class="bg-white/5 border border-white/10 rounded-2xl p-6 text-center">

                    <!-- Photo de profil -->
                    <div class="relative inline-block photo-hover mb-4">
                        <img id="profileImg"
                             src="<%= request.getContextPath() %>/<%= user.getProfilePhoto() %>"
                             onerror="this.src='<%= request.getContextPath() %>/images/profiles/default.svg'"
                             class="w-32 h-32 rounded-full object-cover border-4 border-purple-500 shadow-lg mx-auto">
                        <div class="photo-overlay absolute inset-0 rounded-full bg-black/50 flex items-center justify-center cursor-pointer"
                             onclick="document.getElementById('photoInput').click()">
                            <i class="fas fa-camera text-white text-2xl"></i>
                        </div>
                    </div>

                    <h2 class="text-xl font-bold text-white mb-1"><%= user.getFullName() %></h2>
                    <p class="text-gray-400 text-sm mb-4"><%= user.getEmail() %></p>

                    <!-- Form upload photo -->
                    <form action="<%= request.getContextPath() %>/uploadPhoto" method="post" enctype="multipart/form-data" id="photoForm">
                        <input type="file" id="photoInput" name="profilePhoto"
                               accept="image/jpeg,image/png,image/gif"
                               class="hidden"
                               onchange="previewAndUpload(this)">
                    </form>

                    <button onclick="document.getElementById('photoInput').click()"
                            class="w-full bg-white/10 hover:bg-purple-600/30 border border-white/20 text-white text-sm py-2 px-4 rounded-xl transition mb-2">
                        <i class="fas fa-camera mr-2"></i>Changer la photo
                    </button>
                    <p class="text-gray-500 text-xs">JPG, PNG ou GIF • Max 2MB</p>

                    <!-- Tabs navigation -->
                    <div class="mt-6 space-y-2 text-left">
                        <button onclick="showTab('infos')"
                                class="tab-btn active w-full text-left px-4 py-3 rounded-xl text-sm font-medium" id="btn-infos">
                            <i class="fas fa-user mr-3"></i>Mes informations
                        </button>
                        <button onclick="showTab('password')"
                                class="tab-btn w-full text-left px-4 py-3 rounded-xl text-sm font-medium bg-white/5 hover:bg-white/10" id="btn-password">
                            <i class="fas fa-lock mr-3"></i>Mot de passe
                        </button>
                    </div>
                </div>
            </div>

            <!-- Contenu principal -->
            <div class="md:col-span-2">

                <!-- Tab 1 : Informations -->
                <div id="tab-infos" class="tab-content active bg-white/5 border border-white/10 rounded-2xl p-8">
                    <h3 class="text-xl font-bold mb-6 flex items-center gap-3">
                        <i class="fas fa-user text-purple-400"></i>Mes informations
                    </h3>
                    <form action="<%= request.getContextPath() %>/updateProfile" method="post" class="space-y-5">

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Nom complet</label>
                            <input type="text" name="fullName" value="<%= user.getFullName() %>" required
                                   class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition">
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Email <span class="text-gray-600">(non modifiable)</span></label>
                            <input type="email" value="<%= user.getEmail() %>" disabled
                                   class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-gray-500 cursor-not-allowed">
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Numéro de téléphone</label>
                            <input type="text" name="phoneNumber" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>"
                                   class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition">
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Adresse</label>
                            <input type="text" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                                   class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition">
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Genre</label>
                            <select name="gender"
                                    class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition">
                                <option value="Male"   <%= "Male".equals(user.getGender())   ? "selected" : "" %> class="bg-gray-800">Homme</option>
                                <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %> class="bg-gray-800">Femme</option>
                                <option value="Other"  <%= "Other".equals(user.getGender())  ? "selected" : "" %> class="bg-gray-800">Autre</option>
                            </select>
                        </div>

                        <button type="submit"
                                class="w-full bg-gradient-to-r from-purple-600 to-pink-500 text-white font-bold py-3 rounded-xl hover:opacity-90 transition">
                            <i class="fas fa-save mr-2"></i>Enregistrer les modifications
                        </button>
                        <a href="LogoutServlet"
                           class="w-full block text-center bg-red-600/30 hover:bg-red-600 border border-red-500/40 text-red-400 hover:text-white font-bold py-3 rounded-xl transition mt-2">
                            <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                        </a>
                    </form>
                </div>

                <!-- Tab 2 : Mot de passe -->
                <div id="tab-password" class="tab-content bg-white/5 border border-white/10 rounded-2xl p-8">
                    <h3 class="text-xl font-bold mb-6 flex items-center gap-3">
                        <i class="fas fa-lock text-pink-400"></i>Changer le mot de passe
                    </h3>
                    <form action="<%= request.getContextPath() %>/updatePassword" method="post" class="space-y-5">

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Ancien mot de passe</label>
                            <div class="relative">
                                <input type="password" name="oldPassword" id="oldPass" required
                                       class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition pr-12">
                                <button type="button" onclick="togglePass('oldPass', 'eye1')"
                                        class="absolute right-4 top-3.5 text-gray-400 hover:text-white">
                                    <i class="fas fa-eye" id="eye1"></i>
                                </button>
                            </div>
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Nouveau mot de passe</label>
                            <div class="relative">
                                <input type="password" name="newPassword" id="newPass" required minlength="6"
                                       class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition pr-12">
                                <button type="button" onclick="togglePass('newPass', 'eye2')"
                                        class="absolute right-4 top-3.5 text-gray-400 hover:text-white">
                                    <i class="fas fa-eye" id="eye2"></i>
                                </button>
                            </div>
                        </div>

                        <div>
                            <label class="block text-gray-400 text-sm mb-2">Confirmer le nouveau mot de passe</label>
                            <div class="relative">
                                <input type="password" name="confirmPassword" id="confirmPass" required
                                       class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-purple-400 transition pr-12">
                                <button type="button" onclick="togglePass('confirmPass', 'eye3')"
                                        class="absolute right-4 top-3.5 text-gray-400 hover:text-white">
                                    <i class="fas fa-eye" id="eye3"></i>
                                </button>
                            </div>
                        </div>

                        <div class="bg-yellow-500/10 border border-yellow-500/30 rounded-xl p-4 text-yellow-400 text-sm">
                            <i class="fas fa-info-circle mr-2"></i>
                            Le mot de passe doit contenir au moins <strong>6 caractères</strong>.
                        </div>

                        <button type="submit"
                                class="w-full bg-gradient-to-r from-purple-600 to-pink-500 text-white font-bold py-3 rounded-xl hover:opacity-90 transition">
                            <i class="fas fa-key mr-2"></i>Modifier le mot de passe
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <script>
        function showTab(tab) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('active');
                b.classList.add('bg-white/5');
            });
            document.getElementById('tab-' + tab).classList.add('active');
            document.getElementById('btn-' + tab).classList.add('active');
            document.getElementById('btn-' + tab).classList.remove('bg-white/5');
        }

        function togglePass(inputId, eyeId) {
            const input = document.getElementById(inputId);
            const eye   = document.getElementById(eyeId);
            if (input.type === 'password') {
                input.type = 'text';
                eye.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                input.type = 'password';
                eye.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }

        function previewAndUpload(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profileImg').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
                document.getElementById('photoForm').submit();
            }
        }

        <% if ("oldpassword".equals(error) || "passwordmatch".equals(error) || "passwordshort".equals(error) || "password".equals(success)) { %>
            showTab('password');
        <% } %>
    </script>

</body>
</html>