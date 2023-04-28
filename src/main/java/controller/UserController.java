package controller;

import entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController{

    @Resource
    UserService userService;

    @RequestMapping(value = "register")
    @ResponseBody
    public Boolean register(@RequestParam("userName")String userName,
                            @RequestParam("password")String password,
                            @RequestParam("phone")String phone){
        return userService.register(userName,password,phone);
    }

    @RequestMapping(value = "getNewId")
    @ResponseBody
    public String getNewId(){
        return userService.getNewId();
    }

    @RequestMapping(value = "getUserInfo")
    @ResponseBody
    public User getUserInfo(@RequestParam("userId")String userId){
        return userService.getUserInfo(userId);
    }

    @RequestMapping(value = "setRName")
    @ResponseBody
    public Boolean setRName(@RequestParam("userRName")String userRName,
                            @RequestParam("idNumber")String idNumber,
                            @RequestParam("userId")String userId){
        return userService.setRName(userRName,idNumber,userId);
    }

    @RequestMapping(value = "updUserInfo")
    @ResponseBody
    public Boolean updUserInfo(@RequestParam("userName")String userName,
                               @RequestParam("gender")String gender,
                               @RequestParam("phone")String phone,
                               @RequestParam("email")String email,
                               @RequestParam("birthYear")String birthYear,
                               @RequestParam("userId")String userId){
        return userService.updUserInfo(userName,gender,phone,email,birthYear,userId);
    }

    @RequestMapping(value = "updPassword")
    @ResponseBody
    public Boolean updPassword(@RequestParam("newPassword")String newPassword,
                               @RequestParam("userId")String userId,
                               @RequestParam("password")String password){
        return userService.updPassword(newPassword,userId,password);
    }

    @RequestMapping(value = "updRole")
    @ResponseBody
    public Boolean updRole(@RequestParam("userId")String userId,
                           @RequestParam("roleFlag")String roleFlag){
        return userService.updRole(userId,roleFlag);
    }

    @RequestMapping(value = "sendEmail")
    @ResponseBody
    public Boolean sendEmail(@RequestParam("userId")String userId){
        return userService.sendEmail(userId);
    }

    @RequestMapping(value = "clsPwd")
    @ResponseBody
    public Boolean clsPwd(@RequestParam("code")String code,
                          @RequestParam("password")String password,
                          @RequestParam("userId")String userId){
        return userService.clsPwd(code,password,userId);
    }
}
