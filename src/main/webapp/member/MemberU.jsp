<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>


</head>

<script type="text/javascript">

<%
Calendar c = Calendar.getInstance();
String year = Integer.toString(c.get(Calendar.YEAR));
%>

$(document).ready(function() {
	$("#birthDay").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%="1950"%>:',
		showMonthAfterYear: true,
		autoSize: false,
		buttonImage: '<c:url value="/resources/datepicker/images/calendar.gif"/>',
		buttonImageOnly: true,
		showOn: "button",
		beforeShow: function(input) {
		   	var i_offset= $(input).offset();
		   	setTimeout(function(){
		      	$('#ui-datepicker-div').css({'top':i_offset.top + 20 + document.body.scrollTop, 'bottom':'', 'left':i_offset.left});      //datepicker의 div의 포지션을 강제로 input 위치에 그리고 좌측은 모바일이여서 작기때문에 무조건 10px에 놓았다.
		   	})
		} 
	});
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/memberUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
	
						lfn_goBack();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		lfn_goBack();
	}
}

function lfn_goBack() {
	if ( "<c:out value="${set.condiVO.screen}"/>" == "compUser" )
		gfn_goPage("/compUser/compUserList",top.gCondition.compUser.param);
	else if ( "<c:out value="${set.condiVO.screen}"/>" == "admin" )
		gfn_goPage("/member/memberList",top.gCondition.member.param);
}

function lfn_validate() {
	if ( formValid.check("userName",{isNecess:true,maxLeng:20}) == false ) return false;
	if ( formValid.check("sex",{isNecess:true}) == false ) return false;
	if ( formValid.check("birthDay",{isNecess:true}) == false ) return false;
	if ( formValid.check("mobile1",{isNecess:true,maxLeng:3}) == false ) return false;
	if ( formValid.check("mobile2",{isNecess:true,maxLeng:4}) == false ) return false;
	if ( formValid.check("mobile3",{isNecess:true,maxLeng:4}) == false ) return false;
	if ( formValid.check("email",{isNecess:true,maxLeng:50,isEmail:true}) == false ) return false;
	if ( formValid.check("homeAddr2",{isNecess:false,maxLeng:40}) == false ) return false;
	
	if ( $("#homeZipcodeSeq").val() == "" ) 
		$("#homeZipcodeSeq").val("0");
	
	return true;
}

</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="screen" name="screen" value="<c:out value="${set.condiVO.screen}"/>">
	<input type="hidden" id="compCd" name="compCd" value="<c:out value="${set.data.compCd}"/>">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
<c:choose>
	<c:when test="${set.condiVO.screen eq 'compUser'}">
        		<h1 class="title">직원 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>직원 관리</li>
	          		<li class="last">직원 관리</li>
        		</ul>	          		
	</c:when>
	<c:otherwise>
        		<h1 class="title">사용자 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>사용자</li>
	          		<li class="last">사용자 관리</li>
        		</ul>
	</c:otherwise>
</c:choose>          		
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">사용자 수정</h3>
		      	
				<table class="input">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr class="bn">
							<th>회원 아이디</th>
							<td class="no_line">
								<input type="hidden" id="userId" name="userId" value="${set.data.userId}" >
								${set.data.userId}
							</td>
						</tr>
						<tr>
							<th>이름 (국문) *</th>
							<td class="no_line"><input type="text" id="userName" name="userName" value="${set.data.userName}"></td>
						</tr>
						<tr>
							<th>성별 *</th>
							<td class="no_line">
								<select id="sex" name="sex">
									<option value="" <c:if test="${set.data.sex eq ''}">selected</c:if>></option>
									<option value="M" <c:if test="${set.data.sex eq 'M'}">selected</c:if>>남</option>
									<option value="F" <c:if test="${set.data.sex eq 'F'}">selected</c:if>>여</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>생년월일 *</th>
							<td class="no_line"><input id="birthDay" name="birthDay" maxlength="10" size="10" style="width:70px" readonly class="datePicker" style="ime-mode:disabled;" value="${set.data.birthDay}"/></td>
						</tr>
						<c:if test="${set.condiVO.screen eq 'my'}">
							<tr>
								<th>비밀번호</th>
								<td class="no_line">
									<a href="#" onClick="javascript:Popup.showPasswordChange();"><img src="<c:url value="/resources/images/btn/btn_pwdModify.gif"/>" alt="확인"></a>
								</td>
							</tr>
						</c:if>
						<tr>
							<th >전화번호</th>
							<td class="no_line">
								<input type="text" id="homeTel" name="homeTel" style="width:120px" maxlength="13" value="${set.data.homeTel}">
							</td>
						</tr>
						<tr>
							<th>휴대전화번호 *</th>
							<td class="no_line">
								<input type="text" id="mobile" name="mobile" style="width:120px" maxlength="13" value="${set.data.mobile}">
							</td>
						</tr>
						<tr>
							<th>이메일주소 *</th>
							<td class="no_line"><input type="text" id="email" name="email" style="width:450px" title="이메일입력" value="${set.data.email}"></td>
						</tr>
						<tr>
							<th >주소</th>
							<td class="no_line">
								<input type="hidden" id="homeZipcodeSeq" name="homeZipcodeSeq" value="${set.data.homeZipcodeSeq}">
								<input type="text" id="homeZip1" name="homeZip1" style="width:60px" maxlength="3" title="우편번호앞자리" readonly value="${set.data.homeZip1}">
								-
								<input type="text" id="homeZip2" name="homeZip2" style="width:60px" maxlength="3" title="우편번호뒷자리" readonly value="${set.data.homeZip2}">
								<a href="#ziplcode" onClick="javascript:f_popup('/ns/getZipcode',{displayName:'zipcode',option:'width=400,height=600'})"><img src="<c:url value="/resources/images/btn/btn_zipcode.gif"/>" alt="우편번호 찾기"></a><br>
								<input type="text" id="homeAddr1" name="homeAddr1" style="width:255px;margin-top:2px" title="주소" readonly value="${set.data.homeAddr1}">
								<input type="text" id="homeAddr2" name="homeAddr2" style="width:255px;margin-top:2px" title="상세주소" value="${set.data.homeAddr2}">
													
							</td>
						</tr>
						<tr>
							<th >직급</th>
							<td class="no_line">
								<select id="job" name="job">
					              	<option value=""></option>
									<c:forEach var="row" items="${set.ddJob}">
						              	<option value="${row.ddKey}" <c:if test="${set.data.job == row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<c:if test="${set.condiVO.screen eq 'admin'}">
							<tr>
								<th>어드민 여부</th>
								<td class="no_line">
									<select id="adminYn" name="adminYn">
										<option value="N" <c:if test="${set.data.adminYn eq 'N'}">selected</c:if>>N</option>
										<option value="A" <c:if test="${set.data.adminYn eq 'A'}">selected</c:if>>Admin</option>
										<option value="C" <c:if test="${set.data.adminYn eq 'C'}">selected</c:if>>Contents Admin</option>
										<option value="M" <c:if test="${set.data.adminYn eq 'M'}">selected</c:if>>Manage Admin</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>강사 여부</th>
								<td class="no_line">
									<select id="teacherYn" name="teacherYn">
										<option value="N" <c:if test="${set.data.teacherYn eq 'N'}">selected</c:if>>N</option>
										<option value="Y" <c:if test="${set.data.teacherYn eq 'Y'}">selected</c:if>>Y</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>튜터 여부</th>
								<td class="no_line">
									<select id="tutorYn" name="tutorYn">
										<option value="N" <c:if test="${set.data.tutorYn eq 'N'}">selected</c:if>>N</option>
										<option value="Y" <c:if test="${set.data.tutorYn eq 'Y'}">selected</c:if>>Y</option>
									</select>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
		  			<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
<c:if test="${set.condiVO.screen ne 'my'}">
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
</c:if>					
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>
	

</body>
</html>

