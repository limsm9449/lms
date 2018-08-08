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
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/cost/costRateUUpd.do",
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
	} else if ( pKind =="list" ) {
		gfn_goPage('/cost/costRateList',top.gCondition.costRate.param); 
	}
}

function lfn_validate() {
	if ( formValid.check("companyRate",{isNecess:true,isNum:true,maxLeng:3}) == false )
		return false;
	if ( formValid.check("teacherRate",{isNecess:true,isNum:true,maxLeng:3}) == false )
		return false;
	if ( formValid.check("tutorRate",{isNecess:true,isNum:true,maxLeng:3}) == false )
		return false;
	
	if ( parseInt($("#companyRate").val()) + parseInt($("#teacherRate").val()) + parseInt($("#tutorRate").val()) != 100 ) {
		alert("비율은 100%가 되어야 합니다.");
		$("#companyRate").select();
		return false;
	}
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseCode" name="courseCode" value="${set.data.courseCode}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">분배 비율 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>비용 관리</li>
	          		<li class="last">분배 비율 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">분배 비율 수정</h3>
		      	
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th><spring:message code="lms.label.category" text="-" /></th>
							<td class="no_line"><c:out value="${set.data.categoryName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="no_line"><c:out value="${set.data.courseName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>회사 비율</th>
							<td class="no_line"><input id="companyRate" name="companyRate" value="${set.data.companyRate}"/></td>
						</tr>
						<tr>
							<th>강사 비율</th>
							<td class="no_line"><input id="teacherRate" name="teacherRate" value="${set.data.teacherRate}"/></td>
						</tr>
						<tr>
							<th>Tutor 비율</th>
							<td class="no_line"><input id="tutorRate" name="tutorRate" value="${set.data.tutorRate}"/></td>
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


