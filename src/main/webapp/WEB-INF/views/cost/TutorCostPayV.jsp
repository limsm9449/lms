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

function lfn_btn(pKind, pParam) {
	if ( pKind =="refresh" ) {
		gfn_goPage("/cost/tutorCostPayV","courseId=${set.data.courseId}&costId=" + pParam.costId);
	} else if ( pKind =="list" ) {
		gfn_goPage('/cost/tutorCostPayList',top.gCondition.tutorCostPay.param); 
	}
}




</script>

<body>

<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">이익금 지급 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>비용 관리</li>
	          		<li class="last">이익금 지급 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">이익금 지급 상세</h3>
		      	
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
							<th>카테고리</th>
							<td class="no_line"><c:out value="${set.data.categoryName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>과정명</th>
							<td class="no_line"><c:out value="${set.data.courseName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>총 금액</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.totalCost}" type="number"/></td>
						</tr>
						<tr>
							<th>지급 금액</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.tutorCost}" type="number"/></td>
						</tr>
					</tbody>
				</table>
				
		    	<h3 class="title">지급내역</h3>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  						<th width="150"></th>
	  						<th width="250"></th>
  						</tr>
						<tr>
							<th>지급일자</th>
							<th>튜터 금액</th>
							<th>튜터 은행</th>
							<th class="no_line">튜터 계좌번호</th>
						</tr>
					</thead>
					<tbody>	
						<c:forEach var="row" items="${set.payList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><a href="#" onclick="javascript:lfn_btn('refresh',{costId:'${row.costId}'}); return false;" class="click">${row.paymentDate}</a></td>
				              	<td class="right"><fmt:formatNumber value="${row.tutorCost}" type="number"/></td>
				              	<td class="center">${row.tutorBank}</td>
				              	<td class="no_line center">${row.tutorAccNum}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>

		    	<h3 class="title">수강생</h3>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  						<th width="180"></th>
	  						<th width="130"></th>
  						</tr>
						<tr>
					  		<th>수강생</th>
							<th>E-Mail</th>
							<th>Mobile</th>
							<th class="no_line">금액</th>
						</tr>
					</thead>
					<tbody>	
						<c:forEach var="row" items="${set.payRegisterList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td>${row.userName}</td>
				              	<td>${row.email}</td>
				              	<td>${row.mobile}</td>
				              	<td class="no_line right"><fmt:formatNumber value="${row.paymentCost}" type="number"/></td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
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


