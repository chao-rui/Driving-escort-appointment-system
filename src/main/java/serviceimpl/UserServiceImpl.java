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

    public User login(String userId,String password){

        return userDao.login(userId,password);
    }
}
