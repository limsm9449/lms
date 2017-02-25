package com.qp.lms.category.model;

import com.qp.lms.common.CommonVO;

public class CategoryVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String code;
	private String codeName;
	private String useYn;
	private String depth;
	private String parentCode;
	private String parentCodeName;
	
	private String c1Code;			/** 대분류 코드 */
	private String c1CodeName;		/** 대분류 코드 */
	private String c2Code;			/** 중분류 코드 */
	private String c2CodeName;		/** 중분류 코드 */
	private String c3Code;			/** 소분류 코드 */
	private String c3CodeName;		/** 소분류 코드 */
	
	private String codeNames;		/** 카테고리 연속 이름 : IT > DB > Oracle */

	
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public String getParentCodeName() {
		return parentCodeName;
	}
	public void setParentCodeName(String parentCodeName) {
		this.parentCodeName = parentCodeName;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String getC1Code() {
		return c1Code;
	}
	public void setC1Code(String c1Code) {
		this.c1Code = c1Code;
	}
	public String getC1CodeName() {
		return c1CodeName;
	}
	public void setC1CodeName(String c1CodeName) {
		this.c1CodeName = c1CodeName;
	}
	public String getC2Code() {
		return c2Code;
	}
	public void setC2Code(String c2Code) {
		this.c2Code = c2Code;
	}
	public String getC2CodeName() {
		return c2CodeName;
	}
	public void setC2CodeName(String c2CodeName) {
		this.c2CodeName = c2CodeName;
	}
	public String getC3Code() {
		return c3Code;
	}
	public void setC3Code(String c3Code) {
		this.c3Code = c3Code;
	}
	public String getC3CodeName() {
		return c3CodeName;
	}
	public void setC3CodeName(String c31CodeName) {
		this.c3CodeName = c31CodeName;
	}
	public String getCodeNames() {
		return codeNames;
	}
	public void setCodeNames(String codeNames) {
		this.codeNames = codeNames;
	}
	
	
	
	

}
