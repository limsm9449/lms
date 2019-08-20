package com.qp.lms.login.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.CommUtil;
import com.qp.lms.common.Constant;
import com.qp.lms.company.model.CompanyVO;
import com.qp.lms.login.model.LoginSet;
import com.qp.lms.login.model.LoginVO;

@Service
public class LoginService {

	@Autowired
	private SqlSession sqlSession;

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public LoginSet loginCheck(LoginSet set) throws Exception {
    	//네이버 로그인이면 정보를 가져온다.
    	if ( !"".equals(CommUtil.getString(set.getCondiVO().getNaverAccessToken()))) {
    		//프로필 정보를 가져온다.
            String userId = "";
            String name = "";
            String gender = "";
            String email = "";
            try {
                URL url = new URL("https://openapi.naver.com/v1/nid/me");
                HttpURLConnection con = (HttpURLConnection)url.openConnection();
                con.setRequestMethod("GET");
                con.setRequestProperty("Authorization", "Bearer " + set.getCondiVO().getNaverAccessToken());
                int responseCode = con.getResponseCode();
                BufferedReader br;
                if ( responseCode == 200 ) { // 정상 호출
                    br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                } else {  // 에러 발생
                    br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
                }
                String inputLine;
                StringBuffer res = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    res.append(inputLine);
                }
                br.close();

                if(responseCode==200) {
            		JSONParser jsonParser = new JSONParser();
            		JSONObject jsonObject = (JSONObject) jsonParser.parse(res.toString());
            		
            		JSONObject userInfo = (JSONObject)jsonObject.get("response"); 
            				
                	System.out.println(res.toString());

                	userId = "naver_" + (String)userInfo.get("id");
            		gender = (String)userInfo.get("gender");
            		email = (String)userInfo.get("email");
            		name = (String)userInfo.get("name");

                    set.getCondiVO().setUserId(userId);
                    set.getCondiVO().setPassword(userId);	//패스워드는 userId와 동일하다.
                    set.getCondiVO().setUserName(name);
                    set.getCondiVO().setEmail(email);
                    set.getCondiVO().setSex(gender);
                    
                    set.getCondiVO().setNaverUserYn("Y");
                }
            } catch (Exception e) {
                System.out.println(e);
            }
    	} else {
            set.getCondiVO().setNaverUserYn("N");
    	}
    	
    	LoginVO loginVO = (LoginVO) sqlSession.selectOne("login.getLoginUser",set.getCondiVO());

    	//Naver 사용자를 등록후에 다시 조회한다.
    	if ( loginVO == null && "Y".equals(set.getCondiVO().getNaverUserYn()) ) {
    		sqlSession.insert("login.naverUserInsert",set.getCondiVO());
    		
    		loginVO = (LoginVO) sqlSession.selectOne("login.getLoginUser",set.getCondiVO());
    	}

    	
    	String auth = CommUtil.getString(set.getCondiVO().getAuth());
    	if ( "CHANNEL".equals(auth) || "C2C".equals(set.getCondiVO().getCompType()) ) {
    		LoginVO vo = sqlSession.selectOne("login.c2cUserInfo",set.getCondiVO());
    		if ( vo != null ) {
    			set.setCompCd(vo.getCompCd());	
    		}
    	}

    	if ( loginVO == null ) {
    		set.setIsNotExistUserId("N");
    		set.setIsWrongPassword("N");
    		
    		if ( ((LoginVO)sqlSession.selectOne("login.isExistUser",set.getCondiVO())).getCnt() == 0 ) { 
    			set.setIsNotExistUserId("Y");
    		} else {
    			set.setIsWrongPassword("Y"); 
    		}
    	} else {
			set.setIsNotCertification("N");
			
    		if ( "N".equals(loginVO.getCertificationYn()) ) {
    			set.setIsNotCertification("Y"); 
    		} else {
    			//B2B 이면 해당 회사의 사용자만 들어와야 한다.
	    		if ( CommUtil.isEqual(set.getCondiVO().getCompType(), "B2B") && CommUtil.isEqual(set.getCondiVO().getCompCd(), loginVO.getCompCd()) == false ) {
	    			set.setIsNotExistUserId("Y");
	    		} else {
	    			set.setData(loginVO);
	    		}
    		}
    	}
    	
    	//이전에 logout이 없을 경우를 대배해서 시간을 넣어줌
    	sqlSession.update("login.notLogoutLogUpdate", set.getCondiVO());
    	
    	//접속 시간 기록
    	sqlSession.update("login.loginLogInsert", set.getCondiVO());
    	
        return set ;
    }

    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public LoginSet logout(LoginSet set) throws Exception {
    	sqlSession.update("login.logoutLogUpdate", set.getCondiVO());
    	
    	set.setRtnMode(Constant.mode.OK.name());
    	
        return set ;
    }
    
    public LoginSet backdorLoginCheck(LoginSet set) throws Exception {
    	LoginVO loginVO = (LoginVO) sqlSession.selectOne("login.getLoginUser",set.getCondiVO());
    	
		set.setIsNotExistUserId("N");
		set.setIsWrongPassword("N");
		set.setIsNotAdmin("N");

		if ( loginVO == null ) {
    		if ( ((LoginVO)sqlSession.selectOne("login.isExistUser",set.getCondiVO())).getCnt() == 0 ) { 
    			set.setIsNotExistUserId("Y");
    		} else {
    			set.setIsWrongPassword("Y"); 
    		}
    	} else
    		if ( "A".equals(loginVO.getAdminYn()) || "M".equals(loginVO.getAdminYn()) || "C".equals(loginVO.getAdminYn()) ) {
        		System.out.println("B");
    			//어드민이면 백도어 계정으로 데이타 생성
    			LoginVO condiVO = new LoginVO();
    			condiVO.setUserId(set.getCondiVO().getBackdoorUserId());
    			loginVO = (LoginVO) sqlSession.selectOne("login.getUserInfo",condiVO);

    			if ( loginVO == null ) {
    				set.setIsNotExistUserId("Y");
    			} else {
    				set.setData(loginVO);
    			}
    		} else {
        		System.out.println("C");
    			set.setIsNotAdmin("Y");
    		}
    	
        return set ;
    }

    public LoginSet companyLogin(LoginSet set) throws Exception {
    	CompanyVO condiVO = new CompanyVO();
    	condiVO.setCompCd(set.getCondiVO().getCompCd());
    	
    	set.setCompanyData((CompanyVO) sqlSession.selectOne("company.companyData",condiVO));
    	
        return set ;
    }
}
