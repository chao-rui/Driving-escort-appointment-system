package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.CSAdminService;

import javax.annotation.Resource;

@Controller
@RequestMapping("CSAdmin")
public class CSAdminController {

    @Resource
    CSAdminService csAdminService;

    @RequestMapping(value = "addCSA")
    public Boolean addCSAdmin(@RequestParam("userId")String userId,
                              @RequestParam("workId")String workId,
                              @RequestParam("cSchoolId")String cSchoolId){
        return csAdminService.addCSAdmin(userId,workId,cSchoolId);
    }

    @RequestMapping(value = "delCSA")
    public Boolean delCSA(@RequestParam("userId")String userId){
        return csAdminService.delCSA(userId);
    }
}
