<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.DecimalFormat,com.model.Menu,com.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .cart-container {
		    display: flex;
		    max-width: 1200px;
		    margin: 50px auto;
		    gap: 20px;
		    margin-top: 110px;
		}
		
		.cart-items {
		    flex: 2;
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		    display: flex; 
		    flex-direction: column; 
		}
		
		.cart-items-header {
		    display: flex;
		    justify-content: space-between; 
		    align-items: center;
		    width: 100%;
		}
		
		.cart-items h2 {
		    margin-bottom: 0;
		}
		
		.add-more-btn {
		    padding: 10px 20px;
		    background-color: #1d1f2c;
		    color: white;
		    text-decoration: none;
		    border-radius: 5px;
		}
		
		.add-more-btn:hover {
		    background-color: #444;
		}
		
		.cart-item {
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    border-bottom: 1px solid #ddd;
		    padding: 10px 0;
		}
		
		.cart-item img {
		    width: 80px;
		    height: 80px;
		    border-radius: 5px;
		}
		
		.cart-item-details {
		    flex: 2;
		    margin-left: 10px;
		}
		
		.cart-item-details h3 {
		    margin: 0;
		    font-size: 18px;
		}
		
		.cart-item-details p {
		    margin: 5px 0;
		    color: #777;
		}
		
		.cart-item-quantity {
		    align-items: center;
		    flex-direction: column;
		}
		
		.cart-item-quantity button {
		    padding: 5px 10px;
		    background-color: #1d1f2c;
		    color: white;
		    border: none;
		    cursor: pointer;
		}
		
		.cart-item-quantity button:hover {
		    background-color: #444;
		}
		
		.cart-item-price {
		    font-size: 16px;
		    font-weight: bold;
		    margin-top: 10px;
		}
		
		.cart-summary {
		    flex: 1;
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		    text-align: center;
		}
		
		.cart-summary h2 {
		    margin-bottom: 20px;
		}
		
		.summary-details {
		    text-align: left;
		    margin-bottom: 20px;
		}
		
		.summary-details p {
		    margin: 10px 0;
		    display: flex;
		    justify-content: space-between;
		    font-size: 16px;
		}
		
		.checkout-btn, .add-more-btn {
		    display: inline-block;
		    padding: 10px 20px;
		    background-color: #1d1f2c;
		    color: white;
		    text-decoration: none;
		    border-radius: 5px;
		}
		
		.checkout-btn:hover, .add-more-btn:hover {
		    background-color: #444;
		}

    </style>
</head>
<body>
    <%
	    Map<Menu, Integer> cartMap = (Map<Menu, Integer>) session.getAttribute("cartMap");
	    if (cartMap == null) {
	        cartMap = new HashMap<>();
	        session.setAttribute("cartMap", cartMap);
	    }
	
	    double totalAmount = 0.0;
	    double deliveryCharges = 30.0; 
	    DecimalFormat df = new DecimalFormat("₹#.##");
	    int totalQuantity = 0; 
        User user = (User) session.getAttribute("user");
    	if (user != null) {
    		if(!cartMap.isEmpty()) {
		        Integer resId = null;
		        for (Map.Entry<Menu, Integer> entry : cartMap.entrySet()) {
		        	Menu item = entry.getKey();
		        	if (resId == null) {
		                resId = item.getResId(); 
		            }
		        }
    %>
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

    <div class="cart-container">
        <div class="cart-items">
        	<div style="display:flex;width:100%;justify-content: space-evenly;">
	            <h2>Your Shopping Cart</h2>
	            <a href="<%= request.getContextPath() %>/GetMenu?resId=<%= resId %>" class="add-more-btn">Add More Items</a>  
            </div>
            <% if (cartMap.isEmpty()) { %>
                <p>Your cart is empty!</p>
            <% } else { %>
                <%  
                	for (Map.Entry<Menu, Integer> entry : cartMap.entrySet()) { 
                    Menu item = entry.getKey();
                    int quantity = entry.getValue();
                    totalAmount += item.getPrice() * quantity;
                    totalQuantity += quantity; 
                %>
                <div class="cart-item">
                    <img src="<%= item.getImgPath() %>" alt="<%= item.getItemName() %>">
                    <div class="cart-item-details">
                        <h3><%= item.getItemName() %></h3> 
                        <p><%= item.getDescription() %></p>
                        <p>Price:<%= df.format(item.getPrice()) %></p>
                    </div>
                    <div class="cart-item-quantity">
					    <form action="AddToCart" method="post" style="display: inline;">
						    <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
						    <input type="hidden" name="action" value="decrease">
						    <input type="hidden" name="returnUrl" value="<%= request.getRequestURI()%>">
						    <button type="submit">-</button>
						</form>
						
						<span>&nbsp;<%= quantity %>&nbsp;</span>
						
						<form action="AddToCart" method="post" style="display: inline;">
						    <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
						    <input type="hidden" name="action" value="increase">
						    <input type="hidden" name="returnUrl" value="<%= request.getRequestURI()%>">
						    <button type="submit">+</button>
						</form>


					    <div class="cart-item-price"><%= df.format(item.getPrice() * quantity) %></div>
					</div>

                </div>
                <% } %>
            <% } %>
        </div>

        <div class="cart-summary">
            <h2>Order Summary</h2>
            <div class="summary-details">
                <p><span>Items Total:</span><span><%= df.format(totalAmount) %></span></p>
                <p><span>Delivery Charges:</span><span><%= df.format(deliveryCharges) %></span></p>
                <hr>
                <p><strong><span>Total:</span><span><%= df.format(totalAmount + deliveryCharges) %></span></strong></p>
            </div>
            <%
            	session.setAttribute("finalAmount",totalAmount + deliveryCharges );
            	session.setAttribute("resId", resId);
            %>
            <a href="Checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
        </div>
    </div>
    	<%
    		} else {
		        response.sendRedirect("Home.jsp");
		    }
    		
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
</body>
</html>
