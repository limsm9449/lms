package com.qp.lms.ns.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.PlainMail;
import com.qp.lms.ns.model.NsSet;
import com.qp.lms.ns.model.NsVO;
import com.qp.lms.ns.model.ZipcodeVO;

@Service
public class NsService {
	@Autowired
	private SqlSession sqlSession;
	
	public NsSet getZipcode(NsSet set) throws Exception {
		if ( !"".equals(set.getCondiVO().getFindString()) ) {
			List<ZipcodeVO> list = sqlSession.selectList("comm.getZipcode",set.getCondiVO().getFindString());
			set.setZipcode(list);
		}
		
    	return set;
    }

	public NsSet searchUserId(NsSet set) throws Exception {
		NsVO nsVO = null;
		
		nsVO = (NsVO) sqlSession.selectOne("ns.findUserid",set.getCondiVO());
		
		if ( nsVO == null ) {
			set.setRtnMode(Constant.mode.NOT_EXIST.name());
		} else {
			String userId = nsVO.getUserId();
			String chgUserId = "";
			for ( int i = 0; i < userId.length(); i++ ) {
				if ( i == 3 || i == 5 || i == 7 || i == 9 ) {
					chgUserId += "*";
				} else {
					chgUserId += userId.substring(i, i + 1);
				}
			}
			nsVO.setUserId(chgUserId);
			
			if ( "Y".equals(nsVO.getRetiredYn()) ) {
				set.setRtnMode(Constant.mode.RETIRED.name());
			} else {
				set.setRtnMode(Constant.mode.EXIST.name());
				set.setData(nsVO);
			}
		}
			
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public NsSet searchPassword(NsSet set) throws Exception {
		NsVO vo = null;
		
		vo = (NsVO) sqlSession.selectOne("ns.findPassword",set.getCondiVO());
		
		if ( vo == null ) {
			set.setRtnMode("INCORRECT_USER");
		} else {
			if ( "Y".equals(vo.getRetiredYn()) ) {
				set.setRtnMode(Constant.mode.RETIRED.name());
			} else {
				String newPassword = "U" + Integer.toString((int)(Math.random() * 100000));
	
				//패스워드 변경
				set.getCondiVO().setNewPassword(newPassword);
				sqlSession.update("ns.updNewPassword",set.getCondiVO());
				
				PlainMail mail = new PlainMail();
		    	mail.setReceiver(vo.getEmail());
		    	mail.setSubject("[비밀번호 확인메일] 임시 비밀번호를 발송합니다.");
		    	
		    	StringBuffer contents = new StringBuffer();
		    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
		    	contents.append("  <div align='left'>");
		    	contents.append("    <a href='http://www.qlearning.co.kr'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
		    	contents.append("  </div>");
		    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
		    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
		    	contents.append("    " + vo.getUserName() + "님의 임시 비밀번호를 발송합니다.<br />");
		    	contents.append("    임시 비밀번호는 [<b>" + newPassword + "</b>]입니다. 로그인 후 비밀번호를 변경하여 주십시오.");
		    	contents.append("    <p style='display:block;margin: 30px 10px;'>비밀번호 변경은 <span style='color:#0a88d9'>나의 강의실 > 비밀번호변경</span> 페이지에서 변경 하실 수 있습니다.</p>");
		    	contents.append("    임시 비밀번호의 대소문자에 유의하시기 바랍니다.");
		    	contents.append("  </div>");
		    	contents.append("  <div style='margin: 40px 0 0;'>");
		    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
		    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2014 Qpeople Academy. ALL Right Reserved</p></div>");
		    	contents.append("  </div>");
		    	contents.append("</div>");
		    	
		    	mail.setContent(contents.toString());
		    	
		    	try {
		    		mail.SendMail();
		    	} catch ( UnsupportedEncodingException e ) {
		    		e.printStackTrace();
		    		throw e;
		    	} catch ( MessagingException e ) {
		    		e.printStackTrace();
		    		throw e;
		    	}
		    	
		    	set.setRtnMode("CHANGE_PASSWORD");
			}
		}
		
    	return set;
    }

}
