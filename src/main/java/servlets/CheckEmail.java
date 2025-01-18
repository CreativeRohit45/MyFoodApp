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

@WebServlet("/CheckEmail")
public class CheckEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String email = request.getParameter("email");
		 UserDao user = new UserDaoImp();
		 String userEmail = user.getEmail(email);
		 
		 if(userEmail.equals(email)) {
			 HttpSession session = request.getSession();
		     session.setAttribute("email", userEmail);
			 request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
		 }else {
			 response.sendRedirect("ForgotPassword.jsp?errorMessage=Email not found. Please try again.");
		    }
	}

}
