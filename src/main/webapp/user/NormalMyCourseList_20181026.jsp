<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>

<script type="text/javascript">
function lfn_btn(pKind, pParam) {
	if ( pKind == "refresh" ) {
		f_submitSelf("/normalUser/myCourseList");	
	}
}



</script>

<body> 

<form name="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value=""/>



<!-- skipnav -->
<div id="skipnav"><a href="#side" class="skip">좌측메뉴 바로가기</a></div>
<div id="skipnav"><a href="#contents" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->

<!-- wrap -->
<div id="wrap" class="site">
  <%@ include file="../home/userTop.jsp" %>
  <hr />
  <!-- container -->
  <div id="container" class="site">
   	 	<!-- side -->
   	 	<%
   	 		String menuId = "myCourseList";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의강의실<span>&gt;</span>수강 완료 과정</div>
			<!-- title -->
			<h3 class="tit_big">수강완료 과정</h3>
		      <div class="artcle">
		        <div class="study_list_box">
		          <p class="big_2"><span class="blue">수강완료 상세 리스트</span></p>
		          <p>수강 완료한 과정목록 입니다.</p>
		          <table class="high_list">
		            <caption>수강완료 상세 목록</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th></th>
		    						<th width="120"></th>
		    						<th width="60"></th>
		    						<th width="50"></th>
		    						<th width="50"></th>
		    						<th width="50"></th>
		    						<th width="100"></th>
		    					</tr>
		    					<tr class="t_list">
		    						<th>강의제목</th>
		    						<th>학습기간</th>
									<th>진도</th>
		    						<th>점수</th>
		    						<th>시험</th>
		    						<th>설문</th>
		    						<th>후기작성</th>
		    					</tr>
		  					</thead>
		  					<tbody>
			              		<c:if test="${empty set.course}">
									<tr class="last_line"><td colspan="7" class="last center">검색된 데이타가 없습니다.</td></tr>
								</c:if>					
								<c:forEach var="row" items="${set.course}" varStatus="idx">
					            	<tr <c:if test="${idx.index + 1 eq fn:length(set.course)}"> class="last_line"</c:if>>
<c:choose>
	<c:when test="${row.mode eq 'C_ING'}">
		            					<td class="title"><nobr><a href="#" onclick="javascript:Popup.showUserCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}')"><span>${row.courseName}</span></nobr></a></td>
	</c:when>
	<c:when test="${row.mode eq 'V_ING'}">
		            					<td class="title"><nobr><a href="#" onclick="javascript:Popup.showReviewCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}')"><span>${row.courseName}</span></nobr></a></td>
	</c:when>
	<c:otherwise>
		            					<td class="title"><nobr><span>${row.courseName}</span></nobr></td>
	</c:otherwise>
</c:choose>		            
<c:choose>
	<c:when test="${row.status eq 'C'}">
					            		<td class="center"><span class="cancel">취소 (${row.cFromDate})</span></td>
	</c:when>
	<c:otherwise>
					            		<td class="center">${row.cFromDate} ~ ${row.cToDate}</td>
	</c:otherwise>
</c:choose>		            
					            		<td class="right">${row.progress} %</td>
				            			<td class="right">${row.total}</td>
<c:choose>
	<c:when test="${row.examRate ne '0' && row.progress eq '100' && row.examYn eq 'N'}">
				            			<td class="center"><a href="#" onclick="javascript:Popup.showExam('${row.courseId}')" class="click">${row.examYn}</a></td>
	</c:when>
	<c:otherwise>
		            					<td class="center">${row.examYn}</td>
	</c:otherwise>
</c:choose>		            
<c:choose>
	<c:when test="${row.questYn eq 'N' && row.progress eq '100'}">
				            			<td class="center"><a href="#" onclick="javascript:Popup.showQuest('${row.courseId}','${row.qgId}')" class="click">${row.questYn}</a></td>
	</c:when>
	<c:otherwise>
		            					<td class="center">${row.questYn}</td>
	</c:otherwise>
</c:choose>		            
<c:choose>
	<c:when test="${row.progress eq '100' && (row.questYn eq 'Y' || row.questYn eq '-') && row.courseEval eq '0'}">
				            			<td class="last center"><a href="#" onclick="javascript:Popup.showPostscriptN('${row.courseId}')" class="click"><img src="/resources/images/sub/btn_review.png" alt="후기작성" /></a></td>	
	</c:when>
	<c:when test="${row.progress eq '100' && row.courseEval ne '0'}">
				            			<td class="last center"><a href="#" onclick="javascript:Popup.showPostscriptV('${row.courseId}')" class="click">${row.courseEval}</a></td>
	</c:when>
	<c:otherwise>
		            					<td class="last center">${row.courseEval}</td>
	</c:otherwise>
</c:choose>		            
		          		  			</tr>
								</c:forEach>
		           		 </tbody>
		          </table>
		        </div>
		        <br />
		      </div>
		</div>
		<!-- end content -->

		
		
	</div>
  <!-- end container -->
  <!-- footer_wrap -->
	<%@ include file="../home/bottom.jsp" %>
  <!-- end footer_wrap -->
</div>


</form>

</body>
</html>

