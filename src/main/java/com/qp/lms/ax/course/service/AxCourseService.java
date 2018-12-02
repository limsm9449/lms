package com.qp.lms.ax.course.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.course.model.CourseCodeSet;
import com.qp.lms.course.model.CourseCodeVO;
import com.qp.lms.common.CodeVO;
import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.DdService;

@Service
public class AxCourseService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DdService ddService;
	
	public HashMap<String, Object> axCourseList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		CommUtil.setSesstionInfo(paramMap);

    	List<HashMap<String, Object>> list = sqlSession.selectList("axCourse.axCourseList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCourseSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);
			row.put("SESSION_USER_ID", SessionUtil.getSessionUserId());

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				row.put("CHASU", sqlSession.selectOne("axCourse.axCourseMaxChasu", row));

				//과정 Master 내용 복사
				HashMap<String, Object> courseMaster = sqlSession.selectOne("axCourse.axCourseMasterContents", row);
				if ( courseMaster != null ) {
					row.put("LEARING_GOAL", courseMaster.get("LEARING_GOAL"));
					row.put("LEARING_CONTENT", courseMaster.get("LEARING_CONTENT"));
					row.put("EVAL_METHOD", courseMaster.get("EVAL_METHOD"));
					row.put("LEARING_TARGET", courseMaster.get("LEARING_TARGET"));
					row.put("LEARING_COST", courseMaster.get("LEARING_COST"));
				}
	
				sqlSession.insert("axCourse.axCourseInsert", row);
			} else {
				sqlSession.update("axCourse.axCourseUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axCourse.axCourseDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCourseContentsList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCourse.axCourseContents", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCourseContentsSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		paramMap.put("SESSION_USER_ID", SessionUtil.getSessionUserId());
		
		sqlSession.update("axCourse.axCourseContentsUpdate", paramMap);

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCourseTutorList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCourse.axCourseTutorList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCourseTutorSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			if ( "Y".equals((String)row.get("NEW_FLAG")) ) {
				sqlSession.insert("axCourse.axCourseTutorInsert", row);
			} else {
				sqlSession.update("axCourse.axCourseTutorUpdate", row);
			}
		}

		List<HashMap<String, Object>> delList = (List<HashMap<String, Object>>)paramMap.get("deleted");
		for ( int i = 0; i < delList.size(); i++ ) {
			sqlSession.delete("axCourse.axCourseTutorDelete", delList.get(i));
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
	
	public HashMap<String, Object> axCourseUserTutorList(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
    	List<HashMap<String, Object>> list = sqlSession.selectList("axCourse.axCourseUserTutorList", paramMap);
    	hm.put("list", list);
        
    	return hm;
    }
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public HashMap<String, Object>  axCourseUserTutorSave(HashMap<String, Object> paramMap) throws Exception {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> updList = (List<HashMap<String, Object>>)paramMap.get("modified");

		for ( int i = 0; i < updList.size(); i++ ) {
			HashMap<String, Object> row = (HashMap<String, Object>)updList.get(i);

			sqlSession.update("axCourse.axCourseUserTutorUpdate", row);
		}

		hm.put("RtnMode", Constant.mode.OK.name());
		
    	return hm;
    }
}
