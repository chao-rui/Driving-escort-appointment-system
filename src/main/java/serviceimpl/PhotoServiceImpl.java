package serviceimpl;

import com.mysql.cj.AbstractQuery;
import dao.PhotoDao;
import entity.Photo;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import service.PhotoService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@Service("PhotoService")
public class PhotoServiceImpl implements PhotoService {

    @Resource
    PhotoDao photoDao;

    @Override
    public Boolean addPhoto(MultipartFile photo,String photoType, String photoObject) throws IOException {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        String rootPath = request.getSession().getServletContext().getRealPath("/");
        if(Objects.equals(photoType, "car")||Objects.equals(photoType, "carSchool")){
            long timestamp = System.currentTimeMillis();
            photoObject=photoObject+"_"+timestamp;
        }
        String photoAdd="/resources/img/"+photoType+"/"+photoObject+".png";
        photo.transferTo(new File(rootPath+photoAdd));
        return photoDao.addPhoto(photoType,photoObject,photoAdd);
    }

    @Override
    public Photo getPhoto(String photoType, String photoObject) {
        return photoDao.getPhoto(photoType,photoObject);
    }

    @Override
    public List<Photo> getPhotos(String photoType, String photoObject) {
        return photoDao.getPhotos(photoType,photoObject);
    }

    @Override
    public Boolean delPhoto(String photoType, String photoObject) {
        return photoDao.delPhoto(photoType,photoObject);
    }
}
