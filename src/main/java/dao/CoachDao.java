package dao;

import entity.Coach;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CoachDao {

    //新增教练信息
    @Insert("INSERT INTO coachInfo (USER_ID,WORK_ID,CAR_SCHOOL_ID) " +
            "VALUES (#{userId},#{workId},#{carSchoolId})")
    Boolean addCoach(@Param("userId")String userId,
                     @Param("workId")String workId,
                     @Param("carSchoolId")String CarSchoolId);

    //教练信息查询（按编号）
    @Select("SELECT * FROM coach WHERE USER_ID=#{UserId}")
    Coach getCoachByUserId(@Param("UserId")String UserId);

    //教练信息查询（按驾校）
    @Select("SELECT * FROM coach WHERE CAR_SCHOOL_ID=#{cSchoolId}")
    List<Coach> getCoachByCSId(@Param("cSchoolId")String cSchoolId);

    //教练信息查询（按车辆类型）
    @Select("SELECT * FROM coach JOIN car ON coach.USER_ID = car.USER_ID " +
            "WHERE car.CAR_MODEL = #{Model};")
    List<Coach> getCoachByModel(@Param("Model")String Model);

    //更新驾校评价
    @Update("UPDATE cschool SET " +
            "APPRAISE_CAR_SCHOOL =(SELECT AVG(APPRAISE_COACH) FROM coach" +
            "                     WHERE CAR_SCHOOL_ID=#{cSchoolId}" +
            "                     GROUP BY CAR_SCHOOL_ID)" +
            "WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    Boolean updAppCoach(@Param("cSchoolId")String cSchoolId);

    //注销
    @Delete("DELETE FROM coach WHERE USER_ID=#{userId};")
    Boolean delCoach(@Param("userId")String userId);

}
