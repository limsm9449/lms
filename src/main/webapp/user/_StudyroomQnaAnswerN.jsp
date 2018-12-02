<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor/jquery.cleditor.css"/>" />
<script type="text/javascript" src="<c:url value="/resources/CLEditor/jquery.cleditor.min.js"/>"></script>


</head>

<script type="text/javascript">

$(document).ready(function() {
	$("textarea[name='contents']").cleditor({height:450});
	$("textarea[name='contents']").val("");
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
	} else if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + "/user/studyroomQnaAnswerIns.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "INSERT_OK") {
					lfn_btn("qnaList");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_validate() {
	if ($("textarea[name='contents']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( formValid.check("title",{maxLeng:200}) == false )
		return false;
	if ( checkByte($("textarea[name='contents']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='contents']").val()) + ")");
		$("textarea[name='contents']").Focus();
		return false;
	}	
	
	return true;
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}">
<input id="pageNum" name="pageNum" type="hidden" value="${set.condiVO.pageNum}">
<input id="findString" name="findString" type="hidden" value="${set.condiVO.findString}">
<input id="seq" name="seq" type="hidden" value="${set.condiVO.seq}">

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
		            <!-- tab_3 -->
		            <div id="tab3" class="tab_content" style="display:block;">
		              <p class="big_2"><span class="blue">답변하기</span></p>
		              <div id="bod_search_r">
		                <a href="javascript:" onclick="lfn_btn('qnaList');"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		              </div>
		              <div id="bodinput_box">
		                <form name="frm" method="post">
		                <table>
		                  <caption>답변 폼</caption>
		        					<thead>
		        					  <tr class="guide">
		          						<th width="90"></th>
		          						<th></th>
		          					</tr>
		        					</thead>
		        					<tbody>
		                    <tr>
		                      <th><label>제목</label></th>
		                      <td>${set.boardQna.title}</td>
		                    </tr>
		                    <tr>
		                      <th><label>질문</label></th>
		                      <td>${set.boardQna.contents}</td>
		                    </tr>
		                    <tr class="last_line">
		                      <th><label for="contents">답변</label></th>
		                      <td>
		                        <textarea id="contents" name="contents"></textarea>
		                      </td>
		                    </tr>
		                  </tbody>  
		                </table>
		                <div class="center_btn">
		                  <a href="javascript:" id="saveBtn" onclick="lfn_btn('save');"><img src="/resources/images/sub/btn_reg.png" /></a>&nbsp;<a href="javascript:" onclick="lfn_btn('qnaList');"><img src="/resources/images/sub/btn_censel.png" /></a>
		                </div>
		                </form>
		              </div>
		            </div>
		            <!-- end tab_3 -->

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

