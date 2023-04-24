package entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Appmnts {

  private String appointmentId;

  private String userId;

  private String objectId;

  private double time;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
  private Date startDate;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
  private Date endDate;

  private String appointmentState;

  private double appraise;

  private String appraiseContext;

  private User user;

  private User object;

}
