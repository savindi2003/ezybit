package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.ejb.remote.UserService;

import java.io.IOException;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    @EJB
    private UserService userManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname = req.getParameter("username");
        String password = req.getParameter("password");

        boolean valid = userManager.login(uname,password);
        if(valid){
            req.getSession().setAttribute("user", uname);
            resp.sendRedirect("http://localhost:8080/ezy-bit/home");
        }else{
            resp.getWriter().write("Invalid credentials");
        }
    }
}
