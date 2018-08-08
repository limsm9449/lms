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

var preUrl = "/company/"; 

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
		
		f_submitSelf(preUrl + "companyList");	
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "companyN");
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage(preUrl + "companyV","compCd=" + pParam.compCd);
	} else if ( pKind == "userView") {
		gfn_popup("/companyUser/companyUserList","compCd=" + pParam.compCd,900,520);
	}
}

function lfn_setCondition() {
	top.gCondition.company = {
		param : "fCompName=" + $("#fCompName").val() +
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
        		<h1 class="title">회사 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>기업 강좌 관리</li>
	          		<li class="last">회사 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">회사 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">회사명</label>
		              	<input type="text" id="fCompName" name="fCompName" value="<c:out value="${set.condiVO.fCompName}" escapeXml="" />"/>
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="100"></th>
	  						<th></th>
	  						<th width="110"></th>
	  						<th width="150"></th>
	  						<th width="100"></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>회사코드</th>
							<th>회사명</th>
							<th>회사전화번호</th>
							<th>대표자명</th>
							<th>튜터</th>
							<th class="no_line">직원수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="6" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.compCd}</td>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{compCd:'${row.compCd}'}); return false;" class="click">${row.compName}</a></td>
				            	<td class="subject">${row.compTel}</td>
				            	<td class="subject">${row.ownerName}</td>
				            	<td class="subject">${row.tutorName}</td>
				            	<td class="no_line right"><a href="#" onclick="javascript:lfn_btn('userView',{compCd:'${row.compCd}'}); return false;" class="click">${row.empCnt}</a></td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;"class="blueBtn">회사 생성</a>
				</div>
		   	</div>
		</div>
	</div>
</div>

	
</form>


</body>
</html>


