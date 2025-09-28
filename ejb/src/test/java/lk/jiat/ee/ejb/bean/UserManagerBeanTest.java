package lk.jiat.ee.ejb.bean;

import lk.jiat.ee.core.model.User;
import lk.jiat.ee.ejb.remote.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class UserManagerBeanTest {

    private UserService userService;

    @BeforeEach
    public void setUp(){
        userService = new UserManagerBean();

    }

    @Test
    public void testRegisterNewUser(){
        User user = new User();
        user.setUsername("malshi@gmail.com");
        user.setPassword("malshi1234");

        boolean result = userService.register(user);
        assertTrue(result, "New user should be registered");
    }

    @Test
    public void testRegisterDuplicateUser() {
        User user1 = new User();
        user1.setUsername("dulee@gmail.com");
        user1.setPassword("dulee123");

        User user2 = new User();
        user2.setUsername("dulee@gmail.com");  // same username
        user2.setPassword("user123");

        userService.register(user1);
        boolean result = userService.register(user2);

        assertFalse(result, "Duplicate username should not be allowed");
    }

    @Test
    public void testLoginSuccess() {
        User user = new User();
        user.setUsername("savi@gmail.com");
        user.setPassword("savi1234");

        userService.register(user);

        boolean result = userService.login("savi@gmail.com", "savi1234");
        assertTrue(result, "Login should succeed with correct credentials");
    }

    @Test
    public void testLoginFail_WrongPassword() {
        User user = new User();
        user.setUsername("nishan@gmail.com");
        user.setPassword("nishan1234");

        userService.register(user);

        boolean result = userService.login("nishan@gmail.com", "wrong1");
        assertFalse(result, "Login should fail with incorrect password");
    }

    @Test
    public void testLoginFail_UserNotRegistered() {
        boolean result = userService.login("admin", "wrong2");
        assertFalse(result, "Login should fail for unregistered user");
    }


}
