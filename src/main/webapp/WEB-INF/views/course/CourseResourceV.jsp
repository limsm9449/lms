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
function lfn_btn(pKind, pParam) {
	if ( pKind =="update" ) {
		gfn_goPage('/courseResource/courseResourceU',"courseCode=" +$("#courseCode").val()); 
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseResource/courseResourceList',top.gCondition.courseResource.param); 
	}
}

</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseCode" name="courseCode" value="${set.data.courseCode}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 주차 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 주차 관리</li>
        		</ul>
			</div>

		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">과정 주차 상세 ( <c:out value="${set.data.courseName}" escapeXml="" /> )</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="50"></th>
	  						<th></th>
	  						<th width="50"></th>
	  						<th width="60"></th>
	  						<th width="60"></th>
  						</tr>
						<tr>
							<th>주차</th>
							<th>목차</th>
							<th>경로</th>
							<th>페이지</th>
							<th class="no_line">미리보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.week}" escapeXml="" /></td>
				              	<td class="subject"><a href="#" onclick="javascript:Popup.showViewContents('${set.data.courseCode}',${row.week},'${set.data.hPx + 100}','${set.data.vPx + 100}'); return false;" class="click"><c:out value="${row.title}" escapeXml="" /></a></td>
				              	<td class="center"><c:out value="${row.directory}" escapeXml="" /></td>
				              	<td class="center"><c:out value="${row.pageCnt}" escapeXml="" /></td>
				              	<td class="no_line center"><c:out value="${row.previewPage}" escapeXml="" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
					<a href="#" onclick="javascript:Popup.showViewContents('${set.data.courseCode}',1,'${set.data.hPx + 100}','${set.data.vPx + 100}'); return false;" class="blueBtn">과정보기</a>		  		
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

	
</form>

</body>
</html>


