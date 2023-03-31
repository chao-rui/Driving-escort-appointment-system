package entity;

import lombok.Data;

@Data
public class Appmnts {

  private String appointmentId;
  private String userId;
  private String objectId;
  private long time;
  private java.sql.Timestamp startDate;
  private java.sql.Timestamp endDate;
  private String appointmentAdders;
  private String appointmentState;
  private long appraise;
  private String appraiseContext;

}
