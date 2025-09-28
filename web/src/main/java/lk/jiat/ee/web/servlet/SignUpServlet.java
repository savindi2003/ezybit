package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.core.model.User;
import lk.jiat.ee.ejb.remote.UserService;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @EJB
    private UserService userManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new User(uname,password);
        user.setUsername(uname);
        user.setPassword(password);

        boolean success = userManager.register(user);
        if(success){
            resp.sendRedirect("signIn.jsp");
        }else{
            resp.getWriter().write("Username already exists");
        }
    }
}
