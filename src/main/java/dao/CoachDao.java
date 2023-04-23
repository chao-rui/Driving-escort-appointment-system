package dao;

import entity.Coach;
import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CoachDao {

    //新增教练信息
    @Insert("INSERT INTO coach (USER_ID,WORK_ID,CAR_SCHOOL_ID) " +
            "VALUES (#{userId},#{workId},#{carSchoolId})")
    Boolean addCoach(@Param("userId")String userId,
                     @Param("workId")String workId,
                     @Param("carSchoolId")String CarSchoolId);

    //教练信息查询（按编号）
    @Select("SELECT * FROM coach WHERE USER_ID=#{UserId}")
    Coach getCoachByUserId(@Param("UserId")String UserId);

    //教练信息查询（按驾校）
    @Select("SELECT * FROM coach WHERE CAR_SCHOOL_ID=#{cSchoolId}")
    @Results(id="CUserInfoResultMap",value = {
            @Result(property = "userId",column = "USER_ID",id = true),
            @Result(property = "workId",column = "WORK_ID"),
            @Result(property = "user",
                    column = "USER_ID",
                    javaType = User.class,
                    one = @One(select = "dao.UserDao.getUserInfo"))
    })
    List<Coach> getCoachByCSId(@Param("cSchoolId")String cSchoolId);

    //教练信息查询（按车辆类型）
    @Select("SELECT * FROM coach JOIN car ON coach.USER_ID = car.USER_ID " +
            "WHERE car.CAR_MODEL = #{Model};")
    List<Coach> getCoachByModel(@Param("Model")String Model);


    //注销
    @Delete("DELETE FROM coach WHERE USER_ID=#{userId};")
    Boolean delCoach(@Param("userId")String userId);

}
