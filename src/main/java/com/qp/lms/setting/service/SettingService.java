package com.qp.lms.setting.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.qp.lms.common.Constant;
import com.qp.lms.setting.model.SettingSet;
import com.qp.lms.setting.model.SettingVO;

@Service
public class SettingService {
	@Autowired
	private SqlSession sqlSession;

	public SettingSet settingList(SettingSet set) throws Exception {
    	List<SettingVO> list = sqlSession.selectList("setting.settingList",set.getCondiVO());
    	set.setSettingList(list);
    	
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public SettingSet settingSave(SettingSet set) throws Exception {
    	SettingVO saveVO = new SettingVO();
		for ( int i = 0; i < set.getCondiVO().getOptionKeys().length; i++ ) {
			saveVO.setOptionKey(set.getCondiVO().getOptionKeys()[i]);
			saveVO.setOptionValue(set.getCondiVO().getOptionValues()[i]);

			sqlSession.insert("setting.settingUpd",saveVO);
		}

		set.setRtnMode(Constant.mode.OK.name());
    	    	
    	return set;
    }
    
    public SettingSet mailList(SettingSet set) throws Exception {
    	List<SettingVO> list = sqlSession.selectList("setting.mailList",set.getCondiVO());
    	set.setMailList(list);
    	
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public SettingSet mailSave(SettingSet set) throws Exception {
    	//기존거를 삭제한다.
    	sqlSession.delete("setting.mailAllDelete",set.getCondiVO());

    	SettingVO saveVO = new SettingVO();
		for ( int i = 0; i < set.getCondiVO().getKinds().length; i++ ) {
			saveVO.setKind(set.getCondiVO().getKinds()[i]);
			saveVO.setEmail(set.getCondiVO().getEmails()[i]);
			
			sqlSession.insert("setting.mailIns",saveVO);
		}

		set.setRtnMode(Constant.mode.OK.name());
    	    	
    	return set;
    }

    public SettingSet bankList(SettingSet set) throws Exception {
    	List<SettingVO> list = sqlSession.selectList("setting.bankList",set.getCondiVO());
    	set.setBankList(list);
    	
    	return set;
    }
    
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor={Throwable.class})
    public SettingSet bankSave(SettingSet set) throws Exception {
    	SettingVO saveVO = new SettingVO();
		for ( int i = 0; i < set.getCondiVO().getSeqs().length; i++ ) {
			saveVO.setSeq(set.getCondiVO().getSeqs()[i]);
			saveVO.setBankName(set.getCondiVO().getBankNames()[i]);
			saveVO.setAccNo(set.getCondiVO().getAccNos()[i]);
			saveVO.setUser(set.getCondiVO().getUsers()[i]);
			saveVO.setUseYn(set.getCondiVO().getUseYns()[i]);
			
			if ( "".equals(saveVO.getSeq()) ) {
				sqlSession.insert("setting.bankIns",saveVO);
			} else {
				sqlSession.insert("setting.bankUpd",saveVO);
			}
		}

		set.setRtnMode(Constant.mode.OK.name());
    	    	
    	return set;
    }

    
}
