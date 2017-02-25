package com.qp.lms.setting.model;

import java.util.List;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommonSet;
import com.qp.lms.common.model.CommVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.member.model.MemberVO;



public class SettingSet extends CommonSet {
	private SettingVO condiVO;		
	private List<SettingVO> settingList;
	private List<SettingVO> bankList;
	private List<SettingVO> mailList;

	
	public SettingVO getCondiVO() {
		return condiVO;
	}
	public void setCondiVO(SettingVO condiVO) {
		this.condiVO = condiVO;
	}
	public List<SettingVO> getSettingList() {
		return settingList;
	}
	public void setSettingList(List<SettingVO> settingList) {
		this.settingList = settingList;
	}
	public List<SettingVO> getBankList() {
		return bankList;
	}
	public void setBankList(List<SettingVO> bankList) {
		this.bankList = bankList;
	}
	public List<SettingVO> getMailList() {
		return mailList;
	}
	public void setMailList(List<SettingVO> mailList) {
		this.mailList = mailList;
	}




	

	
	
	
	
	
	
	
	

	

}
