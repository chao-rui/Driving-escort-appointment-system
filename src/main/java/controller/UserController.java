package controller;

import entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
public class UserController{

    @Resource
    UserService userService;

    @RequestMapping(value = "login")
    public ModelAndView login(@RequestParam("userId")String userId,@RequestParam("password")String password){
        String passwordMD5=DigestUtils.md5DigestAsHex(password.getBytes());
        User user=userService.login(userId,passwordMD5);
        HttpServletRequest request= (HttpServletRequest) RequestContextHolder.getRequestAttributes();
        HttpSession session=request.getSession();
        session.setAttribute("user",user);
        ModelAndView mv=new ModelAndView();
        mv.setViewName("index");
        return mv;
    }

    @RequestMapping(value = "register")
    public Boolean register(@RequestParam("userName")String userName,@RequestParam("password")String password,@RequestParam("phone")String phone){
        String passwordMD5=DigestUtils.md5DigestAsHex(password.getBytes());
        return userService.register(userName,passwordMD5,phone);
    }

    @RequestMapping(value = "getNewId")
    public String getNewId(){
        return userService.getNewId();
    }

    @RequestMapping(value = "setRName")
    public Boolean setRName(@RequestParam("userRName")String userRName,@RequestParam("idNumber")String idNumber,@RequestParam("userId")String userId){
        return userService.setRName(userRName,idNumber,userId);
    }

    @RequestMapping(value = "updUserInfo")
    public Boolean updUserInfo(@RequestParam("userName")String userName,@RequestParam("gender")String gender,@RequestParam("birthYear")String birthYear,@RequestParam("userId")String userId){
        return userService.updUserInfo(userName,gender,birthYear,userId);
    }

    @RequestMapping(value = "updPassword")
    public Boolean updPassword(@RequestParam("newPassword")String newPassword,@RequestParam("userId")String userId,@RequestParam("password")String password){
        return userService.updPassword(newPassword,userId,password);
    }

    @RequestMapping(value = "updRole")
    public Boolean updRole(@RequestParam("userId")String userId,@RequestParam("roleFlag")String roleFlag){
        return userService.updRole(userId,roleFlag);
    }
}
