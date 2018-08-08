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
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

var preUrl = "/compCost/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "compCostApprovalList");	
	}
}

function lfn_setCondition() {
	top.gCondition.costApproval = {
		param : "&courseName=" + $("#courseName").val() +
				"&pageNum=" + $("#pageNum").val()
	}	
}

</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">결재 내역 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>결재 내역 관리</li>
	          		<li class="last">결재 내역 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">리스트</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		            	<label for="f_subject">과정명</label>
		             	<input type="text" class="search_input" id="courseName" name="courseName" value="${set.condiVO.courseName}" onkeydown="lfn_enter()"/>
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="60"></th>
	  						<th width="80"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="100"></th>
	  						<th width="130"></th>
	  						<th width="65"></th>
  						</tr>
						<tr>
							<th>과정명</th>
							<th>총금액</th>
							<th>사용 Point</th>
							<th>결재금액</th>
							<th>결재방법</th>
							<th>결재은행</th>
							<th>결재일자</th>
							<th class="no_line">신청자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="8" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.courseName}</td>
				            	<td class="right"><fmt:formatNumber value="${row.totalCost}" type="number"/></td>
				            	<td class="right"><fmt:formatNumber value="${row.paymentPoint}" type="number"/></td>
				            	<td class="right"><fmt:formatNumber value="${row.paymentCost}" type="number"/></td>
				            	<td class="center">${row.paymentKind}</td>
				            	<td class="center">${row.paymentBank}</td>
				            	<td class="center">${row.paymentDate}</td>
				            	<td class="no_line right">${row.cnt}</td>
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


