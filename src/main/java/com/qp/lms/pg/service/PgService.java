package com.qp.lms.pg.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.member.model.MemberVO;
import com.qp.lms.pg.model.PgSet;
import com.qp.lms.pg.model.PgVO;

@Service("pgService")
public class PgService {
	
	@Autowired
	private SqlSession sqlSession;
	 
	public PgSet payInfo(PgSet set) throws Exception {
		Map map = new HashMap();
		
		List al = new ArrayList();
		String[] courseIds = set.getCondiVO().getCourseId().split(",");
		for ( int i = 0; i < courseIds.length; i++ ) {
			al.add(courseIds[i]);
		}
		map.put("list", al);
		
		//결재할 과정 정보
		List<CourseVO> courseList = sqlSession.selectList("pg.applicationCourseList",map);
    	set.setCourseList(courseList);
    	
    	HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    	if ( cart == null ) {
    		//바로 신청할 경우....
    		cart = new HashMap();
    		cart.put(set.getCondiVO().getCourseId(), set.getCondiVO().getCartWeeks());
    	}

    	//결재금액
    	int paymentCost = 0;
    	for ( int i = 0; i < courseList.size(); i++ ) {
    		if ( CommUtil.isEqual((String)cart.get(courseList.get(i).getCourseId()), "") ) {
    			//전체 선택인경우... 
    			paymentCost += Integer.parseInt((String)courseList.get(i).getCourseCost());
    		} else {
    			//부분 선택인 경우...
    			Map weekMap = new HashMap();
    			List weekList = new ArrayList();
    			String[] weeks = ((String)cart.get(courseList.get(i).getCourseId())).split(",");
    			for ( int k = 0; k < weeks.length; k++ ) {
    				weekList.add(weeks[k]);
    			}
    			weekMap.put("list", weekList);
    			weekMap.put("courseId", courseList.get(i).getCourseId());

    			List<CourseVO> cartWeekList = sqlSession.selectList("pg.applicationCourseWeekList",weekMap);
    	    	courseList.get(i).setCartWeekList(cartWeekList);

    	    	//차시별 비용 계산
    	    	int weekCostTotal = 0;
    			for ( int m = 0; m < cartWeekList.size(); m++ ) {
        			paymentCost += Integer.parseInt((String)cartWeekList.get(m).getWeekCost());
        			weekCostTotal += Integer.parseInt((String)cartWeekList.get(m).getWeekCost());
    			}
    			courseList.get(i).setCourseCost(Integer.toString(weekCostTotal));
    		}
    	}
    	set.getCondiVO().setPaymentCost(Integer.toString(paymentCost));

    	if ( courseList.size() == 1 ) {
    		set.getCondiVO().setCoursePayDesc(courseList.get(0).getCourseName());
    	} else {
    		set.getCondiVO().setCoursePayDesc(courseList.get(0).getCourseName() + " 외 " + courseList.size() + "건");
    	}
    	
    	//point
    	PgVO mainVO = (PgVO)sqlSession.selectOne("pg.userPoint", set.getCondiVO());
    	set.getCondiVO().setPoint(mainVO.getPoint());
    	
    	//사용자 정보
    	MemberVO memberCondiVO = new MemberVO();
    	memberCondiVO.setUserId(SessionUtil.getSessionUserId());
    	set.setMemberVO((MemberVO)sqlSession.selectOne("member.userData",memberCondiVO));
    	
    	//은행정보
    	List<BankVO> bankList = sqlSession.selectList("comm.getBankList",set.getCondiVO());
    	set.setBankList(bankList);
    	
    	set.setRtnMode(Constant.mode.OK.name());
    	
    	return set;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public PgSet approval(PgSet set) throws Exception {
		System.out.println("=====================> XpayService approval Start");

		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
		
		if ( "SC0030".equals(set.getCondiVO().getPaymentKind()) ) {
			set.getCondiVO().setPaymentKind("CASH");
		}
		
		//결재 내용 입력.
		sqlSession.insert("pg.approvalIns",set.getCondiVO());
		
		//포인트가 있으면 포인트 사용
		if ( Integer.parseInt(set.getCondiVO().getPaymentPoint()) > 0 ) {
			int paymentPoint = Integer.parseInt(set.getCondiVO().getPaymentPoint());
			
			List<PgVO> pointList = sqlSession.selectList("pg.userValidPoint", set.getCondiVO());
			for ( int i = 0; i < pointList.size(); i++ ) {
				PgVO row = pointList.get(i);
				row.setApprovalId(set.getCondiVO().getApprovalId());
				
				if ( paymentPoint > 0 ) {
					if ( row.getInPointUse() < paymentPoint &&  row.getInPoint() >= paymentPoint ) {
						row.setUsePoint(paymentPoint);
						
						row.setInPointUse(row.getInPointUse() + row.getUsePoint());
						paymentPoint = 0;
						
						sqlSession.insert("pg.pointUpdate",row);
						sqlSession.insert("pg.pointLogInsert",row);
					} else {
						row.setUsePoint(row.getInPoint() - row.getInPointUse());
						
						paymentPoint -= row.getUsePoint();
						row.setInPointUse(row.getInPointUse() + row.getUsePoint());
						
						sqlSession.insert("pg.pointUpdate",row);
						sqlSession.insert("pg.pointLogInsert",row);
					}
				} else {
					break;
				}
			}
			
			//포인트 사용
	    	sqlSession.insert("pg.paymentPointInsert", set.getCondiVO());
		}
		
		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
		if ( cart == null ) {
			//바로 신청할 경우....
    		cart = new HashMap();
    		cart.put(set.getCondiVO().getCourseId(), set.getCondiVO().getCartWeeks());
    	}
		
		PgVO saveVO = new PgVO();
		saveVO.setUserId(SessionUtil.getSessionUserId());
		saveVO.setCreateUser(SessionUtil.getSessionUserId());
		saveVO.setApprovalId(set.getCondiVO().getApprovalId());
		saveVO.setPaymentKind(set.getCondiVO().getPaymentKind());
		
		String[] courseIds = set.getCondiVO().getCourseId().split(",");
		for ( int i = 0; i < courseIds.length; i++ ) {
			saveVO.setCourseId(courseIds[i]);

			//과정별 포인트 지급
	    	sqlSession.insert("pg.coursePointInsert",saveVO);

	    	//과정별 이벤트 포인트 지급
	    	sqlSession.insert("pg.courseEventPointInsert",saveVO);
	    	
			//튜터를 구한다.
			int courseUserCnt = sqlSession.selectOne("pg.courseUserCnt", saveVO);
			List<PgVO> tutorList = sqlSession.selectList("pg.courseTutors", saveVO);
			for ( int m = 0; m < tutorList.size(); m++ ) {
				if ( tutorList.get(m).getFromCnt() <= courseUserCnt && tutorList.get(m).getToCnt() >= courseUserCnt ) {
					saveVO.setTutorId(tutorList.get(m).getTutorId());
					break;
				}
			}
			
			//레포트를 구한다.
			String courseReportYn = sqlSession.selectOne("pg.courseReportExist", saveVO);
			if ( "Y".equals(courseReportYn) ) {
				int courseReportSeq = sqlSession.selectOne("pg.courseRandomReport", saveVO);
				saveVO.setReportSeq(courseReportSeq);
			}
			
			//반려된 케이스가 있으면 삭제를 해준다.
			sqlSession.delete("pg.rejectCourseRegisterDel",saveVO);
			sqlSession.delete("pg.rejectCourseEvalDel",saveVO);
			sqlSession.delete("pg.rejectCourseWeekDel",saveVO);
			
			if ( CommUtil.isEqual((String)cart.get(courseIds[i]), "") ) {
		    	sqlSession.insert("pg.courseRegisterIns",saveVO);

		    	//평가 데이타 생성
		    	sqlSession.insert("pg.courseEvalIns",saveVO);
		    	
		    	//주차별 진도 데이타 생성
		    	sqlSession.insert("pg.courseWeekIns",saveVO);
			} else {
		    	//평가 데이타 생성
		    	sqlSession.insert("pg.courseEvalIns",saveVO);
		    	
		    	//주차별 진도 데이타 생성
    			Map weekMap = new HashMap();
    			List weekList = new ArrayList();
    			String[] weeks = ((String)cart.get(courseIds[i])).split(",");
    			for ( int k = 0; k < weeks.length; k++ ) {
    				weekList.add(weeks[k]);
    			}
    			weekMap.put("list", weekList);
    			weekMap.put("courseId", courseIds[i]);
    			weekMap.put("userId", SessionUtil.getSessionUserId());

    			sqlSession.insert("pg.courseWeekPartIns",weekMap);
    			
    			//과정 신청 및 금액 데이타 생성
		    	sqlSession.insert("pg.courseRegisterPartIns",saveVO);
			}
			
			//수료증 번호 생성
	    	sqlSession.update("pg.myCertificateNoUpd",saveVO);
		}

		//cart에서 결재한건 삭제한다.
		for ( int i = 0; i < courseIds.length; i++ ) {
			if ( cart.containsKey(courseIds[i]) ) {
				cart.remove(courseIds[i]);
			}
		}
		SessionUtil.setAttribute("cart", cart);
		
		set.setRtnMode(Constant.mode.OK.name());

		System.out.println("=====================> XpayService approval end");

    	return set;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean approvalCancel(PgSet set) throws Exception {
		try {
			System.out.println("=====================> XpayService approvalCancel Start");
			
			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
			
			sqlSession.update("pg.approvalUpdateForCardRefund", set.getCondiVO());
			sqlSession.update("pg.registerUpdateForCardRefund", set.getCondiVO());
			
			//포인트 금액이 있으면 사용을 취소한다.
			List<PgVO> pointUseLogList = sqlSession.selectList("pg.userPointLog", set.getCondiVO());
			for ( int m = 0; m < pointUseLogList.size(); m++ ) {
				sqlSession.update("pg.userPointUseBackUpdate", pointUseLogList.get(m));
			}

			//포인트 지급, 과정 적립 포인트를 사용안함으로 변경.
			String userId = sqlSession.selectOne("pg.approvalUserId", set.getCondiVO());
			set.getCondiVO().setUserId(userId);
			sqlSession.update("pg.userPointDeleteUpdate", set.getCondiVO());
			
			System.out.println("=====================> XpayService approvalCancel end");
		} catch ( Exception e) {
			e.printStackTrace();
			return false;
		}
    	return true;
    }

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public boolean approvalCancelRollback(PgSet set) throws Exception {
		try {
			System.out.println("=====================> XpayService approvalCancelRollback Start");
	
			set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
			
			sqlSession.update("pg.approvalUpdateCancelForCardRefund", set.getCondiVO());
			sqlSession.update("pg.registerUpdateCancelForCardRefund", set.getCondiVO());

			//pg 오류시 포인트 금액을 원복한다.
			List<PgVO> pointUseLogList = sqlSession.selectList("pg.userPointLog", set.getCondiVO());
			for ( int m = 0; m < pointUseLogList.size(); m++ ) {
				sqlSession.update("pg.userPointUseBackCancelUpdate", pointUseLogList.get(m));
			}

			//포인트 지급, 과정 적립 포인트를 사용안함으로 변경.
			String userId = sqlSession.selectOne("pg.approvalUserId", set.getCondiVO());
			set.getCondiVO().setUserId(userId);
			sqlSession.update("pg.userPointDeleteCancelUpdate", set.getCondiVO());
			

			System.out.println("=====================> XpayService approvalCancelRollback end");
	
		} catch ( Exception e) {
			e.printStackTrace();
			return false;
		}
    	return true;
    }

}


