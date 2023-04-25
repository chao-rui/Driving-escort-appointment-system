package controller;

import entity.Appmnts;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.StatsService;

import javax.annotation.Resource;

@Controller
@RequestMapping("Stats") 
public class StatsController {
    
    @Resource
    StatsService statsService;

    //统计驾校中学员的人数
    @RequestMapping(value = "countCoachInCS")
    @ResponseBody
    public String countCoachInCS(@RequestParam("cSchoolId")String cSchoolId) {
        return statsService.countCoachInCS(cSchoolId);
    }

    //统计驾校的车辆数
    @RequestMapping(value = "countCarInCS")
    @ResponseBody
    public String countCarInCS(@RequestParam("cSchoolId")String cSchoolId) {
        return statsService.countCarInCS(cSchoolId);
    }

    //统计驾校中所有教练的预约次数
    @RequestMapping(value = "countAppInCS")
    @ResponseBody
    public String countAppInCS(@RequestParam("cSchoolId")String cSchoolId) {
        return statsService.countAppInCS(cSchoolId);
    }

    //统计驾校中所有教练的预约时长
    @RequestMapping(value = "sumAppInCS")
    @ResponseBody
    public String sumAppInCS(@RequestParam("cSchoolId")String cSchoolId) {
        return statsService.sumAppInCS(cSchoolId);
    }

    //统计教练的预约次数
    @RequestMapping(value = "countAppInCo")
    @ResponseBody
    public String countAppInCo(@RequestParam("objectId")String objectId) {
        return statsService.countAppInCo(objectId);
    }

    //统计教练的预约时长
    @RequestMapping(value = "sumAppInCo")
    @ResponseBody
    public String sumAppInCo(@RequestParam("objectId")String objectId) {
        return statsService.sumAppInCo(objectId);
    }

    //统计用户的预约次数
    @RequestMapping(value = "countAppInU")
    @ResponseBody
    public String countAppInU(@RequestParam("userId")String userId) {
        return statsService.countAppInU(userId);
    }

    //统计用户的预约时长
    @RequestMapping(value = "sumAppInU")
    @ResponseBody
    public String sumAppInU(@RequestParam("userId")String userId) {
        return statsService.sumAppInU(userId);
    }

    //教练的最近一条预约记录
    @RequestMapping(value = "RecAppInCo")
    @ResponseBody
    public Appmnts RecAppInCo(@RequestParam("objectId")String objectId) {
        return statsService.RecAppInCo(objectId);
    }

    //用户的最近一条预约记录
    @RequestMapping(value = "RecAppInU")
    @ResponseBody
    public Appmnts RecAppInU(@RequestParam("userId")String userId) {
        return statsService.RecAppInU(userId);
    }
}
