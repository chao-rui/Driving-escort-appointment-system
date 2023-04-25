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
@RequestMapping("Appmnts")
public class AppmntsController {

    @Resource
    AppmntsService appmntsService;

    @RequestMapping(value = "addAppmnts")
    @ResponseBody
    public Boolean addAppmnts(@RequestParam("userId") String userId,
                              @RequestParam("objectId") String objectId,
                              @RequestParam("time") String time,
                              @RequestParam("startDate") Date startDate,
                              @RequestParam("endDate") Date endDate) {
        return appmntsService.addAppmnts(userId, objectId, Double.parseDouble(time), startDate, endDate);
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

    @RequestMapping(value = "getAppmntsByUId")
    @ResponseBody
    public List<Appmnts> getAppmntsByUId(@RequestParam("userId") String userId) {
        return appmntsService.getAppmntsByUId(userId);
    }

    @RequestMapping(value = "updAppmnts")
    @ResponseBody
    public Boolean updAppmnts(@RequestParam("appmntsId") String appmntsId,
                              @RequestParam("startDate") Date startDate,
                              @RequestParam("endDate") Date endDate,
                              @RequestParam("appmntsState") String appmntsState) {
        return appmntsService.updAppmnts(appmntsId, startDate, endDate,appmntsState);
    }

    @RequestMapping(value = "updAppraise")
    @ResponseBody
    public Boolean updAppraise(@RequestParam("appmntsId") String appmntsId,
                               @RequestParam("appraise") String appraise,
                               @RequestParam("appContext") String appContext) {
        return appmntsService.updAppraise(appmntsId, Double.parseDouble(appraise), appContext);
    }

}
