package serviceimpl;

import dao.UserDao;
import entity.User;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import service.EmailService;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.Random;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Resource
    UserDao userDao;

    @Resource
    EmailService emailService;

    @Override
    public User login(String userId,String password){
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        return userDao.login(userId,password);
    }

    @Override
    public Boolean register(String userName, String password, String phone) {
        password=DigestUtils.md5DigestAsHex(password.getBytes());
        return userDao.register(userName,password,phone);
    }

    @Override
    public String getNewId() {
        return userDao.getNewId();
    }

    @Override
    public User getUserInfo(String userId){
        User user=userDao.getUserInfo(userId);
        user.setPassword("***");
        return user;
    }

    @Override
    public Boolean setRName(String userRName, String idNumber, String userId) {
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
        int year = Integer.parseInt(dateFormat.format(date));
        String birthYear = idNumber.substring(6, 10);
        String gender = Integer.parseInt(idNumber.substring(16, 17)) % 2 == 0 ? "女" : "男";
        Boolean fSet = userDao.setRName(userRName,idNumber,userId);
        Boolean fUpd = userDao.updUserInfo("",gender,"","",birthYear,userId);
        if(year-Integer.parseInt(birthYear)>18){
            userDao.updRole(userId,"2");
        }
        return fSet && fUpd;
    }

    @Override
    public Boolean updRole(String userId, String roleFlag) {
        return userDao.updRole(userId,roleFlag);
    }

    @Override
    public Boolean updUserInfo(String userName, String gender, String phone,
                               String email,String birthYear, String userId) {
        return userDao.updUserInfo(userName,gender,phone,email,birthYear,userId);
    }

    @Override
    public Boolean updPassword(String newPassword, String userId, String password) {
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        newPassword = DigestUtils.md5DigestAsHex(newPassword.getBytes());
        return userDao.updPassword(newPassword,userId,password);
    }

    @Override
    public Boolean sendEmail(String userId){
        if(!Objects.equals(userDao.isExist(userId), "0")){
            String email=userDao.getUserInfo(userId).getEmail();
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            StringBuilder sb = new StringBuilder();
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = attributes.getRequest();
            HttpSession session = request.getSession();
            for (int i = 0; i < 5; i++) {
                int index = random.nextInt(characters.length());
                char c = characters.charAt(index);
                sb.append(c);
            }
            String code = sb.toString();
            emailService.sendHtmlEmail(email,code);
            session.setAttribute("code",code);
            System.out.println(code);
            return true;
        }else{
            return false;
        }
    }

    @Override
    public Boolean clsPwd(String code, String password, String userId) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        HttpSession session = request.getSession();
        String rCode=(String) session.getAttribute("code");
        Boolean f1= Objects.equals(rCode, code);
        Boolean f2=false;
        if(f1){
            password = DigestUtils.md5DigestAsHex(password.getBytes());
            f2=userDao.clsPwd(password,userId);
        }
        return f1 && f2;
    }

}
