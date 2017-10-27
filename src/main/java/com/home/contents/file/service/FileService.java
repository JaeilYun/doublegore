package com.home.contents.file.service;

import com.home.common.file.FileUtils;
import com.home.contents.file.entity.FileEntity;
import com.home.contents.file.entity.JsonEntity;
import com.home.contents.file.repository.FileRepository;
import com.home.contents.file.repository.JsonRepository;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
@Transactional
public class FileService {
    private static final Logger logger = LoggerFactory.getLogger(FileService.class);

    @Autowired
    JsonRepository jsonRepository;
    @Autowired
    FileRepository fileRepository;
    @Autowired
    Environment environment;

    public JsonEntity findJson() {
        JsonEntity entity = jsonRepository.findTopBy();
        return entity;
    }

    public List<FileEntity> selectFile(String nodeId, String isDeleted) {
        return fileRepository.findByNodeIdAndIsDeleted(nodeId, isDeleted);
    }

    public FileEntity selectFile(String nodeId, String fileName, String isDeleted) {
        return fileRepository.findTop1ByNodeIdAndFileNameAndIsDeleted(nodeId, fileName, isDeleted);
    }

    public List<FileEntity> selectFileList(String nodeId, String fileName, String isDeleted) {
        return fileRepository.findByNodeIdAndFileNameAndIsDeleted(nodeId, fileName, isDeleted);
    }

    public List<FileEntity> selectFileList(String nodeId, String[] fileName, String isDeleted) {
        return fileRepository.findByNodeIdAndFileNameInAndIsDeleted(nodeId, fileName, isDeleted);
    }
    public List<FileEntity> selectFilePathList(String nodeId, String[] extentionList, String isDeleted) {
        return fileRepository.findByNodeIdAndFileTypeInAndIsDeleted(nodeId, extentionList, isDeleted);
    }

    public String duplicatedFileCheck(String fileName, String nodeId){
        List<FileEntity> fileList = new ArrayList<>();
        fileList = this.selectFileList(nodeId, fileName,"F");
        String result = (fileList.size() > 0) ? "F" : "T";
        return result;
    }

    public FileEntity insertFile(String nodeId, MultipartFile file) throws Exception {
        if (Objects.isNull(file)) {
            throw new Exception("Failed to store empty file " + file.getOriginalFilename());
        }
        String genId = UUID.randomUUID().toString();
        genId = genId.replace("-", "");
        String fileType = FileUtils.getExtension(file.getOriginalFilename());

        String uploadPath = environment.getRequiredProperty("app.home") + environment.getRequiredProperty("file.path");
        String saveFilePath = FileUtils.fileSave(uploadPath, file, genId, nodeId);

        Date date = new Date();
        FileEntity fileEntity = new FileEntity();
        fileEntity.setFileName(file.getOriginalFilename());
        fileEntity.setFilePath("/files"+saveFilePath);
        fileEntity.setFileThumbPath(FileUtils.calcThumbnailPath(genId, nodeId, file.getOriginalFilename()));
        fileEntity.setFileFullPath(uploadPath+saveFilePath);
        fileEntity.setFileSize(file.getSize());
        fileEntity.setFileType(fileType);
        fileEntity.setNodeId(nodeId);
        fileEntity.setCreatedDate(date);
        fileEntity.setUpdatedDate(date);
        fileEntity.setIsDeleted("F");
        fileEntity.setFileKey(genId);
        return fileRepository.save(fileEntity);
    }

    public void updateJson(String data) {
        JsonEntity entity = findJson();
        entity.setJson(data);
    }

    public String selectJson() {
        JsonEntity entity = findJson();
        return entity.getJson();
    }

    public String fileTypeToIcon(String type) {
        String icon = "";
        switch (type) {
            case "txt" :
            case "xml" :
                icon = "<i class='fa fa-file-text-o'></i>&nbsp;&nbsp;";
                break;
            case "pdf" :
                icon = "<i class='fa fa-file-pdf-o'></i>&nbsp;&nbsp;";
                break;
            case "doc" :
            case "docx" :
                icon = "<i class='fa fa-file-word-o'></i>&nbsp;&nbsp;";
                break;
            case "xls" :
            case "xlsx" :
                icon = "<i class='fa fa-file-excel-o'></i>&nbsp;&nbsp;";
                break;
            case "ppt" :
            case "pptx" :
                icon = "<i class='fa fa-file-powerpoint-o'></i>&nbsp;&nbsp;";
                break;
            case "img" :
            case "jpg" :
                icon = "<i class='fa fa-file-image-o'></i>&nbsp;&nbsp;";
                break;
            case "zip" :
            case "jar" :
                icon = "<i class='fa fa-file-zip-o'></i>&nbsp;&nbsp;";
                break;
            case "mp3" :
            case "wav" :
            case "wma" :
            case "m4v" :
                icon = "<i class='fa fa-audio-o'></i>&nbsp;&nbsp;";
                break;
            case "avi" :
            case "mpg" :
            case "mpeg" :
            case "asf" :
            case "wmv" :
            case "mov" :
            case "mp4" :
            case "flv" :
            case "mkv" :
                icon = "<i class='fa fa-movie-o'></i>&nbsp;&nbsp;";
                break;
            default:
                icon = "<i class='fa fa-file-o'></i>&nbsp;&nbsp;";
        }
        return icon;
    }

    public String formattingFileSize(Long fileSize) {
        double size = fileSize;
        int dataUnit = 0;
        while(true) {
            if(size >= 1024) {
                size = Math.round(size/1024);
                dataUnit++;
            } else if(size < 1024 && dataUnit == 0){
                size = 1;
                break;
            } else {
                break;
            }
        }
        return String.valueOf(size) + " " + numToDataUnit(dataUnit);
    }

    public String numToDataUnit(int num) {
        String dataUnit = "";
        switch(num) {
            case 0:
            case 1:
                dataUnit = "KB";
                break;
            case 2:
                dataUnit = "MB";
                break;
            case 3:
                dataUnit = "GB";
                break;
            case 4:
                dataUnit = "TB";
                break;
        }
        return dataUnit;
    }

    public void deleteNode(String nodeId) {
        List<FileEntity> fileList = selectFile(nodeId,"F");
        this.deleteFile(fileList);
        //FileUtils.fileDelete(environment.getRequiredProperty("file.path") + File.separatorChar + nodeId);
    }

    public void deleteSelectFile(String[] fileNameArray, String nodeId) {
        List<FileEntity> fileList = this.selectFileList(nodeId, fileNameArray,"F");
        this.deleteFile(fileList);
    }

    public void deleteFile(List<FileEntity> fileList) {
        for(FileEntity list : fileList) {
            list.setIsDeleted("T");
            list.setNodeId("del");
            list.setDeletedDate(new Date());
            /*try {
                String outputFilePath = FileUtils.fileMove(environment.getRequiredProperty("file.delete.path"), list);
                list.setFilePath(outputFilePath);
            } catch (IOException e) {
                e.printStackTrace();
            }*/
        }
    }
}
