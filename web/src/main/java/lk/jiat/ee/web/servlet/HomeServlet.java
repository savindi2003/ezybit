package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.core.model.Auctionproduct;
import lk.jiat.ee.ejb.remote.AuctionService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @EJB
    private AuctionService auctionManager;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Auctionproduct> auctionproducts = auctionManager.getAuctionproducts();

        LocalDateTime now = LocalDateTime.now();
        for(Auctionproduct product : auctionproducts){
            if(product.getEndTime().isBefore(now)){
                product.setStatus("Closed");
            }else{
                product.setStatus("Active");
            }
        }


        req.setAttribute("products",auctionproducts);
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }
}
