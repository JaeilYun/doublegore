package com.home.common.date;

import com.home.common.file.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtility {
    private static final Logger logger = LoggerFactory.getLogger(FileUtils.class);

    public static String dateFormat(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);

    }
}
