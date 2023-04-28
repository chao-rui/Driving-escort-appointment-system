package dao;


import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {

    //登录
    @Select("SELECT * " +
            "FROM user WHERE USER_ID=#{userId} " +
            "AND PASSWORD=#{password} "+
            "AND ROLE_FLAG!=0")
    User login(@Param("userId") String userId,
               @Param("password")String password);

    //注册
    @Insert("INSERT INTO user (USER_NAME,PHONE,PASSWORD, ROLE_FLAG) " +
            "VALUES (#{userName},#{phone},#{password},1)")
    Boolean register(@Param("userName")String userName,
                     @Param("password")String password,
                     @Param("phone")String phone);

    //获取新用户ID
    @Select("SELECT MAX(USER_ID) FROM user")
    String getNewId();

    //获取用户信息
    @Select("SELECT * FROM user WHERE USER_ID=#{userId}")
    User getUserInfo(@Param("userId")String userId);

    @Select("SELECT COUNT(*) FROM user WHERE USER_ID=#{userId}")
    String isExist(@Param("userId")String userId);

    //实名认证
    @Update("UPDATE user SET  " +
            "USER_RNAME=#{userRName}, " +
            " ID_NUMBER=#{idNumber}" +
            "WHERE USER_ID=#{userId}")
    Boolean setRName(@Param("userRName")String UserRName,
                     @Param("idNumber")String idNumber,
                     @Param("userId")String userId);

    //修改基础信息
    @Update("<script>"+
            "UPDATE user SET " +
            "<if test=\"userName!=''\">"+
            " USER_NAME=#{userName}," +
            "     PHONE=#{phone},"+
            "     EMAIL=#{email},"+
            "    GENDER=#{gender}," +
            "BIRTH_YEAR=#{birthYear} " +
            "</if>"+
            "<if test=\"userName==''\">"+
            "    GENDER=#{gender}," +
            "BIRTH_YEAR=#{birthYear} " +
            "</if>"+
            "WHERE USER_ID=#{userId}"+
            "</script>")
    Boolean updUserInfo(@Param("userName")String userName,
                        @Param("gender")String gender,
                        @Param("phone")String phone,
                        @Param("email")String email,
                        @Param("birthYear")String birthYear,
                        @Param("userId")String userId);

    //修改密码
    @Update("UPDATE user SET PASSWORD=#{newPassword} " +
            "WHERE USER_ID=#{userId} AND PASSWORD=#{password}")
    Boolean updPassword(@Param("newPassword")String newPassword,
                        @Param("userId")String userId,
                        @Param("password")String password);

    //身份变换（教练/驾校管理员_用户表）
    @Update("UPDATE user SET ROLE_FLAG=#{roleFlag} " +
            "WHERE USER_ID=#{userId}")
    Boolean updRole(@Param("userId")String userId,
                    @Param("roleFlag")String roleFlag);

    //重置密码
    @Update("UPDATE user SET PASSWORD=#{password} WHERE USER_ID=#{userId}")
    Boolean clsPwd(@Param("password")String password,
                   @Param("userId")String userId);

    //注销
    @Delete("DELETE FROM user WHERE userId=#{userId}")
    Boolean delUser(@Param("userId")String userId);

}
