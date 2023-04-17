package service;

import entity.CarSchool;
import java.util.Date;

public interface CarSchoolService {

    //新增
    public Boolean addCSchool(String cSchoolAdmin,String cSchoolName, String cSchoolAdders, String cSchoolPhone, String appraiseCS, Date updDate);

    //查询(按编号)
    public CarSchool getCSchool(String cSchoolId);

    //更新驾校信息
    public Boolean updCSchool(String cSchoolId, String cSchoolName, String cSchoolAdders, String cSchoolPhone, Date updDate);

    //注销
    public Boolean delCSchool(String cSchoolId);
}
