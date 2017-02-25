<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	if ( pKind =="save" ) {
		if ( confirm("수강취소를 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + "/normalUser/courseRegCancel.do",
			dataType :"json",
			data : "approvalId=" + pParam.approvalId,
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("정상적으로 취소 되었습니다.");
					window.location = "/normalUser/waitingCourseList.do";
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

</script>

<body>

<form name="frm" method="post">
	<input id="courseId" name="courseId" type="hidden" value=""/>
	<input id="screen" name="screen" type="hidden" value="WaitingCourse"/>



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
   	 		String menuId = "waitingCourseList";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의강의실<span>&gt;</span>수강대기/취소과정</div>
			<!-- title -->
			<h3 class="tit_big">수강대기과정</h3>
		      <div class="artcle">
		        <div class="study_list_box">
		          <p class="big_2"><span class="blue">수강대기 상세 리스트</span></p>
		          <p>현재 수강 대기 과정입니다. 학습이 시작되면 수강과정으로 이동 합니다.</p>
		          <table class="high_list">
		            <caption>수강대기 목록</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th></th>
		    						<th width="92"></th>
		    						<th width="82"></th>
		    						<th width="74"></th>
		    						<th width="67"></th>
		    						<th width="85"></th>
		    					</tr>
		    					<tr class="t_list">
		    						<th>강의제목</th>
		    						<th>학습기간</th>
		    						<th>신청일자</th>
		    						<th>승인여부</th>
		    						<th>교육비</th>
		    						<th>수강여부</th>
		    					</tr>
		  					</thead>
		  					<tbody>
						<c:if test="${empty set.course}">
							<tr class="last_line"><td colspan="6" class="center last">데이타가 없습니다.</td></tr>
						</c:if>			  					
						<c:forEach var="row" items="${set.course}" varStatus="idx">
			              <tr <c:if test="${idx.index + 1 eq fn:length(set.course)}"> class="last_line"</c:if>>
			                <td class="title"><nobr><a href="content1.html"><span>${row.courseName}</span></nobr></td>
			                <td class="center pad">${row.cPeriod}</td>
			                <td class="center">${row.createDate}</td>
			                <td class="center">신청중</td>
			                <td class="center"><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</td>
			                <td class="center last"><a href="javascript:" id="saveBtn" onclick="lfn_btn('save',{approvalId:'${row.approvalId}'});"><img src="/resources/images/sub/btn_study_cancel.png" alt="수강취소" /></a></td>
			              </tr>
			            </c:forEach>
		            </tbody>
		          </table>
		        </div>
		        <div class="div_description">
		          <p>수강취소 버튼이 보이지 않으실 경우, 고객센터(02-888-7805)로 문의하여 주십시오.</p>
		          <p>※ 환불 시 은행명과 계좌번호를 정확히 입력하여 주십시오.</p>
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



