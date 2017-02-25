package com.qp.lms.setting.model;

import com.qp.lms.common.CommonVO;


public class SettingVO extends CommonVO {
	private static final long serialVersionUID = -1l; 

	private String seq;
	private String kind;
	private String email;

	private String bankName;
	private String accNo;
	private String user;
	private String useYn;

	private String optionKey;
	private String optionValue;

	private String[] kinds;
	private String[] emails;
	
	private String[] seqs;
	private String[] bankNames;
	private String[] accNos;
	private String[] users;
	private String[] useYns;
	
	private String[] optionKeys;
	private String[] optionValues;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String[] getKinds() {
		return kinds;
	}
	public void setKinds(String[] kinds) {
		this.kinds = kinds;
	}
	public String[] getEmails() {
		return emails;
	}
	public void setEmails(String[] emails) {
		this.emails = emails;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String[] getBankNames() {
		return bankNames;
	}
	public void setBankNames(String[] bankNames) {
		this.bankNames = bankNames;
	}
	public String[] getAccNos() {
		return accNos;
	}
	public void setAccNos(String[] accNos) {
		this.accNos = accNos;
	}
	public String[] getUsers() {
		return users;
	}
	public void setUsers(String[] users) {
		this.users = users;
	}
	public String[] getUseYns() {
		return useYns;
	}
	public void setUseYns(String[] useYns) {
		this.useYns = useYns;
	}
	public String[] getSeqs() {
		return seqs;
	}
	public void setSeqs(String[] seqs) {
		this.seqs = seqs;
	}
	public String getOptionKey() {
		return optionKey;
	}
	public void setOptionKey(String optionKey) {
		this.optionKey = optionKey;
	}
	public String getOptionValue() {
		return optionValue;
	}
	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}
	public String[] getOptionKeys() {
		return optionKeys;
	}
	public void setOptionKeys(String[] optionKeys) {
		this.optionKeys = optionKeys;
	}
	public String[] getOptionValues() {
		return optionValues;
	}
	public void setOptionValues(String[] optionValues) {
		this.optionValues = optionValues;
	}
	
	
	
	
	

}
