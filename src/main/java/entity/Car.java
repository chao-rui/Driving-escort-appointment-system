package entity;

import lombok.Data;

@Data
public class Car {

  private String carId;
  private String carNumber;
  private String carBrands;
  private String carModel;
  private String carSchoolId;
  private String carFlag;
  private java.sql.Timestamp updateDate;
}
