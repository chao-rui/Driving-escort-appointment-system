package dao;

import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
public interface CommonDao {

    @Update("UPDATE appmnts SET APPOINTMENT_STATE = CASE "+
            "WHEN CURRENT_TIMESTAMP > START_DATE AND CURRENT_TIMESTAMP < END_DATE THEN 1 "+
            "WHEN CURRENT_TIMESTAMP > END_DATE AND APPOINTMENT_STATE < 3 THEN 2 "+
            "ELSE APPOINTMENT_STATE END;")
    Boolean updAppState();
}
