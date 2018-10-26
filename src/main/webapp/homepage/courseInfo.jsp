<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 전체과정</title>
    
    	<%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/course/register_course.css'>    
        
</head>

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
			<c:when test="${set.condiVO.compCd ne 'B2C'}">
				if ( confirm("과정을 신청하시겠습니까?") == true ) {
					$.ajax({
						type :"POST",
						url : context + "/siteManager/axUserCourseRegister.do",
						dataType :"json",
						data : "courseId=${set.courseData.courseId}",
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("과정이 신청되었습니다.") == true )
									page.goPage('/normalUser/attendCourseList');
								else
									lfn_btn("refresh");
							} else if ( json.rtnMode == "NO_SESSION") {
								top.location = "/login.do?preUrl=/main/courseList.do";		
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				}
			</c:when>
			<c:otherwise>
				if ( $("#requestKind").val() == "PART" ) {
					if ( gfn_cbCheckedValues("weeks",",") == "" ) {
						alert("선택된 차시가 없습니다.");
						return;
					}
					gfn_goPage("/paymentGateway/pay","courseId=${set.courseData.courseId}" + "&cartWeeks=" + gfn_cbCheckedValues("weeks",","));
				} else {
					gfn_goPage("/paymentGateway/pay","courseId=${set.courseData.courseId}" + "&cartWeeks=");
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
				if ( $("#requestKind").val() == "PART" ) {
					if ( gfn_cbCheckedValues("weeks",",") == "" ) {
						alert("선택된 차시가 없습니다.");
						return;
					}

					$.ajax({
						type :"POST",
						url : context +"/main/cartAdd.do",
						dataType :"json",
						data : "cartCourseId=" + $("#courseId").val() + "&cartWeeks=" + gfn_cbCheckedValues("weeks",","),
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("강의를 장바구니에 넣었습니다. 장바구니로 이동하시겠습니까?") == true ) {
									page.goPage('/main/cart');
								}
							}
						},
						error : function(e) {
							alert("<spring:message code="lms.msg.systemError" text="-" />");
						}
					})
				} else {
					$.ajax({
						type :"POST",
						url : context +"/main/cartAdd.do",
						dataType :"json",
						data : "cartCourseId=" + $("#courseId").val() + "&cartWeeks=",
						success : function(json){
							if ( json.rtnMode == "OK") {
								if ( confirm("강의를 장바구니에 넣었습니다. 장바구니로 이동하시겠습니까?") == true ) {
									page.goPage('/main/cart');
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
	}

}

</script>

<body>
<frameset rows='*'>   
<form name="frm" id="frm" method="post"> 
	<input id="courseId" name="courseId" type="hidden" value="${set.courseData.courseId}"/>
	
    <div class='wrap'>

		<!-- HEAD -->
       	<%@ include file="../common/mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' onmouseover='sub_hide()'>
            <div class='contents_wrap_box'>
                <!-- QUICK MENU -->
                <%@ include file="../common/mainQuickMenu.jsp" %>

                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepage/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>수강신청</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>교육과정</p>
                        </div>
                    </div>
                    <h1>
                       ${set.courseData.categoryName}</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='register_course_title'>
                    <div class='clear_fix'>
                        <h2>${set.courseData.courseName}</h2>
                        <p>일반</p>
<c:if test="${set.courseData.mobileYn eq 'Y'}">                        
                        <p class='bg_other'>모바일</p>
</c:if>                        
                    </div>
                </div>
                <div class='register_course_contents clear_fix'>
                    <div class='register_course_image'>
                        <div id='register_big_img'><img src='/resources/homepage/img/course/register_1.jpg' alt=' '></div>
                        <ul class='register_image_list clear_fix'>
                            <li onclick='thumbnail(event, 1)' class='register_image_list_item active'>
                                <img src='/resources/homepage/img/course/register_1.jpg' alt=' '>
                            </li>
                            <li onclick='thumbnail(event, 2)' class='register_image_list_item'>
                                <img src='/resources/homepage/img/course/register_2.jpg' alt=' '>
                            </li>
                            <li onclick='thumbnail(event, 3)' class='register_image_list_item last_right'>
                                <img src='/resources/homepage/img/course/register_3.jpg' alt=' '>
                            </li>
                        </ul>
                        <div class='register_course_review clear_fix'>
                            <span><img src='/resources/homepage/img/course/${set.courseData.grade1}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/${set.courseData.grade2}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/${set.courseData.grade3}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/${set.courseData.grade4}.png' alt=' '></span>
                            <span><img src='/resources/homepage/img/course/${set.courseData.grade5}.png' alt=' '></span>
                            <p>
                                평점 : <span>${set.courseData.grade}</span> / 후기 : <span>${set.courseData.gradeCnt}</span>건
                            </p>
                        </div>
                    </div>
                    <div class='register_course_info'>
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>교수명</p>
                            <p>${set.courseData.teacherName}</p>
                        </div>
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>강좌수</p>
                            <p>${set.courseData.weekCnt}강</p>
                        </div>
<c:if test="${set.courseData.termYn eq 'Y'}">                        
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>수강신청기간</p>
                            <p>${set.courseData.termPeriodFrom}~${set.courseData.termPeriodTo}</p>
                        </div>
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>학습기간</p>
                            <p>${set.courseData.studyPeriodFrom}~${set.courseData.studyPeriodTo}</p>
                        </div>
</c:if>                        
<c:if test="${set.courseData.termYn eq 'N'}">                        
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>학습기간</p>
                            <p>${set.courseData.cPeriod}일</p>
                        </div>
</c:if>                        
<c:if test="${set.courseData.weekCostYn eq 'Y'}">                        
                        <div class='register_course_info_text clear_fix'>
                            <p class='register_course_info_title'>신청방식</p>
                            <div>
                                <select onchange="lfn_btn('refresh')" name='requestKind' id='requestKind'>
                                    <option value='ALL' <c:if test="${set.condiVO.requestKind eq 'ALL' || set.condiVO.requestKind eq null}">selected</c:if>>전체과정</option>
                                    <option value='PART' <c:if test="${set.condiVO.requestKind eq 'PART'}">selected</c:if>>차시신청</option>
                                </select>
                                <p>
                                    * 신청방식에 따라 부분 차시 신청을 선택하시면 차시별 <span></span>신청이 가능합니다.
                                </p>
                            </div>
                        </div>
</c:if>                        
                        <p class='register_payment'>
                            총 상품금액 :
                            <span>
                                <strong><fmt:formatNumber value="${set.courseData.courseCost}" type="number"/></strong>원
                            </span>
                        </p>
                        <div class='register_btn_area clear_fix'>
                            <button onclick="javascript:Popup.showSampleCourse('${set.courseData.courseId}','${set.courseData.hPx + 100}','${set.courseData.vPx + 100}'); return false;">맛보기</button>
                            <button onclick="javascript:lfn_btn('cart'); return false;">장바구니</button>
                            <button class='last_right' onclick="javascript:lfn_btn('application'); return false;">수강신청</button>
                        </div>
                    </div>
                </div>
                <div class='register_tab_contents_wrap'>
                    <div class='register_tab_box clear_fix'>
                        <button onclick='register_tab(this, "introduce")' class='register_btn active'>과정소개</button>
                        <button onclick='register_tab(this, "compose")' class='register_btn'>과정구성</button>
                        <button onclick='register_tab(this, "estimate")' class='register_btn last_right'>평가항목</button>
                    </div>
                    <div class='register_tab_content_box' id='introduce'>
                        <ul>
                            <li class='register_introduce_list clear_fix'>
                                <p class='register_introduce_list_title'>강의개요</p>
                                <div>
                                	<p>${set.courseData.learingContent}</p>
                                </div>
                            </li>
                            <li class='register_introduce_list clear_fix'>
                                <p class='register_introduce_list_title'>학습목표</p>
                                <div>
                                	<p>${set.courseData.learingGoal}</p>
                                </div>
                            </li>
                            <li class='register_introduce_list clear_fix'>
                                <p class='register_introduce_list_title'>교육대상</p>
                                <div>
                                	<p>${set.courseData.learingTarget}</p>
                                </div>
                            </li>
                            <li class='register_introduce_list clear_fix'>
                                <p class='register_introduce_list_title'>교수소개</p>
                                <span><img src='/cImage/user/${set.courseData.teacherId}.jpg' alt=' '></span>
                                <div>
                                    <div class='register_tutor_explain clear_fix'>
                                        <p class='register_tutor_title'>교수명</p>
                                        <p>${set.courseData.teacherName}</p>
                                    </div>
                                    <div class='register_tutor_explain clear_fix'>
                                        <p class='register_tutor_title'>경력</p>
                                        <div>
                                        	<p>${set.courseData.career}</p>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <div class='register_review_box'>
                            <p class='register_content_title'>과정후기</p>
                            <table class='register_review_table'>
                                <tr>
                                    <th class='register_review_col1'>번호</th>
                                    <th>내용</th>
                                    <th class='register_review_col3 mobile_last'>평점</th>
                                    <th class='mobile_none'>작성자</th>
                                    <th class='register_review_col5 last_right mobile_none'>등록일</th>
                                </tr>
<c:forEach var="row" items="${set.postScriptList}" varStatus="idx">
                                
                                <tr>
                                    <td>${idx.index + 1}</td>
                                    <td class='register_review_lecture'>
                                        <p>${row.contents}</p>
                                    </td>
                                    <td class='mobile_last'>
                                        <span><img src='/resources/homepage/img/course/register_star_${row.eval1}.png' alt=' '></span>
                                        <span><img src='/resources/homepage/img/course/register_star_${row.eval2}.png' alt=' '></span>
                                        <span><img src='/resources/homepage/img/course/register_star_${row.eval3}.png' alt=' '></span>
                                        <span><img src='/resources/homepage/img/course/register_star_${row.eval4}.png' alt=' '></span>
                                        <span><img src='/resources/homepage/img/course/register_star_${row.eval5}.png' alt=' '></span>
                                    </td>
                                    <td class='mobile_none'>${row.userName}</td>
                                    <td class='last_right mobile_none'>${row.createDate}</td>
                                </tr>
</c:forEach>                                
                            </table>
                        </div>
                    </div>
                    <div class='register_tab_content_box' id='compose'>
                        <p>
                            여러분이 수강을 원하는 강의를 선택하여 수강신청을 할 수 있습니다. <span></span>
                            <strong>전체 강의 신청시 할인된 금액으로 수강신청이 가능</strong>합니다.
                        </p>
                        <table class='register_compose_table'>
                            <tr>
<c:if test="${set.condiVO.requestKind eq 'PART'}">                        
                                <th class='register_compose_col1 right_border part_only'><input type='checkbox' name='all' id='all' onclick="gfn_allChk('all','weeks')"></th>
</c:if>                                
                                <th>차시 제목</th>
                                <th class='register_compose_col3 mobile_none'>학습시간</th>
                                <th class='last_right part_only'>교육비</th>
                            </tr>
<c:forEach var="row" items="${set.courseResourceList}" varStatus="idx">
                            <tr>
	<c:if test="${set.condiVO.requestKind eq 'PART'}">                        
                                <td class='right_border part_only'><input type='checkbox' name='weeks' id='weeks' value="${row.week}"></td>
	</c:if>                                
                                <td class='register_compose_lecture'>
                                    <p>
                                        ${idx.index + 1}<span></span>${row.title}
                                    </p>
                                </td>
                                <td class='mobile_none'>${row.weekTime}분</td>
                                <td class='last_right part_only'><fmt:formatNumber value="${row.weekCost}" type="number"/> <span><img src='/resources/homepage/img/course/ic_won.png' alt=' '></span></td>
                            </tr>
</c:forEach>                            
                        </table>
                    </div>
                    <div class='register_tab_content_box' id='estimate'>
                        <p class='register_content_title'>평가항목 및 수료기준</p>
                        <table class='register_estimate_table'>
                            <tr>
<c:if test="${set.courseData.progressRate ne '0'}">
                                <th>진도 비율</th>
</c:if>                                
<c:if test="${set.courseData.reportRate ne '0'}">
                                <th>레포트 비율</th>
</c:if>                                
<c:if test="${set.courseData.discussionRate ne '0'}">
                                <th>토론 비율</th>
</c:if>                                
<c:if test="${set.courseData.examRate ne '0'}">
                                <th>최종평가 비율</th>
</c:if>                                
                                <th>총점</th>
                            </tr>
                            <tr>
<c:if test="${set.courseData.progressRate ne '0'}">
                                <td>${set.courseData.progressRate}% 반영</td>
</c:if>                                
<c:if test="${set.courseData.reportRate ne '0'}">
                                <td>${set.courseData.reportRate}% 반영</td>
</c:if>                                
<c:if test="${set.courseData.discussionRate ne '0'}">
                                <td>${set.courseData.discussionRate}% 반영</td>
</c:if>                                
<c:if test="${set.courseData.examRate ne '0'}">
                                <td>${set.courseData.examRate}% 반영</td>
</c:if>                                
                                <td>총점 ${set.courseData.totalFail}점 이상</td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <!-- CONTENTS END -->

		<!-- FOOTER -->
       	<%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
        
    </div>
</form>    
</frameset>    
    <script src='/resources/homepage/js/sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>