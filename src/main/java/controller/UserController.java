package controller;

import entity.User;
import org.springframework.boot.jackson.JsonObjectSerializer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import javax.annotation.Resource;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController{

    @Resource
    UserService userService;

    @RequestMapping(value = "register")
    @ResponseBody
    public String register(@RequestParam("userName")String userName,
                            @RequestParam("password")String password,
                            @RequestParam("phone")String phone){
        String passwordMD5=DigestUtils.md5DigestAsHex(password.getBytes());
        return String.valueOf(userService.register(userName,passwordMD5,phone));
    }

    @RequestMapping(value = "getNewId")
    @ResponseBody
    public String getNewId(){
        return userService.getNewId();
    }

    @RequestMapping(value = "getUserInfo")
    public String getUserInfo(@RequestParam("userId")String userId){
        Model model = null;
        model.addAttribute("user",userService.getUserInfo(userId));
       return "true";
    }

    @RequestMapping(value = "setRName")
    public Boolean setRName(@RequestParam("userRName")String userRName,
                            @RequestParam("idNumber")String idNumber,
                            @RequestParam("userId")String userId){
        return userService.setRName(userRName,idNumber,userId);
    }

    @RequestMapping(value = "updUserInfo")
    public Boolean updUserInfo(@RequestParam("userName")String userName,
                               @RequestParam("gender")String gender,
                               @RequestParam("birthYear")String birthYear,
                               @RequestParam("userId")String userId){
        return userService.updUserInfo(userName,gender,birthYear,userId);
    }

    @RequestMapping(value = "updPassword")
    public Boolean updPassword(@RequestParam("newPassword")String newPassword,
                               @RequestParam("userId")String userId,
                               @RequestParam("password")String password){
        return userService.updPassword(newPassword,userId,password);
    }

    @RequestMapping(value = "updRole")
    public Boolean updRole(@RequestParam("userId")String userId,
                           @RequestParam("roleFlag")String roleFlag){
        return userService.updRole(userId,roleFlag);
    }
}
