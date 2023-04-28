package entity;

import lombok.Data;

@Data
public class User {

  private long userId;
  private String userName;
  private String userRname;
  private String gender;
  private long birthYear;
  private String phone;
  private String email;
  private String idNumber;
  private String password;
  private String roleFlag;

}
