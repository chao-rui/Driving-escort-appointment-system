package dao;

import entity.Car;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface CarDao {

    //新增车辆
    @Insert("INSERT INTO car (CAR_NUMBER, CAR_BRANDS, CAR_MODEL, USER_ID, CAR_FLAG, UPDATE_DATE)"+
            "VALUES (#{carNumber},#{carBrands},#{carModel},#{userId},1,#{updDate});")
    Boolean addCar(@Param("carNumber")String carNumber,
                   @Param("carBrands")String carBrands,
                   @Param("carModel")String carModel,
                   @Param("userId")String userId,
                   @Param("updDate")Date updDate);

    //查询车辆信息（按驾校）
    @Select("SELECT * FROM car WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    List<Car> getCarByCS(@Param("cSchoolId")String cSchoolId);

    //查询车辆信息（按编号）
    @Select("SELECT * FROM car WHERE CAR_ID=#{carId};")
    List<Car> getCarById(@Param("carId")String carId);

    //修改车辆信息
    @Update("UPDATE car SET " +
            " CAR_NUMBER=#{carNumber}," +
            " CAR_BRANDS=#{carBrands}," +
            "  CAR_MODEL=#{carModel}," +
            "    USER_ID=#{userId}," +
            "   CAR_FLAG=#{carFlag}," +
            "UPDATE_DATE=#{updDate} " +
            "WHERE CAR_ID=#{carId};")
    Boolean updCar(@Param("carId")String carId,
                   @Param("carNumber")String carNumber,
                   @Param("carBrands")String carBrands,
                   @Param("carModel")String carModel,
                   @Param("userId")String userId,
                   @Param("carFlag")String carFlag,
                   @Param("updDate")Date updDate);

}
