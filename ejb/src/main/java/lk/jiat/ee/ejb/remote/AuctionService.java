package lk.jiat.ee.ejb.remote;

import jakarta.ejb.Remote;
import lk.jiat.ee.core.model.Auctionproduct;

import java.util.List;

@Remote
public interface AuctionService {
    List<Auctionproduct> getAuctionproducts();

    Auctionproduct getProductById(String id);

    Auctionproduct placeBid(String productId, double bidAmount, String username);
}
