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

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/user/studyroomDataList");
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/user/studyroomDataV",$("#frm").serialize());
	} else if ( pKind == "list" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	} else if ( pKind == "weekList" ) {
		gfn_goPage("/user/studyroom",$("#frm").serialize()); 
	} else if ( pKind == "qnaList" ) {
		gfn_goPage("/user/studyroomQnaList",$("#frm").serialize()); 
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="seq" name="seq" type="hidden" value="">
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
		            <li rel="tab1"><a href="javascript:" onclick="lfn_btn('weekList');"><span>강의듣기</span></a></li>
		            <li class="active" rel="tab2"><span>자료실</span></li>
		            <li rel="tab3"><a href="javascript:" onclick="lfn_btn('qnaList');"><span>질문 답변</span></a></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab_2 -->
		            <div id="tab2" class="tab_content" style="display:block;">
		              <p>학습관련 자료를 조회하는 공간 입니다.</p>
		              <div id="bod_search_r">
		                <form class="search_forum" action="" method="get">
		                  <input type="text" class="search_input" id="findString" name="findString" value="${set.condiVO.findString}" />
		                  <a href="javascript:" onclick="lfn_btn('search');"><img src="/resources/images/sub/btn_search.png" alt="검색하기" /></a>
		                </form>
		              </div>
		              <table class="bod_list">
		                <caption>자료 목록</caption>
		      					<thead>
		      					  <tr class="guide">
		        						<th width="42"></th>
		        						<th></th>
		        						<th width="52"></th>
		        						<th width="52"></th>
		        						<th width="104"></th>
		        					</tr>
		        					<tr class="t_list">
		        						<th>No</th>
		        						<th>제목</th>
		        						<th>조회</th>
		        						<th>첨부</th>
		        						<th>등록일</th>
		        					</tr>
		      					</thead>
		      					<tbody>
							<c:forEach var="row" items="${set.boardDataList}" varStatus="idx">
				              <tr <c:if test="${idx.index + 1 eq fn:length(set.boardDataList)}"> class="last_line"</c:if>>
				                <td class="center">${row.rownum}</td>
				                <td class="title"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click">${row.title}</a></span></td>
				                <td class="center">${row.viewCnt}</td>
				                <td class="center">${row.fileYn}</td>
				                <td class="center last">${row.createDate}</td>
				              </tr>
			              	</c:forEach>		      					
		                </tbody>
		              </table>
		              	<%-- 페이징 --%>
						<div id="paging"></div>
		            </div>
		            <!-- end tab_2 -->

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

