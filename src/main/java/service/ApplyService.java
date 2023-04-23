package service;

import entity.Apply;

import java.util.Date;

public interface ApplyService {

    //新增
    public Boolean addApply(String userId, String workId, String cSchoolId, Date updDate);

    //查询(按用户)
    public Apply getApplyByUId(String userId);

    //查询（按编号）
    Apply getApplyByAId(String applyId);

    //查询（按驾校）
    Apply getApplyByCSId(String cSchoolId);

    //更新
    Boolean updApply(String applyId,String applyState,Date updDate);

    //删除
    Boolean delApply(String applyId);
}
