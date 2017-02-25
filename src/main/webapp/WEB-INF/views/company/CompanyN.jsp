<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">

var preUrl = "/company/"; 


$(document).ready(function() {
});


function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
	
		if ( confirm("생성하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + preUrl + "companyNIns.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "EXIST") {
						alert("회사코드가 이미 등록되어 있습니다.");
						btnBind("saveBtn");
					} else if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 등록되었습니다.");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		gfn_goPage(preUrl + "companyList",top.gCondition.company.param);
	} else if ( pKind == "userSearch" ) {
		Popup.showUserSearch("companyTutor");
	}
}

function lfn_validate() {
	if ( formValid.check("compCd",{isNecess:true,maxLeng:15}) == false )
		return false;
	if ( formValid.check("compName",{isNecess:true,maxLeng:40}) == false )
		return false;
	if ( formValid.check("compTel",{isNecess:true,maxLeng:14}) == false )
		return false;
	if ( formValid.check("busiessNo",{isNecess:true,maxLeng:15}) == false )
		return false;
	if ( formValid.check("ownerName",{isNecess:true,maxLeng:20}) == false )
		return false;
	if ( formValid.check("tutorId",{isNecess:true,maxLeng:15}) == false )
		return false;
	if ( formValid.check("tutorName",{isNecess:true,maxLeng:20}) == false )
		return false;
	
	return true;
}

function lfn_userInfo(pParam) {
	$("#tutorId").val(pParam.userId);
	$("#tutorName").val(pParam.userName);
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">회사 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>기업 강좌 관리</li>
	          		<li class="last">회사 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">회사 생성</h3>

				<table class="input">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th>회사코드</th>
							<td class="no_line"><input type="text" id="compCd" name="compCd"/></td>
						</tr>
						<tr>
							<th>회사명</th>
							<td class="no_line"><input type="text" id="compName" name="compName"/></td>
						</tr>
						<tr>
							<th>대표자명</th>
							<td class="no_line"><input type="text" id="ownerName" name="ownerName"/></td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td class="no_line"><input type="text" id="businessNo" name="businessNo"/></td>
						</tr>
						<tr>
							<th>회사전화번호</th>
							<td class="no_line"><input type="text" id="compTel" name="compTel"/></td>
						</tr>
						<tr>
							<th>회사팩스번호</th>
							<td><input type="text" id="fax" name="fax"/></td>
						</tr>
						<tr>
							<th>Tutor ID</th>
							<td class="no_line"><input type="text" id="tutorId" name="tutorId" readonly/>&nbsp;&nbsp;<a href="#" onclick="javascript:lfn_btn('userSearch'); return false;" class="blueBtn">담당자 검색</a></td>
						</tr>
						<tr>
							<th>Tutor 이름</th>
							<td class="no_line"><input type="text" id="tutorName" name="tutorName" readonly/></td>
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


