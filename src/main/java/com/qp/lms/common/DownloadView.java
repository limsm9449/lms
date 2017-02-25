package com.qp.lms.common;

import java.io.*;
import java.net.URLEncoder;
import java.util.Map;
import javax.servlet.http.*;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.qp.lms.board.model.AttachSet;
import com.qp.lms.board.model.AttachVO;

/*
 * 파일 다운로드..
 */
public class DownloadView extends AbstractView {

	public DownloadView() {
		setContentType("application/download; charset=utf-8");
	}
 
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AttachSet set = (AttachSet)model.get("set");
		AttachVO vo = set.getData();
		
		response.setContentType(getContentType());
		response.setContentLength((int)vo.getFileSize());
		
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String fileName = null;
		
		if(ie)
			fileName = URLEncoder.encode(vo.getOrgFileName(), "utf-8");
		else
			fileName = new String(vo.getOrgFileName().getBytes("utf-8"), "iso-8859-1");
 
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
            File f = new File(set.getAttachFolder() + vo.getFilePath() + vo.getFileName());
			fis = new FileInputStream(f);
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