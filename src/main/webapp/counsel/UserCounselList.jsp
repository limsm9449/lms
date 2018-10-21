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
		
		f_submitSelf("/counsel/userCounselList");
	} else if ( pKind == "new" ) {
		gfn_goPage("/counsel/userCounselN",$("#frm").serialize());
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/counsel/userCounselV",$("#frm").serialize());
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">

<input type="hidden" id="seq" name="seq" value=""/>

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
		            <form class="search_forum" action="" method="get">
		              <input type="text" class="search_input" id="findString" name="findString" value="${set.condiVO.findString}" />
		              <a href="javascript:" onclick="javascript:lfn_btn('search');"><img src="/resources/images/sub/btn_search.png" alt="검색하기" /></a>
		            </form>
		          </div>
		          <table class="bod_list">
		            <caption>QnA 목록</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="42"></th>
		    						<th width="130"></th>
		    						<th></th>
		    						<th width="110"></th>
		    						<th width="100 "></th>
		    					</tr>
		    					<tr class="t_list">
		    						<th>No</th>
		    						<th>분류 </th>
		    						<th>제목</th>
		    						<th>등록일</th>
		    						<th>답변상태</th>
		    					</tr>
		  					</thead>
		  					<tbody>
						<c:if test="${empty set.list}">
							<tr class="last_line">
								<td colspan="5" class="last center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.index + 1 eq fn:length(set.list)}"> class="last_line"</c:if>>
				              	<td class="right">${row.rownum}</td>
				              	<td class="center">${row.categoryName}</td>
				              	<td class="title2"><span><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click"><c:out value="${row.title}" escapeXml="true" /></a></span></td>
				              	<td class="center">${row.createDate}</td>
				              	<td class="last center">${row.answerYn}</td>
							</tr>
						</c:forEach> 
		            </tbody>
		          </table>
		          	<%-- 페이징 --%>
					<div id="paging"></div>
	    			<div class="right_btn up_btn">
	    			  <a href="javascript:" onclick="javascript:lfn_btn('new');"><img src="/resources/images/sub/btn_qna.png" alt="질문하기" /></a>
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