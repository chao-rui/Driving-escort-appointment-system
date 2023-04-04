package serviceimpl;

import dao.CSAdminDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("CSAdminService")
public class CSAdminServiceImpl {

    @Resource
    CSAdminDao csAdminDao;

    public Boolean addCSAdmin(String userId,String workId,String cSchoolId){
        return csAdminDao.addCSAdmin(userId,workId,cSchoolId);
    }


    public  Boolean delRole(String userId){
        return delRole(userId);
    }
}
