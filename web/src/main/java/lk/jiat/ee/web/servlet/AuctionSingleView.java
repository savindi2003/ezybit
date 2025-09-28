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

@WebServlet("/auctionDetails")
public class AuctionSingleView extends HttpServlet {

    @EJB
    private AuctionService auctionManagerEJB;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        Auctionproduct selectedProduct = null;
        for (Auctionproduct p : auctionManagerEJB.getAuctionproducts()){
            if(p.getId().equals(id)){
                selectedProduct = p;
                break;
            }
        }

        if(selectedProduct == null){
            resp.getWriter().write("Auction product not found.");
            return;
        }

        req.setAttribute("product", selectedProduct);
        req.getRequestDispatcher("singleView.jsp").forward(req, resp);
    }
}
