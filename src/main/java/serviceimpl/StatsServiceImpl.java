package serviceimpl;

import dao.StatsDao;
import entity.Appmnts;
import org.springframework.stereotype.Service;
import service.StatsService;

import javax.annotation.Resource;

@Service("StatsService")
public class StatsServiceImpl implements StatsService {

    @Resource
    StatsDao statsDao;

    @Override
    public String countCoachInCS(String cSchoolId) {
        return statsDao.countCoachInCS(cSchoolId);
    }

    @Override
    public String countCarInCS(String cSchoolId) {
        return statsDao.countCarInCS(cSchoolId);
    }

    @Override
    public String countAppInCS(String cSchoolId) {
        return statsDao.countAppInCS(cSchoolId);
    }

    @Override
    public String sumAppInCS(String cSchoolId) {
        return statsDao.sumAppInCS(cSchoolId);
    }

    @Override
    public String countAppInCo(String objectId) {
        return statsDao.countAppInCo(objectId);
    }

    @Override
    public String sumAppInCo(String objectId) {
        return statsDao.sumAppInCo(objectId);
    }

    @Override
    public String countAppInU(String userId) {
        return statsDao.countAppInU(userId);
    }

    @Override
    public String sumAppInU(String userId) {
        return statsDao.sumAppInU(userId);
    }

    @Override
    public Appmnts RecAppInCo(String objectId) {
        return statsDao.RecAppInCo(objectId);
    }

    @Override
    public Appmnts RecAppInU(String userId) {
        return statsDao.RecAppInU(userId);
    }
}
