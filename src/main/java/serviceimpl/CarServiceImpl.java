package serviceimpl;

import dao.CarDao;
import entity.Car;
import org.springframework.stereotype.Service;
import service.CarService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("CarService")
public class CarServiceImpl implements CarService {

    @Resource
    CarDao carDao;

    @Override
    public Boolean addCar(String carNumber,String carBrands,String carModel,String cSchoolId,String userId, Date updDate){
        Boolean f1=carDao.updCarU(userId);
        Boolean f2=carDao.addCar(carNumber,carBrands,carModel,cSchoolId,userId,updDate);
        return f1&&f2;
    }

    @Override
    public List<Car> getCarByCS(String cSchoolId){
        return carDao.getCarByCS(cSchoolId);
    }

    @Override
    public Car getCarById(String carId){
        return carDao.getCarById(carId);

    }

    @Override
    public Boolean updCar(String carId,String carNumber,String carBrands,String carModel,String cSchoolId,String userId,String carFlag,Date updDate){
        Boolean f1=carDao.updCarU(userId);
        Boolean f2=carDao.updCar(carId,carNumber,carBrands,carModel,cSchoolId,userId,carFlag,updDate);
        return f1&&f2;
    }

}
