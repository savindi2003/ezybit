package lk.jiat.ee.web.servlet;

import jakarta.annotation.Resource;
import jakarta.ejb.EJB;
import jakarta.jms.ConnectionFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.core.model.Auctionproduct;
import lk.jiat.ee.core.model.BidEvent;
import jakarta.jms.JMSContext;
import jakarta.jms.Topic;
import lk.jiat.ee.ejb.remote.AuctionService;


import java.io.IOException;

@WebServlet("/placeBid")
public class PlaceBidServlet extends HttpServlet {

    @EJB
    private AuctionService auctionManagerEJB;

    @Resource(lookup = "jms/EzyBidTopic")
    private Topic bidTopic;

    @Resource(lookup = "jms/EzyBidConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("productId");
        String bid = req.getParameter("bidAmount");
        String username = (String) req.getSession().getAttribute("user");

        // Check login
        if (username == null) {
            resp.sendRedirect("signin.jsp");
            return;
        }

        // Validate bid amount
        double bidAmount;
        try {
            bidAmount = Double.parseDouble(bid);
        } catch (NumberFormatException e) {
            req.setAttribute("msg", "Invalid bid amount.");
            req.setAttribute("msgType", "error");
            req.getRequestDispatcher("auctionDetails?id=" + productId).forward(req, resp);
            return;
        }

        // Process the bid using concurrency-safe EJB method
        Auctionproduct updatedProduct = auctionManagerEJB.placeBid(productId, bidAmount, username);

        if (updatedProduct == null) {
            req.setAttribute("msg", "Your bid must be higher than the current bid.");
            req.setAttribute("msgType", "error");
            updatedProduct = auctionManagerEJB.getProductById(productId); // show current state
        } else {
            req.setAttribute("msg", "Your bid was placed successfully!");
            req.setAttribute("msgType", "success");


            try (JMSContext context = connectionFactory.createContext()) {
                context.createProducer().send(
                        bidTopic,
                        new BidEvent(productId, username, bidAmount, updatedProduct.getBidCound())
                );
            }


        }

        req.setAttribute("product", updatedProduct);
        req.getRequestDispatcher("singleView.jsp").forward(req, resp);
    }
}