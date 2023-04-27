package serviceimpl;

import dao.AppmntsDao;
import entity.Appmnts;
import entity.FreeTime;
import org.springframework.stereotype.Service;
import service.AppmntsService;

import javax.annotation.Resource;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("AppmntsService")
public class AppmntsServiceImpl implements AppmntsService {

    @Resource
    AppmntsDao appmntsDao;

    @Override
    public Boolean addAppmnts(String userId, String objectId, double time, Date startDate, Date endDate){
        if(startDate.toInstant().isAfter(endDate.toInstant())){
            return false;
        }else{
            return appmntsDao.addAppmnts(userId,objectId,time,startDate,endDate);
        }
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
    public List<Appmnts> getAppmntsByCS(String cSchoolId) {
        return appmntsDao.getAppmntsByCS(cSchoolId);
    }

    @Override
    public List<Appmnts> getAppmntsByUId(String userId) {
        return appmntsDao.getAppmntsByUId(userId);
    }

    @Override
    public Boolean updAppmnts(String appmntsId,Date startDate,Date endDate,String appmntsState){
        return appmntsDao.updAppmnts(appmntsId,startDate,endDate,appmntsState);
    }

    @Override
    public Boolean delAppmnts(String appmntsId) {
        return appmntsDao.delAppmnts(appmntsId);
    }

    @Override
    public Boolean updAppraise(String appmntsId,double appraise,String appContext){
        return appmntsDao.updAppraise(appmntsId,appraise,appContext);
    }

    @Override
    public List<FreeTime> getFreeRange(Date selectDate) {

        LocalTime startTime = LocalTime.of(8, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        List<Appmnts> appmntsList=appmntsDao.getFreeRange(selectDate);
        List<FreeTime> freeRange=new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

        // 创建全集时间点集合
        List<LocalTime> allTimes = new ArrayList<>();
        for (LocalTime time = startTime; !time.isAfter(endTime); time = time.plusMinutes(30)) {
            allTimes.add(time);
            FreeTime freeTime=new FreeTime();
            freeTime.setTime(time.format(formatter));
            freeTime.setIndex(allTimes.size());
            freeTime.setDisabled(true);
            freeRange.add(freeTime);
        }

        // 从数据库中获取时间范围
        List<LocalTime[]> rangesFromDatabase = new ArrayList<>();
        for (Appmnts appmnt : appmntsList) {
            LocalTime start = appmnt.getStartDate().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
            LocalTime end = appmnt.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalTime();
            rangesFromDatabase.add(new LocalTime[]{start, end});
        }

        // 遍历时间范围，移除全集中的时间点
        for (LocalTime[] range : rangesFromDatabase) {
            allTimes.removeIf(time -> (time.isAfter(range[0]) || time.equals(range[0])) && (time.isBefore(range[1]) || time.equals(range[1])));
        }


        freeRange.stream()
                .filter(FreeTime -> allTimes.contains(LocalTime.parse(FreeTime.getTime())))
                .forEach(FreeTime -> FreeTime.setDisabled(false));

        return freeRange;
    }
}
