<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
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

        .login-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
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

        .login-header {
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

        .login-form {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
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

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 35px;
            cursor: pointer;
            color: #666;
        }

        .login-button {
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

        .login-button:hover {
            background-color: #5a67d8;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .login-button:active {
            transform: scale(0.98);
        }

        .login-footer {
            display: flex;
            justify-content: space-between;
            padding: 20px 30px;
            background-color: #f7f7f7;
            font-size: 14px;
        }

        .login-footer a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-footer a:hover {
            color: #5a67d8;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 30px;
            border-radius: 10px;
            width: 300px;
            max-width: 90%;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            animation: fadeInModal 0.3s ease-out;
        }

        @keyframes fadeInModal {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .modal h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
        }

        .ok-button {
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .ok-button:hover {
            background-color: #5a67d8;
        }

        .ok-button:active {
            transform: scale(0.98);
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
	            <a href="Login.jsp" class="active">Log In</a>
	            <a href="SignUp.jsp">Sign Up</a>
        	</div>
        </nav>
    </header>
<div style="display:flex;justify-content:center;align-items:center;margin-top:120px;">
    <div class="login-container">
        <div class="login-header">
            Welcome Back
        </div>
        <form class="login-form" action="Login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <input type="hidden" name="returnUrl" value="<%= request.getParameter("returnUrl") %>">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <span class="password-toggle" onclick="togglePassword()">&#128065;</span>
            </div>
            <button type="submit" class="login-button">Sign In</button>
        </form>
        <div class="login-footer">
            <a href="ForgotPassword.jsp">Forgot Password?</a>
            <a href="SignUp.jsp">Not registered?</a>
        </div>
    </div>

    <div class="modal" id="errorModal">
        <div class="modal-content">
            <h3>Email or Password is incorrect</h3>
            <button class="ok-button" onclick="closeModal()">OK</button>
        </div>
    </div>

	<div class="modal" id="successModal">
        <div class="modal-content">
            <h3>Your password has been successfully updated!</h3>
            <button class="ok-button" onclick="closeModal()">Close</button>
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
	    function togglePassword() {
	        var passwordInput = document.getElementById('password');
	        var passwordToggle = document.querySelector('.password-toggle');
	        
	        if (passwordInput.type === 'password') {
	            passwordInput.type = 'text';
	            passwordToggle.innerHTML = '&#128065;'; 
	        } else {
	            passwordInput.type = 'password';
	            passwordToggle.innerHTML = '&#128065;'; 
	        }
	    }
	    
	    window.onload = function () {
	        const urlParams = new URLSearchParams(window.location.search);

	        if (urlParams.get('error') === 'invalid') {
	            document.getElementById('errorModal').style.display = 'flex'; // Use 'flex' for center alignment
	        }
	        if (urlParams.get('success') === 'true') {
	            document.getElementById('successModal').style.display = 'flex';
	        }
	    };
	    function closeModal() {
	        document.getElementById('errorModal').style.display = 'none';
	        document.getElementById('successModal').style.display = 'none';
	    }
	</script>

    </script>
</body>
</html>
