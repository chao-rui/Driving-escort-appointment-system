package dao;

import entity.CarSchool;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;


@Repository
public interface CarSchoolDao {

    //新增驾校信息
    @Insert("INSERT INTO cschool (CAR_SCHOOL_ADMIN,CAR_SCHOOL_NAME, CAR_SCHOOL_ADDERS, CAR_SCHOOL_PHONE,APPRAISE_CAR_SCHOOL, UPDATE_DATE) " +
            "VALUES (#{cSchoolAdmin},#{cSchoolName},#{cSchoolAdders},#{cSchoolPhone},#{appraiseCS},#{updDate});")
    Boolean addCSchool(@Param("cSchoolAdmin")String cSchoolAdmin,
                       @Param("cSchoolName")String cSchoolName,
                       @Param("cSchoolAdders")String cSchoolAdders,
                       @Param("cSchoolPhone")String cSchoolPhone,
                       @Param("appraiseCS")String appraiseCS,
                       @Param("updDate") Date updDate);

    //查询驾校信息（所有）
    @Select("SELECT * FROM cschool")
    List<CarSchool> getCSchoolAll();

    //查询驾校信息（按管理员）
    @Select("SELECT * FROM cschool WHERE CAR_SCHOOL_ADMIN=#{userId}")
    CarSchool getCSchoolByUid(@Param("userId")String userId);

    //查询驾校信息（按编号）
    @Select("SELECT * FROM cschool WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    CarSchool getCSchoolById(@Param("cSchoolId")String cSchoolId);

    //更新驾校基础信息
    @Update("UPDATE cschool " +
            "SET CAR_SCHOOL_NAME = #{cSchoolName}," +
            "  CAR_SCHOOL_ADDERS = #{cSchoolAdders}, " +
            "  CAR_SCHOOL_DESC = #{cSchoolDesc}, " +
            "   CAR_SCHOOL_PHONE = #{cSchoolPhone}, " +
            "        UPDATE_DATE = #{updDate}" +
            "WHERE CAR_SCHOOL_ID = #{cSchoolId};")
    Boolean updCSchool(@Param("cSchoolId")String cSchoolId,
                       @Param("cSchoolName")String cSchoolName,
                       @Param("cSchoolAdders")String cSchoolAdders,
                       @Param("cSchoolDesc")String cSchoolDesc,
                       @Param("cSchoolPhone")String cSchoolPhone,
                       @Param("updDate") Date updDate);

    //删除驾校信息
    @Delete("DELETE FROM cschool WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    Boolean delCSchool(@Param("cSchoolId")String cSchoolId);

}
