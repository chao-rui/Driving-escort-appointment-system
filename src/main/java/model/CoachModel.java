package model;

import entity.Coach;

public class CoachModel extends Coach {
    public CoachModel() {
    }

    public CoachModel(Coach coach){
        this.setUserId(coach.getUserId());
        this.setWorkId(coach.getWorkId());
        this.setCarSchoolId(coach.getCarSchoolId());
        this.setAppraiseCoach(coach.getAppraiseCoach());
    }
}
