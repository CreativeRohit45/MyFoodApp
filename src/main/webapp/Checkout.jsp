<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.model.User,com.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .checkout-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
            width: 100%;
            max-width: 1200px;
            display: flex;
            padding: 30px;
            animation: fadeInBody 1s ease-out;
            overflow-y: auto;
            max-height: 95vh;
        }

        .left-section {
            width: 55%;
            padding-right: 30px;
        }

        .right-section {
            width: 45%;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            margin-bottom: 20px;
        }

        .user-info label {
            font-size: 14px;
            color: #555;
        }

        .user-info input {
            width: 80%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #888;
            border-radius: 5px;
            background-color: #f7f7f7;
            transition: border-color 0.3s ease, transform 0.2s ease;
        }

        .user-info input:focus {
            border-color: #667eea;
            outline: none;
            transform: scale(1.02);
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.7);
        }

        .user-info input[readonly] {
            background-color: #e0e0e0; 
            border: 1px solid #ccc; 
            cursor: not-allowed; 
        }
        
        .address-field {
            margin-bottom: 20px;
        }

        .address-field label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }

        .address-field textarea {
            width: 100%;
            padding: 6px;
            border: 1px solid #888;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease, transform 0.2s ease;
        }

        .address-field textarea:focus {
            border-color: #667eea;
            outline: none;
            transform: scale(1.02);
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.7);
        }

        .payment-methods {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .payment-methods label {
            display: flex;
            align-items: center;
        }

        .payment-methods input[type="radio"] {
            margin-right: 10px;
        }

        #upiInput, #cardInput {
            display: none;
        }

        #upiInput {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        #upiInput label {
            margin-right: 10px;
        }

        #upiInput input {
            width: 50%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #888;
            border-radius: 5px;
            background-color: #f7f7f7;
            transition: border-color 0.3s ease, transform 0.2s ease;
        }

        #upiInput input:focus {
            border-color: #667eea;
            outline: none;
            transform: scale(1.02);
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.7);
        }

        #cardInput {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        #cardInput .form-row {
            display: flex;
            gap: 10px;
        }

        #cardInput input[type="text"],
        #cardInput input[type="month"],
        #cardInput input[type="password"] {
            width: 60%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #888;
            border-radius: 5px;
            background-color: #f7f7f7;
            transition: border-color 0.3s ease, transform 0.2s ease;
        }

        #cardInput input[type="text"]:focus,
        #cardInput input[type="month"]:focus,
        #cardInput input[type="password"]:focus {
            border-color: #667eea;
            outline: none;
            transform: scale(1.02);
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.7);
        }

        .cart-summary {
            margin-bottom: 20px;
        }

        .cart-summary ul {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
        }

        .cart-summary ul li {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        hr {
            border: none;
            border-top: 1px solid #ddd;
        }

        .pay-now {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        button {
            padding: 14px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.3s ease;
            width: 100%;
        }

        button:hover {
            background-color: #5a67d8;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        button:active {
            transform: scale(0.98);
        }
        
        .modal {
            display: none; 
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        .modal h2 {
            margin-bottom: 20px;
        }

        .modal button {
            margin: 10px 5px;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #667eea;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .modal button:hover {
            background-color: #5a67d8;
        }

    </style>
</head>
<%
    User user = (User) session.getAttribute("user");
	if (user != null) {
		String userName = (user != null) ? user.getUsername() : null;
	    String userEmail = (user != null) ? user.getEmail() : null;
	    String userPhone = (user != null) ? user.getPhoneNumber() : null;
	    String userAddress = (user != null) ? user.getAddress() : null;
	    Map<Menu, Integer> cartMap = (Map<Menu, Integer>) session.getAttribute("cartMap");
	    double finalAmount = (double) session.getAttribute("finalAmount");
	    int resId = (int) session.getAttribute("resId");
%>
<body>
	<header class="hero">
        <nav>
            <div class="logo">
                <i class="fas fa-utensils logo-icon"></i>
                EatEase
            </div>
            <div class="nav-links">
                <a href="Home.jsp">Home</a>
                <a href="MyOrders.jsp">My Orders</a>
                <a href="Logout" class="logout">Logout</a>
                <% 
				    int cartItemCount = (cartMap != null) ? cartMap.size() : 0;
				%>
                <a href="Cart.jsp" class="cart-link active">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-badge"><%= cartItemCount %></span>
                </a>
            </div>
        </nav>
    </header>
    <% String orderId = request.getParameter("orderId"); %>
    <div id="orderModal" class="modal">
        <div class="modal-content">
            <h2>Order Confirmed!</h2>
            <p>Your order has been placed successfully.</p>
            <button onclick="window.location.href='Home.jsp'">Return to Home</button>
            <button onclick="window.location.href='TrackOrder.jsp?orderId=<%=orderId%>'">Track Order</button>
        </div>
    </div>
    
   <div style="display:flex;justify-content: center;align-items: center;margin-top: 130px;">
    <div class="checkout-container">
        <div class="left-section">
         <form action="ProcessPayment" method="post">
	            <h1>Checkout</h1>
	
	            <div class="user-info">
	                <div>
	                    <label for="userName">Name</label>
	                    <input type="text" id="userName" value="<%= userName %>" readonly>
	                </div>
	                <div>
	                    <label for="userEmail">Email</label>
	                    <input type="text" id="userEmail" value="<%= userEmail %>" readonly>
	                </div>
	            </div>
	            <div class="user-info">
		            <div style="display:flex;align-items: center;gap: 10px;">
				        <label for="userPhone">Number</label>
				        <input type="text" id="userPhone" name="userPhone" value="<%= userPhone %>">
				    </div>
				</div>
	            <div class="address-field">
	                <label for="userAddress">Address</label>
	                <textarea id="userAddress" name="userAddress" rows="3"><%= userAddress %></textarea>
	            </div>

           
                <h2>Payment Method</h2>
	                <div class="payment-methods">
	                    <label>
	                        <input type="radio" name="paymentMode" value="UPI" required> UPI
	                    </label>
	                    <label>
	                        <input type="radio" name="paymentMode" value="Card" required> Card
	                    </label>
	                </div>

	                <div id="upiInput" style="display:none;">
	                    <label for="upiId">Enter UPI ID:</label>
	                    <input type="text" id="upiId" name="upiId" placeholder="example@upi">
	                </div>

	                <div id="cardInput" style="display:none;">
	                    <div class="form-row">
	                        <div>
	                            <label for="cardNumber">Card Number:</label>
	                            <input type="text" id="cardNumber" name="cardNumber" placeholder="XXXX-XXXX-XXXX-XXXX">
	                        </div>
	                    </div>
	                    <div class="form-row">
	                        <div>
	                            <label for="expiryDate">Expiry Date:</label>
	                            <input type="month" id="expiryDate" name="expiryDate">
	                        </div>
	                        <div>
	                            <label for="cvv">CVV:</label>
	                            <input type="password" id="cvv" name="cvv" maxlength="3">
	                        </div>
	                    </div>
	                </div>

                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                <input type="hidden" name="resId" value="<%= resId %>">
                <input type="hidden" name="finalAmount" value="<%= finalAmount %>">
        </div>

		        <div class="right-section">
		            <div class="cart-summary">
		                <h2>Order Summary</h2>
		                <ul>
		                    <% 
		                        if (cartMap != null) {
		                            for (Map.Entry<Menu, Integer> entry : cartMap.entrySet()) {
		                                Menu menu = entry.getKey();
		                                int quantity = entry.getValue();
		                                double itemTotal = menu.getPrice() * quantity;
		                    %>
		                    <li>
		                        <span><%= menu.getItemName() %> (x<%= quantity %>)</span>
		                        <span>₹<%= String.format("%.2f", itemTotal) %></span>
		                    </li>
		                    <% 
		                            }
		                        } else { 
		                    %>
		                    <p>Your cart is empty.</p>
		                    <% } %>
		                </ul>
		                <hr>
		                <p><strong>Total Amount:</strong> <span>₹<%= String.format("%.2f", finalAmount) %></span></p>
		
		                <div class="pay-now">
		                    <button type="submit">Pay Now</button>
		                </div>
		            </div>
		        </div>
        </form>
    </div>
  </div>
    	<%
		    } else {
		        response.sendRedirect("Login.jsp");
		    }
		%>
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">
                    <i class="fas fa-utensils logo-icon"></i> 
                    EatEase
                </div>
                <p class="footer-description">Discover the best restaurants in your city with EatEase. Your ultimate food discovery platform.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Restaurants</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Categories</h3>
                <ul class="footer-links">
                    <li><a href="#">Fine Dining</a></li>
                    <li><a href="#">Fast Food</a></li>
                    <li><a href="#">Cafes</a></li>
                    <li><a href="#">Food Trucks</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Connect With Us</h3>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                </div>
                <div class="newsletter">
                    <h3>Newsletter</h3>
                    <div class="newsletter-form">
                        <input type="email" placeholder="Enter your email">
                        <button class="subscribe-btn">Subscribe</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; <%= java.time.Year.now().getValue() %> EatEase. All rights reserved.</p>
        </div>
    </footer>

    <script>
        const upiInput = document.getElementById("upiInput");
        const cardInput = document.getElementById("cardInput");

        function togglePaymentInputs() {
            const selectedPaymentMode = document.querySelector('input[name="paymentMode"]:checked')?.value;

            if (selectedPaymentMode === "UPI") {
                upiInput.style.display = "flex";
                cardInput.style.display = "none";
            } else if (selectedPaymentMode === "Card") {
                upiInput.style.display = "none";
                cardInput.style.display = "flex";
            }
        }

        document.querySelectorAll('input[name="paymentMode"]').forEach(radio => {
            radio.addEventListener('change', togglePaymentInputs);
        });

        window.onload = togglePaymentInputs;
        
        const params = new URLSearchParams(window.location.search);

        if (params.has('orderId')) {
            document.getElementById('orderModal').style.display = 'flex';
        }
    </script>

</body>
</html>
