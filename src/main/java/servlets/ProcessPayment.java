package servlets;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import com.dao.OrderDao;
import com.dao.OrderItemDao;
import com.dao.UserDao;
import com.daoimp.OrderDaoImp;
import com.daoimp.OrderItemDaoImp;
import com.daoimp.UserDaoImp;
import com.model.Menu;
import com.model.Order;
import com.model.OrderItem;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProcessPayment")
public class ProcessPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId =  Integer.parseInt(request.getParameter("userId"));
		int resId = Integer.parseInt(request.getParameter("resId"));
		double finalAmount = Double.parseDouble(request.getParameter("finalAmount"));
		String paymentMode = request.getParameter("paymentMode");
        String userAddress = request.getParameter("userAddress");
        String userPhone = request.getParameter("userPhone");
        
        UserDao userDao = new UserDaoImp();
        userDao.updateAddress(userId, userAddress, userPhone);
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User u1 = userDao.getEmailPassword(user.getEmail(),user.getPassword());
        session.setAttribute("user", u1);
        
        int orderId = generateUniqueOrderId();
        String status = "Order Placed";
        Date orderDate = new java.sql.Timestamp(System.currentTimeMillis());
        java.sql.Date sqlDate = new java.sql.Date(orderDate.getTime());
        Order order = new Order(orderId, userId, resId, sqlDate, finalAmount, status, paymentMode);
        OrderDao orderDao = new OrderDaoImp();
        orderDao.insert(order);
        session.setAttribute("orderStatus", "Order Placed");
        session.setAttribute("orderPlacedTime", new java.sql.Timestamp(System.currentTimeMillis()).toString());
        @SuppressWarnings("unchecked")
		Map<Menu, Integer> cartMap = (Map<Menu, Integer>) request.getSession().getAttribute("cartMap");
        moveOrderToOrderItem(order, cartMap);
        
        new Thread(() -> {
            try {
                Thread.sleep(30000);
                order.setStatus("Preparing");
                session.setAttribute("orderStatus", "Preparing");
                session.setAttribute("preparingTime", new java.sql.Timestamp(System.currentTimeMillis()).toString());
                orderDao.update(order);

                Thread.sleep(30000);
                order.setStatus("Out For Delivery");
                session.setAttribute("orderStatus", "Out For Delivery");
                session.setAttribute("outForDeliveryTime", new java.sql.Timestamp(System.currentTimeMillis()).toString());
                orderDao.update(order);

                Thread.sleep(30000);
                order.setStatus("Completed");
                session.setAttribute("orderStatus", "Completed");
                session.setAttribute("completedTime", new java.sql.Timestamp(System.currentTimeMillis()).toString());
                orderDao.update(order);

            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }).start();
        
        response.sendRedirect("Checkout.jsp?orderId=" + orderId);
    }
      
	private void moveOrderToOrderItem(Order order, Map<Menu, Integer> cartMap) {
		OrderItemDao orderItemDao = new OrderItemDaoImp();
		
		for (Map.Entry<Menu, Integer> entry : cartMap.entrySet()) {
	        Menu menu = entry.getKey(); 
	        int quantity = entry.getValue();
	        double pricePerUnit = menu.getPrice();
	        double totalPrice = pricePerUnit * quantity;
	   
	        OrderItem orderItem = new OrderItem(order.getOrderId(),menu.getMenuId(), quantity, totalPrice);
	        orderItemDao.insert(orderItem);
	    }
		cartMap.clear();	
	}
		
	
	private int generateUniqueOrderId() {
	    int orderId;
	    OrderDao orderDao = new OrderDaoImp();
	    do {
	        orderId = (int) (Math.random() * 9000) + 1000; 
	    } while (orderDao.exists(orderId)); 
	    return orderId;
	}

}
