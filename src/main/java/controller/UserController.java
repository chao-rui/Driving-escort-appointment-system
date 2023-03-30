package controller;

import entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;


@Controller
public class UserController{

    @Resource
    UserService userService;

    @RequestMapping(value = "login")
    public ModelAndView login(@RequestParam("userId")String userId,@RequestParam("password")String password){
        User user=userService.login(userId,password);
        HttpServletRequest request= (HttpServletRequest) RequestContextHolder.getRequestAttributes();
        HttpSession session=request.getSession();
        session.setAttribute("user",user);
        ModelAndView mv=new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
}
