package serviceimpl;

import dao.CarSchoolDao;
import entity.CarSchool;
import org.springframework.stereotype.Service;
import service.CarSchoolService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("CarSchoolService")
public class CarSchoolServiceImpl implements CarSchoolService {

    @Resource
    CarSchoolDao carSchoolDao;

    @Override
    public Boolean addCSchool(String cSchoolAdmin,String cSchoolName, String cSchoolAdders, String cSchoolPhone, String appraiseCS, Date updDate){
        return carSchoolDao.addCSchool(cSchoolAdmin,cSchoolName,cSchoolAdders,cSchoolPhone,appraiseCS,updDate);
    }

    @Override
    public List<CarSchool> getCSchoolAll() {
        return carSchoolDao.getCSchoolAll();
    }

    @Override
    public CarSchool getCSchoolByUid(String userId) {
        return carSchoolDao.getCSchoolByUid(userId);
    }

    @Override
    public CarSchool getCSchoolById(String cSchoolId){
        return carSchoolDao.getCSchoolById(cSchoolId);
    }

    @Override
    public Boolean updCSchool(String cSchoolId, String cSchoolName, String cSchoolAdders,String cSchoolDesc, String cSchoolPhone, Date updDate){
        return carSchoolDao.updCSchool(cSchoolId,cSchoolName,cSchoolAdders,cSchoolDesc,cSchoolPhone,updDate);
    }

    @Override
    public Boolean delCSchool(String cSchoolId){
        return carSchoolDao.delCSchool(cSchoolId);
    }
}
