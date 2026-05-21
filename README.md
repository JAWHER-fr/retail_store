# 🛒 Electronic Store — E-Commerce Web App

![Java](https://img.shields.io/badge/Java-EE-orange?style=for-the-badge&logo=java)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-yellow?style=for-the-badge&logo=apache-tomcat)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Maven](https://img.shields.io/badge/Maven-3.8-red?style=for-the-badge&logo=apache-maven)
![TailwindCSS](https://img.shields.io/badge/Tailwind-CSS-38B2AC?style=for-the-badge&logo=tailwind-css)

> Application e-commerce complète développée en Java EE (JSP/Servlet) avec MySQL et Apache Tomcat.

---

## ✨ Fonctionnalités

### 👤 Utilisateur
- ✅ Inscription & Connexion sécurisée (BCrypt)
- ✅ Gestion de profil (photo, infos, mot de passe)
- ✅ Catalogue de produits avec images
- ✅ Panier d'achat dynamique
- ✅ Passer une commande
- ✅ Historique des commandes
- ✅ Email de confirmation automatique
- ✅ Chatbot d'assistance client

### 🛡️ Admin
- ✅ Dashboard avec statistiques
- ✅ Gestion des produits (ajouter, modifier, supprimer)
- ✅ Gestion des catégories
- ✅ Gestion des utilisateurs
- ✅ Suivi des commandes
- ✅ Pages protégées par session

---

## 🔧 Technologies utilisées

| Technologie | Version | Rôle |
|---|---|---|
| Java EE | 17 | Backend |
| JSP / Servlet | 4.0 | Vues & Contrôleurs |
| Apache Tomcat | 9.0 | Serveur web |
| MySQL | 8.0 | Base de données |
| JDBC | - | Connexion BD |
| BCrypt (jBCrypt) | 0.4 | Hashage mots de passe |
| Maven | 3.8 | Gestion dépendances |
| Tailwind CSS | CDN | Interface utilisateur |
| Font Awesome | 5.15 | Icônes |

---

## 🗄️ Structure de la base de données

```sql
users          → id, full_name, email, password, phone_number, address, gender, profile_photo, role
products       → id, category_id, name, description, price, image_url, stock
categories     → id, name
orders         → id, user_id, total_price, status, created_at
order_items    → id, order_id, product_id, quantity, price
cart           → id, user_id, product_id, quantity
new_arrivals   → id, product_id
```

---

## 📁 Structure du projet

```
retail_store/
├── src/
│   └── main/
│       ├── java/com/electronicstore/
│       │   ├── dao/           → Accès base de données
│       │   ├── model/         → Modèles (User, Product, Order...)
│       │   ├── servlet/       → Servlets utilisateur
│       │   ├── servlet_admin/ → Servlets admin
│       │   └── util/          → DBConnection, EmailService
│       └── webapp/
│           ├── images/        → Images produits & profils
│           ├── WEB-INF/
│           │   ├── admin/     → JSP admin
│           │   ├── views/     → JSP utilisateur
│           │   └── web.xml    → Configuration servlets
│           └── index.jsp
├── pom.xml
└── README.md
```

---

## 🚀 Installation & Lancement

### Prérequis
- Java JDK 17+
- Apache Tomcat 9
- MySQL / XAMPP
- Maven
- IntelliJ IDEA (recommandé)

### Étapes

**1 — Cloner le projet**
```bash
git clone https://github.com/JAWHER-fr/retail_store.git
cd retail_store
```

**2 — Créer la base de données**
```sql
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
```

**3 — Configurer la connexion BD**

Modifie `src/main/java/com/electronicstore/util/DBConnection.java` :
```java
private static final String URL  = "jdbc:mysql://localhost:3306/ecommerce_db";
private static final String USER = "root";
private static final String PASS = ""; // ton mot de passe
```

**4 — Compiler le projet**
```bash
mvn clean package
```

**5 — Déployer sur Tomcat**
- Ouvre le projet dans IntelliJ
- Configure Tomcat 9
- Lance avec `Run`

**6 — Accéder à l'application**
```
http://localhost:8080/retail_store/
```

---

## 👤 Compte Admin

Après inscription, exécute dans MySQL :
```sql
UPDATE users SET role = 'admin' WHERE email = 'ton-email@gmail.com';
```

Accès admin :
```
http://localhost:8080/retail_store/adminDashboard
```

---

## 👨‍💻 Auteur

**Jawher Dridi**
- 🌐 LinkedIn : [linkedin.com/in/jawher-dridi](https://www.linkedin.com/in/dridi-jawher-53b353334/)
- 📧 Email : dridijawher07@gmail.com
- 🐙 GitHub : [github.com/JAWHER-fr](https://github.com/JAWHER-fr)

---

## 📄 Licence

Ce projet est sous licence **MIT** — libre d'utilisation et de modification.
