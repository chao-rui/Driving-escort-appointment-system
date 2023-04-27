package dao;

import entity.Appmnts;
import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface AppmntsDao {

    //新增预约信息
    @Insert("INSERT INTO appmnts (USER_ID, OBJECT_ID, TIME, START_DATE, END_DATE, APPOINTMENT_STATE)" +
            "VALUES (#{userId},#{objectId},#{time},#{startDate},#{endDate},0);")
    Boolean addAppmnts(@Param("userId")String userId,
                       @Param("objectId")String objectId,
                       @Param("time")double time,
                       @Param("startDate")Date startDate,
                       @Param("endDate")Date endDate);

    //查询预约信息（按编号）
    @Select("SELECT * FROM appmnts WHERE APPOINTMENT_ID=#{appmntsId} AND APPOINTMENT_STATE!=4;")
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
            @Result(property = "time",column = "TIME"),
            @Result(property = "startDate",column = "START_DATE"),
            @Result(property = "endDate",column = "END_DATE"),
            @Result(property = "appointmentState",column = "APPOINTMENT_STATE"),
            @Result(property = "appraise",column = "APPRAISE"),
            @Result(property = "appraiseContext",column = "APPRAISE_CONTEXT"),
    })
    Appmnts getAppmntsById(@Param("appmntsId")String appmntsId);

    //查询预约信息（按驾校）
    @Select("SELECT appmnts.* FROM appmnts LEFT JOIN coach ON OBJECT_ID=coach.USER_ID " +
            "WHERE CAR_SCHOOL_ID=#{cSchoolId} AND (APPOINTMENT_STATE = 2 OR APPOINTMENT_STATE = 3);")
    @ResultMap("CUserInfoResultMap")
    List<Appmnts> getAppmntsByCS(@Param("cSchoolId")String cSchoolId);

    //查询预约信息（按预约对象）
    @Select("SELECT * FROM appmnts WHERE OBJECT_ID=#{objectId} AND APPOINTMENT_STATE!=4;")
    @ResultMap("CUserInfoResultMap")
    List<Appmnts> getAppmntsByOId(@Param("objectId")String objectId);

    //查询预约信息（按预约者）
    @Select("SELECT * FROM appmnts WHERE USER_ID=#{userId} AND APPOINTMENT_STATE!=4;")
    @ResultMap("CUserInfoResultMap")
    List<Appmnts> getAppmntsByUId(@Param("userId")String userId);

    //更新预约信息
    @Update("UPDATE appmnts SET " +
            "        START_DATE=#{startDate}," +
            "          END_DATE=#{endDate}," +
            " APPOINTMENT_STATE=#{appmntsState}" +
            "WHERE APPOINTMENT_ID=#{appmntsId};")
    Boolean updAppmnts(@Param("appmntsId")String appmntsId,
                       @Param("startDate")Date startDate,
                       @Param("endDate")Date endDate,
                       @Param("appmntsState")String appmntsState);
    @Update("UPDATE appmnts SET " +
            "APPOINTMENT_STATE=4 " +
            "WHERE APPOINTMENT_ID=#{appmntsId};")
    Boolean delAppmnts(@Param("appmntsId")String appmntsId);

    //更新评价信息
    @Update("UPDATE appmnts SET  " +
            "        APPRAISE=#{appraise}," +
            "APPRAISE_CONTEXT=#{appContext}," +
            "APPOINTMENT_STATE=3 " +
            "WHERE APPOINTMENT_ID=#{appmntsId};")
    Boolean updAppraise(@Param("appmntsId")String appmntsId,
                        @Param("appraise")double appraise,
                        @Param("appContext")String appContext);

    //获取教练空闲时间
    @Select("SELECT * FROM appmnts WHERE DATE(START_DATE)=#{selectDate}")
    List<Appmnts> getFreeRange(@Param("selectDate")Date selectDate);
}
