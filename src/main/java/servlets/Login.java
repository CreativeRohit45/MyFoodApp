package servlets;

import java.io.IOException;

import com.daoimp.UserDaoImp;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String returnUrl = request.getParameter("returnUrl");
		
		UserDaoImp user = new UserDaoImp();
    	User u = user.getEmailPassword(email,password);
    	
    	if (u != null) {
    	    HttpSession session = request.getSession();
    	    session.setAttribute("user", u);
    	    session.setAttribute("userEmail", u.getEmail());
    	    session.setAttribute("userPass", u.getPassword());
    	    if (returnUrl != null && !returnUrl.isEmpty() && !returnUrl.equals("null")) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect("Home.jsp");
            }
    	} else {
    	    response.sendRedirect("Login.jsp?error=invalid");
    	}
	}

}
