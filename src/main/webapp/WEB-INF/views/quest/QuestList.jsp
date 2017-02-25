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
		
		f_submitSelf("/quest/questList");	
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage("/quest/questN");
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/quest/questV","qgId=" + pParam.qgId);
	}
	
}

function lfn_setCondition() {
	top.gCondition.quest = {
		param : "groupName=" + $("#groupName").val() + 
				"&useYn=" + $("#useYn").val() +
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
        		<h1 class="title">설문지 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>설문관리</li>
	          		<li class="last">설문지 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">리스트</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">설문지 그룹명</label>
		             	<input type="text" class="search_input" id="groupName" name="groupName" value="${set.condiVO.groupName}" />
		            </div>
		        	<div class="search_2">
		            	<label for="f_subject">사용여부</label>
						<select id="useYn" name="useYn">
			             	<option value="" selected>전체</option>
			             	<option value="Y" <c:if test="${set.condiVO.useYn eq 'Y'}">selected</c:if>>사용</option>
			             	<option value="N" <c:if test="${set.condiVO.useYn eq 'N'}">selected</c:if>>미사용</option>
						</select>
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<p class="count">${set.totalCount} 건</span></p>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="130"></th>
  						</tr>
						<tr>
							<th>설문지 그룹명</th>
							<th>사용여부</th>
							<th>항목수</th>
							<th class="no_line">생성일자</th>
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
<c:choose>
	<c:when test="${row.cnt eq 0}">
								<td class="subject">${row.groupName}</td>
	</c:when>
	<c:otherwise>
								<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{qgId:'${row.qgId}'}); return false;" class="click">${row.groupName}</a></td>
	</c:otherwise>
</c:choose>
								<td class="center">${row.useYn}</td>
								<td class="center">${row.cnt}</td>
								<td class="no_line center">${row.createDate}</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">설문지 생성</a>
				</div>
		   	</div>
		</div>
	</div>
</div>		   		
        	
</form>

</body>
</html>


