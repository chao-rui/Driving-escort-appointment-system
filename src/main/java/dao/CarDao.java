package dao;

import entity.Car;
import entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface CarDao {

    //新增车辆
    @Insert("INSERT INTO car (CAR_NUMBER, CAR_BRANDS, CAR_MODEL,CAR_SCHOOL_ID, USER_ID, CAR_FLAG, UPDATE_DATE)"+
            "VALUES (#{carNumber},#{carBrands},#{carModel},#{cSchoolId},#{userId},1,#{updDate});")
    Boolean addCar(@Param("carNumber")String carNumber,
                   @Param("carBrands")String carBrands,
                   @Param("carModel")String carModel,
                   @Param("cSchoolId")String cSchoolId,
                   @Param("userId")String userId,
                   @Param("updDate")Date updDate);

    //查询车辆信息（按驾校）
    @Select("SELECT * FROM car WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    @Results(id = "carUserMap",value = {
            @Result(property = "carId",column = "CAR_ID",id = true),
            @Result(property = "carNumber",column = "CAR_NUMBER"),
            @Result(property = "carBrands" ,column = "CAR_BRANDS"),
            @Result(property = "carModel",column = "CAR_MODEL"),
            @Result(property = "carSchoolId",column = "CAR_SCHOOL_ID"),
            @Result(property = "user",
                    column = "USER_ID",
                    javaType = User.class,
                    one =@One(select = "dao.UserDao.getUserInfo") )
    })
    List<Car> getCarByCS(@Param("cSchoolId")String cSchoolId);

    //查询车辆信息（按编号）
    @Select("SELECT * FROM car WHERE CAR_ID=#{carId};")
    @ResultMap("carUserMap")
    Car getCarById(@Param("carId")String carId);

    //修改车辆信息
    @Update("UPDATE car SET " +
            " CAR_NUMBER=#{carNumber}," +
            " CAR_BRANDS=#{carBrands}," +
            "  CAR_MODEL=#{carModel}," +
            "CAR_SCHOOL_ID=#{cSchoolId}," +
            "    USER_ID=#{userId}," +
            "   CAR_FLAG=#{carFlag}," +
            "UPDATE_DATE=#{updDate} " +
            "WHERE CAR_ID=#{carId};")
    Boolean updCar(@Param("carId")String carId,
                   @Param("carNumber")String carNumber,
                   @Param("carBrands")String carBrands,
                   @Param("carModel")String carModel,
                   @Param("cSchoolId")String cSchoolId,
                   @Param("userId")String userId,
                   @Param("carFlag")String carFlag,
                   @Param("updDate")Date updDate);

}
