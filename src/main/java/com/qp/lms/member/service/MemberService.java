package com.qp.lms.member.service;

import java.util.List;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.ax.common.service.AxCommService;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;
import com.qp.lms.member.model.MemberSet;
import com.qp.lms.member.model.MemberVO;

@Service
public class MemberService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	@Autowired
	private AxCommService axCommService;
	
	
	//사용자 리스트
    public MemberSet memberList(MemberSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	//분류 DD
    	set.setDdUserKind(ddService.getDdCodeKeyDdMain("AUTH"));
    	
    	List<MemberVO> list = sqlSession.selectList("member.memberList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((MemberVO)sqlSession.selectOne("member.memberTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	return set;
    }
    
    public MemberSet isExistUserId(MemberSet set) throws Exception {
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.isExistUserId",set.getCondiVO());

    	if ( vo.getCnt() == 0 )
    		set.setRtnMode("USERID_OK");
    	else
    		set.setRtnMode("EXIST");
    	
    	return set;
    }

    public MemberSet memberU(MemberSet set) throws Exception {
    	set.setIsAdminYn(SessionUtil.isAdminYn());
    	
    	//사용자 정보를 가져온다.
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.userData",set.getCondiVO());
    	
    	set.setData(vo);
    	
    	return set;
    }

    public MemberSet memberN(MemberSet set) throws Exception {
    	//DD 데이타를 가져온다.
    	set.setDdTel(ddService.getDdCodeKeyDdMain("TEL"));
    	set.setDdMobile(ddService.getDdCodeKeyDdMain("MOBILE"));
    	set.setDdJob(ddService.getDdCodeKeyDdMain("JOB"));
    	
    	return set;
    }
    
    public MemberSet memberV(MemberSet set) throws Exception {
    	//DD 데이타를 가져온다.
    	set.setDdTel(ddService.getDdCodeKeyDdMain("TEL"));
    	set.setDdMobile(ddService.getDdCodeKeyDdMain("MOBILE"));
    	set.setDdJob(ddService.getDdCodeKeyDdMain("JOB"));

    	//사용자 정보를 가져온다.
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.userData",set.getCondiVO());
    	
    	set.setData(vo);
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet memberInsert(MemberSet set) throws Exception {
    	MemberVO vo = set.getCondiVO();

    	if ( "--".equals(vo.getHomeTel()) )
    		vo.setHomeTel("");

    	vo.setCertificationKey("");
    	vo.setCertificationYn("Y");

    	sqlSession.insert("member.userInsert",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.INSERT_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet memberUpd(MemberSet set) throws Exception {
    	MemberVO vo = set.getCondiVO();
    	if ( "--".equals(vo.getMobile()) )
    		vo.setMobile("");
    	if ( "--".equals(vo.getHomeTel()) )
    		vo.setHomeTel("");
    	
    	if ( "admin".equals(set.getCondiVO().getScreen()) )
    		sqlSession.update("member.userUpdateForAdmin",set.getCondiVO());
    	else
    		sqlSession.update("member.userUpdate",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet memberDel(MemberSet set) throws Exception {
    	String userIds[] = set.getCondiVO().getSelIds().split(",");
    	
    	MemberVO condi = new MemberVO();
    	for ( int i = 0; i < userIds.length; i++ ) {
    		condi.setUserId(userIds[i]);
    		if ( ((MemberVO)sqlSession.selectOne("member.registerCourseCnt",condi)).getCnt() == 0 ) {
    			sqlSession.delete("member.userDelete",condi);
    			sqlSession.delete("member.userDelete",condi);
    		}
    	}
    	
		set.setRtnMode(Constant.mode.DELETE_OK.name());
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet memberChangePasswordUpdate(MemberSet set) throws Exception {
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.isCurrentPassword",set.getCondiVO());
    	if ( vo.getCnt() == 1 ) {
        	sqlSession.update("member.userChangePasswordUpdate",set.getCondiVO());
        	
    		set.setRtnMode("PASSWORD_OK");
    	} else
    		set.setRtnMode("PASSWORD_ERROR");
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet memberRetiredUpdate(MemberSet set) throws Exception {
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.isCurrentPassword",set.getCondiVO());
    	if ( vo.getCnt() == 1 ) {
        	//탈퇴 처리
        	sqlSession.update("member.userRetiredUpdate",set.getCondiVO());
        	
        	//Session을 없앤다.
        	SessionUtil.getSessionDestory();
        	
    		set.setRtnMode("RETIRED_OK");
    	} else
    		set.setRtnMode("INFO_ERROR");
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet reJoin(MemberSet set) throws Exception {
    	//탈퇴 여부를 초기화
    	sqlSession.update("member.reJoin",set.getCondiVO());

		set.setRtnMode("REJOIN_OK");
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet passwordReset(MemberSet set) throws Exception {
    	MemberVO memberVO = sqlSession.selectOne("member.userData",set.getCondiVO());
    	String newPassword = "U" + Integer.toString((int)(Math.random() * 100000));

		//패스워드 변경
		set.getCondiVO().setNewUserPassword(newPassword);
    	sqlSession.update("member.passwordReset",set.getCondiVO());
		
    	StringBuffer contents = new StringBuffer();
    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
    	contents.append("  <div align='left'>");
    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
    	contents.append("  </div>");
    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
    	contents.append("    " + memberVO.getUserName() + "님의 임시 비밀번호를 발송합니다.<br />");
    	contents.append("    임시 비밀번호는 [<b>" + newPassword + "</b>]입니다. 로그인 후 비밀번호를 변경하여 주십시오.");
    	contents.append("    <p style='display:block;margin: 30px 10px;'>비밀번호 변경은 <span style='color:#0a88d9'>마이페이지 > 비밀번호 변경</span> 페이지에서 변경 하실 수 있습니다.</p>");
    	contents.append("    임시 비밀번호의 대소문자에 유의하시기 바랍니다.");
    	contents.append("  </div>");
    	contents.append("  <div style='margin: 40px 0 0;'>");
    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
    	contents.append("  </div>");
    	contents.append("</div>");
    	
    	axCommService.axMailSave(set.getCondiVO().getUserId(), memberVO.getEmail(), "[비밀번호 확인메일] 임시 비밀번호를 발송합니다.", contents.toString());
		axCommService.axSendMail(null);

		set.setRtnMode("RESET_PASSWORD_OK");
    	
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet joinMemberInsert(MemberSet set) throws Exception {
    	//userId 체크
    	int userIdCnt = ((MemberVO)sqlSession.selectOne("member.isExistUserId",set.getCondiVO())).getCnt();
    	int emailCnt = ((MemberVO)sqlSession.selectOne("member.isExistEmail",set.getCondiVO())).getCnt();
    	int recommendUserIdCnt = ((MemberVO)sqlSession.selectOne("member.isExistRecommendUserId",set.getCondiVO())).getCnt();
    	if ( userIdCnt > 0 ) {
    		set.setRtnMode("EXIST_USERID");
    	} else if ( emailCnt > 0 ) {
    		set.setRtnMode("EXIST_EMAIL");
    	} else if ( CommUtil.isEqual(set.getCondiVO().getRecommendId(), "") == false && recommendUserIdCnt == 0 ) {
    		set.setRtnMode("NOT_EXIST_USERID");
    	} else {
	    	MemberVO vo = set.getCondiVO();
	
	    	//cerification key 생성
	    	String certificationKey = "";
	    	Random rand = new Random();
	    	for ( int i = 0; i < 20; i++ ) {
	    		int idx = rand.nextInt(62);
	    		
	    		certificationKey += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890".substring(idx, idx + 1);
	    	}
	    	vo.setCertificationKey(certificationKey);
	    	vo.setCertificationYn("N");
	
	    	sqlSession.insert("member.joinUserInsert",set.getCondiVO());

    		//포인트 적립
    		sqlSession.insert("member.joinPointInsert",set.getCondiVO());

	    	//추천인이 있으면..
	    	if ( CommUtil.isEqual(set.getCondiVO().getRecommendId(), "") == false ) {
	    		//추천으로 가입된 포인트 적립
	    		sqlSession.insert("member.recommendJoinPointInsert",set.getCondiVO());
	    		//추천한 사람의 포인트 적립
	    		sqlSession.insert("member.recommendPointInsert",set.getCondiVO());
	    	}
	    	
	    	StringBuffer contents = new StringBuffer();
	    	contents.append("<div style='font-size: 12px; width: 650px; height:500px; margin:0 auto;' align='center'>");
	    	contents.append("  <div align='left'>");
	    	contents.append("    <a href='" + SessionUtil.getAttribute("serverDomain") + "'><img src='http://www.qlearning.co.kr/resources/images/common/toplogo.png' style='border:0;' /></a>");
	    	contents.append("  </div>");
	    	contents.append("  <div style='text-align: left;margin: 30px 10px 30px;'>");
	    	contents.append("    <p style='font-size: 14px; line-height: 1.5;'>안녕하세요.<br />온라인 학습 사이트 <b>큐러닝</b>입니다.<br /><br /></p>");
	    	contents.append("    " + set.getCondiVO().getUserName() + "님의 회원가입을 축하드립니다.<br />");
	    	contents.append("    회원 가입을 정상적으로 처리하기 위해서는 아래 이메일 인증 주소를 클릭 하시거나 <a href='" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "'>여기</a>를 클릭하여 주십시오.");
	    	contents.append("    <p style='display:block;margin: 30px 10px;'><a href='" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "'>" + SessionUtil.getAttribute("serverDomain") + "/guest/certification.do?certificationKey=" + certificationKey + "</a></p>");
	    	contents.append("    이메일이 정상적으로 인증 되지 않을 경우 고객센터로 연락 주시면 신속하게 처리해 드리겠습니다.  ");
	    	contents.append("  </div>");
	    	contents.append("  <div style='margin: 40px 0 0;'>");
	    	contents.append("    <div style='float: left;'><img src='http://www.qlearning.co.kr/resources/images/admin/common/bottom_logo.png' alt='Qpeople' /></div>");
	    	contents.append("    <div style='float: left;margin-left: 20px;'><p style='font-size: 11px;'>Copyrights 2017 Qpeople Academy. ALL Right Reserved</p></div>");
	    	contents.append("  </div>");
	    	contents.append("</div>");
	    	
    		axCommService.axMailSave(set.getCondiVO().getUserId(), vo.getEmail(), "[회원가입 인증메일] 큐러닝에 가입하신 것을 환영합니다.", contents.toString());
    		axCommService.axSendMail(null);
	
			set.setRtnMode(Constant.mode.INSERT_OK.name());
    	}
		
    	return set;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet certification(MemberSet set) throws Exception {
    	MemberVO memberVO = sqlSession.selectOne("member.certificationKeyUser",set.getCondiVO());
    	if ( memberVO == null ) {
        	set.setRtnMode(Constant.mode.NOT_EXIST.name());
    	} else {
    		set.getCondiVO().setUserId(memberVO.getUserId());
        	sqlSession.update("member.userCertificationUpd",set.getCondiVO());

        	set.setRtnMode(Constant.mode.OK.name());
    	}

    	return set;
    }

    public MemberSet joinCheck(MemberSet set) throws Exception {
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.joinCheck",set.getCondiVO());

    	if ( vo.getCnt() == 0 )
    		set.setRtnMode("NOT_EXIST");
    	else
    		set.setRtnMode("EXIST");
    	
    	return set;
    }
    
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet userMemberUpd(MemberSet set) throws Exception {
    	MemberVO vo = set.getCondiVO();
    	
   		sqlSession.update("member.userUpdateForUser",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
    	return set;
    }

    
	//강사 리스트
    public MemberSet teacherList(MemberSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForBoard);

    	List<MemberVO> list = sqlSession.selectList("member.teacherList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((MemberVO)sqlSession.selectOne("member.teacherTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForBoard);

    	return set;
    }

    public MemberSet teacherV(MemberSet set) throws Exception {
    	//사용자 정보를 가져온다.
    	MemberVO vo = (MemberVO)sqlSession.selectOne("member.teacherData",set.getCondiVO());
    	
    	set.setData(vo);
    	
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet teacherUpd(MemberSet set) throws Exception {
    	MemberVO vo = set.getCondiVO();

    	sqlSession.update("member.teacherUpdate",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public MemberSet teacherPictureUpd(MemberSet set) throws Exception {
    	MemberVO vo = set.getCondiVO();

    	sqlSession.update("member.teacherPictureUpdate",set.getCondiVO());
    	
		set.setRtnMode(Constant.mode.OK.name());
		
    	return set;
    }
   
    public MemberSet join3(MemberSet set) throws Exception {
    	int point = sqlSession.selectOne("member.getRecommendJoinPoint", null);

    	set.setPoint(point);
    	
    	return set;
    }
}
