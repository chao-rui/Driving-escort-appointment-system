package service;

import entity.Car;

import java.util.Date;
import java.util.List;

public interface CarService {

    //新增
    public Boolean addCar(String carNumber,String carBrands,String carModel,String cSchoolId,String userId, Date updDate);

    //查询（按驾校）
    public List<Car> getCarByCS(String cSchoolId);

    //查询（按编号）
    public Car getCarById(String carId);

    //更新
    public Boolean updCar(String carId,String carNumber,String carBrands,String carModel,String cSchoolId,String userId,String carFlag,Date updDate);

}
