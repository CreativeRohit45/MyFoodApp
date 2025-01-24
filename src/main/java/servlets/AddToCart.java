package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.dao.MenuDao;
import com.daoimp.MenuDaoImp;
import com.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String action = request.getParameter("action");
        String returnUrl = request.getParameter("returnUrl");
        int itemResId = Integer.parseInt(request.getParameter("resId")); // Retrieve resId from request parameter

        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        Map<Menu, Integer> cartMap = (Map<Menu, Integer>) session.getAttribute("cartMap");
        if (cartMap == null) {
            cartMap = new HashMap<>();
            session.setAttribute("cartMap", cartMap);
        }

        Integer currentResId = (Integer) session.getAttribute("resId");
        if (currentResId != null && currentResId != itemResId) {
            cartMap.clear();
        }

        session.setAttribute("resId", itemResId);

        MenuDao menuDao = new MenuDaoImp();
        Menu menuItem = menuDao.getMenuItem(itemId);

        if (menuItem != null) {
            if ("increase".equals(action)) {
                int currentQuantity = cartMap.getOrDefault(menuItem, 0);
                cartMap.put(menuItem, currentQuantity + 1);
            } else if ("decrease".equals(action)) {
                int currentQuantity = cartMap.getOrDefault(menuItem, 0);
                if (currentQuantity > 1) {
                    cartMap.put(menuItem, currentQuantity - 1);
                } else {
                    cartMap.remove(menuItem);
                }
            } else {
                cartMap.put(menuItem, cartMap.getOrDefault(menuItem, 0) + 1);
            }
        } else {
            System.out.println("Item not found in database for ID: " + itemId);
        }

        session.setAttribute("cartMap", cartMap);
        response.sendRedirect(returnUrl);
    }
}
