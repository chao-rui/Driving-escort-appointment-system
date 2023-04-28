package service;

import entity.Coach;

import java.util.List;

public interface CoachService {

    //新增
    public Boolean addCoach(String userId,String workId,String carSchoolId);

    //查询（按编号）
    public Coach getCoachByUserId(String userId);

    //查询（按驾校）
    public List<Coach> getCoachByCSId(String cSchoolId);

    //查询（按车辆类型）
    public List<Coach> getCoachByModel(String Model,String cSchoolId);

    //注销
    public Boolean delCoach(String userId);
}
