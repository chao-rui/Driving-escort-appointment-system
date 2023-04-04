package entity;

import lombok.Data;

import java.util.Date;

@Data
public class Appmnts {

  private String appointmentId;
  private String userId;
  private String objectId;
  private int time;
  private Date startDate;
  private Date endDate;
  private String appointmentAdders;
  private String appointmentState;
  private int appraise;
  private String appraiseContext;

}
