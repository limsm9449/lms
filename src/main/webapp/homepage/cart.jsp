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
$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "cartApplication" ) {
		if ( $("#chk").length == 0 ) {
			alert("신청할 과정이 없습니다.");
			return false;
		}
		if ( confirm("해당 과정으로 결재하시겠습니까?") == true ) {
			gfn_goPage("/main/cartApplication"); 
		}
	} else if ( pKind == "cartDel" ) {
		if ( confirm("장바구니에서 삭제 하시겠습니까?") == true ) {
			gfn_goPage("/main/cartDel","cartCourseId=" + pParam.courseId);
		}
	} else if ( pKind == "cartSelectDel" ) {
		if ( gfn_cbCheckedValues("chk",",") == "" ) {
			alert("선택된 데이타가 없습니다.");
			return false;
		} else {
			if ( confirm("장바구니에서 삭제 하시겠습니까?") == true ) {
				gfn_goPage("/main/cartSelectDel","cartCourseId=" + gfn_cbCheckedValues("chk",","));
			}
		}
	}
}

</script>

<body>

<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="">

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
   	 		String menuId = "cart";
   	 	%>
		<%@ include file="../home/userLeft2.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>장바구니</div>
			<!-- title -->
			<h3 class="tit_big">장바구니</h3>
		      <div class="artcle">
		      	<div class="orderflow_box">
		          <img src="/resources/images/sub/img_orderflow_1.png" alt="결제순서 1단계 장바구니" />
		          <ul class="order_tip">
		            <li>고객님께서 장바구니에 담으신 과정 및 상품입니다. 담긴 날로부터 30일간 자동 저장됩니다.</li>
								<li>결제 시 가격정보를 확인 후 구매하시기 바랍니다.</li>
								<li>과정은 매월 21일 기준으로 정보 변경됩니다.(참고도서 포함)</li>
		          </ul>
		        </div>
		        <div class="cart_box">
		          <p class="big_4"><span class="blue">신청과정</span></p>
		          <table class="cart_list">
		          	<caption>카트 리스트</caption>
  					<thead>
  					  <tr class="guide">
    						<th width="43"></th>
    						<th width="120"></th>
    						<th></th>
    						<th width="140"></th>
    					</tr>
  					</thead>
  					<tbody>
  						<tr class="sel_all">
  							<td class="center"><input type="checkbox" name="aChk" id="aChk"  onclick="gfn_allChk('aChk','chk');"/></td>
  							<td colspan="3">전체 선택</td>
  						</tr>
						<c:forEach var="row" items="${set.courseList}" varStatus="idx">
					    	<tr <c:if test="${idx.index + 1 eq fn:length(set.courseList)}"> class="last_line"</c:if>>
			              	<td class="center"><input type="checkbox" name="chk" id="chk" value="${row.courseId}" /></td>
			                <td class="center"><img src="/cImage/contents/${row.courseCode}/sImg1.jpg" /></td>
			                <td class="title">
			                	<nobr><p class="big_2"><a href="content1.html"><span class="blue">${row.courseName}</span></a></p></nobr>
			                	<p class="period">교육기간 : ${row.cFromDate} ~ ${row.cToDate} (${row.cPeriod} 일)</p>
			                	<c:if test="${not empty row.cartWeekList}">
				                	<ul class="chapter">
										<c:forEach var="subRow" items="${row.cartWeekList}">
											<li>[${subRow.week} 차시] ${subRow.title} (<fmt:formatNumber value="${subRow.weekCost}" type="number"/> 원)</li>
										</c:forEach>
				                	</ul>
			                	</c:if>
			                	<ul class="option">
			                		<li>교육비 | <fmt:formatNumber value="${row.courseCost}" type="number"/> 원</li>
			                	</ul>
			               	</td>
			                <td class="center"><a href="javascript:" onclick="javascript:lfn_btn('cartDel',{courseId:'${row.courseId}'}); return false;"><img src="/resources/images/sub/btn_cart_out.png" alt="카트에서 제거" /></a></td>
			              </tr>
			            </c:forEach>
		            </tbody>
		          </table>
		        </div>
		        <div class="center_btn">
		        	<a href="javascript:" onclick="javascript:lfn_btn('cartApplication'); return false;"><img src="/resources/images/sub/btn_pay_next.png" alt="결제신청" /></a>&nbsp;<a href="javascript:" onclick="javascript:lfn_btn('cartSelectDel'); return false;"><img src="/resources/images/sub/btn_all_cartout.png" alt="카트비우기" /></a>
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

