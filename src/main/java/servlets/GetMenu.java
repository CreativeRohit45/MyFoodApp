package servlets;

import java.io.IOException;
import java.util.List;

import com.dao.MenuDao;
import com.dao.RestaurantDao;
import com.daoimp.MenuDaoImp;
import com.daoimp.RestaurantDaoImp;
import com.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetMenu")
public class GetMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    String restaurantId = request.getParameter("resId");
	    
	    if (restaurantId != null && !restaurantId.isEmpty()) {
	        MenuDao menuDao = new MenuDaoImp();
	        List<Menu> menuList = menuDao.getMenuByRestaurantId(Integer.parseInt(restaurantId));
	        
	        RestaurantDao resDao = new RestaurantDaoImp();
	        String restaurantName = resDao.getRestaurantNameById(Integer.parseInt(restaurantId));

	        request.setAttribute("MenuList", menuList);
	        request.setAttribute("restaurantId", restaurantId);
	        request.setAttribute("restaurantName", restaurantName);
	        
	        request.getRequestDispatcher("Menu.jsp").forward(request, response);
	    } else {
	        System.out.println("No restaurant ID provided.");
	    }
	}

}
