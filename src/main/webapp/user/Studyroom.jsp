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
	if ( pKind == "list" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	} else if ( pKind == "dataList" ) {
		gfn_goPage("/user/studyroomDataList",$("#frm").serialize()); 
	} else if ( pKind == "qnaList" ) {
		gfn_goPage("/user/studyroomQnaList",$("#frm").serialize()); 
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}">

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
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의강의실<span>&gt;</span>수강과정<span>&gt;</span>학습하기</div>
			<!-- title -->
			<h3 class="tit_big">수강과정</h3>
				<div class="artcle">
		        <div class="course_box">
		          <div class="thumbnail"><img src="/cImage/contents/${set.courseInfo.courseCode}/cImg.jpg" alt="course photo" /></div>
		          <div class="course_info">
		            <a href="javascript:" onclick="lfn_btn('list');" class="list"><img src="/resources/images/sub/btn_course_list.png" alt="강좌목록" /></a>
		            <p class="big_3">${set.courseInfo.courseName}</p>
		            <dl>
		              <dt>교 수 명</dt><dd>${set.courseInfo.teacherName}</dd>
		              <dt>강 좌 수</dt><dd>${set.courseInfo.weekCnt}강</dd>
		              <dt>학습기간</dt><dd>${set.courseInfo.cFromDate} ~ ${set.courseInfo.cToDate}</dd>
		              <dt>남은학습일</dt><dd>${set.courseInfo.remainDay}일</dd>
		            </dl>
		          </div>
		        </div>
		        <div class="study_list_box">
		          <ul class="tabs">
		            <li class="active" rel="tab1"><span>강의듣기</span></li>
		            <li rel="tab2"><a href="javascript:" onclick="lfn_btn('dataList');"><span>자료실</span></a></li>
		            <li rel="tab3"><a href="javascript:" onclick="lfn_btn('qnaList');"><span>질문 답변</span></a></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab_1 -->
		            <div id="tab1" class="tab_content" style="display:block;">
		              <p class="big_2"><span class="blue">강의 상세 리스트</span></p>
		              <p>학습을 원하시는 차시의 start 버튼을 누르시면 학습을 하실 수 있습니다.</p>
		              <p>진도율을 누르시면 진도에 대한 상세정보를 보실 수 있습니다.</p>
		              <table class="high_list">
		                <caption>수강중인 강좌 목록</caption>
		      					<thead>
		      					  <tr class="guide">
		        						<th width="42"></th>
		        						<th></th>
		        						<th width="97"></th>
		        						<th width="86"></th>
		        						<th width="64"></th>
		        						<th width="86"></th>
		        					</tr>
		        					<tr class="t_list">
		        						<th>No</th>
		        						<th>강의제목</th>
		        						<th>최초<br />학습일</th>
		        						<th>최종<br />학습일</th>
		        						<th>진도율</th>
		        						<th>학습시작</th>
		        					</tr>
		      					</thead>
		      					<tbody>
						<c:forEach var="row" items="${set.week}" varStatus="idx">
			              <tr <c:if test="${idx.index + 1 eq fn:length(set.week)}"> class="last_line"</c:if>>
			                <td class="center">${row.week}</td>
			                <td class="title">${row.title}</td>
			                <td class="center">${row.studyStart}</td>
			                <td class="center">${row.studyEnd}</td>
			                <td class="center">${row.progressRate} %</td>
			                <td class="center last"><a href="#" onclick="javascript:Popup.showUserCourseWeek('${set.courseInfo.courseId}','${row.week}','${set.courseInfo.hPx + 100}','${set.courseInfo.vPx + 100}')"><img src="/resources/images/sub/btn_start.png" alt="학습시작" /></a></td>
			              </tr>
		              	</c:forEach>		      					
		                </tbody>
		              </table>
		            </div>
		            <!-- end tab_1 -->
		          </div>
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

