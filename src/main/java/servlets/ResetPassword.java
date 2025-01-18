package servlets;

import java.io.IOException;

import com.dao.UserDao;
import com.daoimp.UserDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			HttpSession session = request.getSession(false); 
		    String email = (session != null) ? (String) session.getAttribute("email") : null;
		 	String newPassword = request.getParameter("new-password"); 
			UserDao user = new UserDaoImp();
			boolean isUpdated = user.updatePassword(email, newPassword);
	        if (isUpdated) {
	        	response.sendRedirect("Login.jsp?success=true");
	        } else {
	        	response.sendRedirect("ChangePassword.jsp?error=1");
	        }
	}

}
