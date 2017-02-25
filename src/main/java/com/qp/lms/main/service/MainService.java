package com.qp.lms.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.course.model.CourseResourceVO;
import com.qp.lms.course.model.CourseVO;
import com.qp.lms.guest.model.BankVO;
import com.qp.lms.main.model.MainSet;
import com.qp.lms.main.model.MainVO;
import com.qp.lms.member.model.MemberVO;

@Service("mainService")
public class MainService {
	@Autowired
	private SqlSession sqlSession;

	public MainSet mainCourseList(MainSet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitForMain);

    	List<CourseVO> courseList = sqlSession.selectList("main.mainCourseList",set.getCondiVO());
    	set.setCourseList(courseList);
        
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CourseVO)sqlSession.selectOne("main.mainCourseTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitForMain);
    	
    	return set;
    }
	
	public MainSet mainCourseData(MainSet set) throws Exception {
    	set.setCourseData((CourseVO)sqlSession.selectOne("main.courseData",set.getCondiVO()));
    	
    	List<CourseResourceVO> courseResourceList = sqlSession.selectList("main.courseResourceData",set.getCondiVO());
    	set.setCourseResourceList(courseResourceList);
    	
    	return set;
    }

	public MainSet cart(MainSet set) throws Exception {
		Map map = new HashMap();
		
		if ( set.getCondiVO().getCourseId() != null ) {
			List al = new ArrayList();
			String[] courseIds = set.getCondiVO().getCourseId().split(",");
			for ( int i = 0; i < courseIds.length; i++ ) {
				al.add(courseIds[i]);
			}
			map.put("list", al);
			
			//결재할 과정 정보
			List<CourseVO> courseList = sqlSession.selectList("main.applicationCourseList",map);
	    	set.setCourseList(courseList);
	    	
	    	HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
	    	if ( cart == null ) {
	    		//바로 신청할 경우....
	    		cart = (HashMap)SessionUtil.getAttribute("tempCart");
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
	
	    			List<CourseVO> cartWeekList = sqlSession.selectList("main.applicationCourseWeekList",weekMap);
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
		}

    	set.setRtnMode(Constant.mode.OK.name());

    	return set;
    }
	
	public MainSet application(MainSet set) throws Exception {
		Map map = new HashMap();
		
		List al = new ArrayList();
		String[] courseIds = set.getCondiVO().getCourseId().split(",");
		for ( int i = 0; i < courseIds.length; i++ ) {
			al.add(courseIds[i]);
		}
		map.put("list", al);
		
		//결재할 과정 정보
		List<CourseVO> courseList = sqlSession.selectList("main.applicationCourseList",map);
    	set.setCourseList(courseList);
    	
    	HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
    	if ( cart == null ) {
    		//바로 신청할 경우....
    		cart = (HashMap)SessionUtil.getAttribute("tempCart");
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

    			List<CourseVO> cartWeekList = sqlSession.selectList("main.applicationCourseWeekList",weekMap);
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
    	
    	//point
    	System.out.print("userId : " + set.getCondiVO());
    	MainVO mainVO = (MainVO)sqlSession.selectOne("main.userPoint", set.getCondiVO());
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
	
	/////////////////////////////////////////////////////////////////////////////////////////
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
	public MainSet approval(MainSet set) throws Exception {
		set.getCondiVO().setUserId(SessionUtil.getSessionUserId());
		set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
		
		
		//결재 내용 입력.
		sqlSession.insert("main.approvalIns",set.getCondiVO());
		
		HashMap cart = (HashMap)SessionUtil.getAttribute("cart");
		if ( cart == null ) {
    		//바로 신청할 경우....
    		cart = (HashMap)SessionUtil.getAttribute("tempCart");
    	}
		
		MainVO saveVO = new MainVO();
		saveVO.setUserId(SessionUtil.getSessionUserId());
		saveVO.setCreateUser(SessionUtil.getSessionUserId());
		saveVO.setApprovalId(set.getCondiVO().getApprovalId());
		saveVO.setPaymentKind(set.getCondiVO().getPaymentKind());
		
		String[] courseIds = set.getCondiVO().getCourseId().split(",");
		for ( int i = 0; i < courseIds.length; i++ ) {
			saveVO.setCourseId(courseIds[i]);
			
			//반려된 케이스가 있으면 삭제를 해준다.
			sqlSession.delete("main.rejectCourseRegisterDel",saveVO);
			sqlSession.delete("main.rejectCourseEvalDel",saveVO);
			sqlSession.delete("main.rejectCourseWeekDel",saveVO);
			
			if ( CommUtil.isEqual((String)cart.get(courseIds[i]), "") ) {
		    	sqlSession.insert("main.courseRegisterIns",saveVO);

		    	//평가 데이타 생성
		    	sqlSession.insert("main.courseEvalIns",saveVO);
		    	
		    	//주차별 진도 데이타 생성
		    	sqlSession.insert("main.courseWeekIns",saveVO);
			} else {
		    	//평가 데이타 생성
		    	sqlSession.insert("main.courseEvalIns",saveVO);
		    	
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

    			sqlSession.insert("main.courseWeekPartIns",weekMap);
    			
    			//과정 신청 및 금액 데이타 생성
		    	sqlSession.insert("main.courseRegisterPartIns",saveVO);
			}
		}
		
		set.setRtnMode(Constant.mode.OK.name());
		
    	return set;
    }
	
	
	public MainSet mailQuestion(MainSet set) throws Exception {
		List<CodeVO> ddMailList = sqlSession.selectList("comm.getDdMail",null);
		set.setDdMailList(ddMailList);
    	
    	return set;
    }

}
