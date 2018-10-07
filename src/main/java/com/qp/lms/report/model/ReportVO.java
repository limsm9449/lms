package com.qp.lms.report.model;

import com.qp.lms.common.CommonVO;

public class ReportVO extends CommonVO {
	private String courseId;
	private String seq;
	private String title;
	private String contents;
	private String reportUserContents;
	private String reportTutorContents;
	private String attachSeq;
	private String report;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getReportUserContents() {
		return reportUserContents;
	}
	public void setReportUserContents(String reportUserContents) {
		this.reportUserContents = reportUserContents;
	}
	public String getReportTutorContents() {
		return reportTutorContents;
	}
	public void setReportTutorContents(String reportTutorContents) {
		this.reportTutorContents = reportTutorContents;
	}
	public String getAttachSeq() {
		return attachSeq;
	}
	public void setAttachSeq(String attachSeq) {
		this.attachSeq = attachSeq;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	
	
	
}
