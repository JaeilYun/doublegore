package com.home.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component("download")
public class DownloadView extends AbstractView {
 
    public void Download(){
         
        setContentType("application/download; utf-8");
         
    }
    
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
    		HttpServletResponse response) throws Exception {

		
		File file = new File((String) model.get("filePath"));
		
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		String browser = request.getHeader("User-Agent");
		String fileName = null;
		fileName = new String(((String) model.get("fileName")).getBytes("UTF-8"), "ISO-8859-1");
		/*if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
			fileName = URLEncoder.encode((String) model.get("fileName"),"UTF-8").replaceAll("\\+", "%20"); 
		} else { 
			fileName = new String(((String) model.get("fileName")).getBytes("UTF-8"), "ISO-8859-1"); 
		}*/

		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch(IOException ioe) {}
			}
		}
		out.flush();
    }
}
