package dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CoachDao {

    //新增教练信息
    @Insert("INSERT INTO coachInfo (WORK_ID,CAR_SCHOOL_ID) VALUES (#{workId},#{carSchoolId})")
    Boolean addCoach(@Param("workId")String workId,@Param("carSchoolId")String CarSchoolId);

}
