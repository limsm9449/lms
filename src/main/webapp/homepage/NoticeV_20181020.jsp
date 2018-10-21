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
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "list" ) {
		gfn_goPage("/user/noticeList",$("#frm").serialize()); 
	} else if ( pKind == "nextNotice" ) {
		gfn_goPage("/user/noticeV","seq=" + pParam.seq); 
	} else if ( pKind == "prevNotice" ) {
		gfn_goPage("/user/noticeV","seq=" + pParam.seq); 
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

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
   	 		String menuId = "noticeList";
   	 	%>
		<%@ include file="../home/userLeft3.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>학습지원<span>&gt;</span>공지사항</div>
			<!-- title -->
			<h3 class="tit_big">공지사항</h3>
		      <div class="artcle">
		        <div class="notice_view_box">
		        	&nbsp;
		          <div id="bod_search_r">
		            <a href="javascript:" onclick="lfn_btn('list');"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		          </div>
		          <div id="bodview_box">
		            <div class="title">${set.boardNotice.title}</div>
		            <div class="tool_box">
		              <dl>
		                <dt>조회</dt>
		                <dd>${set.boardNotice.viewCnt}</dd>
		                <dt class="date">등록일</dt>
		                <dd>${set.boardNotice.createDate}</dd>
		              </dl>
		            </div>
		            <div class="text">
		              ${set.boardNotice.contents}
		            </div>
		          </div>
		          <div id="bod_search_r">
<c:if test="${set.boardNotice.prevSeq ne ''}">
		            <a href="javascript:" onclick="lfn_btn('prevNotice',{seq:'${set.boardNotice.prevSeq}'});">이전글</a>
</c:if>		            
<c:if test="${set.boardNotice.nextSeq ne ''}">
		            <a href="javascript:" onclick="lfn_btn('nextNotice',{seq:'${set.boardNotice.nextSeq}'});">다음글</a>
</c:if>		            
		            <a href="javascript:" onclick="lfn_btn('list');"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
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

