package entity;


import lombok.Data;

import java.util.Date;

@Data
public class Apply {

  private int applyId;
  private int userId;
  private int workId;
  private int carSchoolId;
  private String applyState;
  private Date updateDate;

}
