package lk.jiat.ee.core.broadcast;

import java.util.function.Consumer;

public class BidBroadcaster {
    public static Consumer<String> listener;

    public static void broadcast(String message) {
        if (listener != null) {
            listener.accept(message);
        }
    }
}
