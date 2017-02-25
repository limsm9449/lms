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
	if ( pKind == "list" ) {
		gfn_goPage("/normalUser/attendCourseList",""); 
	} else if ( pKind == "weekList" ) {
		gfn_goPage("/user/studyroom",$("#frm").serialize()); 
	} else if ( pKind == "dataList" ) {
		gfn_goPage("/user/studyroomDataList",$("#frm").serialize()); 
	} else if ( pKind == "qnaList" ) {
		gfn_goPage("/user/studyroomQnaList",$("#frm").serialize()); 
	} else if ( pKind == "update" ) {
		gfn_goPage("/user/studyroomQnaU",$("#frm").serialize());
	} else if ( pKind == "delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + "/user/studyroomQnaDel.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					lfn_btn("qnaList");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "answerN" ) {
		gfn_goPage("/user/studyroomQnaAnswerN",$("#frm").serialize());
	} else if ( pKind == "answerU" ) {
		$("#answerSeq").val(pParam.seq);
		gfn_goPage("/user/studyroomQnaAnswerU",$("#frm").serialize());
	} else if ( pKind == "answerDelete" ) {
		$("#answerSeq").val(pParam.seq);

		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		$.ajax({
			type :"POST",
			url : context + "/user/studyroomQnaAnswerDel.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "refresh") {
		gfn_goPage("/user/studyroomQnaV",$("#frm").serialize());
	} 
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}">
<input id="pageNum" name="pageNum" type="hidden" value="${set.condiVO.pageNum}">
<input id="findString" name="findString" type="hidden" value="${set.condiVO.findString}">
<input id="seq" name="seq" type="hidden" value="${set.condiVO.seq}">
<input id="answerSeq" name="answerSeq" type="hidden" value="">

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
		            <li rel="tab2"><a href="javascript:" onclick="lfn_btn('dataList');"><span>자료실</span></a></li>
		            <li class="active" rel="tab3"><span>질문 답변</span></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab_2 -->
		            <div id="tab2" class="tab_content" style="display:block;">
		              <p>학습진행 중 궁금한 사항을 질문하는 공간 입니다.</p>
		              <div id="bod_search_r">
		                <a href="javascript:" onclick="lfn_btn('qnaList');"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		              </div>
		              <div id="bodview_box">
		                <div class="title">${set.boardQna.title}</div>
		                <div class="tool_box">
		                  <dl>
		                    <dt>조회</dt>
		                    <dd>${set.boardQna.viewCnt}</dd>
		                    <dt class="date">등록일</dt>
		                    <dd>${set.boardQna.createDate}</dd>
		                    <dd class="btn"><a href="#" onclick="javascript:lfn_btn('update');">수정</a></dd>
		                    <dd class="btn"><a id="saveBtn" href="#" onclick="javascript:lfn_btn('delete');">삭제</a></dd>
		                    <dd class="btn"><a href="#" onclick="javascript:lfn_btn('answerN');">답변</a></dd>
		                  </dl>
		                </div>
		                <div class="text">${set.boardQna.contents}</div>
		              </div>
<c:forEach var="row" items="${set.answerList}" varStatus="idx">
		              <div id="bodview_box" class="replay">
		                <div class="title">답변</div>
		                <div class="tool_box">
		                  <dl>
		                    <dt>작성자</dt>
		                    <dd>${row.userName}</dd>
		                    <dt class="date">등록일</dt>
		                    <dd>${row.createDate}</dd>
<c:if test="${set.condiVO.userId eq row.userId}">
		                    <dd class="btn"><a href="javascript:" onclick="lfn_btn('answerU',{seq:'${row.seq}'});">수정</a></dd>
		                    <dd class="btn"><a href="javascript:" onclick="lfn_btn('answerDelete',{seq:'${row.seq}'});">삭제</a></dd>
</c:if>
		                  </dl>
		                </div>
		                <div class="text">${row.contents}</div>
              		  </div>
</c:forEach>			                  
		              
		              <div id="bod_search_r">
		                <a href="javascript:" onclick="lfn_btn('qnaList');"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		              </div>
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


<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>

