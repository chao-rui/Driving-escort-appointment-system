package serviceimpl;

import dao.CSAdminDao;
import org.springframework.stereotype.Service;
import service.CSAdminService;

import javax.annotation.Resource;

@Service("CSAdminService")
public class CSAdminServiceImpl implements CSAdminService {

    @Resource
    CSAdminDao csAdminDao;

    @Override
    public Boolean addCSAdmin(String userId,String workId,String cSchoolId){
        return csAdminDao.addCSAdmin(userId,workId,cSchoolId);
    }

    @Override
    public Boolean delCSA(String userId) {
        return csAdminDao.delCSA(userId);
    }
}
