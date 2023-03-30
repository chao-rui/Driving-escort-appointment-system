package model;


import entity.CarSchoolManager;

public class CarSchoolManagerModel extends CarSchoolManager {
    public CarSchoolManagerModel() {
    }

    public CarSchoolManagerModel(CarSchoolManager carSchoolManager){
        this.setUserId(carSchoolManager.getUserId());
        this.setWorkId(carSchoolManager.getWorkId());
        this.setCarSchoolId(carSchoolManager.getCarSchoolId());
    }

}
