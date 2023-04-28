package service;


import entity.User;

public interface UserService {
    //登录
    public User login(String userId, String password);

    //注册
    public Boolean register(String userName,String password,String phone);

    //获取新用户ID
    public String getNewId();

    //获取用户信息
    public User getUserInfo(String userId);

    //实名认证
    public Boolean setRName(String userRName,String idNumber,String userId);

    //修改基础信息
    public Boolean updUserInfo(String userName,String gender,String phone,
                               String email,String birthYear,String userId);

    //修改密码
    public Boolean updPassword(String newPassword,String userId,String password);

    //身份变换（教练/驾校管理员_用户表）
    public Boolean updRole(String userId,String roleFlag);

    //发送验证邮件
    public  Boolean sendEmail(String userId);

    //重置密码
    public Boolean clsPwd(String code,String password,String userId);
}
