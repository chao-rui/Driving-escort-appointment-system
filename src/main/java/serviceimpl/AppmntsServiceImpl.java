package serviceimpl;

import dao.AppmntsDao;
import entity.Appmnts;
import entity.freeTime;
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
    public Boolean updAppraise(String appmntsId,double appraise,String appContext){
        return appmntsDao.updAppraise(appmntsId,appraise,appContext);
    }

    @Override
    public List<freeTime> getFreeRange(Date selectDate) {

        LocalTime startTime = LocalTime.of(8, 0);
        LocalTime endTime = LocalTime.of(18, 0);
        List<Appmnts> appmntsList=appmntsDao.getFreeRange(selectDate);
        List<freeTime> freeRange=new ArrayList<>();

        // 创建全集时间点集合
        List<LocalTime> allTimes = new ArrayList<>();
        for (LocalTime time = startTime; time.compareTo(endTime) <= 0; time = time.plusMinutes(1)) {
            allTimes.add(time);
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

        // 将补集时间点转换为时间范围
        List<String> complementRanges = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
//        LocalTime rangeStart = null;
        for (int i = 0; i < allTimes.size(); i++) {
            LocalTime time = allTimes.get(i);
//            if (rangeStart == null) {
//                rangeStart = time;
//                // 修改开始时间
//                if (rangeStart.getMinute() == 1) {
//                    rangeStart = rangeStart.plusMinutes(29);
//                }
//            }
//            if (i == allTimes.size() - 1 || allTimes.get(i + 1).isAfter(time.plusMinutes(1))) {
//                // 修改结束时间
//                LocalTime rangeEnd = time.plusMinutes(30 - time.getMinute());
//                // 判断结束时间是否超过全集最大时间
//                if (rangeEnd.isAfter(endTime)) {
//                    rangeEnd = endTime;
//                }
//                // 判断开始时间和结束时间是否相等
//                if (!rangeStart.equals(rangeEnd)) {
//                    complementRanges.add(rangeStart.format(formatter) + "-" + rangeEnd.format(formatter));
//                }
//                rangeStart = null;
//            }
            if(time.getMinute()==0||time.getMinute()==30){
                freeTime freeTime = new freeTime();
                freeTime.setIndex(freeRange.size());
                freeTime.setTime(time.format(formatter));
                freeTime.setDisabled(false);
                freeRange.add(freeTime);
            }

        }

//        // 输出补集时间范围
//        for (String range : complementRanges) {
//            System.out.println(range);
//        }
        return freeRange;
    }
}
