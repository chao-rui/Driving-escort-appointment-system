package service;

import entity.Appmnts;

import java.util.Date;
import java.util.List;

public interface AppmntsService {

    //新增
    public Boolean addAppmnts(String userId, String objectId, int time, Date startDate,Date endDate,String appmntsAdders);

    //查询（按编号）
    public Appmnts getAppmntsById(String appmntsId);

    //查询（按教练）
    public List<Appmnts> getAppmntsByOId(String objectId);

    //更新预约信息
    public Boolean updAppmnts(String appmntsId,int time, Date startDate,Date endDate,String appmntsAdder,String appmntsState);

    //更新评价
    public Boolean updAppraise(String appmntsId,int appraise,String appContext);

    //更新教练评价
    public Boolean updAppCoach(String ObjectId);

}
