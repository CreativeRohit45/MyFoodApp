<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat,java.text.DecimalFormat,com.model.*,com.dao.*,com.daoimp.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
   
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Tracking</title> 
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
		:root {
		    --primary-color: #5b8ef7;
		    --secondary-color: #818cf8;
		    --success-color: #22c55e;
		    --error-color: #ef4444;
		    --background-color: #f9fafb;
		    --card-bg: #ffffff;
		    --text-primary: #1f2937;
		    --text-secondary: #6b7280;
		    --border-color: #e5e7eb;
		    --shadow-color: rgba(0, 0, 0, 0.1);
		    --gradient-primary: linear-gradient(to right, #4f46e5, #818cf8);
		    --progress-gradient: linear-gradient(to right, #22c55e, #4ade80);
		}
		
		* {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}
		
		body {
		    font-family: 'Poppins', sans-serif;
		    background: #e6e6fa;
		    color: var(--text-primary);
		}
		
		.container {
		    background-color: var(--card-bg);
		    border-radius: 1rem;
		    box-shadow: 0 8px 16px var(--shadow-color);
		    max-width: 900px;
		    width: 100%;
		    overflow: hidden;
		}
		
		.tracking-header {
		    background: var(--primary-color);;
		    color: white;
		    padding: 1.5rem 2rem;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.logo h1 {
		    font-size: 1.8rem;
		    font-weight: 700;
		    margin-left: 10px;
		}
		
		.order-id {
		    background-color: rgba(255, 255, 255, 0.3);
		    padding: 0.6rem 1.2rem;
		    border-radius: 0.5rem;
		    font-size: 0.9rem;
		    letter-spacing: 0.5px;
		    font-weight: 500;
		}
		
		.tracking-content {
		    padding: 2rem;
		}
		
		.map-container {
		    position: relative;
		    margin-bottom: 2rem;
		    border-radius: 1rem;
		    overflow: hidden;
		    height: 250px;
		    box-shadow: 0 4px 8px var(--shadow-color);
		}
		
		.map-image {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		    filter: brightness(90%);
		}
		
		.delivery-time {
		    position: absolute;
		    bottom: 1rem;
		    right: 1rem;
		    background-color: white;
		    padding: 1rem 1.5rem;
		    border-radius: 0.75rem;
		    box-shadow: 0 6px 12px var(--shadow-color);
		    display: flex;
		    align-items: center;
		    gap: 0.75rem;
		    font-size: 0.9rem;
		}
		
		.time-icon {
		    font-size: 1.8rem;
		    color: var(--success-color);
		}
		
		.progress-container {
		    margin-bottom: 2rem;
		    padding: 1rem;
		}
		
		.steps {
		    display: grid;
		    grid-template-columns: repeat(4, 1fr);
		    gap: 1.5rem;
		    margin-top: 2rem;
		}
		
		.step {
		    text-align: center;
		    position: relative;
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		    cursor: pointer;
		}
		
		.step:hover {
		    transform: scale(1.05);
		    box-shadow: 0 6px 12px var(--shadow-color);
		}
		
		.step-icon {
		    width: 60px;
		    height: 60px;
		    background-color: var(--border-color);
		    border-radius: 50%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin: 0 auto 0.75rem;
		    color: var(--text-secondary);
		    transition: all 0.3s ease;
		    box-shadow: 0 4px 8px var(--shadow-color);
		}
		
		.step.active .step-icon {
		    background: var(--success-color);
		    color: white;
		    transform: scale(1.15);
		}
		
		.step-content h3 {
		    font-size: 1rem;
		    font-weight: 600;
		    margin-bottom: 0.25rem;
		}
		
		.time {
		    font-size: 0.85rem;
		    color: var(--text-secondary);
		}
		
		.order-details {
		    border-radius: 0.75rem;
		    padding: 1.5rem;
		    margin-top: 1.5rem;
		    background-color: #f4f4f4;
		    border: 1px solid #ccc;
		    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
		}
		
		.order-details h2 {
		    font-size: 1.5rem;
		    font-weight: 700;
		    margin-bottom: 1.5rem;
		    color: var(--primary-color);
		}
		
		.details-grid {
		    display: grid;
		    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
		    gap: 1.5rem;
		}
		
		.detail-item {
		    display: flex;
		    flex-direction: column;
		    gap: 0.3rem;
		}
		
		.detail-label {
		    font-size: 0.9rem;
		    color: var(--text-secondary);
		    text-transform: uppercase;
		    font-weight: 500;
		}
		
		.detail-value {
		    font-size: 1rem;
		    font-weight: 600;
		}

}
</style>

</head>
	<%
        User user = (User) session.getAttribute("user");
        String username = (user != null) ? user.getUsername() : null;
        DecimalFormat df = new DecimalFormat("₹#.##");
        
        if (user != null) {
        	
        	int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderItemDao orderItemDao = new OrderItemDaoImp();
            MenuDao menuDao = new MenuDaoImp();
            
            List<OrderItem> orderItems = orderItemDao.getAllOrderItemsByOrderId(orderId);
            
            String orderStatus = (String) session.getAttribute("orderStatus");
		    String orderPlacedTime = (String) session.getAttribute("orderPlacedTime");
		    String preparingTime = (String) session.getAttribute("preparingTime");
		    String outForDeliveryTime = (String) session.getAttribute("outForDeliveryTime");
		    String completedTime = (String) session.getAttribute("completedTime");
		    
		    String orderPlacedTimeStr = (orderPlacedTime != null) ? orderPlacedTime : "--:--";
		    String preparingTimeStr = (preparingTime != null) ? preparingTime : "--:--";
		    String outForDeliveryTimeStr = (outForDeliveryTime != null) ? outForDeliveryTime : "--:--";
		    String completedTimeStr = (completedTime != null) ? completedTime : "--:--";
	
		    if (orderStatus == null) {
		        orderStatus = "Order Placed"; 
		    }
            
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
	                <% if (username != null) { %>
	                    <a href="MyOrders.jsp" class="active">My Orders</a>
	                    <a href="Logout" class="logout">Logout</a>
	                    <% 
		                Map<Menu, Integer> cartMap = (Map<Menu, Integer>) session.getAttribute("cartMap");
					    int cartItemCount = (cartMap != null) ? cartMap.size() : 0;
						%>
		                <% if (cartItemCount > 0) { %>
			                <a href="Cart.jsp" class="cart-link">
			                    <i class="fas fa-shopping-cart"></i>
			                    <span class="cart-badge"><%= cartItemCount %></span>
			                </a>
			            <% } } %>
	            </div>
	        </nav>
	    </header>
<div style="display:flex;justify-content:center;align-items:center;margin-top: 120px">
    <div class="container">
	    
     <header class="tracking-header">
            <div class="logo">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="8 12 12 16 16 12"/><line x1="12" y1="8" x2="12" y2="16"/></svg>
                <h1>Track Your Order</h1>
            </div>
            <div class="order-id">Order #<%= orderId %></div>
        </header>

        <main class="tracking-content">
           <div class="order-details">
			    <table style="width: 100%; border-collapse: collapse;">
			        <thead>
			            <tr>
			                <th style="text-align: left; padding: 8px;">Item Name</th>
			                <th style="text-align: center; padding: 8px;">Quantity</th>
			                <th style="text-align: right; padding: 8px;">Price</th>
			            </tr>
			        </thead>
			        <tbody>
			           <%
			          	double totalAmount = 0; 
		                for (OrderItem item : orderItems) { 
		                    Menu menu = menuDao.getMenuItem(item.getMenuId());
		                    double price = menu.getPrice() * item.getQuantity();
		                    totalAmount += price;
			           %>
			                <tr>
			                    <td style="padding: 8px; border-bottom: 1px solid #ddd;"><%= menu.getItemName() %></td>
			                    <td style="text-align: center; padding: 8px; border-bottom: 1px solid #ddd;"><%= item.getQuantity() %></td>
			                    <td style="text-align: right; padding: 8px; border-bottom: 1px solid #ddd;">₹<%= String.format("%.2f", price) %></td>
			                </tr>
			            <% } %>
			            <tr>
			                <td colspan="2" style="text-align: left; padding: 8px; font-weight: bold;">Delivery Charges</td>
			                <td style="text-align: right; padding: 8px;">₹30</td>
			            </tr>
			            <tr>
			                <td colspan="2" style="text-align: left; padding: 8px; font-weight: bold;">Total Amount</td>
			                <td style="text-align: right; padding: 8px; font-weight: bold;">₹<%= String.format("%.2f", totalAmount + 30) %></td>
			            </tr>
			        </tbody>
			    </table>
			</div>

            

            <div class="progress-container">
			    <div class="steps">
			        <div class="step" id="step1">
			            <div class="step-icon">
			                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			                    <path d="M20 12V8H6a2 2 0 0 1-2-2c0-1.1.9-2 2-2h12v4"/>
			                    <path d="M4 6v12c0 1.1.9 2 2 2h14v-4"/>
			                    <path d="M18 12c-1.1 0-2 .9-2 2s.9 2 2 2h4v-4h-4z"/>
			                </svg>
			            </div>
			            <div class="step-content">
			                <h3>Order Confirmed</h3>
			                <p class="time" id="time1">--:--</p>
			            </div>
			        </div>
			
			        <div class="step" id="step2">
			            <div class="step-icon">
			                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			                    <path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/>
			                </svg>
			            </div>
			            <div class="step-content">
			                <h3>Preparing</h3>
			                <p class="time" id="time2">--:--</p>
			            </div>
			        </div>
			
			        <div class="step" id="step3">
			            <div class="step-icon">
			                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
			                </svg>
			            </div>
			            <div class="step-content">
			                <h3>Out for Delivery</h3>
			                <p class="time" id="time3">--:--</p>
			            </div>
			        </div>
			
			        <div class="step" id="step4">
			            <div class="step-icon">
			                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
			                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>
			                </svg>
			            </div>
			            <div class="step-content">
			                <h3>Delivered</h3>
			                <p class="time" id="time4">--:--</p>
			            </div>
			        </div>
			    </div>
			</div>


            <div class="order-details">
                <h2>Delivery Details</h2>
                <div class="details-grid">
                    <div class="detail-item">
                        <span class="detail-label">Delivery Address</span>
                        <span class="detail-value"><%= user.getAddress() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Contact</span>
                        <span class="detail-value"><%= user.getPhoneNumber() %></span>
                    </div>
                </div>
            </div>
        </main>
        
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
    <%!
	    String formatTime(String timestamp) {
	        if (timestamp == null) return "--:--";
	        try {
	            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	            java.util.Date date = sdf.parse(timestamp);
	            java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("hh:mm a");
	            return timeFormat.format(date);
	        } catch (Exception e) {
	            return "--:--";
	        }
	    }
	%>
    
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        const orderStatus = "<%= orderStatus %>"; 
        const steps = document.querySelectorAll('.step');

        const orderPlacedTime = "<%= formatTime(orderPlacedTime) %>";
        const preparingTime = "<%= formatTime(preparingTime) %>";
        const outForDeliveryTime = "<%= formatTime(outForDeliveryTime) %>";
        const completedTime = "<%= formatTime(completedTime) %>";

        const statusSteps = {
            "Order Placed": 0,
            "Preparing": 1,
            "Out For Delivery": 2,
            "Completed": 3
        };

        const currentStep = statusSteps[orderStatus] || 0;

        steps.forEach((step, index) => {
            const time = step.querySelector('.time');
            if (index <= currentStep) {
                step.classList.add('active');
                switch (index) {
                    case 0:
                        time.textContent = orderPlacedTime;
                        break;
                    case 1:
                        time.textContent = preparingTime;
                        break;
                    case 2:
                        time.textContent = outForDeliveryTime;
                        break;
                    case 3:
                        time.textContent = completedTime;
                        break;
                }
            } else {
                step.classList.remove('active');
                time.textContent = '--:--';
            }
        });
    });

    </script>
    	<%
		    } else {
		        response.sendRedirect("Login.jsp");
		    }
		%>
</body>
</html>