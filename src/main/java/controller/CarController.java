package controller;

import entity.Car;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.CarService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
public class CarController {

    @Resource
    CarService carService;

    @RequestMapping(value = "addCar")
    public Boolean addCar(@RequestParam("carNumber") String carNumber,
                          @RequestParam("carBrands") String carBrands,
                          @RequestParam("carModel") String carModel,
                          @RequestParam("userId") String userId,
                          @RequestParam("updDate") Date updDate) {
        return carService.addCar(carNumber, carBrands, carModel, userId, updDate);
    }

    @RequestMapping(value = "getCarByCS")
    public List<Car> getCarByCS(@RequestParam("cSchoolId") String cSchoolId) {
        return carService.getCarByCS(cSchoolId);
    }

    @RequestMapping(value = "getCarById")
    public Car getCarById(@RequestParam("carId") String carId) {
        return carService.getCarById(carId);
    }

    @RequestMapping(value = "updCar")
    public Boolean updCar(@RequestParam("carId") String carId,
                          @RequestParam("carNumber") String carNumber,
                          @RequestParam("carBrands") String carBrands,
                          @RequestParam("carModel") String carModel,
                          @RequestParam("userId") String userId,
                          @RequestParam("carFlag") String carFlag,
                          @RequestParam("updDate") Date updDate) {
        return carService.updCar(carId, carNumber, carBrands, carModel, userId, carFlag, updDate);
    }
}