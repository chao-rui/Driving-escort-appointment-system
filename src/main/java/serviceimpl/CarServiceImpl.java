package serviceimpl;

import dao.CarDao;
import entity.Car;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("CarService")
public class CarServiceImpl {

    @Resource
    CarDao carDao;

    public Boolean addCar(String carNumber,String carBrands,String carModel,String userId, Date updDate){
        return carDao.addCar(carNumber,carBrands,carModel,userId,updDate);
    }

    public List<Car> getCarByCS(String cSchoolId){
        return carDao.getCarByCS(cSchoolId);
    }

    public Car getCarById(String carId){
        return carDao.getCarById(carId);

    }

    public Boolean updCar(String carId,String carNumber,String carBrands,String carModel,String userId,String carFlag,Date updDate){
        return carDao.updCar(carId,carNumber,carBrands,carModel,userId,carFlag,updDate);
    }

}
