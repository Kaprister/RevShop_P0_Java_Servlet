<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Custom animation */
        @keyframes successBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

    <!-- Payment success card -->
    <div class="bg-white p-8 rounded-lg shadow-lg text-center ">
        <!-- Success icon animation -->
        <div class="mb-4 flex justify-center animate-bounce transition duration-500 ease-in-out">
            <div class="bg-green-100 p-4 rounded-full ">
                <svg class="w-16 h-16 text-green-500 animate-pulse" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m0 0a9 9 0 11-5.833-2.165M12 2v4m0 4v2a1 1 0 01-1 1H9m3 4v4" />
                </svg>
            </div>
        </div>

        <!-- Success message -->
        <h1 class="text-2xl font-bold text-gray-800">Payment Successful!</h1>
        <p class="text-gray-600 mt-2">Thank you for your purchase. Your order has been processed.</p>

        <!-- Button to continue -->
        <a href="${pageContext.request.contextPath}/index.jsp" class="mt-6 inline-block bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-lg transition duration-300">
            Continue Shopping
        </a>
    </div>

</body>
</html>
