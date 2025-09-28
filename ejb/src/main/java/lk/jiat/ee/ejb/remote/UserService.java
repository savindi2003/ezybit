package lk.jiat.ee.ejb.remote;

import jakarta.ejb.Remote;
import lk.jiat.ee.core.model.User;

@Remote
public interface UserService {
    boolean register(User user);
    boolean login(String username,String password);
}
