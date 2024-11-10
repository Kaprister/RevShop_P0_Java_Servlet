<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login as Seller</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom Tailwind styles */
        body {
            @apply h-screen bg-cover bg-center bg-no-repeat;
            background-image: url('https://res.cloudinary.com/dbleggv6z/image/upload/v1728223261/RevShop/b17_bohafc.jpg');
            background-repeat: no-repeat;
    		background-size: cover;
        }

        /* Background overlay for better contrast */
        .overlay {
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay */
        }
    </style>
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-semibold text-center text-gray-700 mb-6">Seller Login</h2>
        <form action="${pageContext.request.contextPath}/SellerController" method="post">
            <input type="hidden" name="action" value="login">
            
            <div class="mb-4">
                <label for="email" class="block text-gray-600 font-semibold mb-2">Email:</label>
                <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-indigo-400" required>
            </div>

            <div class="mb-4">
                <label for="password" class="block text-gray-600 font-semibold mb-2">Password:</label>
                <input type="password" id="password" name="password" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-indigo-400" required>
            </div>

            <div class="flex justify-center">
                <input type="submit" value="Login" class="bg-indigo-500 text-white font-semibold py-2 px-6 rounded-md hover:bg-indigo-600 cursor-pointer">
            </div>
            
             <p
		      class="mt-6 flex justify-center font-sans text-sm font-light leading-normal text-inherit antialiased"
		    >
		      Don't have an account?
		      <a
		        class="ml-1 block font-sans text-sm font-bold leading-normal text-cyan-500 antialiased"
		        href="${pageContext.request.contextPath}/views/seller/register.jsp"
		      >
		        Sign up
		      </a>
		    </p>
        </form>
    </div>
</body>
</html>
