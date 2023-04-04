package dao;

import entity.Appmnts;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface AppmntsDao {

    //新增预约信息
    @Insert("INSERT INTO appmnts (USER_ID, OBJECT_ID, \"TIME\", START_DATE, END_DATE, APPOINTMENT_ADDERS, 1)" +
            "VALUES (#{userId},#{objectId},#{time}),#{startDate},#{endDate},#{appmntsAdders};")
    Boolean addAppmnts(@Param("userId")String userId,
                       @Param("objectId")String objectId,
                       @Param("time")int time,
                       @Param("startDate")Date startDate,
                       @Param("endDate")Date endDate,
                       @Param("appmntsAdders")String appmntsAdders);

    //查询预约信息（按编号）
    @Select("SELECT * FROM appmnts WHERE APPOINTMENT_ID=#{appmntsId};")
    Appmnts getAppmntsById(@Param("appmntsId")String appmntsId);

    //查询预约信息（按预约对象）
    @Select("SELECT * FROM appmnts WHERE OBJECT_ID=#{objectId};")
    List<Appmnts> getAppmntsByOId(@Param("objectId")String objectId);

    //更新预约信息
    @Update("UPDATE appmnts SET " +
            "              TIME=#{time}," +
            "        START_DATE=#{startDate}," +
            "          END_DATE=#{endDate}," +
            "APPOINTMENT_ADDERS=#{appmntsAdders}," +
            " APPOINTMENT_STATE=#{appmntsState}" +
            "WHERE APPOINTMENT_ID=#{appmntsId};")
    Boolean updAppmnts(@Param("appmntsId")String appmntsId,
                       @Param("time")int time,
                       @Param("startDate")Date startDate,
                       @Param("endDate")Date endDate,
                       @Param("appmntsAdders")String appmntsAdders,
                       @Param("appmntsState")String appmntsState);

    //更新评价信息
    @Update("UPDATE appmnts SET  " +
            "        APPRAISE=#{appraise}," +
            "APPRAISE_CONTEXT=#{appContext}" +
            "WHERE APPOINTMENT_ID=#{appmntsId};")
    Boolean updAppraise(@Param("appmntsId")String appmntsId,
                        @Param("appraise")int appraise,
                        @Param("appContext")String appContext);

    //更新教练评价
    @Update("UPDATE coach SET " +
            "APPRAISE_COACH =(SELECT AVG(APPRAISE) FROM appmnts" +
            "                 WHERE OBJECT_ID=#{ObjectId}" +
            "                 GROUP BY OBJECT_ID)" +
            "WHERE USER_ID=#{ObjectId};")
    Boolean updAppCoach(@Param("ObjectId")String ObjectId);

}
