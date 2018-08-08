<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">

var preUrl = "/company/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "update" ) {
		f_submitSelf(preUrl + "companyU",$("#courseId").val());
	} else if ( pKind =="delete" ) {
		btnUnbind("delBtn");
		$.ajax({
			type :"POST",
			url : context +preUrl + "companyDel.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					alert("<spring:message code="lms.msg.deleteOk" text="-" />");
					lfn_btn("list");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "list") {
		gfn_goPage(preUrl + "companyList",top.gCondition.company.param);
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">

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
		    	<h3 class="title">회사 상세</h3>

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
							<th>회사코드</th>
							<td class="no_line"><input id="compCd" name="compCd" type="hidden" value="${set.data.compCd}"/><c:out value="${set.data.compCd}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>회사명</th>
							<td class="no_line"><c:out value="${set.data.compName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>대표자명</th>
							<td class="no_line"><c:out value="${set.data.ownerName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td class="no_line"><c:out value="${set.data.businessNo}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>회사전화번호</th>
							<td class="no_line"><c:out value="${set.data.compTel}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>회사팩스번호</th>
							<td class="no_line"><c:out value="${set.data.fax}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>Tutor ID</th>
							<td class="no_line"><c:out value="${set.data.tutorId}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>Tutor 이름</th>
							<td class="no_line"><c:out value="${set.data.tutorName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>Tutor Email</th>
							<td class="no_line"><c:out value="${set.data.tutorEmail}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>Tutor 전화번호</th>
							<td class="no_line"><c:out value="${set.data.tutorTel}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>Tutor 핸드폰</th>
							<td class="no_line"><c:out value="${set.data.tutorMobile}" escapeXml="" /></td>
						</tr>
					</tbody>
				</table>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
<c:if test="${set.data.cnt eq 0}">
					<a href="#" id="delBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">삭제</a>
</c:if>
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


