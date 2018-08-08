<%@ page contentType="text/html;charset=utf-8"%>

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

function lfn_btn(pKind, pParam) {
	if ( pKind == "update" ) {
		gfn_goPage("/member/memberU",$("#frm").serialize());
	} else if ( pKind =="resetPwd" ) {
		if ( confirm("패스워드를 초기화 하시겠습니까?") == true ) {
			btnUnbind("resetBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/passwordReset.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "RESET_PASSWORD_OK") {
						alert("정상적으로 초기화 되었습니다.");
						btnBind("resetBtn");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="reJoin" ) {
		if ( confirm("재등록 하시겠습니까?") == true ) {
			btnUnbind("resetBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/reJoin.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "REJOIN_OK") {
						alert("재등록 되었습니다.");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="reCertificationMail" ) {
		if ( confirm("인증메일 재발송을 하시겠습니까?") == true ) {
			btnUnbind("reCertificationMailBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/reCertificationMail.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "OK") {
						alert("재발송 되었습니다.");
						lfn_btn("list");
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

</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="screen" name="screen" value="<c:out value="${set.condiVO.screen}"/>">
	<input type="hidden" id="certificationKey" name="certificationKey" value="<c:out value="${set.data.certificationKey}"/>">
	<input type="hidden" id="userName" name="userName" value="<c:out value="${set.data.userName}"/>">
	<input type="hidden" id="email" name="email" value="<c:out value="${set.data.email}"/>">

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
		    	<h3 class="title">사용자 상세</h3>
		      	
				<table class="view">
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
								<input type="hidden" id="seq" name="seq" value="${set.data.seq}" >
								${set.data.userId}
							</td>
						</tr>
						<tr>
							<th>이름 (국문)</th>
							<td class="no_line">${set.data.userName}</td>
						</tr>
						<tr>
							<th>성별</th>
							<td class="no_line">
								<select id="sex" name="sex" disabled>
									<option value="" <c:if test="${set.data.sex == null }">selected</c:if>></option>
									<option value="M" <c:if test="${set.data.sex eq 'M'}">selected</c:if>>남</option>
									<option value="F" <c:if test="${set.data.sex eq 'F'}">selected</c:if>>여</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td class="no_line">${set.data.birthDay}</td>
						</tr>
						<c:if test="${set.condiVO.screen eq 'admin'}">
							<tr>
								<th>어드민 여부</th>
								<td class="no_line"><c:if test="${set.data.adminYn eq 'N'}">${set.data.adminYn}</c:if><c:if test="${set.data.adminYn ne 'N'}">${set.data.adminYnName}</c:if></td>
							</tr>
							<tr>
								<th>강사 여부</th>
								<td class="no_line">${set.data.teacherYn}</td>
							</tr>
							<tr>
								<th>튜터 여부</th>
								<td class="no_line">${set.data.tutorYn}</td>
							</tr>
						</c:if>
						<tr>
							<th >전화번호</th>
							<td class="no_line">
<c:if test="${set.data.homeTel ne null && set.data.homeTel ne ''}">
								${set.data.homeTel1} - ${set.data.homeTel2} - ${set.data.homeTel3}
</c:if>
							</td>
						</tr>
						<tr>
							<th class="necessary">휴대전화번호</th>
							<td class="no_line">${set.data.mobile1} - ${set.data.mobile2} - ${set.data.mobile3}</td>
						</tr>
						<tr>
							<th class="necessary">이메일주소</th>
							<td class="no_line">${set.data.email}</td>
						</tr>
						<tr>
							<th >주소</th>
							<td class="no_line">
<c:if test="${set.data.homeZip ne null && set.data.homeZip ne ''}">
								${set.data.homeZip1} - ${set.data.homeZip2}
								${set.data.homeAddr1} ${set.data.homeAddr2}
</c:if>
							</td>
						</tr>
						<tr>
							<th >직급</th>
							<td class="no_line">${set.data.jobName}</td>
						</tr>
						<c:if test="${set.condiVO.screen eq 'admin'}">
							<tr>
								<th >탈퇴 사유</th>
								<td class="no_line"><c:out value="${set.data.retiredReason}" escapeXml="" /></td>
							</tr>
						</c:if>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
<c:if test="${set.condiVO.screen eq 'admin' && set.data.retiredYn eq 'Y'}">
					<a href="#" onClick="javascript:lfn_btn('reJoin'); return false;" class="blueBtn">재등록</a>
					<a href="#" id="deleteBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
<c:if test="${set.data.certificationYn eq 'N'}">
					<a href="#" id="reCertificationMailBtn" onClick="javascript:lfn_btn('reCertificationMail'); return false;" class="blueBtn">인증메일 재발송</a>
</c:if>
					<a href="#" id="resetBtn" onClick="javascript:lfn_btn('resetPwd'); return false;" class="blueBtn">패스워드 초기화</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>
	
</body>
</html>


