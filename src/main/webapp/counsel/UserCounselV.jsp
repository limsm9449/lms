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

<%
	String returnParameter = 
			"findString=" + request.getParameter("findString") +
			"&pageNum=" + request.getParameter("pageNum") +
			"&seq=" + request.getParameter("seq")
			;
%>


<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + "/counsel/userCounselDel.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "DELETE_OK") {
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="update" ) {
		gfn_goPage("/counsel/userCounselU","<%=returnParameter%>"); 
	} else if ( pKind =="list" ) {
		gfn_goPage("/counsel/userCounselList","<%=returnParameter%>"); 
	}
}



</script>

<body>

<form id="frm" name="frm" method="post">

<input type="hidden" id="seq" name="seq" value="${set.condiVO.seq}"/>

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
   	 		String menuId = "userCounselList";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의정보<span>&gt;</span>상담내역</div>
			<!-- title -->
			<h3 class="tit_big">상담내역</h3>
		      <div class="artcle">
		        <div class="qna_list_box">
		          <p>회원님께서 문의하셨던 내용에 대한 답변을 확인하실 수 있습니다.</p>
		          <div id="bod_search_r">
		            <a href="javascript:" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		          </div>
		          <div id="bodview_box">
		            <div class="title">${set.data.title}</div>
		            <div class="tool_box">
		              <dl>
		                <dt>분류</dt>
		                <dd>${set.data.categoryName}</dd>
		                <dd class="btn"><a href="javascript:" onclick="javascript:lfn_btn('update'); return false;">수정</a></dd>
		                <dd class="btn"><a id="saveBtn" href="javascript:" onclick="javascript:lfn_btn('delete'); return false;">삭제</a></dd>
		              </dl>
		              <hr class="dash" />
		              <dl>
		                <dt>등록일</dt>
		                <dd> ${set.data.createDate}</dd>
		              </dl>
		            </div>
		            <div class="text">${set.data.contents}</div>
		          </div>
<c:if test="${set.data.answer ne null}">
		          <div id="bodview_box" class="replay">
	                <div class="title">답변</div>
	                <div class="text">${set.data.answer}</div>
           		  </div>
</c:if>
		          <div id="bod_search_r">
		            <a href="javascript:" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
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