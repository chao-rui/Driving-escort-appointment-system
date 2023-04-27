package serviceimpl;

import dao.ApplyDao;
import entity.Apply;
import org.springframework.stereotype.Service;
import service.ApplyService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service("ApplyService")
public class ApplyServiceImpl implements ApplyService {

    @Resource
    ApplyDao applyDao;

    @Override
    public Boolean addApply(String userId, String workId, String cSchoolId, Date updDate) {
        return applyDao.addApply(userId,workId,cSchoolId,updDate);
    }

    @Override
    public List<Apply> getApplyByUId(String userId) {
        return applyDao.getApplyByUId(userId);
    }

    @Override
    public Apply getApplyByAId(String applyId) {
        return applyDao.getApplyByAId(applyId);
    }

    @Override
    public List<Apply> getApplyByCSId(String cSchoolId) {
        return applyDao.getApplyByCSId(cSchoolId);
    }

    @Override
    public Boolean updApply(String applyId, String operate, Date updDate) {
        if(Objects.equals(operate, "0")) {
            return applyDao.updApply(applyId, "1", updDate);
        }else{
            return applyDao.delApply(applyId);
        }
    }
}
