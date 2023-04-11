package controller;

import entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class CommonController {

    @Resource
    UserService userService;

    @RequestMapping(value = "register")
    public ModelAndView regPageLoad(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("register");
        return modelAndView;
    }

    @RequestMapping(value = "login")
    public ModelAndView login(@RequestParam("userId")String userId,
                              @RequestParam("password")String password){
        String passwordMD5= DigestUtils.md5DigestAsHex(password.getBytes());
        User user=userService.login(userId,passwordMD5);
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        ModelAndView mv=new ModelAndView("index");
        return mv;
    }
}
