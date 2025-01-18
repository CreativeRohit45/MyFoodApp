package servlets;

import java.io.IOException;

import com.dao.UserDao;
import com.daoimp.UserDaoImp;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserDao user = new UserDaoImp();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        User u = new User(username, password, email, address);

        String userEmail = user.getEmail(email);

        if (userEmail.equals(email)) {
        	 response.sendRedirect("SignUp.jsp?error=emailExists");
        } else {
        	user.insertUser(u);
        	User u1 = user.getEmailPassword(email,password);
        	HttpSession session = request.getSession();
        	
    		session.setAttribute("user", u1);
    		session.setAttribute("userEmail", u1.getEmail());
    		session.setAttribute("userPass", u.getPassword());
    		response.sendRedirect("Home.jsp?registrationSuccess=true");
        }
    }

}
