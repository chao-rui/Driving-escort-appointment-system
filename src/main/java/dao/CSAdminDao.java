package dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CSAdminDao {

    //新增驾校管理员
    @Insert("INSERT INTO csadmin (USER_ID, WORK_ID, CAR_SCHOOL_ID) " +
            "VALUES (#{userId},#{workId},#{cSchoolId});")
    Boolean addCSAdmin(@Param("userId")String userId,
                       @Param("workId")String workId,
                       @Param("cSchoolId")String cSchoolId);

    //注销
    @Delete("DELETE FROM csadmin WHERE userId=#{userId}")
    Boolean delCSA(@Param("userId")String userId);

}
