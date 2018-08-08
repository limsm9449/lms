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

var preUrl = "/cost/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf(preUrl + "costBankList");	
	} else if ( pKind == "confirm" ) {
		if ( confirm("입금확인을 하시겠습니까?") == false )
			return;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context +"/cost/costBankUpd.do",
			dataType :"json",
			data : "approvalId=" + pParam.approvalId,
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("입금 확인처리 되었습니다.");
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}


</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">은행입금 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>입금 관리</li>
	          		<li class="last">은행입금 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">은행입금 관리</h3>
		       	<div id="search">
		      		<div class="search_1">
		              	<label for="c1Code">신청자</label>
		              	<input type="text" id="userName" name="userName" value="<c:out value="${set.condiVO.userName}" escapeXml="" />"/>
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
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="100"></th>
	  						<th width="90"></th>
	  						<th width="160"></th>
	  						<th width="80"></th>
  						</tr>
						<tr>
							<th>신청자명</th>
							<th>구분</th>
							<th>총금액</th>
							<th>사용 Point</th>
							<th>결재금액</th>
							<th>결재방법</th>
							<th>결재은행</th>
							<th class="no_line">입금확인</th>
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
				            	<td class="subject">${row.userName}</td>
				            	<td class="subject">${row.kindName}</td>
				            	<td class="right"><fmt:formatNumber value="${row.totalCost}" type="number"/></td>
				            	<td class="right"><fmt:formatNumber value="${row.paymentPoint}" type="number"/></td>
				            	<td class="right"><fmt:formatNumber value="${row.paymentCost}" type="number"/></td>
				            	<td class="center">${row.paymentKindName}</td>
				            	<td class="center">${row.paymentBank}</td>
<c:choose>
	<c:when test="${row.status eq 'C'}">
            					<td class="no_line center"><nobr><span style="color:red">취소</span></nobr></td>
	</c:when>
	<c:otherwise>
				            	<td class="no_line center"><a href="#" id="saveBtn" onclick="javascript:lfn_btn('confirm',{approvalId:'${row.approvalId}'}); return false;" class="blueBtn">입금확인</a></td>
	</c:otherwise>
</c:choose>
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


