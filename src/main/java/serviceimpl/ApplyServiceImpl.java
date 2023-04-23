package serviceimpl;

import dao.ApplyDao;
import entity.Apply;
import org.springframework.stereotype.Service;
import service.ApplyService;

import javax.annotation.Resource;
import java.util.Date;

@Service("ApplyService")
public class ApplyServiceImpl implements ApplyService {

    @Resource
    ApplyDao applyDao;

    @Override
    public Boolean addApply(String userId, String workId, String cSchoolId, Date updDate) {
        return applyDao.addApply(userId,workId,cSchoolId,updDate);
    }

    @Override
    public Apply getApplyByUId(String userId) {
        return applyDao.getApplyByUId(userId);
    }

    @Override
    public Apply getApplyByAId(String applyId) {
        return applyDao.getApplyByAId(applyId);
    }

    @Override
    public Apply getApplyByCSId(String cSchoolId) {
        return applyDao.getApplyByCSId(cSchoolId);
    }

    @Override
    public Boolean updApply(String applyId, String applyState, Date updDate) {
        return applyDao.updApply(applyId,applyState,updDate);
    }

    @Override
    public Boolean delApply(String applyId) {
        return applyDao.delApply(applyId);
    }
}
