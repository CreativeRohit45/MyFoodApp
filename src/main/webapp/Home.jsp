<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,com.model.*,com.dao.*,com.daoimp.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EatEase - Restaurant Discovery</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<% 
        User user = (User) session.getAttribute("user");
        String username = (user != null) ? user.getUsername() : null;
    %>
    <header class="hero">
        <nav>
            <div class="logo">
                <i class="fas fa-utensils logo-icon"></i>
                EatEase
            </div>
            <div class="search-container">
			    <input type="text" id="searchInput" placeholder="Search for restaurants, cuisines, or locations...">
			    <button class="search-btn">
			        <i class="fas fa-search"></i>
			    </button>
			</div>

            <div class="nav-links">
	            <a href="Home.jsp" class="active">Home</a>
	            <% if (username!=null) { %>
	                <a href="MyOrders.jsp">My Orders</a>
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
	                <a href="SignUp.jsp">Sign Up</a>
	            <% } %>
        	</div>
        </nav>
    </header>
    <div id="successModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Registration Successful</div>
            <div class="modal-message">You have successfully registered!</div>
            <div class="modal-footer">
                <button class="close" onclick="closeModal()">OK</button>
            </div>
        </div>
    </div>

   <main>
    <section class="featured">
        <h2>Featured Restaurants</h2>
        <div class="restaurant-grid" id="restaurantGrid">
            <% 
                RestaurantDao resImp = new RestaurantDaoImp();
                List<Restaurant> list = resImp.getAllRestaurants();
                
                if (list != null && !list.isEmpty()) {
                    for (Restaurant r : list) {
                        boolean isActive = r.isActive();
            %>
            <a href="GetMenu?resId=<%= r.getResId() %>" class="restaurant-card <%= isActive ? "" : "inactive" %>">
			    <div class="restaurant-card">
			        <img src="<%= request.getContextPath() %>/<%= r.getImgPath() %>" 
			             alt="<%= r.getName() %>" class="restaurant-image">
			        
			        <div class="restaurant-info">
			            <h3 class="restaurant-name"><%= r.getName() %></h3>
			            <p class="restaurant-cuisine"><strong>Type:</strong> <%= r.getCuisineType() %></p>
			            
			            <div class="restaurant-meta">
			                <p class="rating"><strong>Ratings:</strong> ⭐ <%= r.getRating() %></p>
			                <% if (!isActive) { %>
			                    <div class="inactive-message">
			                        Not accepting orders right now
			                    </div>
			                <% } else { %>
			                    <p class="delivery-time"><strong>Delivery Time:</strong> <%= r.getDeliveryTime() %> mins</p>
			                    <p class="address"><strong>Address:</strong> <%= r.getAddress() %></p>
			                <% } %>
			            </div>
			        </div>
			    </div>
			</a>
            <% 
                }
            } else { 
            %>
            <p class="no-results">No restaurants available at the moment. Please check back later!</p>
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
	    document.getElementById('searchInput').addEventListener('input', function () {
	        var searchTerm = this.value.toLowerCase();
	        var cards = document.querySelectorAll('.restaurant-card');
	        
	        cards.forEach(function (card) {
	            var name = card.querySelector('.restaurant-name').textContent.toLowerCase();
	            var cuisine = card.querySelector('.restaurant-cuisine').textContent.toLowerCase();
	            var address = card.querySelector('.address').textContent.toLowerCase();
	            
	            if (name.includes(searchTerm) || cuisine.includes(searchTerm) || address.includes(searchTerm)) {
	                card.style.display = 'block';  
	            } else {
	                card.style.display = 'none';
	            }
	        });
	    });
	    
	    const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('registrationSuccess')) {
            document.getElementById('successModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('successModal').style.display = 'none';
        }
	</script>


</body>
</html>
