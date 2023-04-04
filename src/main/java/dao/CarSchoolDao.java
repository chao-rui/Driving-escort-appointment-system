package dao;

import entity.CarSchool;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;

//Note:更改“APPRAISE_CAR_SHOOL”为“APPRAISE_CAR_SCHOOL”，包括数据库

@Repository
public interface CarSchoolDao {

    //新增驾校信息
    @Insert("INSERT INTO cschool (CAR_SCHOOL_NAME, CAR_SCHOOL_ADDERS, CAR_SCHOOL_PHONE, UPDATE_DATE) " +
            "VALUES (#{cSchoolName},#{cSchoolAdders},#{cSchoolPhone},#{appraiseCS},#{updDate});")
    Boolean addCSchool(@Param("cSchoolName")String cSchoolName,
                       @Param("cSchoolAdders")String cSchoolAdders,
                       @Param("cSchoolPhone")String cSchoolPhone,
                       @Param("appraiseCS")String appraiseCS,
                       @Param("updDate") Date updDate);

    //查询驾校信息（按编号）
    @Select("SELECT * FROM cschool WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    CarSchool getCSchool(@Param("cSchoolId")String cSchoolId);

    //更新驾校基础信息
    @Update("UPDATE cschool" +
            "SET CAR_SCHOOL_NAME = #{cSchoolName}," +
            "  CAR_SCHOOL_ADDERS = #{cSchoolAdders}, " +
            "   CAR_SCHOOL_PHONE = #{cSchoolPhone}, " +
            "        UPDATE_DATE = #{updDate}" +
            "WHERE CAR_SCHOOL_ID = #{cSchoolId};")
    Boolean updCSchool(@Param("cSchoolId")String cSchoolId,
                       @Param("cSchoolName")String cSchoolName,
                       @Param("cSchoolAdders")String cSchoolAdders,
                       @Param("cSchoolPhone")String cSchoolPhone,
                       @Param("updDate") Date updDate);

    //删除驾校信息
    @Delete("DELETE FROM cschool WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    Boolean delCSchool(@Param("cSchoolId")String cSchoolId);

}
