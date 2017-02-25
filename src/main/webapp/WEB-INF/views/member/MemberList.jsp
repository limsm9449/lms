<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

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
		
		gfn_goPage("/member/memberList",$("#frm").serialize());	
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage("/member/memberN","screen=admin&compCd=");
	} else if ( pKind == "view") {
		lfn_setCondition();

		gfn_goPage("/member/memberV","screen=admin&userId=" + pParam.userId);
	}
}

function lfn_setCondition() {
	top.gCondition.member = {
		param : "searchKind=" + $("#searchKind").val() +
				"&searchStr=" + $("#searchStr").val() +
				"&userKind=" + $("#userKind").val() +
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
        		<h1 class="title">사용자 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>사용자</li>
	          		<li class="last">사용자 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">사용자 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">검색</label>
		              	<select id="searchKind" name="searchKind">
			              	<option value="USER_ID" <c:if test="${set.condiVO.searchKind eq '' || set.condiVO.searchKind eq 'USER_ID'}">selected</c:if>>사용자 ID</option>
			              	<option value="USER_NAME" <c:if test="${set.condiVO.searchKind eq 'USER_NAME'}">selected</c:if>>사용자명</option>
			              	<option value="EMAIL" <c:if test="${set.condiVO.searchKind eq 'EMAIL'}">selected</c:if>>이메일</option>
			              	<option value="MOBILE" <c:if test="${set.condiVO.searchKind eq 'MOBILE'}">selected</c:if>>핸드폰</option>
						</select>
						<input type="text" id="searchStr" name="searchStr" value="<c:out value="${set.condiVO.searchStr}"/>">
		            </div>
		        	<div class="search_2">
		            	<label for="f_subject">사용자 유형</label>
		             	<select id="userKind" name="userKind">
							<option value="">전체</option>
							<c:forEach var="row" items="${set.ddUserKind}">
				              	<option value="${row.ddKey}"<c:if test="${set.condiVO.userKind == row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="90"></th>
	  						<th width="100"></th>
	  						<th width="120"></th>
	  						<th width="40"></th>
	  						<th width="40"></th>
	  						<th></th>
	  						<th width="100"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>어드민</th>
							<th>강사</th>
							<th>튜터</th>
							<th>이메일</th>
							<th>핸드폰</th>
							<th>인증여부</th>
							<th>탈퇴여부</th>
							<th class="no_line">가입일</th>							
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr><td colspan="10" class="no_line center">검색된 데이타가 없습니다.</td></tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="subject">${row.userId}</td>
				              	<td class="center"><span><a href="#" onClick="javascript:lfn_btn('view',{userId:'${row.userId}'}); return false;" class="click">${row.userName}</a></span></td>
				              	<td class="center"><c:if test="${row.adminYn eq 'N'}">${row.adminYn}</c:if><c:if test="${row.adminYn ne 'N'}">${row.adminYnName}</c:if></td>
				              	<td class="center">${row.teacherYn}</td>
				              	<td class="center">${row.tutorYn}</td>
				              	<td class="subject">${row.email}</td>
				              	<td class="subject">${row.mobile}</td>
				              	<td class="center">${row.certificationYnName}</td>
				              	<td class="center">${row.retiredYn}</td>
				              	<td class="no_line center">${row.createDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%-- 페이징 --%>
				<div id="paging"></div>
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">사용자 생성</a>
					<a href="#" onClick="javascript:f_submitSelf('/member/memberList',{urlParams:'isExcel=Y'}); return false;" class="blueBtn">엑셀출력</a>
				</div>
		   	</div>
		</div>
	</div>
</div>	


</form>


</body>
</html>

