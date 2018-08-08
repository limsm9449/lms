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

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/cost/tutorCostPayList");	
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/cost/tutorCostPayV","courseId=" + pParam.courseId);
	}
	
}

function lfn_setCondition() {
	top.gCondition.tutorCostPay = {
		param : "courseName=" + $("#courseName").val() +
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
        		<h1 class="title">이익금 지급 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌관리</li>
	          		<li class="last">이익금 지급 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">이익금 지급 관리</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		            	<label for="f_subject">과정명</label>
		             	<input type="text" class="search_input" id="courseName" name="courseName" value="${set.condiVO.courseName}" />
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   				   		
				<%-- 테이블 --%>
		   		<table summary="" >
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="250"></th>
	  						<th width="90"></th>
	  						<th width="60"></th>
	  						<th width="100"></th>
  						</tr>
						<tr>
							<th>카테고리</th>
							<th>과저명</th>
							<th>과정종류</th>
							<th>차수</th>
							<th class="no_line">튜터 금액</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr><td colspan="5" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>	
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject">${row.categoryName}</td>
				              	<td class="subject">${row.courseKindName}</td>
				              	<td class="center">${row.courseName}</td>
				              	<td class="center">${row.chasu}</td>
				              	<td class="no_line right"><a href="#" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class="click"><fmt:formatNumber value="${row.tutorCost}" type="number"/></a></td>
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


