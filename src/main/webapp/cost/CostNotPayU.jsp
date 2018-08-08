<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    $("#allChk").prop("checked", "checked");
	gfn_allChk('allChk','userIds');
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="payment" ) {
		if ( lfn_validate() == false )
			return false;

		<%-- 금액 확인후에 저장을 수행한다. --%>
		$.ajax({
			type :"POST",
			url : context +"/cost/costCheck.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( confirm("전체 금액 : " + json.paymentCost + 
								"\n\n회사 금액 : " + json.companyCost + 
								"\n\n강사 금액 : " + json.teacherCost + 
								"\n강사 은행 : " + json.teacherBank + 
								"\n강사 계좌번호 : " + json.teacherAccNum + 
								"\n\n튜터 금액 : " + json.tutorCost + 
								"\n튜터 은행 : " + json.tutorBank + 
								"\n튜터 계좌번호 : " + json.tutorAccNum +
								"\n\n\n입금처리를 하시겠습니까?") == false ) {
					return;
				}
				
				btnUnbind("saveBtn");
				$.ajax({
					type :"POST",
					url : context +"/cost/costNotPayUUpd.do",
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
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="list" ) {
		gfn_goPage('/cost/costNotPayList',top.gCondition.costNotPay.param); 
	}
}

function lfn_validate() {
	var isCheck = false;
	$("[id=userIds]").each(function() {
     	if ( $(this).is(":checked") ) {
	    	isCheck = true;
	   	}
	});
	if ( isCheck == false ) {
		alert("선택한 대상자가 없습니다.");
		return false;
	}
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.data.courseId}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">이익금 미지급 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>비용 관리</li>
	          		<li class="last">이익금 미지급 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">이익금 미지급금 지급</h3>
		      	
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
							<td class="subject no_line"><c:out value="${set.data.categoryName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th><spring:message code="lms.label.courseName" text="-" /></th>
							<td class="subject no_line"><c:out value="${set.data.courseName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>총 금액</th>
							<td class="subject no_line"><fmt:formatNumber value="${set.data.paymentCost}" type="number"/></td>
						</tr>
						<tr>
							<th>미지급 금액</th>
							<td class="subject no_line"><fmt:formatNumber value="${set.data.notPaymentCost}" type="number"/></td>
						</tr>
					</tbody>
				</table>
				
		    	<h3 class="title">대상자</h3>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="90"></th>
	  						<th></th>
	  						<th width="180"></th>
	  						<th width="130"></th>
	  						<th width="90"></th>
  						</tr>
						<tr>
							<th><input id="allChk" name="allChk" type="checkbox" onclick="gfn_allChk('allChk','userIds')"/></th>
							<th>수강생</th>
							<th>E-Mail</th>
							<th>Mobile</th>
							<th class="no_line">금액</th>
						</tr>
					</thead>
					<tbody>			
						<c:forEach var="row" items="${set.registerList}" varStatus="idx">
				            <tr>
				              	<td class="center"><input type="checkbox" id="userIds" name="userIds" value="${row.userId}" onclick="gfn_chk('allChk','userIds')"/></td>
				              	<td class="subject">${row.userName}</td>
				              	<td class="subject">${row.email}</td>
				              	<td class="subject">${row.mobile}</td>
				              	<td class="no_line right"><fmt:formatNumber value="${row.courseCost}" type="number"/></td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
		  			<a href="#" id="saveBtn" onclick="javascript:lfn_btn('payment'); return false;" class="blueBtn">이익금 지급</a>
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


