package serviceimpl;

import dao.AppmntsDao;
import entity.Appmnts;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("AppmntsService")
public class AppmntsServiceImpl {

    @Resource
    AppmntsDao appmntsDao;

    public Boolean addAppmnts(String userId, String objectId, int time, Date startDate, Date endDate, String appmntsAdders){
        return appmntsDao.addAppmnts(userId,objectId,time,startDate,endDate,appmntsAdders);
    }

    public Appmnts getAppmntsById(String appmntsId){
        return appmntsDao.getAppmntsById(appmntsId);
    }

    public List<Appmnts> getAppmntsByOId(String objectId){
        return appmntsDao.getAppmntsByOId(objectId);
    }

    public Boolean updAppmnts(String appmntsId,int time, Date startDate,Date endDate,String appmntsAdder,String appmntsState){
        return appmntsDao.updAppmnts(appmntsId,time,startDate,endDate,appmntsAdder,appmntsState);
    }

    public Boolean updAppraise(String appmntsId,int appraise,String appContext){
        return appmntsDao.updAppraise(appmntsId,appraise,appContext);
    }

    public Boolean updAppCoach(String ObjectId){
        return appmntsDao.updAppCoach(ObjectId);
    }

}
