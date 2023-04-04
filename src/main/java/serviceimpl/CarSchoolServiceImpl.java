package serviceimpl;

import dao.CarSchoolDao;
import entity.CarSchool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

@Service("CarSchoolService")
public class CarSchoolServiceImpl {

    @Resource
    CarSchoolDao carSchoolDao;

    public Boolean addCSchool(String cSchoolName, String cSchoolAdders, String cSchoolPhone, String appraiseCS, Date updDate){
        return carSchoolDao.addCSchool(cSchoolName,cSchoolAdders,cSchoolPhone,appraiseCS,updDate);
    }


    public CarSchool getCSchool(String cSchoolId){
        return carSchoolDao.getCSchool(cSchoolId);
    }


    public Boolean updCSchool(String cSchoolId, String cSchoolName, String cSchoolAdders, String cSchoolPhone, Date updDate){
        return carSchoolDao.updCSchool(cSchoolId,cSchoolName,cSchoolAdders,cSchoolPhone,updDate);
    }


    public Boolean delCSchool(String cSchoolId){
        return carSchoolDao.delCSchool(cSchoolId);
    }
}
