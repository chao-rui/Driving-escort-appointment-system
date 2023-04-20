package service;

import entity.CarSchool;
import java.util.Date;
import java.util.List;

public interface CarSchoolService {

    //新增
    public Boolean addCSchool(String cSchoolAdmin,String cSchoolName, String cSchoolAdders, String cSchoolPhone, String appraiseCS, Date updDate);

    //查询(所有)
    public List<CarSchool> getCSchoolAll();

    //查询(按管理员)
    public CarSchool getCSchoolByUid(String userId);

    //查询(按编号)
    public CarSchool getCSchoolById(String cSchoolId);

    //更新驾校信息
    public Boolean updCSchool(String cSchoolId, String cSchoolName, String cSchoolAdders, String cSchoolDesc, String cSchoolPhone, Date updDate);

    //注销
    public Boolean delCSchool(String cSchoolId);
}
