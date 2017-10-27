package com.home.common.file;

import com.home.contents.file.entity.FileEntity;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import java.io.*;
import java.util.List;

public class DownloadZipView {

    public String downloadZip(List<FileEntity> fileList, String filePath) {
        int size = 1024;
        String outFileName = "";

        // Create a buffer for reading the files
        byte[] buf = new byte[size];
        try {
            // Create the ZIP file
            outFileName = filePath+".zip";

            File file = new File(outFileName);
            int fileCount = 0;
            while(file.exists()) {
                fileCount++;
                outFileName = filePath + "(" + fileCount + ").zip";
                file = new File(outFileName);
            }

            ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(outFileName)));
            out.setEncoding("EUC-KR");
            // Compress the files
            for (int i=0; i<fileList.size(); i++) {

                FileInputStream fs = new FileInputStream(fileList.get(i).getFileFullPath());
                BufferedInputStream in = new BufferedInputStream(fs, size);

                // Add ZIP entry to output stream.
                out.putNextEntry(new ZipEntry(fileList.get(i).getFileName())); // Zip 파일에 경로를 정하여 저장할수 있다.

            /*
            ****************************************************************
            * 압축 레벨을 정하는것인데 9는 가장 높은 압축률을 나타냅니다.
            * 그 대신 속도는 젤 느립니다. 디폴트는 8입니다.
            *****************************************************************/
                final int COMPRESSION_LEVEL = 8;
                out.setLevel(COMPRESSION_LEVEL);

                // Transfer bytes from the file to the ZIP file
                int len;
                while ((len = in.read(buf, 0, size)) > 0) {
                    out.write(buf, 0, len);
                }

                // Complete the entry
                out.closeEntry();
                in.close();
            }

            // Complete the ZIP file
            out.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return outFileName;
    }
}
