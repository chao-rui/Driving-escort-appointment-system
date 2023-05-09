package dao;

import entity.Photo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PhotoDao {

    //上传照片
    @Insert("INSERT INTO photo (PHOTO_TYPE, PHOTO_OBJECT, PHOTO_ADD) " +
            "VALUES (#{photoType},#{photoObject},#{photoAdd});")
    Boolean addPhoto(@Param("photoType")String photoType,
                     @Param("photoObject")String photoObject,
                     @Param("photoAdd")String photoAdd);

    //获取单个图片
    @Select("SELECT * FROM photo " +
            "WHERE PHOTO_TYPE=#{photoType} AND PHOTO_OBJECT=#{photoObject}")
    Photo getPhoto(@Param("photoType")String photoType,
                   @Param("photoObject")String photoObject);

    //获取图片列表
    @Select("SELECT * FROM photo " +
            "WHERE PHOTO_TYPE=#{photoType} AND " +
            "PHOTO_OBJECT LIKE CONCAT(#{photoObject}, '_%')")
    List<Photo> getPhotos(@Param("photoType")String photoType,
                          @Param("photoObject")String photoObject);

    //删除图片
    @Delete("Delete FROM photo " +
            "WHERE PHOTO_TYPE=#{photoType} AND " +
            "PHOTO_OBJECT=#{photoObject}")
    Boolean delPhoto(@Param("photoType")String photoType,
                     @Param("photoObject")String photoObject);
}
