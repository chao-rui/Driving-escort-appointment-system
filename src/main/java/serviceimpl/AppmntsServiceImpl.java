package serviceimpl;

import dao.AppmntsDao;
import entity.Appmnts;
import org.springframework.stereotype.Service;
import service.AppmntsService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("AppmntsService")
public class AppmntsServiceImpl implements AppmntsService {

    @Resource
    AppmntsDao appmntsDao;

    @Override
    public Boolean addAppmnts(String userId, String objectId, double time, Date startDate, Date endDate){
        return appmntsDao.addAppmnts(userId,objectId,time,startDate,endDate);
    }

    @Override
    public Appmnts getAppmntsById(String appmntsId){
        return appmntsDao.getAppmntsById(appmntsId);
    }

    @Override
    public List<Appmnts> getAppmntsByOId(String objectId){
        return appmntsDao.getAppmntsByOId(objectId);
    }

    @Override
    public List<Appmnts> getAppmntsByUId(String userId) {
        return appmntsDao.getAppmntsByUId(userId);
    }

    @Override
    public Boolean updAppmnts(String appmntsId,double time, Date startDate,Date endDate,String appmntsAdder,String appmntsState){
        return appmntsDao.updAppmnts(appmntsId,time,startDate,endDate,appmntsAdder,appmntsState);
    }

    @Override
    public Boolean updAppraise(String appmntsId,double appraise,String appContext){
        return appmntsDao.updAppraise(appmntsId,appraise,appContext);
    }


}
