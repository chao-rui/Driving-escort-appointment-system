package model;


import entity.CarSchool;

public class CarSchoolModel extends CarSchool {
    public CarSchoolModel() {
    }

    public CarSchoolModel(CarSchool carSchool){
        this.setCarSchoolId(carSchool.getCarSchoolId());
        this.setCarSchoolName(carSchool.getCarSchoolName());
        this.setCarSchoolAdders(carSchool.getCarSchoolAdders());
        this.setCarSchoolPhone(carSchool.getCarSchoolPhone());
        this.setAppraiseCarShool(carSchool.getAppraiseCarShool());
        this.setUpdateDate(carSchool.getUpdateDate());
    }

}
