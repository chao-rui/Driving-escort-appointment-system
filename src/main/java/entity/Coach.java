package entity;

import lombok.Data;

@Data
public class Coach {

  private String userId;
  private String workId;
  private String carSchoolId;
  private int appraiseCoach;

  private String context;

  private double price;

  private User user;
}
