package lk.jiat.ee.ejb.bean;

import jakarta.ejb.*;
import lk.jiat.ee.core.model.Auctionproduct;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import lk.jiat.ee.core.model.BidEvent;
import lk.jiat.ee.ejb.remote.AuctionService;

@Singleton
@Startup
public class AuctionManagerBean implements AuctionService {

    private final List<Auctionproduct> auctionproducts = new ArrayList<>();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");


    public AuctionManagerBean(){


        auctionproducts.add(new Auctionproduct(
                "P002",
                "Description",
                "iPhone 11 Pro",
                800.00,
                1200.00,
                "Hirushi Lakshini",
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(60),
                "Active",9

        ));

        auctionproducts.add(new Auctionproduct(
                "P006",
                "Description",
                "iPhone Sj Pro",
                800.00,
                1200.00,
                "Hirushi Lakshini",
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(10),
                "Active",9

        ));



        auctionproducts.add(new Auctionproduct(
                "P007",
                "Description",
                "iPhone SE",
                1500.00,
                900.00,
                "Omini Lakshini",
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(20),
                "Active",
                1

        ));

        auctionproducts.add(new Auctionproduct(
                "P008",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.of(2025, 5, 25, 14, 0,0),
                LocalDateTime.of(2025, 9, 29, 12, 0,0),
                "Active",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P009",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.of(2025, 5, 25, 14, 0,0),
                LocalDateTime.of(2025, 9, 30, 16, 7,0),
                "Active",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P0010",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.of(2025, 5, 25, 14, 0,0),
                LocalDateTime.of(2025, 9, 30, 17, 58,0),
                "Active",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P001",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.of(2025, 5, 25, 14, 0,0),
                LocalDateTime.of(2025, 5, 30, 17, 58,0),
                "Closed",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P003",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(60),
                "Active",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P004",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(50),
                "Active",19

        ));

        auctionproducts.add(new Auctionproduct(
                "P005",
                "Description",
                "Samsung Galaxy S24",
                1000.00,
                2300.00,
                "Samadhi Lakshini",
                LocalDateTime.of(2025, 5, 25, 14, 0,0),
                LocalDateTime.of(2025, 5, 30, 17, 58,0),
                "Closed",19

        ));



    }

    @Override
    public List<Auctionproduct> getAuctionproducts(){
        return auctionproducts;
    }

    @Override
    public Auctionproduct getProductById(String id){
        for (Auctionproduct p : auctionproducts) {
            if (p.getId().equals(id)) {
                return p;
            }
        }
        return null;
    }

    @Override
    @Lock(LockType.WRITE)
    public Auctionproduct placeBid(String productId, double bidAmount, String username) {
        Auctionproduct product = getProductById(productId);
        if (product == null) return null;

        if(product.getEndTime().isBefore(LocalDateTime.now())){
            product.setStatus("Closed");
            return null;
        }
        if(product.isClosed()){
            return null;
        }
        if (bidAmount > product.getCurrentBid()) {
            product.setCurrentBid(bidAmount);
            product.setHighestBidder(username);
            product.setBidCound(product.getBidCound() + 1);

            // ✅ Add Bid to Bid History
            BidEvent newBid = new BidEvent();
            newBid.setBidder(username);
            newBid.setBidAmount(bidAmount);
            newBid.setTime(LocalDateTime.now());

            product.getBids().add(newBid); // Add bid to product
            return product; // updated object
        }
        return null; // invalid bid
    }


}
