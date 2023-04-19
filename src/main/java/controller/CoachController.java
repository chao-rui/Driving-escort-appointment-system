package controller;

import entity.Coach;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.CoachService;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("Coach")
public class CoachController {

    @Resource
    CoachService coachService;

    @RequestMapping(value = "addCoach")
    @ResponseBody
    public Boolean addCoach(@RequestParam("userId")String userId,
                            @RequestParam("workId")String workId,
                            @RequestParam("carSchoolId")String carSchoolId){
        return coachService.addCoach(userId,workId,carSchoolId);
    }

    @RequestMapping(value = "getCoachByUserId")
    @ResponseBody
    public Coach getCoachByUserId(@RequestParam("userId")String userId){
        return coachService.getCoachByUserId(userId);
    }

    @RequestMapping(value = "getCoachByCSId")
    @ResponseBody
    public List<Coach> getCoachByCSId(@RequestParam("cSchoolId")String cSchoolId){
        return coachService.getCoachByCSId(cSchoolId);
    }

    @RequestMapping(value = "getCoachByModel")
    @ResponseBody
    public List<Coach> getCoachByModel(@RequestParam("Model")String Model){
        return coachService.getCoachByModel(Model);
    }

    @RequestMapping(value = "updAppCoach")
    @ResponseBody
    public Boolean updAppCoach(@RequestParam("cSchoolId")String cSchoolId){
        return coachService.updAppCoach(cSchoolId);
    }

    @RequestMapping(value = "delCoach")
    @ResponseBody
    public Boolean delCoach(@RequestParam("userId")String userId){
        return coachService.delCoach(userId);
    }
}
