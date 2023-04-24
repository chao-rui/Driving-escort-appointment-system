package service;

import entity.Appmnts;

public interface StatsService {

    String countCoachInCS(String cSchoolId);

    String countCarInCS(String cSchoolId);

    String countAppInCS(String cSchoolId);

    String sumAppInCS(String cSchoolId);

    String countAppInCo(String objectId);

    String sumAppInCo(String objectId);

    String countAppInU(String userId);

    String sumAppInU(String userId);

    Appmnts RecAppInCo(String objectId);

    Appmnts RecAppInU(String userId);

}
