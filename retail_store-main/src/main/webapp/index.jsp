<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | Electronic Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* ── Chatbot Styles ── */
        #chat-bubble {
            position: fixed;
            bottom: 28px;
            right: 28px;
            z-index: 9999;
        }

        #chat-toggle-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #a855f7, #ec4899);
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(168,85,247,0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s;
        }
        #chat-toggle-btn:hover { transform: scale(1.1); }

        #chat-window {
            display: none;
            position: fixed;
            bottom: 100px;
            right: 28px;
            width: 340px;
            height: 480px;
            background: #1f2937;
            border-radius: 16px;
            border: 1px solid #374151;
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            flex-direction: column;
            z-index: 9999;
            overflow: hidden;
        }
        #chat-window.open { display: flex; }

        #chat-header {
            background: linear-gradient(135deg, #a855f7, #ec4899);
            padding: 14px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        #chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 14px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .msg-bot {
            align-self: flex-start;
            background: #374151;
            color: #f9fafb;
            padding: 10px 14px;
            border-radius: 16px 16px 16px 4px;
            max-width: 85%;
            font-size: 14px;
            line-height: 1.5;
        }

        .msg-user {
            align-self: flex-end;
            background: linear-gradient(135deg, #a855f7, #ec4899);
            color: white;
            padding: 10px 14px;
            border-radius: 16px 16px 4px 16px;
            max-width: 85%;
            font-size: 14px;
        }

        .quick-btns {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-top: 4px;
        }

        .quick-btn {
            background: #4b5563;
            color: #e5e7eb;
            border: 1px solid #6b7280;
            border-radius: 20px;
            padding: 5px 12px;
            font-size: 12px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .quick-btn:hover { background: #a855f7; border-color: #a855f7; color: white; }

        #chat-input-area {
            padding: 10px 12px;
            border-top: 1px solid #374151;
            display: flex;
            gap: 8px;
        }

        #chat-input {
            flex: 1;
            background: #374151;
            border: 1px solid #4b5563;
            border-radius: 20px;
            padding: 8px 14px;
            color: white;
            font-size: 13px;
            outline: none;
        }
        #chat-input::placeholder { color: #9ca3af; }

        #chat-send-btn {
            background: linear-gradient(135deg, #a855f7, #ec4899);
            border: none;
            border-radius: 50%;
            width: 38px;
            height: 38px;
            cursor: pointer;
            color: white;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #notif-badge {
            position: absolute;
            top: -4px;
            right: -4px;
            background: #ef4444;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body class="dark bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-sans">
<%
    if (request.getParameter("redirected") == null) {
        response.sendRedirect("ProductServlet?redirected=true");
    }
%>
    <!-- Navbar -->
    <nav class="bg-gradient-to-r from-purple-600 to-pink-500 p-5 text-white shadow-lg rounded-b-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-300">Electronic Store</h1>
            <div>
                <a href="index.jsp" class="hover:underline px-4">Home</a>
                <a href="shop" class="hover:underline px-4">Shop</a>
                <a href="myOrders" class="hover:underline px-4">Mes Commandes</a>
                <%
                    HttpSession sessionObj = request.getSession(false);
                    String userEmail = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;
                    if (userEmail != null) {
                %>

                    <a href="profile" class="hover:underline px-4">Mon Profil</a>
                <% } else { %>
                    <a href="login" class="hover:underline px-4">Login</a>
                    <a href="register" class="hover:underline px-4">Register</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Session Validation -->
    <div class="container mx-auto mt-10 text-center">
        <%
            if (userEmail != null) {
        %>
            <h4 class="text-3xl font-bold text-pink-400">Welcome, <%= userEmail %>!</h4>
        <% } else { %>
            <h2 class="text-3xl font-bold text-white">Welcome to Our Store!</h2>
            <p class="text-gray-300 mt-2">Explore the latest electronics and gadgets.</p>
        <% } %>
    </div>

    <!-- Product Showcase -->
    <main class="container mx-auto mt-10 p-4">
        <section class="mb-8">
            <h2 class="text-2xl font-bold mb-4 text-white">Product List</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                %>
                    <div class="bg-gray-800 border border-gray-700 p-4 rounded-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
                        <a href="ProductDetailServlet?id=<%= product.getId() %>">
                            <img class="w-full h-48 object-cover mb-2 rounded-md" src="<%= product.getImageUrl() %>" alt="Product Image">
                            <h3 class="text-lg font-semibold text-white"><%= product.getName() %></h3>
                            <p class="text-pink-300">DT <%= product.getPrice() %></p>
                        </a>
                    </div>
                <% } } else { %>
                    <p class="text-gray-400">No products available.</p>
                <% } %>
            </div>
        </section>
    </main>

    <!-- ══════════════════════════════════════════ -->
    <!--                  CHATBOT                   -->
    <!-- ══════════════════════════════════════════ -->

    <!-- Bouton flottant -->
    <div id="chat-bubble">
        <button id="chat-toggle-btn" onclick="toggleChat()">
            <i class="fas fa-comment-dots text-white text-2xl"></i>
        </button>
        <div id="notif-badge">1</div>
    </div>

    <!-- Fenêtre chat -->
    <div id="chat-window">

        <!-- Header -->
        <div id="chat-header">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center">
                    <i class="fas fa-robot text-white"></i>
                </div>
                <div>
                    <p class="text-white font-bold text-sm">Assistant Electronic Store</p>
                    <p class="text-white/70 text-xs">En ligne • Répond instantanément</p>
                </div>
            </div>
            <button onclick="toggleChat()" class="text-white/80 hover:text-white text-lg">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <!-- Messages -->
        <div id="chat-messages">
            <div class="msg-bot">
                👋 Bonjour ! Je suis l'assistant de <strong>Electronic Store</strong>.<br><br>
                Comment puis-je vous aider aujourd'hui ?
            </div>
            <div class="quick-btns">
                <button class="quick-btn" onclick="sendQuick('Comment passer une commande ?')">🛒 Commander</button>
                <button class="quick-btn" onclick="sendQuick('Délais de livraison ?')">🚚 Livraison</button>
                <button class="quick-btn" onclick="sendQuick('Comment retourner un produit ?')">↩️ Retour</button>
                <button class="quick-btn" onclick="sendQuick('Moyens de paiement ?')">💳 Paiement</button>
                <button class="quick-btn" onclick="sendQuick('Nous contacter')">📞 Contact</button>
            </div>
        </div>

        <!-- Zone de saisie -->
        <div id="chat-input-area">
            <input id="chat-input" type="text" placeholder="Écrivez votre message..."
                   onkeydown="if(event.key==='Enter') sendMessage()" />
            <button id="chat-send-btn" onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <!-- ══════════════════════════════════════════ -->
    <!--           CHATBOT JAVASCRIPT               -->
    <!-- ══════════════════════════════════════════ -->
    <script>
        const responses = [
            {
                keywords: ["commander","commande","acheter","achat","panier","cart","order"],
                answer: "🛒 <strong>Comment passer une commande :</strong><br>1. Parcourez nos produits sur la page <a href='shop' style='color:#f472b6;text-decoration:underline'>Shop</a><br>2. Cliquez sur un produit puis <em>Ajouter au panier</em><br>3. Allez dans votre panier et cliquez <em>Commander</em><br>4. Remplissez vos informations et confirmez ✅"
            },
            {
                keywords: ["livraison","delai","délai","expedition","expédition","shipping","delivery"],
                answer: "🚚 <strong>Délais de livraison :</strong><br>• Tunis & Grand Tunis : <strong>1-2 jours</strong><br>• Autres gouvernorats : <strong>2-4 jours</strong><br>• Livraison gratuite dès <strong>150 DT</strong> d'achat<br>• Livraison express disponible (+5 DT)"
            },
            {
                keywords: ["retour","rembours","remboursement","return","annul","annuler"],
                answer: "↩️ <strong>Politique de retour :</strong><br>• Retour accepté sous <strong>7 jours</strong> après réception<br>• Produit doit être dans son emballage d'origine<br>• Remboursement sous 3-5 jours ouvrables 💰"
            },
            {
                keywords: ["paiement","payer","carte","virement","cash","espece","espèce"],
                answer: "💳 <strong>Moyens de paiement acceptés :</strong><br>• 💵 Paiement à la livraison (cash)<br>• 💳 Carte bancaire (Visa / Mastercard)<br>• 🏦 Virement bancaire<br>• 📱 Paiement mobile (Flouci, D17)"
            },
            {
                keywords: ["contact","contacter","telephone","téléphone","email","whatsapp","appel"],
                answer: "📞 <strong>Nous contacter :</strong><br>• 📧 Email : contact@electronicstore.tn<br>• 📱 WhatsApp : +216 XX XXX XXX<br>• 🕐 Disponible : Lun-Sam, 8h-18h<br>• 📍 Adresse : Tunis, Tunisie"
            },
            {
                keywords: ["promo","promotion","remise","reduction","réduction","solde","offre","discount"],
                answer: "🎁 <strong>Promotions en cours :</strong><br>• -10% sur les smartphones avec code <strong>PHONE10</strong><br>• Livraison gratuite dès 150 DT<br>• Abonnez-vous à notre newsletter pour recevoir nos offres ! 📩"
            },
            {
                keywords: ["compte","inscription","inscrire","register","profil","mot de passe","password"],
                answer: "👤 <strong>Gestion de compte :</strong><br>• Créer un compte : <a href='register' style='color:#f472b6;text-decoration:underline'>Register</a><br>• Se connecter : <a href='login' style='color:#f472b6;text-decoration:underline'>Login</a><br>• Mot de passe oublié ? Contactez-nous par email"
            },
            {
                keywords: ["garantie","garanti","warranty","panne","reparation","réparation","sav"],
                answer: "🔧 <strong>Garantie & SAV :</strong><br>• Smartphones : <strong>12 mois</strong> de garantie<br>• Vêtements : échange sous <strong>15 jours</strong><br>• SAV disponible par email ou WhatsApp"
            },
            {
                keywords: ["bonjour","salut","hello","bonsoir","salam","hi","hey"],
                answer: "👋 <strong>Bonjour !</strong> Bienvenue sur Electronic Store 😊<br>Que puis-je faire pour vous ?"
            },
            {
                keywords: ["merci","thank","شكرا","choukran"],
                answer: "😊 Avec plaisir ! N'hésitez pas si vous avez d'autres questions. Bonne navigation ! 🛍️"
            },
            {
                keywords: ["produit","product","telephone","téléphone","smartphone","samsung","iphone","redmi","vetement","vêtement"],
                answer: "📱 <strong>Nos produits :</strong><br>Nous proposons des smartphones et vêtements de qualité.<br>• Consultez notre <a href='shop' style='color:#f472b6;text-decoration:underline'>catalogue complet</a> 🛒"
            }
        ];

        function getBotResponse(userMsg) {
            const msg = userMsg.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
            for (const r of responses) {
                if (r.keywords.some(k => msg.includes(k))) return r.answer;
            }
            return "🤔 Je n'ai pas bien compris.<br>Essayez : <strong>Commande • Livraison • Retour • Paiement • Contact</strong><br><br>Ou contactez-nous directement 📞";
        }

        function addMessage(text, type) {
            const box = document.getElementById("chat-messages");
            const div = document.createElement("div");
            div.className = type === "user" ? "msg-user" : "msg-bot";
            div.innerHTML = text;
            box.appendChild(div);
            box.scrollTop = box.scrollHeight;
        }

        function sendMessage() {
            const input = document.getElementById("chat-input");
            const text = input.value.trim();
            if (!text) return;
            addMessage(text, "user");
            input.value = "";
            setTimeout(() => addMessage(getBotResponse(text), "bot"), 400);
        }

        function sendQuick(text) {
            addMessage(text, "user");
            setTimeout(() => addMessage(getBotResponse(text), "bot"), 400);
        }

        function toggleChat() {
            const win = document.getElementById("chat-window");
            const badge = document.getElementById("notif-badge");
            win.classList.toggle("open");
            if (win.classList.contains("open")) badge.style.display = "none";
        }
    </script>

</body>
</html>
