package entity;

import lombok.Data;

import java.util.Date;

@Data
public class Car {

  private String carId;
  private String carNumber;
  private String carBrands;
  private String carModel;
  private String carSchoolId;
  private String carFlag;
  private Date updateDate;
}
