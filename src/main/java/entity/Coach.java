package entity;

import lombok.Data;

@Data
public class Coach {

  private String userId;
  private String workId;
  private String carSchoolId;
  private int appraiseCoach;
  private User user;
}
