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
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/user/courseList");	
	} else if ( pKind == "view" ) {
		$("#courseId").val(pParam.courseId);
		
		gfn_goPage("/main/mainCourseData",$("#frm").serialize());
	} else if ( pKind == "application" ) {
		<c:choose>
			<c:when test="${set.condiVO.isLogin eq 'N'}">
				alert("로그인 후에 수강신청을 하셔야 합니다.");
				top.location = "/login.do?preUrl=" + encodeURIComponent(window.location + "?" + $("#frm").serialize());
			</c:when>
			<c:when test="${compCd ne 'B2C'}">
				if ( confirm("과정을 신청하시겠습니까?") == true ) {
					$.ajax({
						type :"POST",
						url : context + "/siteManager/axUserCourseRegister.do",
						dataType :"json",
						data : "courseId=" + pParam.courseId,
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("과정이 신청되었습니다.") == true )
									page.goPage('/normalUser/attendCourseList');
								else
									lfn_btn("refresh");
							} else if ( json.rtnMode == "NO_SESSION") {
								top.location = "/login.do?preUrl=/user/courseList.do";		
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				}
			</c:when>
			<c:otherwise>
				if (pParam.cnt > "0" ) {
					alert("신청한 과정입니다.")
				} else {
					gfn_goPage("/main/application","courseId=" + pParam.courseId + "&cartWeeks=");
				}
			</c:otherwise>
		</c:choose>
	} else if ( pKind == "cart" ) {
		if (pParam.cnt > "0" ) {
			alert("신청한 과정입니다.")
		} else {
			$.ajax({
				type :"POST",
				url : context + "/main/cartAdd.do",
				dataType :"json",
				data : "cartCourseId=" + pParam.courseId + "&cartWeeks=",
				success : function(json){
					if ( json.rtnMode == "OK") {
						if ( confirm("강의를 장바구니에 넣었습니다.\n장바구니로 이동하시겠습니까?") == true )
							page.goPage('/main/cart');
						else
							lfn_btn("refresh");
					} else if ( json.rtnMode == "NO_SESSION") {
						top.location = "/login.do?preUrl=/user/courseList.do";		
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
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
   	 		String menuId = "courseAll";
   	 	%>
		<%@ include file="../home/userLeft2.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>교육과정</div>
			<!-- title -->
			<h3 class="tit_big">교육과정</h3>
		      <div class="artcle">
		      	<div id="search_box">
		      	  <form class="search_forum" action="" method="get">
		            <div class="search_1">
		              <label for="c1Code">카테고리</label>
		              <select id="c1Code" name="c1Code" onchange="gfn_category1Change()">
			              	<option value="">전체</option>
							<c:forEach var="row" items="${set.ddCategory1Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c1Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c2Code" name="c2Code" onchange="gfn_category2Change()">
			              	<option value="">전체</option>
			              	<c:forEach var="row" items="${set.ddCategory2Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c2Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
						<select id="c3Code" name="c3Code">
			             	<option value="" selected>전체</option>
			             	<c:forEach var="row" items="${set.ddCategory3Depth}">
				              	<option value="${row.ddKey}" <c:if test="${set.condiVO.c3Code eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
							</c:forEach>
						</select>
		            </div>
		            <div class="search_2">
		              <label for="f_subject">과정명</label>
		              <input type="text" class="search_input" id="courseName" name="courseName" value="${set.condiVO.courseName}" />
		              <a href="javascript:" onclick="javascript:lfn_btn('search');return false;"><img src="/resources/images/sub/btn_search.png" alt="검색" /></a>
		            </div>
		          </form>
		        </div>
		        <div class="conlist_box">
		          <table class="cont_list">
		          	<caption>교육과정 목록</caption>
  					<thead>
  					  <tr class="guide">
    						<th width="140"></th>
    						<th></th>
    						<th width="150"></th>
    					</tr>
  					</thead>
  					<tbody>
						<c:forEach var="row" items="${set.courseList}" varStatus="idx">
					    	<tr <c:if test="${idx.index + 1 eq fn:length(set.courseList)}"> class="last_line"</c:if>>
				                <td class="center"><img src="/cImage/contents/${row.courseCode}/sImg1.jpg"/></td>
				                <td class="title">
				                	<nobr><p class="big_4"><a href="javascript:" onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;"><span class="blue">${row.courseName}</span></a></p></nobr>
				                	<p class="cate">${row.categoryName}</p>
				                	<ul class="option">
				                		<li><a href="javascript:" onclick="javascript:Popup.showSampleCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;"><img src="/resources/images/sub/btn_content_sample2.png" alt="맛보기" /></a></li>
				                		<li><a href="javascript:" onclick="javascript:lfn_btn('cart',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;"><img src="/resources/images/sub/btn_cart_in2.png" alt="장바구니 담기" /></a></li>
				                	</ul>
				               	</td>
				                <td class="center"><p class="pay">교육비: <fmt:formatNumber value="${row.courseCost}" type="number"/> 원</p><a href="javascript:" onclick="javascript:lfn_btn('application',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;"><img src="/resources/images/sub/btn_content_pay2.png" alt="수강신청" /></a></td>
				            </tr>
				        </c:forEach>
		            </tbody>
		          </table>
		          <%-- 페이징 --%>
						<div id="paging"></div>
		        </div>
		      </div>
			<br />
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

