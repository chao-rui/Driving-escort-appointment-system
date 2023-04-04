package entity;


import lombok.Data;

@Data
public class User {

  private int userId;
  private String userName;
  private String userRname;
  private String gender;
  private int birthYear;
  private String phone;
  private String idNumber;
  private String password;
  private String roleFlag;
}
