package dao;

import entity.Apply;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface ApplyDao {

    //新增
    @Insert("INSERT INTO apply (USER_ID, WORK_ID, CAR_SCHOOL_ID, APPLY_STATE, UPDATE_DATE) " +
            "VALUES (#{userId},#{workId},#{cSchoolId},0,#{updDate}); ")
    Boolean addApply(@Param("userId")String userId,
                     @Param("workId")String workId,
                     @Param("cSchoolId")String cSchoolId,
                     @Param("updDate") Date updDate);

    //查询(按用户)
    @Select("SELECT * FROM apply WHERE USER_ID=#{userId};")
    Apply getApplyByUId(@Param("userId")String userId);

    //查询（按编号）
    @Select("SELECT * FROM apply WHERE APPLY_ID=#{applyId};")
    Apply getApplyByAId(@Param("applyId")String applyId);

    //查询（按驾校）
    @Select("SELECT * FROM apply WHERE CAR_SCHOOL_ID=#{cSchoolId};")
    Apply getApplyByCSId(@Param("cSchoolId")String cSchoolId);

    //更新
    @Update("UPDATE apply SET" +
            "APPLY_STATE = #{applyState}" +
            "UPDATE_DATE = #{updDate}" +
            "WHERE APPLY_ID=#{applyId};")
    Boolean updApply(@Param("applyId")String applyId,
                     @Param("applyState")String applyState,
                     @Param("updDate")Date updDate);

    //删除
    @Delete("DELETE FROM apply WHERE APPLY_ID=#{applyId};")
    Boolean delApply(@Param("applyId")String applyId);
}
