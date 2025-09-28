package lk.jiat.ee.ejb.bean;

import lk.jiat.ee.core.model.Auctionproduct;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class AuctionManagerBeanTest {

    private AuctionManagerBean auctionManager;

    @BeforeEach
    public void setUp(){
        auctionManager = new AuctionManagerBean();
    }

    @Test
    public void testGetAuctionproducts(){
        List<Auctionproduct> products = auctionManager.getAuctionproducts();
        assertNotNull(products, "Product list should not be null");
        assertTrue(products.size() > 0, "There should be at least one product");
    }

    @Test
    public void testGetProductById_Valid() {
        Auctionproduct product = auctionManager.getProductById("P002");
        assertNotNull(product, "Product should be found for ID P002");
        assertEquals("iPhone 11 Pro", product.getName(), "Product name should match");
    }

    @Test
    public void testGetProductById_Invalid() {
        Auctionproduct product = auctionManager.getProductById("INVALID_ID");
        assertNull(product, "Product should be null for invalid ID");
    }

    @Test
    public void testPlaceBid_ValidHigherBid() {
        Auctionproduct original = auctionManager.getProductById("P002");
        double newBid = original.getCurrentBid() + 100;

        Auctionproduct updated = auctionManager.placeBid("P002", newBid, "Nimal");

        assertNotNull(updated, "Product should be returned after successful bid");
        assertEquals(newBid, updated.getCurrentBid(), "Bid amount should be updated");
        assertEquals("Nimal", updated.getHighestBidder(), "Highest bidder should be updated");
    }

    @Test
    public void testPlaceBid_LowerThanCurrent() {
        Auctionproduct original = auctionManager.getProductById("P002");
        double lowBid = original.getCurrentBid() - 50;

        Auctionproduct result = auctionManager.placeBid("P002", lowBid, "Kamal");
        assertNull(result, "Bid lower than current should be rejected");
    }

    @Test
    public void testPlaceBid_ExpiredAuction() {
        // Create a product with expired end time manually
        Auctionproduct expiredProduct = new Auctionproduct(
                "PX01", "Desc", "Old Phone",
                100.0, 150.0, "ExpiredUser",
                java.time.LocalDateTime.now().minusMinutes(30),
                java.time.LocalDateTime.now().minusMinutes(1),
                "Active", 5
        );
        auctionManager.getAuctionproducts().add(expiredProduct);

        Auctionproduct result = auctionManager.placeBid("PX01", 200.0, "ExpiredBidder");
        assertNull(result, "Should not allow bids on expired auctions");
    }

}
