package serviceimpl;

import dao.UserDao;
import entity.User;
import org.springframework.stereotype.Service;
import service.UserService;

import javax.annotation.Resource;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Resource
    UserDao userDao;

    @Override
    public User login(String userId,String password){
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
    public Boolean setRName(String userRName, String idNumber, String userId) {
        String birthYear = idNumber.substring(6, 10);
        String gender = Integer.parseInt(idNumber.substring(16, 17)) % 2 == 0 ? "女" : "男";
        Boolean fSet = userDao.setRName(userRName,idNumber,userId);
        Boolean fUpd = userDao.updUserInfo("",gender,birthYear,userId);
        return fSet && fUpd;
    }

    @Override
    public Boolean updRole(String userId, String roleFlag) {
        return userDao.updRole(userId,roleFlag);
    }

    @Override
    public Boolean updUserInfo(String userName, String gender, String birthYear, String userId) {
        return userDao.updUserInfo(userName,gender,birthYear,userId);
    }

    @Override
    public Boolean updPassword(String newPassword, String userId, String password) {
        return userDao.updPassword(newPassword,userId,password);
    }

}
