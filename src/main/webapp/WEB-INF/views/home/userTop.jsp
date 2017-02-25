<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>
<%@ page import="com.qp.lms.common.SessionVO"%>
<%@ page import="com.qp.lms.course.model.CourseVO"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
	SessionVO sessionVO = (SessionVO)SessionUtil.getSession();
	request.setAttribute("sessionVO",sessionVO);
	
	List<CourseVO> favorityCourseList = SessionUtil.getFavorityCourseList();

	request.setAttribute("favorityCourseList",favorityCourseList);

%>

  <!-- header_wrap -->
  <div id="header_wrap" class="site">
    <div id="header" class="site">
      <h1><a href="javascript:" onclick="page.goHome();"><img src="/resources/images/common/toplogo.png" alt="Qlearning" /></a></h1>
      <div class="menu_bg"></div>
      <ul class="gnb">
        <li><a href="/">홈</a></li>
<c:if test="${empty sessionVO}">      		
        <li><a href="javascript:" onclick="page.goPage('/login');">로그인</a></li>
        <li><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
</c:if>        
<c:if test="${!empty sessionVO}">      		
		<li><a href="javascript:" onclick="gfn_ajax.logout()">로그아웃</a></li>
        <li><a href="javascript:" onclick="page.goPage('/member/userMemberU');">나의 정보</a></li>
</c:if>        
        <li class="last"><a href="javascript:" onclick="page.goPage('/main/cart');">장바구니</a></li>
      </ul>
      <div id="menu_box">
        <ul class="menu">
          <li><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');" id="top1">나의강의실</a>
            <div id="menu_wrap">
        			<ul class="main_gnb" style="margin-left: 260px;">
        				<li><span>나의 학습활동</span>
        					<ul>
          					<li><a href="javascript:" onclick="page.goPage('/normalUser/attendCourseList');">수강과정</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/normalUser/waitingCourseList');">수강대기/취소과정</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/normalUser/myCourseList');">수강 완료 과정</a></li>
        					</ul>
        				</li>
        				<li><span>나의 정보</span>
        					<ul>
          					<li><a href="javascript:" onclick="page.goPage('/member/userMemberU');">회원정보수정</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/member/memberChangePassword');">비밀번호변경</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/counsel/userCounselList');">상담내역</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/member/memberRetired');">회원탈퇴</a></li>
        					</ul>
        				</li>
        				<li>
        					<ul>
<c:if test="${empty sessionVO}">    		  		
          					<li><a href="javascript:" onclick="page.goPage('/login');">로그인</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
</c:if>          					
          					<li><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
        					</ul>
        				</li>
        			</ul>
        		</div>
          </li>
          
          <li><a href="javascript:" onclick="page.goPage('/user/courseList');" id="top2">수강신청</a>
            <div id="menu_wrap">
        			<ul class="main_gnb" style="margin-left: 280px;">
        				<li><span>교육과정</span>
        					<ul>
          					<li><a href="javascript:" onclick="page.goPage('/user/courseList');">전체 교육과정</a></li>
<c:forEach var="row" items="${favorityCourseList}" varStatus="idx">
          					<li><a href="javascript:" onclick="page.goPage('/main/mainCourseData','courseId=${row.courseId}');">${row.courseName}</a></li>
</c:forEach>          					
        					</ul>
        				</li>
        				<li><span>수강신청</span>
        					<ul>
          					<li><a href="javascript:" onclick="page.goNsJsp('how');">수강신청방법</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/main/cart');">장바구니</a></li>
          					<li><a href="javascript:" onclick="alert('준비중');">주문/신청 조회</a></li>
        					</ul>
        				</li>
        				<li>
        					<ul>
<c:if test="${empty sessionVO}">      		      		
          					<li><a href="javascript:" onclick="page.goPage('/login');">로그인</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
</c:if>          					
          					<li><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
        					</ul>
        				</li>
        			</ul>
        		</div>
          </li>
          
          <li><a href="javascript:" onclick="page.goPage('/user/noticeList');" id="top3">학습지원</a>
            <div id="menu_wrap">
        			<ul class="main_gnb" style="margin-left: 360px;">
        				<li><span>학습지원/교육문의</span>
        					<ul>
          					<li><a href="javascript:" onclick="page.goPage('/user/noticeList');">공지사항</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/user/faqList');">FAQ</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/main/mailQuestion');">1:1메일문의</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/guest/bankInfo');">입금계좌안내</a></li>
        					</ul>
        				</li>
        				<li>
        					<ul>
<c:if test="${empty sessionVO}">  		      		
          					<li><a href="javascript:" onclick="page.goPage('/login');">로그인</a></li>
          					<li><a href="javascript:" onclick="page.goPage('/guest/join');">회원가입</a></li>
</c:if>          					
        					</ul>
        				</li>
        			</ul>
        		</div>
          </li>
        </ul>
      </div>
      <!-- end menu_box -->
    </div>
  </div>
  <!-- end header_wrap -->