package dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
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
    @Select("SELECT COUNT(*) FROM ")
    String countAppInCS(@Param("cSchoolId")String cSchoolId);

    //统计驾校中所有教练的预约时长
    @Select("SELECT COUNT(*) FROM ")
    String sumAppInCS(@Param("cSchoolId")String cSchoolId);
}
