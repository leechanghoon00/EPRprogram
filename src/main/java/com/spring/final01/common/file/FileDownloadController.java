package com.spring.final01.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileDownloadController {
	private static final String BOARD_REPO = "/Users/bangjuncheol/Documents/dev/WEB/board_repo";
	
	@RequestMapping("/download.do")
	public void download(
			@RequestParam("imageFileName") String imageFileName,
			@RequestParam("articleNo") String articleNo,
			HttpServletResponse response) throws Exception {
		
		OutputStream out = response.getOutputStream();
		String downFile = BOARD_REPO + "/" + articleNo + "/" + imageFileName;
		File file = new File(downFile);
		
		String encoderFileName = URLEncoder.encode(imageFileName, "utf-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-disposition", "attachment;fileName="+encoderFileName);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			if (count == -1) {
				break;
			}
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}
	
}
