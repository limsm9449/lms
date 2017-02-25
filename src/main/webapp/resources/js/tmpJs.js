//alert("A");

//http://cafe.naver.com/buldon/750  : 공통 js

//function 





/***********************************************************************
 * 이름 체크
 ***********************************************************************/
function nameCheck(input){
	input = input.replaceAll("\"","!");
	input = input.replaceAll("\'","!");
	input = input.replaceAll("\\","!");

	if(input.trim()=="")return false;

	var chars = '!@#$%^&*()+=|{}[]<>,./?';
	return !isHaveContain(input,chars);
}

/***********************************************************************
 * 전화번호 체크
 ***********************************************************************/
function isPhoneCheck(input) { 
	var chars = "0123456789";
	return isAllHaveContain(input,chars);
}

/***********************************************************************
 * 영문체크
 ***********************************************************************/
function isEngCheck(input) { 
	
	if(input.trim()=="")return false;

	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	return isAllHaveContain(input,chars);
}

/***********************************************************************
 * 영문, 숫자 체크
 ***********************************************************************/
function isEngAndNumCheck(input) { 
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	return isAllHaveContain(input,chars);
}

/***********************************************************************
 * 숫자중에 대쉬(-)있는지 체크
 ***********************************************************************/
function isNumDash(input) {
	var chars = "-0123456789";
	return isAllHaveContain(input,chars);
}

/***********************************************************************
 * 숫자중에 콤마(,)있는지 체크
 ***********************************************************************/
function isNumComma(input) {
	var chars = ",0123456789";
	return isAllHaveContain(input,chars);
}


/***********************************************************************
 * 입력값이 사용자가 정의한 포맷 형식인지 체크
 * 자세한 format 형식은 자바스크립트의 ''regular expression''을 참조
 ***********************************************************************/
function isValidFormat(input,format) {
	if (input.search(format) != -1) {
	return true;//올바른 포맷 형식
	}
	return false;
}

/***********************************************************************
 * 이메일 체크
 * ex) if (!isValidEmail(form.email)) alert("올바른 이메일 주소가 아닙니다.");
 ***********************************************************************/
function isValidEmail(input) {
//  var format = /^(\S+)@(\S+)\.([A-Za-z]+)$/;
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	return isValidFormat(input,format);
}

/***********************************************************************
 * 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
 ***********************************************************************/
function isValidPhone(input) {
	var format = /^(\d+)-(\d+)-(\d+)$/;
	return isValidFormat(input,format);
}

/***********************************************************************
 * 콤마 없애기
 ***********************************************************************/
function removeComma(input) {
	return input.replace(/,/gi,"");
}
/***********************************************************************
 * 금액형식
 ***********************************************************************/
function addComma(num) {
	var numData="";
	var startRealNum=0;
	var sign="";
	numData=num;
	
	numData = numData.toString().replace(/\$|\,/g,'');
	
	if(isNaN(numData)) {
		numData = "";
		return numData;
	}
	if(numData.substring(0,1)=="-"){
		sign="-";
		numData=numData.substring(1);
	}
	
	for(var i=0;i<numData.length;i++){
		if(numData.charAt(i)!='0'){
			break;
		}
		startRealNum++;
	}
	
	if(numData.length!=1&&startRealNum>0){
		if(numData.charAt(startRealNum)=='.'){
			numData = numData.substring(startRealNum-1);
		}else{
			numData = numData.substring(startRealNum);
		}
	}

	if(numData.charAt(0)=="."){
		numData="0."+numData.substring(1);
	}
	
	tmpNum=numData.split('.');
	if(tmpNum.length==1){
		numData=tmpNum[0];
		cents="";
	}else if(tmpNum.length==2){
		numData	=tmpNum[0];
		cents	=tmpNum[1];
	}else{
		return "";
	}

	for (var i = 0; i < Math.floor((numData.length-(1+i))/3); i++)
		numData = numData.substring(0,numData.length-(4*i+3))+','+numData.substring(numData.length-(4*i+3));

	if(cents==""){
		return sign+numData;
	}else{
		return sign+(numData + "." + cents);
	}
}
/***********************************************************************
 * 문자 변환 함수
 ***********************************************************************/
function alterString(str,before,after) {
	var returnStr = "";
	for(i = 0; i < str.length; i++) {
		value = str.charAt(i);
		index = before.indexOf(value);
		if(index >= 0) value = after.charAt(index);
		returnStr += value;
	}
	return returnStr;
}

/***********************************************************************
 * 소 --> 대문자 변환 함수
 ***********************************************************************/
function ToUpper(arg) {
	var str1 = "abcdefghijklmnopqrstuvwxyz";
	var str2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	return alterString(arg,str1,str2);
}

/***********************************************************************
 * 대 --> 소문자 변환 함수
 ***********************************************************************/
function ToLower(arg){
	var str1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var str2 = "abcdefghijklmnopqrstuvwxyz";
	return alterString(arg,str1,str2);
}

/***********************************************************************
 * 반각 문자를 전각문자로
 ***********************************************************************/
function convert2ByteChar(x_char) {
	var x_2byteChar = ""; //컨버트된 문자
	var c = x_char.charCodeAt(0);
	if(32 <= c && c <= 126) { //전각으로 변환될수 있는 문자의 범위
		if(c == 32) { //스페이스인경우 ascii 코드 32
			x_2byteChar = unescape("%uFFFC");
		} else {
			x_2byteChar = unescape("%u"+gf_DecToHex(c+65248));
		}
	}
	return  x_2byteChar;
}

/***********************************************************************
 * 10진수를 16진수로
 ***********************************************************************/
function gf_DecToHex(x_dec) {
	var x_Hex = new Array();
	var x_serial = 0;
	var x_over16 = x_dec;
	var x_tempNum = 0;
	while(x_dec > 15) {
		var x_h = x_dec % 16; //나머지
		x_dec = parseInt(x_dec/16); //몫
		x_Hex[x_serial++] = (x_h > 9 ? String.fromCharCode(x_h + 55) : x_h); //16진수코드변환
	}
	//마지막은 몫의 값을 가짐
	x_Hex[x_serial++] = (x_dec > 9 ? String.fromCharCode(x_dec + 55) : x_dec); //16진수코드변환
	//몫,나머지,나머지,.....
	var retValue = "";
	for(var i=x_Hex.length ; i>0 ;i--) {
		retValue += x_Hex[i-1];
	}
	return retValue;
}

/***********************************************************************
 * 문자 길이체크
 ***********************************************************************/
function checkLength(str,minLng,maxLng){
	var ckstr = str.value.length; 
	if (parseInt(ckstr) < parseInt(minLng) || parseInt(ckstr) > parseInt(maxLng)) return false;
	return true;
}




/***********************************************************************
 * 바이트 구하기
 ***********************************************************************/
function getByteLen(str){
	return(str.length+(escape(str)+"%u").match(/%u/g).length-1);
}

/***********************************************************************
 * url 가져오기
 ***********************************************************************/
function getUrlAddress(){
	var pageUrl = document.location; 
	pageUrl  = new String(pageUrl);
	return pageUrl.substring(0,pageUrl.lastIndexOf("/"));
}

/***********************************************************************
 * 오른마우스 금지, 나중에 해당 주석 풀고 사용
 ***********************************************************************/
function rightbutton(e){
	if (navigator.appName == 'Netscape' &&  (e.which == 3 || e.which == 2))
		return false;
	else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3)){
		alert("죄송합니다!! 정보무단복제를 막기 위하여 오른쪽 마우스 사용을 허용하지 않습니다.");
		return false;
	}
	return true;
}
//document.onmousedown=rightbutton;

/***********************************************************************
 * 컨트롤 키 금지, 나중에 해당 주석 풀고 사용
 ***********************************************************************/
function checkCtl(){
	if (document.all){
		if(event.keyCode==17) {
		alert("죄송합니다!! 컨트롤키 사용을 허용하지 않습니다.");
		return false;
		}
	}
}
//document.onkeydown = checkCtl;

/***********************************************************************
 * 쿠키설정
 ***********************************************************************/
function setCookie(name,value, expires) {
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expires.toGMTString();
}

/***********************************************************************
 * 쿠키얻기
 ***********************************************************************/
function getCookie(Name) {
	var search = Name + "="
	if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
		offset = document.cookie.indexOf(search)
		if (offset != -1) { // 쿠키가 존재하면
			offset += search.length
			// set index of beginning of value
			end = document.cookie.indexOf(";", offset)
			// 쿠키 값의 마지막 위치 인덱스 번호 설정
			if (end == -1) end = document.cookie.length
			return unescape(document.cookie.substring(offset, end));
		}
	}
}
/***********************************************************************
 * 체크로직
 * chars에 문자열이 input에 있다면 true, 없으면 false
 ***********************************************************************/
function isHaveContain(input,chars) {
	for(var i=0 ; i<chars.length ; i++){
		if(input.indexOf(chars.charAt(i))!=-1)return true
	}
	return false;
}

//문자 바꾸기, 사용법 var str = 문자열.replaceAll("a", "1");  
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/gi, "");
}


/* StringBuffer 클래스 정의 시작 */
function StringBuffer() {  
    this.buffer = new Array();   
}   
StringBuffer.prototype.append = function(obj) {   
    this.buffer.push(obj);   
}   
StringBuffer.prototype.toString = function() {   
  return this.buffer.join("");   
}
/* StringBuffer 클래스 정의 종료 */


function printTestRes(check){
	if(check=="isNum"){
		document.getElementById("isNumDiv").innerHTML="<b><font color=white>"+isNum(document.getElementById("isNumTxt").value)+"</font></b>";
	}else if(check=="nameCheck"){
		document.getElementById("nameCheckDiv").innerHTML="<b><font color=white>"+nameCheck(document.getElementById("nameCheckTxt").value)+"</font></b>";
	}else if(check=="isEngCheck"){
		document.getElementById("isEngCheckDiv").innerHTML="<b><font color=white>"+isEngCheck(document.getElementById("isEngCheckTxt").value)+"</font></b>";
	}else if(check=="isValidEmail"){
		document.getElementById("isValidEmailDiv").innerHTML="<b><font color=white>"+isValidEmail(document.getElementById("isValidEmailTxt").value)+"</font></b>";
	}else if(check=="isValidPhone"){
		document.getElementById("isValidPhoneDiv").innerHTML="<b><font color=white>"+isValidPhone(document.getElementById("isValidPhoneTxt").value)+"</font></b>";
	}else if(check=="check_ResidentNO"){
		document.getElementById("check_ResidentNODiv").innerHTML="<b><font color=white>"+check_ResidentNO(document.getElementById("check_ResidentNOTxt1").value,document.getElementById("check_ResidentNOTxt2").value)+"</font></b>";
	}
}


