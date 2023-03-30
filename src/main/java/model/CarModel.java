package model;


import entity.Car;

public class CarModel extends Car {

    public CarModel() {
    }

    public CarModel(Car car){
        this.setCarId(car.getCarId());
        this.setCarNumber(car.getCarNumber());
        this.setCarBrands(car.getCarBrands());
        this.setCarModel(car.getCarModel());
        this.setCarSchoolId(car.getCarSchoolId());
        this.setCarFlag(car.getCarFlag());
        this.setUpdateDate(car.getUpdateDate());
    }
}
