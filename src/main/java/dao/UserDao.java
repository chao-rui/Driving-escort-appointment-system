package dao;


import entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public interface UserDao {

    //登录
    @Select("SELECT * FROM userinfo WHERE USER_ID=#{userId} AND PASSWORD=#{password}")
    User login(@Param("userId") String userId,@Param("passWord")String password);

    //注册
    @Insert("INSERT INTO userinfo (USER_NAME,PHONE,PASSWORD, ROLE_FLAG) values (#{userName},#{phone},#{password})")
    Boolean register(@Param("userName")String userName,@Param("phone")String phone,@Param("password")String password);

//    //获取新用户ID
//    @Select("SELECT MAX(USER_ID)+1 FROM userinfo")
//    Boolean getNewId();
//
//    //获取用户角色
//    @Select("SELECT ROLE_FLAG FROM userinfo WHERE USER_ID=#{userId}")
//    int getRole(@Param("userId")String userId);
//
//    //获取用户基本信息
//    @Select("SELECT * FROM userinfo WHERE USER_ID=#{userId}")
//    User getAll(@Param("userId")String userId);

    //实名认证
    @Update("UPDATE USERINFO SET  USER_RNAME=#{userRName}, ID_NUMBER=#{idNumber},ROLE_FLAG=1 WHERE USER_ID=#{userId}")
    Boolean setRName(@Param("userRName")String UserRName,@Param("idNumber")String idNumber,@Param("userId")String userId);

    //修改基础信息
    @Update("UPDATE USERINFO SET USER_NAME=,GENDER=1,BIRTH_YEAR=1 WHERE USER_ID=#{userId}")
    Boolean updUserInfo();

}
