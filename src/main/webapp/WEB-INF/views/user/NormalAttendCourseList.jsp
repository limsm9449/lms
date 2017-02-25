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
		f_submitSelf("/normalUser/attendCourseList");	
	} else if ( pKind == "view" ) {
		$("#courseId").val(pParam.courseId);
		
		gfn_goPage("/user/studyroom",$("#frm").serialize());
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="">

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
   	 		String menuId = "attendCourseList";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의강의실<span>&gt;</span>수강과정</div>
			<!-- title -->
			<h3 class="tit_big">수강과정</h3>
		      <div class="artcle">
		        <div class="yourinfo_box">
		          <div class="portrait"><img src="/resources/images/sub/img_base_photo.png" alt="your photo" /></div>
		          <div class="your_info">
		            <p class="big_2"><span class="blue">${set.data.userName}</span> 님 큐러닝 나의강의실 방문을 환영 합니다.</p>
		            <dl>
		              <dt>휴대폰 번호</dt><dd>${set.data.mobile}</dd>
		              <dt>이메일</dt><dd>${set.data.email}</dd>
		              <dt>상담현황</dt><dd>${set.data.counselCnt}개</dd>
		            </dl>
		          </div>
		        </div>
		        <div class="study_list_box">
		          <p class="big_2"><span class="blue">나의 강의 리스트</span></p>
		          <p>Start 버튼을 누르시면 학습을 하실 수 있습니다.</p>
		          <table class="high_list">
		            <caption>수강중인 강좌 목록</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th></th>
		    						<th width="115"></th>
		    						<th width="98"></th>
		    						<th width="86"></th>
		    						<th width="84"></th>
		    						<th width="60"></th>
		    						<th width="84"></th>
		    					</tr>
		    					<tr class="t_list">
		    						<th>강의제목</th>
		    						<th>학습기간</th>
		    						<th>남은 학습일</th>
		    						<th>진도율</th>
		    						<th>시험여부</th>
		    						<th>점수</th>
		    						<th>학습시작</th>
		    					</tr>
		  					</thead>
		  					<tbody>
		              <c:if test="${empty set.course}">
							<tr class="last_line"><td colspan="7" class="last center">데이타가 없습니다.</td></tr>
					  </c:if>					
 					  <c:forEach var="row" items="${set.course}" varStatus="idx">
			              <tr <c:if test="${idx.index + 1 eq fn:length(set.course)}"> class="last_line"</c:if>>
			                <td class="title"><nobr><span><a href="javascript:" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'});">${row.courseName}</a></span></nobr></td>
			                <td class="center">${row.cFromDate} ~ ${row.cToDate}</td>
			                <td class="center">${row.remainDay}일</td>
			                <td class="center">${row.progress} %</td>
<c:choose>
	<c:when test="${row.examRate ne '0' && row.progress eq '100' && row.examYn eq 'N'}">
			            	<td class="center"><a href="#" onclick="javascript:Popup.showExam('${row.courseId}')" class="click">${row.examYn}</a></td>
	</c:when>
	<c:otherwise>
	            			<td class="center">${row.examYn}</td>
	</c:otherwise>
</c:choose>		            
			            	<td class="right">${row.total}</td>
			                <td class="center last"><a href="#" onclick="javascript:Popup.showUserCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); lfn_btn('view',{courseId:'${row.courseId}'});"><img src="/resources/images/sub/btn_start.png" alt="학습시작" /></a></td>
			              </tr>
		              </c:forEach>
		            </tbody>
		          </table>
		        </div>
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

