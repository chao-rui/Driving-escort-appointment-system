package controller;

import entity.Photo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import service.PhotoService;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("Photo")
public class PhotoController {

    @Resource
    PhotoService photoService;

    @RequestMapping(value = "addPhoto")
    @ResponseBody
    public Boolean addPhoto(@RequestParam("file")MultipartFile photo,
                            @RequestParam("photoType")String photoType,
                            @RequestParam("photoObject")String photoObject) throws IOException {
        return photoService.addPhoto(photo,photoType,photoObject);
    }

    @RequestMapping(value = "getPhotos")
    @ResponseBody
    public List<Photo> getPhotos(@RequestParam("photoType")String photoType,
                                 @RequestParam("photoObject")String photoObject){
        return photoService.getPhotos(photoType,photoObject);
    }

    @RequestMapping(value = "getPhoto")
    @ResponseBody
    public Photo getPhoto(@RequestParam("photoType")String photoType,
                          @RequestParam("photoObject")String photoObject){
        return photoService.getPhoto(photoType,photoObject);
    }

    @RequestMapping(value = "delPhoto")
    @ResponseBody
    public Boolean delPhoto(@RequestParam("photoType")String photoType,
                            @RequestParam("photoObject")String photoObject){
        return photoService.delPhoto(photoType,photoObject);
    }
}
