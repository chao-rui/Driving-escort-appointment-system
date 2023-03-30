package model;


import entity.Appointment;

public class AppointmentModel extends Appointment {

    public AppointmentModel() {
    }

    public AppointmentModel(Appointment appointment){
        this.setAppointmentId(appointment.getAppointmentId());
        this.setUserId(appointment.getUserId());
        this.setObjectId(appointment.getObjectId());
        this.setTime(appointment.getTime());
        this.setStartDate(appointment.getStartDate());
        this.setEndDate(appointment.getEndDate());
        this.setAppointmentAdders(appointment.getAppointmentAdders());
        this.setAppointmentState(appointment.getAppointmentState());
        this.setAppraise(appointment.getAppraise());
        this.setAppraiseContext(appointment.getAppraiseContext());
    }

}
