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
		
		f_submitSelf("/user/faqList");
	} else if ( pKind == "view") {
		$("#seq").val(pParam.seq);
		
		gfn_goPage("/user/faqV",$("#frm").serialize());
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="seq" name="seq" type="hidden" value="">

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
   	 		String menuId = "faqList";
   	 	%>
		<%@ include file="../home/userLeft3.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>학습지원<span>&gt;</span>FAQ</div>
			<!-- title -->
			<h3 class="tit_big">FAQ</h3>
      <div class="artcle">
      	<div class="img_head"><img src="/resources/images/sub/img_faq_head.png" alt="FAQ입니다." /></div>
      	<div id="faq_search_box">
      		<p>
          	<select name="category">
          		<option value="">전체</option>
          		<c:forEach var="row" items="${set.ddCategory}">
	              	<option value="${row.ddKey}" <c:if test="${set.condiVO.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
				</c:forEach>
          	</select>
          	 <input type="text" class="search_input" id="findString" name="findString" value="${set.condiVO.findString}" />
		     <a href="javascript:" onclick="lfn_btn('search');"><img src="/resources/images/sub/btn_search.png" alt="검색하기" /></a>
        	</p>
        </div>
        <div class="faq_list_box">
          <table class="bod_list">
            <caption>Faq 목록</caption>
  					<thead>
  					  <tr class="guide">
    						<th width="42"></th>
    						<th width="120"></th>
    						<th></th>
    						<th width="53"></th>
    						<th width="100"></th>
    					</tr>
    					<tr class="t_list">
    						<th>No</th>
    						<th>분류</th>
    						<th>제목</th>
    						<th>조회</th>
    						<th>등록일</th>
    					</tr>
  					</thead>
  					<tbody>
       				<c:forEach var="row" items="${set.boardFaqList}" varStatus="idx">
		              <tr <c:if test="${idx.index + 1 eq fn:length(set.boardFaqList)}"> class="last_line"</c:if>>
		                <td class="center">${row.rownum}</td>
		                <td class="center">${row.categoryName}</td>
		                <td class="title"><nobr><a href="#" onClick="javascript:lfn_btn('view',{seq:'${row.seq}'}); return false;" class="click">${row.title}</a></nobr><c:if test="${row.isNew eq 'Y'}">><img src="/resources/images/sub/icon/icon_new.png" alt="새글" /></c:if></td>
		                <td class="center">${row.viewCnt}</td>
		                <td class="center last">${row.createDate}</td>
		              </tr>
	              	</c:forEach>
            </tbody>
          </table>
          <%-- 페이징 --%>
						<div id="paging"></div>
        </div>
      </div>
			<br />
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

