package service;


import entity.User;

public interface UserService {
    public User login(String userId,String password);
}
