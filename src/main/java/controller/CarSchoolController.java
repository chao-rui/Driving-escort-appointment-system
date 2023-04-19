package controller;

import entity.CarSchool;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.CarSchoolService;

import javax.annotation.Resource;
import java.util.Date;

@Controller
public class CarSchoolController {

    @Resource
    CarSchoolService cSchoolService;

    @RequestMapping(value = "addCSchool")
    @ResponseBody
    public Boolean addCSchool(@RequestParam("cSchoolAdmin")String cSchoolAdmin,
                              @RequestParam("cSchoolName")String cSchoolName,
                              @RequestParam("cSchoolAdders")String cSchoolAdders,
                              @RequestParam("cSchoolPhone")String cSchoolPhone,
                              @RequestParam("appraiseCS")String appraiseCS,
                              @RequestParam("updDate") Date updDate){
        return cSchoolService.addCSchool(cSchoolAdmin,cSchoolName,cSchoolAdders,cSchoolPhone,appraiseCS,updDate);
    }

    @RequestMapping(value = "getCSchool")
    @ResponseBody
    public CarSchool getCSchool(@RequestParam("cSchoolId")String cSchoolId){
        return cSchoolService.getCSchool(cSchoolId);
    }

    @RequestMapping(value = "updCSchool")
    @ResponseBody
    public Boolean updCSchool(@RequestParam("cSchoolId")String cSchoolId,
                              @RequestParam("cSchoolName")String cSchoolName,
                              @RequestParam("cSchoolAdders")String cSchoolAdders,
                              @RequestParam("cSchoolPhone")String cSchoolPhone,
                              @RequestParam("updDate")Date updDate){
        return cSchoolService.updCSchool(cSchoolId,cSchoolName,cSchoolAdders,cSchoolPhone,updDate);
    }

    @RequestMapping(value = "delCSchool")
    @ResponseBody
    public Boolean delCSchool(@RequestParam("cSchoolId")String cSchoolId){
        return cSchoolService.delCSchool(cSchoolId);
    }

}
