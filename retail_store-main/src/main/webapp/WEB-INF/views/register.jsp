<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 font-roboto">
    <div class="min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <h2 class="text-2xl font-bold mb-6 text-center">Create an Account</h2>
            <form action="register" method="POST" class="space-y-4">
                <div>
                    <label for="fullName" class="block text-sm font-medium text-gray-700">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" id="email" name="email" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <input type="password" id="password" name="password" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="phoneNumber" class="block text-sm font-medium text-gray-700">Phone Number</label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                    <input type="text" id="address" name="address" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <span class="block text-sm font-medium text-gray-700">Gender</span>
                    <div class="mt-2 space-y-2">
                        <div class="flex items-center">
                            <input id="male" name="gender" type="radio" value="Male" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" required>
                            <label for="male" class="ml-3 block text-sm font-medium text-gray-700">Male</label>
                        </div>
                        <div class="flex items-center">
                            <input id="female" name="gender" type="radio" value="Female" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300">
                            <label for="female" class="ml-3 block text-sm font-medium text-gray-700">Female</label>
                        </div>
                        <div class="flex items-center">
                            <input id="other" name="gender" type="radio" value="Other" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300">
                            <label for="other" class="ml-3 block text-sm font-medium text-gray-700">Other</label>
                        </div>
                    </div>
                </div>
                <div class="flex items-center">
                    <input id="terms" name="terms" type="checkbox" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded" required>
                    <label for="terms" class="ml-2 block text-sm text-gray-900">I agree to the <a href="#" class="text-indigo-600 hover:text-indigo-500">Terms & Conditions</a></label>
                </div>
                <div>
                    <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Register</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
