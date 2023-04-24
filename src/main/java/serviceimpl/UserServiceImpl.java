package serviceimpl;

import dao.UserDao;
import entity.User;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import service.UserService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Resource
    UserDao userDao;

    @Override
    public User login(String userId,String password){
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        return userDao.login(userId,password);
    }

    @Override
    public Boolean register(String userName, String password, String phone) {
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
        Boolean fUpd = userDao.updUserInfo("",gender,"",birthYear,userId);
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
    public Boolean updUserInfo(String userName, String gender, String phone,String birthYear, String userId) {
        return userDao.updUserInfo(userName,gender,phone,birthYear,userId);
    }

    @Override
    public Boolean updPassword(String newPassword, String userId, String password) {
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        newPassword = DigestUtils.md5DigestAsHex(newPassword.getBytes());
        return userDao.updPassword(newPassword,userId,password);
    }

}
