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
import service.CommonService;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class CommonController {

    @Resource
    UserService userService;

    @Resource
    CommonService commonService;


    @RequestMapping(value = "")
    public ModelAndView logPageLoad(){
        return new ModelAndView("common/login");
    }


    @RequestMapping(value = "login")
    @ResponseBody
    public User login(@RequestParam("userId")String userId,
                      @RequestParam("password")String password,
                      HttpSession session){
        User user=userService.login(userId,password);
        if(user != null){
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = attributes.getRequest();
            session = request.getSession();
            session.setAttribute("user",user);
            return user;
        }else{
            return null;
        }
    }

    @RequestMapping(value = "register")
    public ModelAndView regPageLoad(){
        return new ModelAndView("common/register");
    }

    @RequestMapping(value = "show")
    public ModelAndView showContext(@RequestParam("url")String url,
                                    @RequestParam(value = "value",required = false)String value){
        ModelAndView modelAndView=new ModelAndView(url);
        if(value!=null&& !value.equals("")){
            modelAndView.addObject("value",value);
        }
        return modelAndView;
    }

    @RequestMapping(value = "index")
    public ModelAndView indexPageLoad(HttpSession session){
        User user= (User) session.getAttribute("user");
        user=userService.getUserInfo(String.valueOf(user.getUserId()));
        session.removeAttribute("user");
        session.setAttribute("user",user);
        return new ModelAndView("common/index");
    }

    @RequestMapping(value = "error")
    public ModelAndView errPageLoad(){
        return new ModelAndView("common/error");
    }

    @RequestMapping(value = "forgetPwd")
    public ModelAndView fWDPageLoad(){
        return new ModelAndView("common/forgetPwd");
    }

    @RequestMapping(value = "updAppState")
    @ResponseBody
    public Boolean updAppState(){
        return commonService.updAppState();
    }
}
