<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway</title>
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Add card hover effect */
        .payment-card {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .payment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
        }
        .form-input:focus {
            outline: none;
            border-color: #2563EB;
            box-shadow: 0 0 5px rgba(37, 99, 235, 0.5);
        }
    </style>
</head>
<body class="bg-gray-100">
    <!-- Include header.jsp for Navbar -->
    <%@ include file="../../header.jsp" %>

    <!-- Payment Gateway Container -->
    <div class="container mx-auto py-10 px-4 lg:px-20">
        <h1 class="text-4xl font-bold text-center text-gray-800 mb-8">Secure Payment Gateway</h1>

        <!-- Payment Methods Section -->
        <div class="bg-white p-8 rounded-lg shadow-lg max-w-4xl mx-auto">
            <h2 class="text-2xl font-semibold mb-6">Choose Your Payment Method</h2>

            <!-- Payment Method Tabs -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
                <!-- Card Payment -->
                <div class="payment-card p-6 bg-blue-50 text-center rounded-lg">
                    <img src="https://img.icons8.com/ios-filled/50/000000/bank-cards.png" alt="Card Payment" class="mx-auto mb-3">
                    <h3 class="text-xl font-bold">Credit / Debit Card</h3>
                </div>

                <!-- UPI Payment -->
                <div class="payment-card p-6 bg-green-50 text-center rounded-lg">
                    <img src="https://img.icons8.com/ios-filled/50/000000/rupee.png" alt="UPI Payment" class="mx-auto mb-3">
                    <h3 class="text-xl font-bold">UPI</h3>
                </div>

                <!-- Net Banking -->
                <div class="payment-card p-6 bg-yellow-50 text-center rounded-lg">
                    <img src="https://img.icons8.com/external-flat-juicy-fish/60/000000/external-bank-banking-flat-flat-juicy-fish.png" alt="Net Banking" class="mx-auto mb-3">
                    
                    <h3 class="text-xl font-bold">Net Banking</h3>
                </div>

                <!-- Wallets -->
                <div class="payment-card p-6 bg-pink-50 text-center rounded-lg">
                    <img src="https://img.icons8.com/ios-filled/50/000000/wallet-app.png" alt="Wallet Payment" class="mx-auto mb-3">
                    <h3 class="text-xl font-bold">Wallets</h3>
                </div>
            </div>

            <!-- Payment Form (Card Payment Example) -->
            <form action="" method="post">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Card Details -->
                    <div>
                        <label for="cardNumber" class="block text-lg font-semibold mb-2">Card Number</label>
                        <input type="text" name="cardNumber" id="cardNumber" placeholder="1234 5678 9012 3456" class="form-input w-full p-3 border border-gray-300 rounded-lg mb-4" required>

                        <label for="cardName" class="block text-lg font-semibold mb-2">Cardholder Name</label>
                        <input type="text" name="cardName" id="cardName" placeholder="John Doe" class="form-input w-full p-3 border border-gray-300 rounded-lg mb-4" required>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label for="expiryDate" class="block text-lg font-semibold mb-2">Expiry Date</label>
                                <input type="text" name="expiryDate" id="expiryDate" placeholder="MM/YY" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                            </div>
                            <div>
                                <label for="cvv" class="block text-lg font-semibold mb-2">CVV</label>
                                <input type="text" name="cvv" id="cvv" placeholder="123" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                            </div>
                        </div>
                    </div>

                    <!-- Billing Address -->
                    <div>
                        <label for="address" class="block text-lg font-semibold mb-2">Billing Address</label>
                        <textarea name="address" id="address" rows="4" class="form-input w-full p-3 border border-gray-300 rounded-lg mb-4" placeholder="Street, City, Postal Code" required></textarea>

                        <label for="phone" class="block text-lg font-semibold mb-2">Phone Number</label>
                        <input type="text" name="phone" id="phone" placeholder="9876543210" class="form-input w-full p-3 border border-gray-300 rounded-lg" required>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="mt-8 text-center">
                    <a href="payment-success.jsp" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition-all duration-300 focus:ring-4 focus:ring-blue-300 focus:outline-none">
                        Complete Payment
                    </a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
