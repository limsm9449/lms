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
$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/courseExam/courseExamList");	
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage("/courseExam/courseExamN");
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/courseExam/courseExamV","courseCode=" + pParam.courseCode);
	}
	
}

function lfn_setCondition() {
	top.gCondition.courseExam = {
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
	<input id="courseCode" name="courseCode" type="hidden" value=""/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 시험 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 시험 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">과정 시험 관리</h3>
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
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="250"></th>
	  						<th></th>
	  						<th width="75"></th>
	  						<th width="75"></th>
  						</tr>
						<tr>
							<th>카테고리</th>
							<th>과정명</th>
							<th>문제갯수</th>
							<th class="no_line">점수비율</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="4" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
								<td class="subject">${row.categoryName}</td>
<c:choose>
	<c:when test="${row.questionCnt eq 0}">
				              	<td class="subject">${row.courseName}</td>
	</c:when>
	<c:otherwise>
				              	<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{courseCode:'${row.courseCode}'}); return false;" class="click">${row.courseName}</a></td>
	</c:otherwise>
</c:choose>		              	
		        	    	  	<td class="center">${row.questionCnt}</td>
		            	  		<td class="no_line center">${row.examRate} %</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">과정 시험 생성</a>
				</div>
		   	</div>
		</div>
	</div>
</div>


</form>


</body>
</html>



