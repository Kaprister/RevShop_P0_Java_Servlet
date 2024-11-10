<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom Styles -->
    <style>
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }
        body {
            background-image: url('https://res.cloudinary.com/dbleggv6z/image/upload/v1728223264/RevShop/banner_jqt39a.png'); /* Set background image */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center; /* Center the background image */
        }

        /* Styles for header and footer */
        header, footer {
            background-color: white; /* White background with slight transparency */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Form Styles */
        .form-container {
            background-color: rgba(255, 255, 255, 0.7); 
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        /* Enhanced input styles */
        input, textarea {
            background-color: rgba(255, 255, 255, 0.8); 
            border: 1px solid rgba(0, 0, 0, 0.2); 
            transition: border-color 0.3s ease, box-shadow 0.3s ease; 
        }
        
        /* Input focus styles */
        input:focus, textarea:focus {
            outline: none;
            border-color: #6366f1; /* Indigo color */
            box-shadow: 0 0 10px rgba(99, 102, 241, 0.5); 
        }

     
        .btn-hover {
            transition: background-color 0.3s ease, transform 0.3s ease; 
        }
        .btn-hover:hover {
            transform: scale(1.05);
            background-color: #4f46e5; 
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="../../header.jsp" %>
    
    <div class="image-container relative">
        <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223257/RevShop/b1_elce1n.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
        <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
            <h1 class="text-white text-3xl md:text-4xl font-bold">Add Product</h1>
        </div>
    </div>

    <div class="flex justify-center items-center p-4">
        <div class="form-container bg-white bg-opacity-10 p-8 rounded-lg shadow-lg w-full max-w-lg fade-in">
            
            <form action="${pageContext.request.contextPath}/ProductController" method="post" class="space-y-6 ">
                <input type="hidden" name="action" value="addProduct">
                <input type="hidden" name="sellerId" value="${sellerId}">

                <!-- Two fields side by side in larger screens, stack in smaller screens -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative">
                        <label for="name" class="block text-white  font-medium mb-1">Product Name:</label>
                        <input type="text" id="name" name="name" required 
                            class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                    </div>

                    <div class="relative">
                        <label for="brand" class="block text-white font-medium mb-1">Brand:</label>
                        <input type="text" id="brand" name="brand" required 
                            class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                    </div>
                </div>

                <!-- Another row for two side-by-side fields -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative">
                        <label for="price" class="block text-white font-medium mb-1">Price:</label>
                        <input type="number" step="0.01" id="price" name="price" required 
                            class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                    </div>

                    <div class="relative">
                        <label for="quantity" class="block text-white font-medium mb-1">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" required 
                            class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                    </div>
                </div>

                <!-- Full-width fields -->
                <div class="relative">
                    <label for="description" class="block text-white font-medium mb-1">Description:</label>
                    <textarea id="description" name="description" rows="4"
                        class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105"></textarea>
                </div>

                <div class="relative">
                    <label for="imageUrl" class="block text-white font-medium mb-1">Image URL:</label>
                    <input type="text" id="imageUrl" name="imageUrl" required 
                        class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                </div>

                <div class="relative">
                    <label for="rating" class="block text-white font-medium mb-1">Rating (1 to 5):</label>
                    <input type="number" id="rating" name="rating" required 
                        class="mt-1 block w-full px-4 py-3 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 transition duration-200 ease-in-out transform hover:scale-105">
                </div>

                <div>
                    <input type="submit" value="Add Product" 
                        class="w-full py-3 px-6 bg-indigo-600 text-white font-bold rounded-md shadow-sm transition duration-300 transform hover:scale-105 btn-hover">
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/ProductController" 
                class="block text-center text-indigo-600 mt-6 hover:text-indigo-800 transition duration-300 transform hover:translate-y-1">
                View all products
            </a>
        </div>
    </div>

    <%-- Include footer.jsp for the Footer --%>
    <%@ include file="../../footer.jsp" %>
</body>
</html>
