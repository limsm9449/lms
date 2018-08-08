<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
		
		f_submitSelf("/postscript/postscriptList");	
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/postscript/postscriptUserList","courseId=" + pParam.courseId);
	}
}

function lfn_setCondition() {
	top.gCondition.postscript = {
		param : "c1Code=" + $("#c1Code").val() + 
				"&c2Code=" + $("#c2Code").val() + 
				"&c3Code=" + $("#c3Code").val() +
				"&courseName=" + $("#courseName").val() +
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
        		<h1 class="title">수강후기 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>수강후기 관리</li>
	          		<li class="last">수강후기 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">리스트</h3>
		    	
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">카테고리</label>
		              	<select id="c1Code" name="c1Code" onchange="gfn_category1Change()">
			              	<option value="">전체</option>
							<c:forEach var="row" items="${set.ddCategory1Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c1Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c2Code" name="c2Code" onchange="gfn_category2Change()">
			              	<option value="">전체</option>
			              	<c:forEach var="row" items="${set.ddCategory2Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c2Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c3Code" name="c3Code">
			             	<option value="" selected>전체</option>
			             	<c:forEach var="row" items="${set.ddCategory3Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c3Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
		            </div>
		        	<div class="search_2">
		            	<label for="f_subject">과정명</label>
		             	<input type="text" class="search_input" id="courseName" name="courseName" value="${set.condiVO.courseName}" />
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<p class="count">${set.totalCount} 건</span></p>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="200"></th>
	  						<th width="77"></th>
	  						<th></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
	  						<th width="50"></th>
  						</tr>
						<tr>
							<th>카테고리</th>
							<th>과정코드</th>
							<th>과정명</th>
							<th>2</th>
							<th>4</th>
							<th>6</th>
							<th>8</th>
							<th>10</th>
							<th class="no_line">평균</th>
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
								<td class="subject">${row.categoryName}</td>
								<td class="subject">${row.courseCode}</td>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class="click">${row.courseName}</a></td>
				            	<td class="center">${row.evalCnt2}</td>
				            	<td class="center">${row.evalCnt4}</td>
				            	<td class="center">${row.evalCnt6}</td>
				            	<td class="center">${row.evalCnt8}</td>
				            	<td class="center">${row.evalCnt10}</td>
				            	<td class="no_line center"><fmt:formatNumber value="${row.evalAvg}" type="number"/></td>
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


