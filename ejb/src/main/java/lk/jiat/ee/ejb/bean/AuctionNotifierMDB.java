package lk.jiat.ee.ejb.bean;

import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;
import jakarta.jms.JMSException;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import lk.jiat.ee.core.model.BidEvent;
import lk.jiat.ee.core.broadcast.BidBroadcaster;

@MessageDriven(activationConfig = {
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic"),
        @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "jms/EzyBidTopic")
})

public class AuctionNotifierMDB implements MessageListener {
    @Override
    public void onMessage(Message message) {
        try {
            BidEvent event = message.getBody(BidEvent.class);

            String json = "{ \"type\": \"bidUpdate\", " +
                    "\"productId\": \"" + event.getProductId() + "\", " +
                    "\"bid\": " + event.getBidAmount() + ", " +
                    "\"bidCount\": " + event.getBidCount() + ", " +
                    "\"bidder\": \"" + event.getBidder() + "\" }";

            BidBroadcaster.broadcast(json);

            if(event.getStatus() != null && event.getStatus().equals("Closed")){
                String winnerJson = "{ \"type\": \"auctionClosed\", " +
                        "\"productId\": \"" + event.getProductId() + "\", " +
                        "\"winner\": \"" + event.getBidder() + "\", " +
                        "\"winningBid\": " + event.getBidAmount() + " }";

                BidBroadcaster.broadcast(winnerJson);
            }


        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}
