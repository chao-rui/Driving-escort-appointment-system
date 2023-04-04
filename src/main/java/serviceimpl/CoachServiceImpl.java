package serviceimpl;

import dao.CoachDao;
import entity.Coach;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("CoachService")
public class CoachServiceImpl {

    @Resource
    CoachDao coachDao;

    public Boolean addCoach(String userId,String workId,String carSchoolId){
        return coachDao.addCoach(userId,workId,carSchoolId);
    }

    public Coach getCoachByUserId(String userId){
        return coachDao.getCoachByUserId(userId);
    }


    public List<Coach> getCoachByCSId(String cSchoolId){
        return coachDao.getCoachByCSId(cSchoolId);
    }


    public List<Coach> getCoachByModel(String Model){
        return coachDao.getCoachByModel(Model);
    }


    public Boolean updAppCoach(String cSchoolId){
        return coachDao.updAppCoach(cSchoolId);
    }


    public Boolean delCoach(String userId){
        return delCoach(userId);
    }
}
