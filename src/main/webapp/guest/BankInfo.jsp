<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>

<script type="text/javascript">

</script>

<body>

<form name="frm" id="frm" method="post">

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
   	 		String menuId = "bankInfo";
   	 	%>
		<%@ include file="../home/userLeft3.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>학습지원<span>&gt;</span>입금계좌안내</div>
			<!-- title -->
			<h3 class="tit_big">입금계좌안내</h3>
		      <div class="artcle">
		      	<div class="img_head"><img src="/resources/images/sub/img_account_head.png" alt="입금계좌안내 입니다." /></div>
		        <div class="account_list_box">
		          <table class="bod_list">
		            <caption>입금계좌 목록</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="42"></th>
		    						<th width="195"></th>
		    						<th></th>
		    						<th width="120"></th>
		    					</tr>
		    					<tr class="t_list">
		    						<th>No</th>
		    						<th>은행명</th>
		    						<th>계좌번호</th>
		    						<th>예금주</th>
		    					</tr>
		  					</thead>
		  					<tbody>
						<c:forEach var="row" items="${set.bankList}" varStatus="idx">
					    	<tr <c:if test="${idx.index + 1 eq fn:length(set.bankList)}"> class="last_line"</c:if>>
				                <td class="center">${idx.count}</td>
				                <td class="center">${row.bankName}</td>
				                <td class="center">${row.accNo}</td>
				                <td class="center last">${row.user}</td>
			                </tr>
			            </c:forEach>
		            </tbody>
		          </table>
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

