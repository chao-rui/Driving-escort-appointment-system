package service;

import entity.Photo;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface PhotoService {

    Boolean addPhoto(MultipartFile photo, String photoType, String photoObject) throws IOException;

    Photo getPhoto(String photoType,String photoObject);

    List<Photo> getPhotos(String photoType, String photoObject);

    Boolean delPhoto(String photoType, String photoObject);

}
