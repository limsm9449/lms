package com.qp.lms.company.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.common.SessionUtil;
import com.qp.lms.common.service.CommService;
import com.qp.lms.common.service.DdService;
import com.qp.lms.company.model.CompanySet;
import com.qp.lms.company.model.CompanyVO;

@Service
public class CompanyService {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private DdService ddService;

	@Autowired
    private CommService commSvr;

    public CompanySet companyList(CompanySet set) throws Exception {
    	//쿼리에서 가져올 갯수 지정
    	set.getCondiVO().setLimitUnit(Constant.unitPerPage);

    	List<CompanyVO> list = sqlSession.selectList("company.companyList",set.getCondiVO());
    	set.setList(list);
    	
    	//페이징 처리 변수 세팅
    	set.setTotalCount(((CompanyVO)sqlSession.selectOne("company.companyTotal",set.getCondiVO())).getCnt());
    	set.setPageUnit(Constant.unitPerPage);
    	
    	return set;
    }
    
    public CompanySet companyN(CompanySet set) throws Exception {
    	return set;
    }
    
    public CompanySet companyV(CompanySet set) throws Exception {
    	set.setData((CompanyVO) sqlSession.selectOne("company.companyData",set.getCondiVO()));

    	return set;
    }
    
    public CompanySet companyU(CompanySet set) throws Exception {
    	set.setData((CompanyVO) sqlSession.selectOne("company.companyData",set.getCondiVO()));

    	return set;
    }
    
    
    
    
    ///////////////////////////////////////////////// Transaction ////////////////////////////////////////////////////
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanySet companyNIns(CompanySet set) throws Exception {
    	set.getCondiVO().setCreateUser(SessionUtil.getSessionUserId());
    	
    	CompanyVO vo = (CompanyVO)sqlSession.selectOne("company.isExistCompany",set.getCondiVO());
		if ( vo.getCnt() == 1 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		} else {
			sqlSession.update("company.companyIns",set.getCondiVO());
	    	
			String cuFolder = commSvr.getSetting("CU_FOLDER");

			//회사별 디렉토리 생성
			File compDir = new File(cuFolder + "//" + set.getCondiVO().getCompCd());
			compDir.mkdir();
			
			//index 파일 복사
			FileInputStream fis = null;
			FileOutputStream fos = null;
			try {
				fis = new FileInputStream(cuFolder + "//index.jsp");
				fos = new FileOutputStream(cuFolder + "//" + set.getCondiVO().getCompCd() + "//index.jsp");
				byte[] b = new byte[4096];
				int cnt = 0;
				while ((cnt = fis.read(b)) != -1) {
					fos.write(b, 0, cnt);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					fis.close();
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			//js 파일 생성
			File jsFile = new File(cuFolder + "//" + set.getCondiVO().getCompCd() + "//company.js");
			BufferedWriter out = new BufferedWriter(new FileWriter(jsFile));
			out.write("var compCd = \"" + set.getCondiVO().getCompCd() + "\";");
			out.flush();
			out.close();
			
	   		set.setRtnMode(Constant.mode.INSERT_OK.name());
		}
   		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanySet companyUUpd(CompanySet set) throws Exception {
    	set.getCondiVO().setUpdateUser(SessionUtil.getSessionUserId());
    	
    	CompanyVO vo = (CompanyVO)sqlSession.selectOne("company.isExistCompanyTutor",set.getCondiVO());
		if ( vo.getCnt() > 0 ) {
			set.setRtnMode(Constant.mode.EXIST.name());
			return set;
		} else {
	   		sqlSession.update("company.companyUpd",set.getCondiVO());
	   		
	   		set.setRtnMode(Constant.mode.UPDATE_OK.name());
		}
		
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public CompanySet companyDel(CompanySet set) throws Exception {
   		sqlSession.update("company.companyUserDel",set.getCondiVO());

   		sqlSession.update("company.companyDel",set.getCondiVO());
    	
   		set.setRtnMode(Constant.mode.DELETE_OK.name());
   		
    	return set;
    }

}
