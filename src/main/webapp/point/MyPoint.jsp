<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

function lfn_btn(pKind, pParam) {
	if ( pKind == "list") {
		gfn_goPage("/point/pointUserList",top.gCondition.point.param);
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">Point 내역</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li class="last">Point 내역</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title insertool">Point 내역</h3>
				
				<div class="course_tool">
					잔여 포인트 : ${set.remainPoint}
				</div>
				

				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="220"></th>
	  						<th width="150"></th>
	  						<th width="150"></th>
	  						<th></th>
  						</tr>
						<tr>
							<th>구분</th>
							<th>적립 Point</th>
							<th>사용 Point</th>
							<th class="no_line">일자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.pointList}">
							<tr>
								<td colspan="4" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.pointList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="center">${row.kindName}</td>
				            	<td class="right">${row.inPoint}</td>
				            	<td class="right">${row.outPoint}</td>
				            	<td class="no_line center">${row.createDate}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>



</form>


</body>
</html>


