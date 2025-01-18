<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            animation: fadeInBody 1s ease-out;
        }
        @keyframes fadeInBody {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .signup-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            overflow: hidden;
            width: 100%;
            max-width: 600px;
            animation: slideIn 0.8s ease-out;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .signup-header {
            background-color: #f7f7f7;
            color: #333;
            text-align: center;
            padding: 25px 0;
            font-size: 24px;
            font-weight: 600;
            animation: fadeInText 1s ease-out;
        }
        @keyframes fadeInText {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .signup-form {
            padding: 30px;
        }
        .form-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-size: 14px;
            opacity: 0;
            animation: fadeInLabel 1s ease-out forwards;
        }
        @keyframes fadeInLabel {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-group-item {
            flex: 1 1 45%;
            min-width: 220px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #888;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease, transform 0.2s ease;
        }
        .form-group input:focus {
            border-color: #667eea;
            outline: none;
            transform: scale(1.02);
        }
        .signup-button {
            width: 100%;
            padding: 12px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.3s ease;
        }
        .signup-button:hover {
            background-color: #5a67d8;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .signup-button:active {
            transform: scale(0.98);
        }
        .signup-footer {
            text-align: center;
            padding: 20px 30px;
            background-color: #f7f7f7;
            font-size: 14px;
        }
        .signup-footer a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .signup-footer a:hover {
            color: #5a67d8;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }
        .modal-header {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .modal-message {
            margin: 20px 0;
            font-size: 16px;
            color: red;
        }
        .modal-footer {
            text-align: center;
        }
        .close, .ok-button {
            background-color: #667eea;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .close:hover, .ok-button:hover {
            background-color: #5a67d8;
        }
        .close:focus, .ok-button:focus {
            outline: none;
        }
    </style>
</head>
<body>
	<header class="hero">
        <nav>
            <div class="logo">
                <i class="fas fa-utensils logo-icon"></i>
                EatEase
            </div>
            <div class="nav-links">
	            <a href="Home.jsp">Home</a>
	            <a href="Login.jsp">Log In</a>
	            <a href="SignUp.jsp" class="active">Sign Up</a>
        	</div>
        </nav>
    </header>
<div style="display:flex;justify-content:center;align-items:center;margin-top:120px;">
    <div class="signup-container">
        <div class="signup-header">Create an Account</div>
        <form class="signup-form" id="signupForm" action="UserRegister" method="Post">
            <div class="form-group">
                <div class="form-group-item">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required>
                </div>
                <div class="form-group-item">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
            </div>
            <div class="form-group">
                <div class="form-group-item">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                </div>
                <div class="form-group-item">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password" required>
                </div>
            </div>
            <div class="form-group">
                <div class="form-group-item">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter your address" required>
                </div>
            </div>
            <button type="submit" class="signup-button">Sign Up</button>
        </form>
        <div class="signup-footer">
            Already have an account? <a href="Login.jsp">Log In</a>
        </div>
    </div>

    <div id="passwordMismatchModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Password Error</div>
            <div class="modal-message">The passwords you entered do not match. Please try again.</div>
            <div class="modal-footer">
                <button class="close" onclick="closePasswordMismatchModal()">OK</button>
            </div>
        </div>
    </div>

    <div id="errorModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Error</div>
            <div class="modal-message">The email you entered is already registered. Please try a different one.</div>
            <div class="modal-footer">
                <button class="ok-button" id="closeErrorModal">OK</button>
            </div>
        </div>
    </div>
</div>
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
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm-password").value;

            if (password !== confirmPassword) {
                showPasswordMismatchModal();
                return false; 
            }
            return true; 
        }

        function showPasswordMismatchModal() {
            document.getElementById("passwordMismatchModal").style.display = "block";
        }

        function closePasswordMismatchModal() {
            document.getElementById("passwordMismatchModal").style.display = "none";
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error') && urlParams.get('error') === 'emailExists') {
                showEmailExistsModal();
            }
        };

        function showEmailExistsModal() {
            document.getElementById("errorModal").style.display = "block";
        }

        document.getElementById("closeErrorModal").onclick = function () {
            document.getElementById("errorModal").style.display = "none";
        };

        document.getElementById("signupForm").onsubmit = function () {
            return validateForm(); 
        };
    </script>
</body>
</html>
