package serviceimpl;

import dao.CoachDao;
import entity.Coach;
import org.springframework.stereotype.Service;
import service.CoachService;

import javax.annotation.Resource;
import java.util.List;

@Service("CoachService")
public class CoachServiceImpl implements CoachService {

    @Resource
    CoachDao coachDao;

    @Override
    public Boolean addCoach(String userId,String workId,String carSchoolId){
        return coachDao.addCoach(userId,workId,carSchoolId);
    }

    @Override
    public Coach getCoachByUserId(String userId){
        return coachDao.getCoachByUserId(userId);
    }

    @Override
    public List<Coach> getCoachByCSId(String cSchoolId){
        return coachDao.getCoachByCSId(cSchoolId);
    }

    @Override
    public List<Coach> getCoachByModel(String Model,String cSchoolId){
        return coachDao.getCoachByModel(Model,cSchoolId);
    }

    @Override
    public Boolean delCoach(String userId){
        return coachDao.delCoach(userId);
    }
}
