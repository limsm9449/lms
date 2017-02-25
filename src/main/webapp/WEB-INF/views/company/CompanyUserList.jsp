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

var preUrl = "/companyUser/"; 

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
		
		f_submitSelf(preUrl + "companyUserList");	
	} else if ( pKind == "pwdReset" ) {
		if ( confirm("패스워드를 초기화 하시겠습니까?") == false ) 
			return false;
		
		$("#userId").val(pParam.userId);
		
		$.ajax({
			type :"POST",
			url : context + preUrl + "companyUserPwdReset.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("패스워드가 초기화 되었습니다.");
					lfn_btn("list");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "close") {
		this.close();
	}
}


</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="compCd" name="compCd" type="hidden" value="${set.condiVO.compCd}"/>
	<input id="userId" name="userId" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
			<div id="article">
	      		<div style="height:10px;"></div>
		    	<h3 class="title">회사 직원 관리</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">직원명</label>
		              	<input type="text" id="fUserName" name="fUserName" value="<c:out value="${set.condiVO.fUserName}" escapeXml="" />"/>
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
	  						<th width="90"></th>
	  						<th width="170"></th>
	  						<th width="120"></th>
	  						<th width="120"></th>
	  						<th width="90"></th>
  						</tr>
						<tr>
							<th>사용자ID</th>
							<th>사용자명</th>
							<th>TUTOR 여부</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>휴대폰번호</th>
							<th class="no_line">Password</th>
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
				            	<td class="subject">${row.userId}</td>
				            	<td class="subject">${row.userName}</td>
				            	<td class="subject">${row.tutorYn}</td>
				            	<td class="subject">${row.email}</td>
				            	<td class="subject">${row.tel}</td>
				            	<td class="subject">${row.mobile}</td>
				            	<td class="no_line right"><a href="#" onclick="javascript:lfn_btn('pwdReset',{userId:'${row.userId}'}); return false;">초기화</a></td>
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


