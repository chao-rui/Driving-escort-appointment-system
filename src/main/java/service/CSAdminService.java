package service;

public interface CSAdminService {

    //新增
    public Boolean addCSAdmin(String userId,String workId,String cSchoolId);

    //注销
    public  Boolean delCSA(String userId);
}
