<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.model.Menu,com.dao.MenuDao,com.daoimp.MenuDaoImp,com.model.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu - EatEase</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <% 
        User user = (User) session.getAttribute("user");
        String username = (user != null) ? user.getUsername() : null;

        List<Menu> menuList = (List<Menu>) request.getAttribute("MenuList");
        String restaurantId = (String) request.getAttribute("restaurantId");
        String restaurantName = (String) request.getAttribute("restaurantName");
    %>
    <header class="hero">
        <nav>
            <div class="logo">
                <i class="fas fa-utensils logo-icon"></i>
                EatEase
            </div>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="Search for menu items...">
                <button class="search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </div>
            <div class="nav-links">
                <a href="Home.jsp">Home</a>
                <% if (username != null) { %>
                    <a href="MyOrders.jsp">My Orders</a>
                    <a href="Logout" class="logout">Logout</a>
                <% } else { %>
                    <a href="Login.jsp">Log In</a>
                    <a href="SignUp.html">Sign Up</a>
                <% } %>
                
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
            </div>
        </nav>
    </header>

    <main>
        <section class="menu-section">
            <h2 class="res-name"><%= restaurantName %> Menu</h2>
            <div class="menu-container">
                <% 
				    if (menuList != null && !menuList.isEmpty()) { 
				        for (Menu item : menuList) { 
				            boolean isAvailable = item.isAvailable(); 
				%>
                        <div class="menu-item <%= isAvailable ? "" : "unavailable" %>">
				    <img src="<%= request.getContextPath() %>/<%= item.getImgPath() %>" alt="<%= item.getItemName() %>" class="menu-image">
				    <div class="menu-info">
				        <h3 class="menu-name"><%= item.getItemName() %></h3>
				        <p class="menu-description"><%= item.getDescription() %></p>
				        <p class="menu-price"><strong>Price:</strong> ₹<%= item.getPrice() %></p>
				        <p class="menu-rating"><strong>Rating:</strong> ⭐ <%= item.getRating() %></p>
				        <% if (isAvailable) { %>
				            <form action="<%= (user == null) ? "Login.jsp" : "AddToCart" %>" method="post">
							    <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
							    <input type="hidden" name="returnUrl" value="<%= request.getContextPath() %>/GetMenu?resId=<%= restaurantId %>">
							    <% if (user == null) { %>
							        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
							    <% } else { %>
							        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
							    <% } %>
							</form>
				        <% } else { %>
				            <p class="not-available">Not Available</p>
				        <% } %>
				    </div>
				</div>
				<% 
				        } 
				    } else { 
				%>
				<p class="no-menu">No menu items available for this restaurant. Please check back later!</p>
				<% } %>
            </div>
        </section>
    </main>

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
                    <li><a href="Home">Home</a></li>
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
        document.getElementById('searchInput').addEventListener('input', function () {
            var searchTerm = this.value.toLowerCase();
            var items = document.querySelectorAll('.menu-item');
            
            items.forEach(function (item) {
                var name = item.querySelector('.menu-name').textContent.toLowerCase();
                var description = item.querySelector('.menu-description').textContent.toLowerCase();
                
                if (name.includes(searchTerm) || description.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>
