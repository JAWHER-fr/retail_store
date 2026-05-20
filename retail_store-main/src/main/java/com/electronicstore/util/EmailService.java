package com.electronicstore.util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String FROM_EMAIL    = "dridijawherr@gmail.com";
    private static final String FROM_PASSWORD = "gpbf vcaq glan pkgk";

    // URL de base de ton application
    private static final String BASE_URL = "http://localhost:8082/retail_store";

    public static void sendOrderConfirmation(String toEmail, String userName,
                                             int orderId, double totalPrice) {
        Properties props = new Properties();
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("✅ Order Confirmation #" + orderId + " - Electronic Store");

            // Lien vers la page de commande
            String orderLink = BASE_URL + "/placeOrder?orderId=" + orderId;

            String emailBody =
                    "<html><body style='font-family: Arial, sans-serif; color: #333;'>" +

                            // Header
                            "<div style='background: linear-gradient(to right, #8A2BE2, #FF69B4); padding: 20px; text-align: center;'>" +
                            "<h1 style='color: white;'>Store</h1>" +
                            "</div>" +

                            // Body
                            "<div style='padding: 30px;'>" +
                            "<h2>Thank you for your order, " + userName + "! 🎉</h2>" +
                            "<p>Your order has been placed successfully.</p>" +

                            // Détails commande
                            "<div style='background: #f9f9f9; padding: 15px; border-radius: 8px; margin: 20px 0;'>" +
                            "<p><strong>📦 Order ID :</strong> #" + orderId + "</p>" +
                            "<p><strong>💰 Total    :</strong> " + String.format("%.2f", totalPrice) + " DT</p>" +
                            "<p><strong>📋 Status  :</strong> Pending</p>" +
                            "</div>" +

                            // Bouton lien
                            "<div style='text-align: center; margin: 30px 0;'>" +
                            "<a href='" + orderLink + "' " +
                            "style='background: linear-gradient(to right, #8A2BE2, #FF69B4); " +
                            "color: white; padding: 15px 30px; " +
                            "text-decoration: none; border-radius: 8px; " +
                            "font-size: 16px; font-weight: bold;'>" +
                            "🛍️ View My Order" +
                            "</a>" +
                            "</div>" +

                            "<p style='color: #888; font-size: 12px; text-align: center;'>" +
                            "If you have any questions, contact us at " + FROM_EMAIL +
                            "</p>" +
                            "</div>" +

                            // Footer
                            "<div style='background: #333; color: white; text-align: center; padding: 10px;'>" +
                            "<p>© 2026 Store. All rights reserved.</p>" +
                            "</div>" +

                            "</body></html>";

            message.setContent(emailBody, "text/html; charset=utf-8");
            Transport.send(message);

            System.out.println("✅ Email envoyé à : " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Erreur envoi email : " + e.getMessage());
        }
    }
}