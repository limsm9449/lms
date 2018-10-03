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

<script type="text/javascript">
<!--
$(function() { 
    $(".tab_content").hide(); 
    $(".tab_content:first").show();
    
    $("ul.tabs li").click(function() { 
      	$("ul.tabs li").removeClass("active");
      	$(this).addClass("active");
      	$(".tab_content").hide(); 
      	var activeTab = $(this).attr("rel"); 
      	$("#"+activeTab).fadeIn();
    }); 
}); 

$(document).ready(function(){
  	$('#thumbs li').mouseover(function(e){
  		e.preventDefault();
  		$('#thumbs li').removeClass('active');
  		$(this).addClass('active');
  		var idx = $('#thumbs li').index(this);
  		img_url = "/cImage/contents/${set.courseData.courseCode}/mImg"+ (idx+1) +".jpg";
  		$('#photoview img').attr('src',img_url);
	});
  	
  	//부분차시 선택시 과정구성 Tab이 활성화 되도록
  	if ( $("#requestKind").val() == "SEL" ) {
      	$(".tab_content").hide(); 
      	$("#tab2").fadeIn(); 
  	}
})
//-->
</script>


<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind == "application" ) {
		<c:choose>
			<c:when test="${set.condiVO.isLogin eq 'N'}">
				alert("로그인 후에 수강신청을 하셔야 합니다.");
				top.location = "/login.do?preUrl=" + encodeURIComponent(window.location + "?courseId=${set.courseData.courseId}");
			</c:when>
			<c:when test="${set.condiVO.isLogin eq 'Y' && set.courseData.subCnt ne 0}">
				alert("신청한 과정입니다.");
			</c:when>
			<c:otherwise>
				if ( $("#requestKind").val() == "SEL" ) {
					if ( gfn_cbCheckedValues("weeks",",") == "" ) {
						alert("선택된 차시가 없습니다.");
						return;
					}
					gfn_goPage("/paymentGateway/pay","courseId=" + $("#courseId").val() + "&cartWeeks=" + gfn_cbCheckedValues("weeks",","));
				} else {
					gfn_goPage("/paymentGateway/pay","courseId=" + $("#courseId").val() + "&cartWeeks=");
				}
			</c:otherwise>
		</c:choose>
	} else if ( pKind == "cart" ) {
		<c:choose>
			<c:when test="${set.condiVO.isLogin eq 'N'}">
				alert("로그인 후에 수강신청을 하셔야 합니다.");
				top.location = "/login.do?preUrl=" + encodeURIComponent(window.location + "?courseId=${set.courseData.courseId}");
			</c:when>
			<c:when test="${set.condiVO.isLogin eq 'Y' && set.courseData.subCnt ne 0}">
				alert("신청한 과정입니다.")
			</c:when>
			<c:otherwise>
				if ( $("#requestKind").val() == "SEL" ) {
					if ( gfn_cbCheckedValues("weeks",",") == "" ) {
						alert("선택된 차시가 없습니다.");
						return;
					}

					btnUnbind("cartBtn");
					$.ajax({
						type :"POST",
						url : context +"/main/cartAdd.do",
						dataType :"json",
						data : "cartCourseId=" + $("#courseId").val() + "&cartWeeks=" + gfn_cbCheckedValues("weeks",","),
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("강의를 장바구니에 넣었습니다. 장바구니로 이동하시겠습니까?") == true ) {
									page.goPage('/main/cart');
								} else {
									lfn_btn("list");
								}
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				} else {
					btnUnbind("cartBtn");
					$.ajax({
						type :"POST",
						url : context +"/main/cartAdd.do",
						dataType :"json",
						data : "cartCourseId=" + $("#courseId").val() + "&cartWeeks=",
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("강의를 장바구니에 넣었습니다. 장바구니로 이동하시겠습니까?") == true ) {
									page.goPage('/main/cart');
								} else {
									lfn_btn("list");
								}
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				}
			</c:otherwise>
		</c:choose>
	} else if ( pKind == "refresh" ) {
		f_submitSelf("/main/mainCourseData",$("#frm").serialize());
	} else if ( pKind == "list" ) {
		f_submitSelf("/main/courseList",$("#frm").serialize());
	}

}

</script>

<body>


<form name="frm" id="frm" method="post">

<input id="courseId" name="courseId" type="hidden" value="${set.courseData.courseId}"/>

<input id="c1Code" name="c1Code" type="hidden" value="<%=request.getParameter("c1Code")%>"/>
<input id="c2Code" name="c2Code" type="hidden" value="<%=request.getParameter("c2Code")%>"/>
<input id="c3Code" name="c3Code" type="hidden" value="<%=request.getParameter("c3Code")%>"/>
<input id="courseName" name="courseName" type="hidden" value="<%=request.getParameter("courseName")%>"/>

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
   	 		String menuId = "eduCourse";
   	 	%>
		<%@ include file="../home/userLeft2.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>수강신청<span>&gt;</span>수강과정</div>
			<!-- title -->
			<h3 class="tit_big">${set.courseData.courseName}</h3>
		      <div class="artcle">
		        <div class="content_box">
		          <div id="mini_gallery">
		            <div id="photoview"><img src="/cImage/contents/${set.courseData.courseCode}/mImg1.jpg" alt="preview image" /></div>
		            <ul id="thumbs">
		              <li class="active"><img src="/cImage/contents/${set.courseData.courseCode}/sImg1.jpg" alt="thumb" /></li>
		              <li><img src="/cImage/contents/${set.courseData.courseCode}/sImg2.jpg" alt="thumb" /></li>
		              <li><img src="/cImage/contents/${set.courseData.courseCode}/sImg3.jpg" alt="thumb" /></li>
		            </ul>
		          </div>
		          <div class="content_info">
		            <dl>
		              <dt>교 수 명</dt><dd>${set.courseData.teacherName}</dd>
		              <dt>강 좌 수</dt><dd>16강</dd>
		              <dt>학습기간</dt><dd>${set.courseData.cPeriod}</dd>
<c:if test="${set.courseData.weekCostYn eq 'Y'}">
		              <dt class="last">신청방식</dt>
		              <dd>
						<select id="requestKind" name="requestKind" onchange="lfn_btn('refresh')">
							<option value="ALL" <c:if test="${set.condiVO.requestKind eq 'ALL' || set.condiVO.requestKind eq null}">selected</c:if>>전차시 신청</option>
							<option value="SEL" <c:if test="${set.condiVO.requestKind eq 'SEL'}">selected</c:if>>부분 차시 신청</option>
						</select>
		              </dd>
</c:if>
<c:if test="${set.courseData.weekCostYn ne 'Y'}">
		              <dt class="last">신청방식</dt>
		              <dd>전차시 신청</option></dd>
</c:if>
		            </dl>
		            <p class="help">※신청방식에서 '부분 차시 신청'을 선택하면 차시별 신청이 가능합니다.</p>
		            <p class="payment">총 상품금액 : <span class="blue big"><fmt:formatNumber value="${set.courseData.courseCost}" type="number"/></span>원</p>
		            <div class="center_btn">
		            	<a href="javascript:" onclick="javascript:lfn_btn('application'); return false;"><img src="/resources/images/sub/btn_content_pay.png" alt="강의신청" /></a>
		            	<a href="javascript:" onclick="javascript:Popup.showSampleCourse('${set.courseData.courseId}','${set.courseData.hPx + 100}','${set.courseData.vPx + 100}'); return false;"><img src="/resources/images/sub/btn_content_sample.png" alt="강의샘플보기" /></a>
		            	<a href="javascript:" id="cartBtn" onclick="javascript:lfn_btn('cart'); return false;"><img src="/resources/images/sub/btn_cart_in.png" alt="장바구니 담기" /></a>
		            	<!-- a href="javascript:" onclick="javascript:lfn_btn('list'); return false;">리스트</a-->
		            </div>
		          </div>
		        </div>
		        <div class="content_view_box">
		          <ul class="tabs">
		            <li class="active" rel="tab1"><span>과정설명</span></li>
		            <li rel="tab2"><span>과정구성</span></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab_1 -->
		            <div id="tab1" class="tab_content">
		              <ul class="content_detail">
		              	<li>
		              		<dl>
		              			<dt>강의개요</dt>
		              			<dd>${set.courseData.learingContent}</dd>
		              		</dl>
		              	</li>
		              	<li>
		              		<dl>
		              			<dt>학습목표</dt>
		              			<dd>
		              				${set.courseData.learingGoal}
		              			</dd>
		              		</dl>
		              	</li>
		              	<li>
		              		<dl>
		              			<dt>교육대상</dt>
		              			<dd>
		              				${set.courseData.learingTarget}
		              			</dd>
		              		</dl>
		              	</li>
		              	<li>
		              		<dl>
		              			<dt>교수소개</dt>
		              			<dd>
		              				<div class="tutor_info">
		              					<img src="/cImage/teacher/${set.courseData.picture}" alt="xx강사" />
		              					<dl>
		              						<dt>교수명</dt>
		              						<dd>${set.courseData.teacherName}</dd>
		              						<dt>경력</dt>
		              						<dd>${set.courseData.career}</dd>
		              					</dl>
		              				</div>
		              			</dd>
		              		</dl>
		              	</li>
		              </ul>
		            </div>
		            <!-- end tab_1 -->
		            <!-- tab_2 -->
		            <div id="tab2" class="tab_content">
		              <ul class="content_detail">
		              	<li>
		              		<dl>
		              			<dt>과정구성</dt>
		              			<dd></dd>
		              		</dl>
		              	</li>
		              </ul>
		              <table class="content_list">
		              	<caption>과정구성</caption>
<c:if test="${set.condiVO.requestKind eq 'SEL'}">
      					<thead>
      					  <tr class="guide">
        						<th width="65"></th>
        						<th></th>
        						<th width="305"></th>
        					</tr>
        					<tr class="c_list">
        						<th>선택</th>
        						<th>차시</th>
        						<th class="title">강의 제목</th>
        						<th class="title">교육비</th>
        					</tr>
      					</thead>
      					<tbody>
	<c:forEach var="row" items="${set.courseResourceList}" varStatus="idx">
    						<tr <c:if test="${idx.index + 1 eq fn:length(set.courseResourceList)}"> class="last_line"</c:if>>
								<td class="center"><input type="checkbox" id="weeks" name="weeks" value="${row.week}">
								<td class="center">${row.week} 차시</td>
								<td class="title"><nobr>${row.title}</nobr></td>
								<td class="title">${row.weekCost}</td>
							</tr>
	</c:forEach>
		                </tbody>
</c:if>		      					
<c:if test="${set.condiVO.requestKind ne 'SEL'}">
      					<thead>
      					  <tr class="guide">
        						<th width="65"></th>
        						<th></th>
        						<th width="305"></th>
        					</tr>
        					<tr class="c_list">
        						<th></th>
        						<th class="title">강의 제목</th>
        						<th class="title"></th>
        					</tr>
      					</thead>
      					<tbody>
	<c:forEach var="row" items="${set.courseResourceList}" varStatus="idx">
    						<tr <c:if test="${idx.index + 1 eq fn:length(set.courseResourceList)}"> class="last_line"</c:if>>
								<td class="center">${row.week} 차시</td>
								<td class="title"><nobr>${row.title}</nobr></td>
								<td class="title"></td>
							</tr>
	</c:forEach>
		                </tbody>
</c:if>		      					
		              </table>
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



</body>

</html>
