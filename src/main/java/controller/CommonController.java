package controller;

import entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

    @RequestMapping(value = "login")
    @ResponseBody
    public String login(@RequestParam("userId")String userId,
                              @RequestParam("password")String password){
        String passwordMD5= DigestUtils.md5DigestAsHex(password.getBytes());
        User user=userService.login(userId,passwordMD5);
        if(user != null){
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = attributes.getRequest();
            HttpSession session = request.getSession();
            session.setAttribute("user",user);
            return "true";
        }else{
            return "false";
        }
    }

    @RequestMapping(value = "show")
    public ModelAndView showContext(@RequestParam("url")String url){
        return new ModelAndView(url);
    }

}
