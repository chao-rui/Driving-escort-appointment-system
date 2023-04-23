package entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Apply {

  private int applyId;
  private int userId;
  private int workId;
  private int carSchoolId;
  private String applyState;
  @JsonFormat(pattern = "yyyy年MM月dd日",timezone = "GMT+8")
  private Date updateDate;
  private User user;

}
