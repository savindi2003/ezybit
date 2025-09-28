package lk.jiat.ee.ejb.bean;

import jakarta.ejb.Stateless;
import lk.jiat.ee.core.model.User;
import lk.jiat.ee.ejb.remote.UserService;

import java.util.ArrayList;
import java.util.List;

@Stateless
public class UserManagerBean implements UserService {

    private static final List<User> users = new ArrayList<>();

    @Override
    public boolean register(User user) {
        for (User u : users) {
            if (u.getUsername().equals(user.getUsername())) {
                return false;
            }
        }
        users.add(user);
        return true;

    }

    @Override
    public boolean login(String username, String password) {
        for (User u : users) {
            if (u.getUsername().equals(username) && u.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }


}
