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
var preUrl = "/compCourseReg/"; 

$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "compCourseRegList");	
	} else if ( pKind == "register") {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "compCourseRegU","courseId=" + pParam.courseId);
	}
}

function lfn_setCondition() {
	top.gCondition.compCourseReg = {
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
        		<h1 class="title">강좌 신청 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">강좌 신청 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">강좌 신청 관리</h3>

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
	  						<th width="100"></th>
	  						<th width="40"></th>
	  						<th width="70"></th>
	  						<th width="60"></th>
	  						<th width="50"></th>
	  						<th width="80"></th>
	  						<th width="40"></th>
	  						<th width="65"></th>
  						</tr>
						<tr>
							<th>과정명</th>
							<th>담당자</th>
							<th>차수</th>
							<th>오픈여부</th>
							<th>학습기간</th>
							<th>미승인</th>
							<th>미승인 비용</th>
							<th>승인</th>
							<th class="no_line">승인 비용</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="9" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('register',{courseId:'${row.courseId}'}); return false;" class="click">${row.courseName}</a></td>
				            	<td class="subject">${row.tutorName}</td>
				            	<td class="center">${row.chasu}</td>
				            	<td class="center">${row.openYn}</td>
				            	<td class="right">${row.cPeriod}</td>
				            	<td class="right">${row.yCnt}</td>
				            	<td class="right"><fmt:formatNumber value="${row.yCourseCost}" type="number"/></td>
				            	<td class="right">${row.aCnt}</td>
				            	<td class="no_line right"><fmt:formatNumber value="${row.aCourseCost}" type="number"/></td>
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


