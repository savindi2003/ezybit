package lk.jiat.ee.core.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class BidEvent implements Serializable {
    private String productId;
    private String bidder;
    private double bidAmount;
    private double bidCount;
    private LocalDateTime time;
    private String status;

    public BidEvent(String productId, String bidder, double bidAmount, double bidCount, String status) {
        this.productId = productId;
        this.bidder = bidder;
        this.bidAmount = bidAmount;
        this.bidCount = bidCount;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public double getBidCount() {
        return bidCount;
    }

    public void setBidCount(double bidCount) {
        this.bidCount = bidCount;
    }

    public BidEvent() {
    }

    public BidEvent(String productId, String bidder, double bidAmount,double bidCount) {
        this.productId = productId;
        this.bidder = bidder;
        this.bidAmount = bidAmount;
        this.bidCount = bidCount;
    }

    public BidEvent(String productId, double bidAmount, double bidCount, String status) {
        this.productId = productId;
        this.bidAmount = bidAmount;
        this.bidCount = bidCount;
        this.status = status;
    }

    public BidEvent(String bidder, LocalDateTime time, double bidAmount) {
        this.bidder = bidder;
        this.time = time;
        this.bidAmount = bidAmount;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getBidder() {
        return bidder;
    }

    public void setBidder(String bidder) {
        this.bidder = bidder;
    }

    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }
}
