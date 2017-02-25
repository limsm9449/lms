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
		gfn_goPage('/courseExam/courseExamU',"courseCode=" +$("#courseCode").val()); 
	} else if ( pKind =="list" ) {
		gfn_goPage('/courseExam/courseExamList',top.gCondition.courseExam.param); 
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
        		<h1 class="title">과정 시험 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 시험 관리</li>
        		</ul>
			</div>

		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">과정 시험 상세 ( <c:out value="${set.data.courseName}" escapeXml="" /> )</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="50"></th>
	  						<th></th>
	  						<th width="100"></th>
	  						<th width="60"></th>
  						</tr>
						<tr>
							<th>순번</th>
							<th>질문</th>
							<th>답</th>
							<th class="no_line">점수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.examList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="center"><c:out value="${row.seq}" escapeXml="" /></td>
				              	<td class="subject">
				              		<c:out value="${row.question}" escapeXml="" /> 
				              		<c:if test="${row.type eq 'G'}">
				              			 =>1.<c:out value="${row.qa1}" escapeXml="" />,&nbsp;
				              			2.<c:out value="${row.qa2}" escapeXml="" />,&nbsp;
				              			3.<c:out value="${row.qa3}" escapeXml="" />,&nbsp;
				              			4.<c:out value="${row.qa4}" escapeXml="" />
				              		</c:if>
				              	</td>
				              	<td class="center"><c:out value="${row.answer}" escapeXml="" /></td>
				              	<td class="no_line center"><c:out value="${row.grade}" escapeXml="" /></td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
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


