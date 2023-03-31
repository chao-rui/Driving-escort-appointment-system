package model;


import entity.CSAdmin;

public class CSAdminModel extends CSAdmin {
    public CSAdminModel() {
    }

    public CSAdminModel(CSAdmin CSAdmin){
        this.setUserId(CSAdmin.getUserId());
        this.setWorkId(CSAdmin.getWorkId());
        this.setCarSchoolId(CSAdmin.getCarSchoolId());
    }

}
