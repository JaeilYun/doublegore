package com.home.contents.file.controller;

import com.home.common.annotation.breadcrumb.Breadcrumb;
import com.home.common.annotation.menu.Menu;
import com.home.common.date.DateUtility;
import com.home.common.file.DownloadZipView;
import com.home.common.types.MenuTypes;
import com.home.contents.file.entity.FileEntity;
import com.home.contents.file.service.FileService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/file")
public class FileController {
	private static final Logger log = LoggerFactory.getLogger(FileController.class);

	@Autowired
	FileService fileService;
	@Autowired
	Environment environment;

	@Menu(type = MenuTypes.FILE)
	@Breadcrumb(values = { "file.main" })
	@RequestMapping(value = "/main")
	public ModelAndView main() {
		log.debug("[FileController] main()");
		ModelAndView mav = new ModelAndView("file/fileMain");
		
		return mav;
	}

	@RequestMapping(value = "/selectFile")
	public @ResponseBody List<List<String>> selectFile(String nodeId){
		log.debug("[FileController] selectFile()");
		List<FileEntity> fileEntityList = fileService.selectFile(nodeId,nodeId.equals("del") ? "T" : "F");
		List<List<String>> fileList = new ArrayList<>();

		for(FileEntity file : fileEntityList) {
			List<String> list = new ArrayList<>();
			list.add(fileService.fileTypeToIcon(file.getFileType()) + file.getFileName());
			list.add(DateUtility.dateFormat(nodeId.equals("del") ? file.getDeletedDate() : file.getUpdatedDate()));
			list.add(file.getFileType());
			list.add(fileService.formattingFileSize(file.getFileSize()));
			fileList.add(list);
		}
		return fileList;
	}

	@RequestMapping(value = "/selectFilePrevView")
	public @ResponseBody String selectFilePrevView(String nodeId, String fileName){
		log.debug("[FileController] selectFilePrevView()");
		FileEntity fileEntity = fileService.selectFile(nodeId, fileName, "F");
		return fileEntity.getFilePath();
	}

	@RequestMapping(value = "/selectFilePath")
	public @ResponseBody List<String> selectFilePath(String nodeId){
		log.debug("[FileController] selectFilePath()");
		String[] extentionArr = {"jpg","jpeg","png","gif","bmp"};
		List<FileEntity> fileEntityList = fileService.selectFilePathList(nodeId, extentionArr, nodeId.equals("del") ? "T" : "F");
		List<String> filePathList = new ArrayList<>();

		for(FileEntity file : fileEntityList) {
			filePathList.add(file.getFileName()+","+file.getFilePath()+","+file.getFileThumbPath());
		}
		return filePathList;
	}

	@RequestMapping(value = "/uploadFile")
	public @ResponseBody List<String> uploadFile(HttpServletRequest request){
		log.debug("[FileController] uploadFile()");
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		String fileName = multipartHttpServletRequest.getFileNames().next();
		String nodeId = request.getParameter("nodeId");
		MultipartFile multipartFile = multipartHttpServletRequest.getFile(fileName);
		FileEntity fileEntity = new FileEntity();
		List<String> result = new ArrayList<>();
		try {
			fileEntity = fileService.insertFile(nodeId, multipartFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.add(fileService.fileTypeToIcon(fileEntity.getFileType()) + fileEntity.getFileName());
		result.add(DateUtility.dateFormat(fileEntity.getUpdatedDate()));
		result.add(fileEntity.getFileType());
		result.add(fileService.formattingFileSize(fileEntity.getFileSize()));
		return result;
	}

	@RequestMapping(value = "/deleteFile")
	public @ResponseBody List<FileEntity> deleteFile(@RequestParam(value="fileNameList[]") String[] fileNameArray, String nodeId){
		log.debug("[FileController] deleteFile()");
		fileService.deleteSelectFile(fileNameArray, nodeId);
		List<FileEntity> fileEntityList = fileService.selectFile(nodeId,nodeId.equals("del") ? "T" : "F");
		return fileEntityList;
	}

	@RequestMapping(value = "/downloadFile")
	public ModelAndView downloadFile(String fileName, String nodeId){
		log.debug("[FileController] downloadFile()");
		ModelAndView mav = new ModelAndView("download");
		FileEntity fileEntity = fileService.selectFile(nodeId, fileName, "F");

		mav.addObject("filePath", fileEntity.getFileFullPath());
		mav.addObject("fileName", fileEntity.getFileName());

		return mav;
	}

	@RequestMapping(value = "/downloadZipFile")
	public @ResponseBody String downloadZipFile(@RequestParam(value="fileNameList[]") String[] fileNameArray, String nodeId){
		log.debug("[FileController] downloadZipFile()");
		List<FileEntity> fileEntity = fileService.selectFileList(nodeId, fileNameArray, "F");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String userName = environment.getRequiredProperty("userName");
		String zipPath = "C:\\Users\\"+userName+"\\Desktop\\"+sdf.format(new Date());
		DownloadZipView downloadZip = new DownloadZipView();
		String result = downloadZip.downloadZip(fileEntity, zipPath);

		return result;
	}

	@RequestMapping(value = "/duplicatedFileCheck")
	public @ResponseBody String duplicatedFileCheck(String fileName, String nodeId){
		log.debug("[FileController] duplicatedFileCheck()");
		String result = fileService.duplicatedFileCheck(fileName, nodeId);
		return result;
	}

	@RequestMapping(value = "/updateJson")
	public @ResponseBody String updateJson(String data){
		log.debug("[FileController] updateJson()");
		fileService.updateJson(data);
		return data;
	}

	@RequestMapping(value = "/selectJson")
	public @ResponseBody String selectJson(){
		log.debug("[FileController] selectJson()");
		String json = fileService.selectJson();
		return json;
	}

	@RequestMapping(value = "/deleteNodeFile")
	public @ResponseBody String deleteNodeFile(String nodeId){
		log.debug("[FileController] deleteNodeFile()");
		fileService.deleteNode(nodeId);
		return nodeId;
	}

}
