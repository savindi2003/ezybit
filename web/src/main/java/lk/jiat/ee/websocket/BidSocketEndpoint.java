package lk.jiat.ee.websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import lk.jiat.ee.core.broadcast.BidBroadcaster;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/bidsocket")
public class BidSocketEndpoint {

    private static final Set<Session> sessions = ConcurrentHashMap.newKeySet();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);

        // Register listener once
        BidBroadcaster.listener = (message) -> {
            for (Session s : sessions) {
                if (s.isOpen()) {
                    s.getAsyncRemote().sendText(message);
                }
            }
        };
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
}
