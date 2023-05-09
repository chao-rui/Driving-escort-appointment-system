package serviceimpl;

import dao.CommonDao;
import org.springframework.stereotype.Service;
import service.CommonService;

import javax.annotation.Resource;

@Service("CommonService")
public class CommonServiceImpl implements CommonService {

    @Resource
    CommonDao commonDao;

    @Override
    public Boolean updAppState() {
        return commonDao.updAppState();
    }
}
