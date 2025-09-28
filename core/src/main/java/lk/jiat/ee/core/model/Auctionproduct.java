package lk.jiat.ee.core.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Auctionproduct implements Serializable {

    private String id;
    private String name;
    private String description;
    private double startingPrice;
    private double currentBid;
    private String highestBidder;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String status;
    private double bidCound;
    private List<BidEvent> bids = new ArrayList<>();

    public Auctionproduct() {
    }

    public Auctionproduct(String id, String description, String name, double startingPrice, double currentBid, String highestBidder, LocalDateTime startTime, LocalDateTime endTime, String status,double bidCount) {
        this.id = id;
        this.description = description;
        this.name = name;
        this.startingPrice = startingPrice;
        this.currentBid = currentBid;
        this.highestBidder = highestBidder;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.bidCound = bidCount;
    }


    public Auctionproduct(String id, String name, String description, double currentBid, LocalDateTime startTime, LocalDateTime endTime) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.currentBid = currentBid;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public List<BidEvent> getBids() {
        return bids;
    }

    public void addBid(BidEvent bid) {
        this.bids.add(bid);
    }

    public String getId() {
        return id;
    }

    public double getBidCound() {
        return bidCound;
    }

    public void setBidCound(double bidCound) {
        this.bidCound = bidCound;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getStartingPrice() {
        return startingPrice;
    }

    public void setStartingPrice(double startingPrice) {
        this.startingPrice = startingPrice;
    }

    public double getCurrentBid() {
        return currentBid;
    }

    public void setCurrentBid(double currentBid) {
        this.currentBid = currentBid;
    }

    public String getHighestBidder() {
        return highestBidder;
    }

    public void setHighestBidder(String highestBidder) {
        this.highestBidder = highestBidder;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isClosed(){
        return "closed".equalsIgnoreCase(status);
    }
}
