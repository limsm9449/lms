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

$(document).ready(function() {
	$("textarea[name='career']").cleditor({height:450});
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/teacherUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
	
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		gfn_goPage("/member/teacherList",top.gCondition.teacher.param);
	}
}

function lfn_validate() {
	
	if ($("textarea[name='career']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( formValid.check("title",{maxLeng:200}) == false )
		return false;
	if ( checkByte($("textarea[name='career']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='career']").val()) + ")");
		$("textarea[name='career']").Focus();
		return false;
	}	
	
	
	return true;
}

</script>

<body>


<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">강사 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>사용자</li>
	          		<li class="last">강사 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">강사 수정</h3>
		      	
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
						<tr>
							<th class="necessary">휴대전화번호</th>
							<td class="no_line">${set.data.mobile1} - ${set.data.mobile2} - ${set.data.mobile3}</td>
						</tr>
						<tr>
							<th class="necessary">이메일주소</th>
							<td class="no_line">${set.data.email}</td>
						</tr>
						<tr>
							<th class="necessary">경력</th>
							<td class="no_line">
								<textarea id="career" name="career">${set.data.career}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
		  			<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
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

