package controller;

import entity.Appmnts;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AppmntsService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
public class AppmntsController {

    @Resource
    AppmntsService appmntsService;

    @RequestMapping(value = "addAppmnts")
    @ResponseBody
    public Boolean addAppmnts(@RequestParam("userId") String userId,
                              @RequestParam("objectId") String objectId,
                              @RequestParam("time") int time,
                              @RequestParam("startDate") Date startDate,
                              @RequestParam("endDate") Date endDate,
                              @RequestParam("appmntsAdders") String appmntsAdders) {
        return appmntsService.addAppmnts(userId, objectId, time, startDate, endDate, appmntsAdders);
    }

    @RequestMapping(value = "getAppmntsById")
    @ResponseBody
    public Appmnts getAppmntsById(@RequestParam("appmntsId") String appmntsId) {
        return appmntsService.getAppmntsById(appmntsId);
    }

    @RequestMapping(value = "getAppmntsByOId")
    @ResponseBody
    public List<Appmnts> getAppmntsByOId(@RequestParam("objectId") String objectId) {
        return appmntsService.getAppmntsByOId(objectId);
    }

    @RequestMapping(value = "updAppmnts")
    @ResponseBody
    public Boolean updAppmnts(@RequestParam("appmntsId") String appmntsId,
                              @RequestParam("time") int time,
                              @RequestParam("startDate") Date startDate,
                              @RequestParam("endDate") Date endDate,
                              @RequestParam("appmntsAdder") String appmntsAdder,
                              @RequestParam("appmntsState") String appmntsState) {
        return appmntsService.updAppmnts(appmntsId, time, startDate, endDate, appmntsAdder, appmntsState);
    }

    @RequestMapping(value = "updAppraise")
    @ResponseBody
    public Boolean updAppraise(@RequestParam("appmntsId") String appmntsId,
                               @RequestParam("appraise") int appraise,
                               @RequestParam("appContext") String appContext) {
        return appmntsService.updAppraise(appmntsId, appraise, appContext);
    }

    @RequestMapping(value = "updAppCoach")
    @ResponseBody
    public Boolean updAppCoach(@RequestParam("ObjectId") String ObjectId) {
        return appmntsService.updAppCoach(ObjectId);
    }
}