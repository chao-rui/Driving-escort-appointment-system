package serviceimpl;

import dao.CarSchoolDao;
import entity.CarSchool;
import org.springframework.stereotype.Service;
import service.CarSchoolService;

import javax.annotation.Resource;
import java.util.Date;

@Service("CarSchoolService")
public class CarSchoolServiceImpl implements CarSchoolService {

    @Resource
    CarSchoolDao carSchoolDao;

    @Override
    public Boolean addCSchool(String cSchoolAdmin,String cSchoolName, String cSchoolAdders, String cSchoolPhone, String appraiseCS, Date updDate){
        return carSchoolDao.addCSchool(cSchoolAdmin,cSchoolName,cSchoolAdders,cSchoolPhone,appraiseCS,updDate);
    }

    @Override
    public CarSchool getCSchool(String cSchoolId){
        return carSchoolDao.getCSchool(cSchoolId);
    }

    @Override
    public Boolean updCSchool(String cSchoolId, String cSchoolName, String cSchoolAdders, String cSchoolPhone, Date updDate){
        return carSchoolDao.updCSchool(cSchoolId,cSchoolName,cSchoolAdders,cSchoolPhone,updDate);
    }

    @Override
    public Boolean delCSchool(String cSchoolId){
        return carSchoolDao.delCSchool(cSchoolId);
    }
}
