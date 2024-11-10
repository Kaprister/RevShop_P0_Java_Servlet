<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register as Buyer</title>
    <script src="https://cdn.tailwindcss.com"></script>
      <style>
        /* Custom Tailwind styles */
        body {
            @apply h-screen bg-cover bg-center bg-no-repeat;
            background-image: url('https://res.cloudinary.com/dbleggv6z/image/upload/v1728223260/RevShop/b18_fskrnx.jpg');
            background-repeat: no-repeat;
    		background-size: cover;
        }

        /* Background overlay for better contrast */
        .overlay {
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
        }
    </style>
</head>
<body class="flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center">Buyer Registration</h2>
        <form action="${pageContext.request.contextPath}/BuyerController" method="post" class="space-y-4">
            <input type="hidden" name="action" value="register">
            
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Name:</label>
                <input type="text" id="name" name="name" required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
                <input type="email" id="email" name="email" required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                <input type="password" id="password" name="password" required
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            
            <div>
                <label for="address" class="block text-sm font-medium text-gray-700">Address:</label>
                <textarea id="address" name="address"
                    class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"></textarea>
            </div>
            
            <div>
                <input type="submit" value="Register" 
                    class="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700">
            </div>
            
            <p
		      class="mt-6 flex justify-center font-sans text-sm font-light leading-normal text-inherit antialiased"
		    >
		      Already have an account?
		      <a
		        class="ml-1 block font-sans text-sm font-bold leading-normal text-cyan-500 antialiased"
		        href="${pageContext.request.contextPath}/views/buyer/login.jsp"
		      >
		        Login
		      </a>
		    </p>
        </form>
    </div>
</body>
</html>
