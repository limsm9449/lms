<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

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
<%
Calendar c = Calendar.getInstance();
String year = Integer.toString(c.get(Calendar.YEAR) - 10);
%>

$(document).ready(function() {
	$("#fDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+10',
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
	$("#tDate").datepicker({ 
		changeMonth: true,
		changeYear: true,
		yearRange:'<%=year%>:+10',
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
	
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

var preUrl = "/cost/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "costRefundList");	
	} else if ( pKind == "view" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "costRefundV","approvalId="+pParam.approvalId);
	}
}

function lfn_setCondition() {
	top.gCondition.costRefund = {
		param : "&pageNum=" + $("#pageNum").val()
	}	
}

</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">환불 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>입금 관리</li>
	          		<li class="last">환불 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">환불 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">일자</label>
		              	<input id="fDate" name="fDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.condiVO.fDate}" escapeXml="" />"/> ~ 
		              	<input id="tDate" name="tDate" maxlength="10" size="10" class="datePicker" style="ime-mode:disabled;" value="<c:out value="${set.condiVO.tDate}" escapeXml="" />"/>
		            </div>
		        	<div class="search_2">
		              	<label for="c1Code">신청자</label>
		              	<input type="text" id="userName" name="userName" value="<c:out value="${set.condiVO.userName}" escapeXml="" />"/>
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="110"></th>
	  						<th width="110"></th>
	  						<th width="110"></th>
	  						<th width="110"></th>
	  						<th width="110"></th>
	  						<th width="130"></th>
  						</tr>
						<tr>
							<th>신청자명</th>
							<th>구분</th>
							<th>총금액</th>
							<th>사용 Point</th>
							<th>결재금액</th>
							<th>환불금액</th>
							<th class="no_line">환불일자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="7" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.userName}</td>
				            	<td class="subject">${row.kindName}</td>
				            	<td class="right"><fmt:formatNumber value="${row.totalCost}" type="number"/></td>
				            	<td class="right"><fmt:formatNumber value="${row.paymentPoint}" type="number"/></td>
				            	<td class="right"><a href="#" onclick="javascript:lfn_btn('view',{approvalId:'${row.approvalId}'}); return false;" class="click"><fmt:formatNumber value="${row.paymentCost}" type="number"/></a></td>
				            	<td class="right"><fmt:formatNumber value="${row.refundCost}" type="number"/></td>
				            	<td class="no_line center">${row.refundDate}</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
				</div>
		   	</div>
		</div>
	</div>
</div>

</form>

</body>
</html>


