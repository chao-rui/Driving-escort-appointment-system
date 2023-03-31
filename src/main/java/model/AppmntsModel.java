package model;


import entity.Appmnts;

public class AppmntsModel extends Appmnts {

    public AppmntsModel() {
    }

    public AppmntsModel(Appmnts appmnts){
        this.setAppointmentId(appmnts.getAppointmentId());
        this.setUserId(appmnts.getUserId());
        this.setObjectId(appmnts.getObjectId());
        this.setTime(appmnts.getTime());
        this.setStartDate(appmnts.getStartDate());
        this.setEndDate(appmnts.getEndDate());
        this.setAppointmentAdders(appmnts.getAppointmentAdders());
        this.setAppointmentState(appmnts.getAppointmentState());
        this.setAppraise(appmnts.getAppraise());
        this.setAppraiseContext(appmnts.getAppraiseContext());
    }

}
