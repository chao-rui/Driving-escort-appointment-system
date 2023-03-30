package model;


import entity.User;

public class UserModel extends User {

    public UserModel() {
    }

    public UserModel(User user){
        this.setUserId(user.getUserId());
        this.setUserName(user.getUserName());
        this.setUserRname(user.getUserRname());
        this.setGender(user.getGender());
        this.setAge(user.getAge());
        this.setPhone(user.getPhone());
        this.setIdNumber(user.getIdNumber());
        this.setPassword(user.getPassword());
        this.setRoleFlag(user.getRoleFlag());
    }
}
