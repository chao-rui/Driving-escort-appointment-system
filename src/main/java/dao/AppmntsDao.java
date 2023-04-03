package dao;

import entity.Appmnts;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AppmntsDao {

    //新增预约信息
    @Insert("")
    Boolean addAppmnts();

    //查询预约信息（按预约对象）
    @Select("")
    List<Appmnts> getAppmnts();

    //更新预约信息


    //更新评价信息


}
