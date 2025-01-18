<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat,java.text.DecimalFormat,com.model.*,com.dao.*,com.daoimp.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --background-color: #f0f2f5;
            --text-color: #34495e;
            --card-bg-color: #ffffff;
            --header-bg-color: #2c3e50;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--text-color);
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .orders-header {
            background-color: var(--header-bg-color);
            color: #fff;
            text-align: center;
            padding: 2rem;
            border-radius: 10px 10px 0 0;
            font-size: 2rem;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        .orders-content {
            background-color: var(--card-bg-color);
            border-radius: 0 0 10px 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border-radius: 6px;
        }
        .orders-section {
            padding: 2rem;
        }
        .section-title {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 0.5rem;
        }
        .order-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #ccc;
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary-color);
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        .order-id {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        .order-status {
            font-weight: bold;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        .status-processing {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-shipped {
            background-color: #cce5ff;
            color: #004085;
        }
        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }
        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        .order-detail {
            font-size: 0.9rem;
        }
        .order-detail strong {
            display: block;
            margin-bottom: 0.3rem;
            color: #6c757d;
        }
        .track-order-btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
        }
        .track-order-btn:hover {
            background-color: #2980b9;
        }
        @media (max-width: 768px) {
            .order-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
	<%
        User user = (User) session.getAttribute("user");
        String username = (user != null) ? user.getUsername() : null;
        DecimalFormat df = new DecimalFormat("₹#.##");
        
        if (user != null) {
            int userId = user.getUserId();

            OrderDao orderDao = new OrderDaoImp();
            List<Order> orders = orderDao.getAllUsingUserId(userId);

            OrderItemDao orderItemDao = new OrderItemDaoImp();
            MenuDao menuDao = new MenuDaoImp();
            
            Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
            for (Order order : orders) {
                List<OrderItem> orderItems = orderItemDao.getAllOrderItemsByOrderId(order.getOrderId());
                orderItemsMap.put(order.getOrderId(), orderItems);
            }
  
    %>
    <div class="container">
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
		            <% } %>
                <% } else { %>
                    <a href="Login.jsp">Log In</a>
                    <a href="SignUp.html">Sign Up</a>
                <% } %>
            </div>
        </nav>
    </header>
        <main class="orders-content">
            <section class="orders-section">
                <h2 class="section-title">In Process Orders</h2>
                <%
                for (Order order : orders) {
                    if (!order.getStatus().equalsIgnoreCase("Completed")) {
                        List<OrderItem> orderItems = orderItemsMap.get(order.getOrderId());
           		 %>
                <div class="order-card">	
                    <div class="order-header">
                        <span class="order-id">Order #<%= order.getOrderId() %></span>
                        <span class="order-status status-processing"><%= order.getStatus() %></span>
                    </div>
                    <div class="order-details">
                        <div class="order-detail">
                            <strong>Date</strong>
                            <%
						        Date orderDate = order.getOrderDate();
						        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
						        String formattedDate = sdf.format(orderDate); 
						    %>
                           <%= formattedDate %>
                        </div>
                        <div class="order-detail">
                            <strong>Item</strong>
                           <ul>
			                    <% for (OrderItem item : orderItems) { 
			                    	Menu menu = menuDao.getMenuItem(item.getMenuId());
			                    %>
			                        <li><%= menu.getItemName() %> (Qty: <%= item.getQuantity() %>)</li>
			                    <% } %>
			                </ul>
                        </div>
                        <div class="order-detail">
                            <strong>Total</strong>
                            <%= df.format(order.getTotalAmount()) %>
                        </div>
                    </div>
                    <a href="TrackOrder.jsp?orderId=<%=order.getOrderId()%>" class="track-order-btn">Track Order</a>
                </div>
               <% } } %>
               
            </section>
            
            <section class="orders-section">
                <h2 class="section-title">Completed Orders</h2>
                 <%
	                for (Order order : orders) {
	                    if (order.getStatus().equalsIgnoreCase("Completed")) {
	                        List<OrderItem> orderItems = orderItemsMap.get(order.getOrderId());
           		 %>
                <div class="order-card">
                    <div class="order-header">
                        <span class="order-id">Order #<%= order.getOrderId() %></span>
                        <span class="order-status status-delivered">Delivered</span>
                    </div>
                    <div class="order-details">
                        <div class="order-detail">
                            <strong>Date</strong>
                            <%
						        Date orderDate = order.getOrderDate();
						        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
						        String formattedDate = sdf.format(orderDate); 
						    %>
                           <%= formattedDate %>
                        </div>
                        <div class="order-detail">
                            <strong>Item</strong>
                            <ul>
			                    <% for (OrderItem item : orderItems) { 
			                    	Menu menu = menuDao.getMenuItem(item.getMenuId());
			                    %>
			                        <li><%= menu.getItemName() %> (Qty: <%= item.getQuantity() %>)</li>
			                    <% } %>
			                </ul>
                        </div>
                        <div class="order-detail">
                            <strong>Total</strong>
                            <%= df.format(order.getTotalAmount()) %>
                        </div>
                    </div>
                </div>
                <% } } %>
                
            </section>
        </main>
        <%
		    } else {
		        response.sendRedirect("Login.jsp");
		    }
		%>
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
</body>
</html>