package dao;

import entity.Appmnts;
import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

@Repository
public interface StatsDao {

    //统计驾校中学员的人数
    @Select("SELECT COUNT(*) FORM coach WHERE CAR_SCHOOL_ID=#{cSchoolId}")
    String countCoachInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校的车辆数
    @Select("SELECT COUNT(*) FORM car WHERE CAR_SCHOOL_ID=#{cSchoolId}")
    String countCarInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校中所有教练的预约次数
    @Select("SELECT COUNT(*) FROM appmnts " +
            "LEFT JOIN coach ON OBJECT_ID=coach.USER_ID WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    String countAppInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校中所有教练的预约时长
    @Select("SELECT SUM(time) FROM appmnts " +
            "LEFT JOIN coach ON OBJECT_ID=coach.USER_ID WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    String sumAppInCS(@Param("cSchoolId")String cSchoolId);

    //统计教练的预约次数
    @Select("SELECT COUNT(*) FROM appmnts WHERE OBJECT_ID=#{objectId};")
    String countAppInCo(@Param("objectId")String objectId);

    //统计教练的预约时长
    @Select("SELECT SUM(time) FROM appmnts WHERE OBJECT_ID=#{objectId};")
    String sumAppInCo(@Param("objectId")String objectId);

    //统计用户的预约次数
    @Select("SELECT COUNT(*) FROM appmnts WHERE USER_ID=#{userId};")
    String countAppInU(@Param("userId")String userId);

    //统计用户的预约时长
    @Select("SELECT SUM(time) FROM appmnts WHERE USER_ID=#{userId};")
    String sumAppInU(@Param("userId")String userId);

    //教练的最近一条预约记录
    @Select("SELECT * FROM appmnts WHERE OBJECT_ID=#{objectId} " +
            "AND END_DATE=(SELECT MAX(END_DATE) FROM appmnts WHERE OBJECT_ID=#{objectId});")
    @Results(id = "CUserInfoResultMap",value = {
            @Result(property = "appointmentId",column = "APPOINTMENT_ID",id = true),
            @Result(property = "user",
                    column = "USER_ID",
                    javaType = User.class,
                    one = @One(select = "dao.UserDao.getUserInfo")),
            @Result(property = "object",
                    column = "OBJECT_ID",
                    javaType = User.class,
                    one = @One(select = "dao.UserDao.getUserInfo")),
            @Result(property = "time",column = "APPOINTMENT_ID"),
            @Result(property = "startDate",column = "START_DATE"),
            @Result(property = "endDate",column = "END_DATE"),
            @Result(property = "appointmentState",column = "APPOINTMENT_STATE"),
            @Result(property = "appraise",column = "APPRAISE"),
            @Result(property = "appraiseContext",column = "APPRAISE_CONTEXT"),
    })
    Appmnts RecAppInCo(@Param("objectId")String objectId);

    //教练的最近一条预约记录
    @Select("SELECT * FROM appmnts WHERE USER_ID=#{userId} " +
            "AND END_DATE=(SELECT MAX(END_DATE) FROM appmnts WHERE USER_ID=#{userId});")
    @ResultMap("CUserInfoResultMap")
    Appmnts RecAppInU(@Param("userId")String userId);
}
