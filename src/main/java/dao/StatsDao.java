package dao;

import entity.Appmnts;
import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface StatsDao {

    //统计驾校中学员的人数
    @Select("SELECT COUNT(*) FROM coach WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    String countCoachInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校的车辆数
    @Select("SELECT COUNT(*) FROM car WHERE CAR_SCHOOL_ID=#{cSchoolId} ;")
    String countCarInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校中所有教练的预约次数
    @Select("SELECT COUNT(*) FROM appmnts " +
            "LEFT JOIN coach ON OBJECT_ID=coach.USER_ID " +
            "WHERE CAR_SCHOOL_ID=#{cSchoolId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String countAppInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校中所有教练的预约时长
    @Select("SELECT SUM(time) FROM appmnts " +
            "LEFT JOIN coach ON OBJECT_ID=coach.USER_ID " +
            "WHERE CAR_SCHOOL_ID=#{cSchoolId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String sumAppInCS(@Param("cSchoolId")String cSchoolId);

    //统计教练的预约次数
    @Select("SELECT COUNT(*) FROM appmnts " +
            "WHERE OBJECT_ID=#{objectId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String countAppInCo(@Param("objectId")String objectId);

    //统计教练的预约时长
    @Select("SELECT SUM(time) FROM appmnts " +
            "WHERE OBJECT_ID=#{objectId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String sumAppInCo(@Param("objectId")String objectId);

    //统计用户的预约次数
    @Select("SELECT COUNT(*) FROM appmnts " +
            "WHERE USER_ID=#{userId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String countAppInU(@Param("userId")String userId);

    //统计用户的预约时长
    @Select("SELECT SUM(time) FROM appmnts " +
            "WHERE USER_ID=#{userId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    String sumAppInU(@Param("userId")String userId);

    //教练的最近一条预约记录
    @Select("SELECT * FROM appmnts WHERE OBJECT_ID=#{objectId} " +
            "ORDER BY ABS(TIMESTAMPDIFF(SECOND, END_DATE, NOW())) LIMIT 1;")
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
    Appmnts RecAppInCo(@Param("objectId")String objectId, @Param("now")Date now);

    //用户的最近一条预约记录
    @Select("SELECT * FROM appmnts WHERE USER_ID=#{userId} " +
            "ORDER BY ABS(TIMESTAMPDIFF(SECOND, END_DATE, NOW())) LIMIT 1; ")
    @ResultMap("CUserInfoResultMap")
    Appmnts RecAppInU(@Param("userId")String userId, @Param("now")Date now);
}
