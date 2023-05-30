package controller;

import entity.Apply;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ApplyService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("Apply")
public class ApplyController {

    @Resource
    ApplyService applyService;

    //新增
    @RequestMapping(value = "addApply")
    @ResponseBody
    public Boolean addApply(@RequestParam("userId")String userId,
                            @RequestParam("workId")String workId,
                            @RequestParam("cSchoolId")String cSchoolId,
                            @RequestParam("updDate") Date updDate){
        return applyService.addApply(userId,workId,cSchoolId,updDate);

    }

    //查询(按用户)
    @RequestMapping(value = "getApplyByUId")
    @ResponseBody
    public List<Apply> getApplyByUId(@RequestParam("userId")String userId){
        return applyService.getApplyByUId(userId);

    }

    //查询（按编号）
    @RequestMapping(value = "getApplyByAId")
    @ResponseBody
    public Apply getApplyByAId(@RequestParam("applyId")String applyId){
        return applyService.getApplyByAId(applyId);

    }

    //查询（按驾校）
    @RequestMapping(value = "getApplyByCSId")
    @ResponseBody
    public List<Apply> getApplyByCSId(@RequestParam("cSchoolId")String cSchoolId){
        return applyService.getApplyByCSId(cSchoolId);

    }

    //更新
    @RequestMapping(value = "updApply")
    @ResponseBody
    public Boolean updApply(@RequestParam("applyId")String applyId,
                            @RequestParam("operate")String operate,
                            @RequestParam("updDate") Date updDate){
        return applyService.updApply(applyId,operate,updDate);

    }

    //删除
    @RequestMapping(value = "delApply")
    @ResponseBody
    public Boolean updApply(@RequestParam("applyId")String applyId){
        return applyService.delApply(applyId);
    }

}
