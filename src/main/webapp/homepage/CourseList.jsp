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
    <link rel='stylesheet' href='/resources/homepage/css/course/process.css'>
        
</head>

<script type="text/javascript">

$(document).ready(function(){
    $("#categoryAll").click(function(){
        if ( $("#categoryAll").prop("checked") ) {
            $("input[name=category]").prop("checked",true);
        }else{
            $("input[name=category]").prop("checked",false);
        }
    })
    
	<c:forEach var="row" items="${set.condiVO.category}" varStatus="idx">
		$("input[name=category][value=${row}]").prop("checked",true);
	</c:forEach>
	
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.condiVO.limitUnit});
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		f_submitSelf("/main/courseList");	
	} else if ( pKind == "view" ) {
		$("#courseId").val(pParam.courseId);
		
		gfn_goPage("/main/mainCourseData",$("#frm").serialize());
	} else if ( pKind == "application" ) {
		<c:choose>
			<c:when test="${set.condiVO.isLogin eq 'N'}">
				alert("로그인 후에 수강신청을 하셔야 합니다.");
				top.location = "/login.do?preUrl=" + encodeURIComponent(window.location + "?" + $("#frm").serialize());
			</c:when>
			<c:when test="${set.condiVO.compCd ne 'B2C'}">
				if (pParam.cnt > "0" ) {
					alert("신청한 과정입니다.")
				} else {
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
									top.location = "/login.do?preUrl=/main/courseList.do";		
								}
							},
							error : function(e) {
								alert("<spring:message code="lms.msg.systemError" text="-" />");
							}
						})
					}
				}
			</c:when>
			<c:otherwise>
				if (pParam.cnt > "0" ) {
					alert("신청한 과정입니다.")
				} else {
					gfn_goPage("/paymentGateway/pay","courseId=" + pParam.courseId + "&cartWeeks=");
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
						top.location = "/login.do?preUrl=/main/courseList.do";		
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
    <div class='wrap'>
        
		<!-- HEAD -->
       	<%@ include file="./mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' onmouseover='sub_hide()'>
            <!-- QUICK MENU -->
            <%@ include file="./mainQuickMenu.jsp" %>

            <!-- Process -->
            <div class='process_top_area'>
                <div class='clear_fix'>
                    <div class='process_history_box clear_fix'>
                        <span>
                            <img src='/resources/homepage/img/process/ic_home.jpg' alt=' '>
                        </span>
                        <p>HOME</p>
                        <span>
                            <img src='/resources/homepage/img/process/arr_right.jpg' alt=' '>
                        </span>
                        <p>수강신청</p>
                        <span>
                            <img src='/resources/homepage/img/process/arr_right.jpg' alt=' '>
                        </span>
                        <p>교육과정</p>
                    </div>
                </div>
                <h1>
                    전체<span>과정</span>
                </h1>
            </div>
            <ul class='process_list_wrap clear_fix'>
                <li>
                    <p class='process_category'>리더십 일반</p>
                    <a href=''><img src='/resources/homepage/img/process/process_1.jpg' alt=' '></a>
                    <div class='process_text_box'>
                        <div class='process_info_box'>
                            <div>
                                <p>일반</p>
                                <p>모바일</p>
                            </div>
                            <p class='process_title'>
                                [스마트러닝] 김정구 교수의 미래창조경영 위기와 역경을 기회로
                            </p>
                        </div>
                        <div class='process_btn_area clear_fix'>
                            <button>맛보기</button>
                            <button>장바구니</button>
                            <button class='admission'>수강신청</button>
                        </div>
                        <div class='process_score_box clear_fix'>
                            <div class='process_score_image clear_fix'>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_inactive.png' alt=' '></span>
                            </div>
                            <p class='process_score_text'>
                                평점 : <span id='process_score_num'>4.5</span> / 후기 : <span id='process_review_num'>2</span>건
                            </p>
                        </div>
                        <div class='process_payment_box clear_fix'>
                            <p>교육비</p>
                            <p class='process_payment'>50,000원</p>
                        </div>
                    </div>
                </li>
                <li>
                    <p class='process_category'>재테크</p>
                    <a href=''><img src='/resources/homepage/img/process/process_2.jpg' alt=' '></a>
                    <div class='process_text_box'>
                        <div class='process_info_box'>
                            <div>
                                <p>일반</p>
                                <p>모바일</p>
                            </div>
                            <p class='process_title'>
                                [스마트러닝] 김정구 교수의 미래창조경영 위기와 역경을 기회로
                            </p>
                        </div>
                        <div class='process_btn_area clear_fix'>
                            <button>맛보기</button>
                            <button>장바구니</button>
                            <button class='admission'>수강신청</button>
                        </div>
                        <div class='process_score_box clear_fix'>
                            <div class='process_score_image clear_fix'>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_inactive.png' alt=' '></span>
                            </div>
                            <p class='process_score_text'>
                                평점 : <span id='process_score_num'>4.5</span> / 후기 : <span id='process_review_num'>2</span>건
                            </p>
                        </div>
                        <div class='process_payment_box clear_fix'>
                            <p>교육비</p>
                            <p class='process_payment'>50,000원</p>
                        </div>
                    </div>
                </li>
                <li class='last_right'>
                    <p class='process_category'>자기개발</p>
                    <a href=''><img src='/resources/homepage/img/process/process_3.jpg' alt=' '></a>
                    <div class='process_text_box'>
                        <div class='process_info_box'>
                            <div>
                                <p>일반</p>
                                <p>모바일</p>
                            </div>
                            <p class='process_title'>
                                [스마트러닝] 김정구 교수의 미래창조경영 위기와 역경을 기회로
                            </p>
                        </div>
                        <div class='process_btn_area clear_fix'>
                            <button>맛보기</button>
                            <button>장바구니</button>
                            <button class='admission'>수강신청</button>
                        </div>
                        <div class='process_score_box clear_fix'>
                            <div class='process_score_image clear_fix'>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_active.png' alt=' '></span>
                                <span><img src='/resources/homepage/img/process/star_inactive.png' alt=' '></span>
                            </div>
                            <p class='process_score_text clear_fix'>
                                평점 : <span id='process_score_num'>4.5</span> / 후기 : <span id='process_review_num'>2</span>건
                            </p>
                        </div>
                        <div class='process_payment_box clear_fix'>
                            <p>교육비</p>
                            <p class='process_payment'>50,000원</p>
                        </div>
                    </div>
                </li>
            </ul>
            <!-- Process END -->

<form name="frm" id="frm" method="post">

            <!-- Search Area -->
            <div class='process_search clear_fix'>
                <div class='process_search_text con'>
                    <p>과정명</p>
                    <span><input type='text' name='' id=''></span>
                </div>
                <div class='process_search_category con'>
                    <p class='process_category_text'>카테고리</p>
                    <div class='process_category_box'>
                        <div>
                            <div class='process_category_all clear_fix'>
                                <input type='checkbox' name='categoryAll' id='categoryAll'>
                                <p>전체</p>
                            </div>
                            <div class='process_category_etc clear_fix'>
<c:forEach var="row" items="${courseCategoryList}" varStatus="idx">
                                <input type='checkbox' id='category' name='category' value="${row.code}">
                                <p>${row.codeName}</p>
</c:forEach>                            
                            </div>
                        </div>
                    </div>
                </div>
                <div class='process_support_fund con'>
                    <p>교육비지원과정</p>
                    <div>
                        <div class='process_support clear_fix'>
                            <input type='checkbox' id='process_supportType_employee' name='process_supportType_1'>
                            <p>근로자카드</p>
                            <input type='checkbox' id='process_supportType_employer' name='process_supportType_2'>
                            <p>사업주지원</p>
                            <input type='checkbox' id='process_supportType_normal' name='process_supportType_3'>
                            <p>일반과정</p>
                        </div>
                    </div>
                </div>
                <div class='process_search_btn'>
                    <button onclick="javascript:lfn_btn('search');return false;">검색</button>
                </div>
            </div>
            <!-- Search Area END -->

            <!-- Filter Area -->
            <div class='process_filter clear_fix'>
                <p>총 <span>${set.totalCount}</span>개의 과정이 검색되었습니다.</p>
                <div>
                    <ul class='clear_fix'>
                        <li class='process_filter_item select1'>
                            <select name='' id=''>
                                <option value=''>인기강의순</option>
                                <option value=''>추천강의순</option>
                            </select>
                        </li>
                        <li class='process_filter_item select2'>
                            <select name='limitUnit' id='limitUnit'>
                                <option value='10'>10개씩</option>
                                <option value='15'>15개씩</option>
                                <option value='30'>30개씩</option>
                            </select>
                        </li>
                        <input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
                        <li class='process_filter_item range'>
                            <p class='non_image'>정렬</p>
                        </li>
                        <li class='process_filter_item list'>
                            <p>리스트</p>
                        </li>
                        <li class='process_filter_item image'>
                            <p>이미지</p>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- Filter Area END -->
</form>

            <!-- Search Result Area -->
            <div class='process_search_result'>
                <div class='clear_fix'>
                    <div class='process_result_checkbox'>
                        <input type='checkbox' name='' id=''>
                    </div>
                    <p class='process_result_con'>과정정보</p>
                    <p class='process_result_review'>만족도/후기</p>
                    <p class='process_result_btn'>수강신청</p>
                </div>
                <ul class='process_result_list'>
<c:forEach var="row" items="${set.courseList}" varStatus="idx">
                    <li class='clear_fix'>
                        <div class='process_result_checkbox con'>
                            <input type='checkbox' name='' id=''>
                        </div>
                        <div class='process_result_con con clear_fix'>
                            <div class='process_result_img'>
                                <img src='/cImage/contents/${row.courseCode}/sImg1.jpg' alt=' '>
                            </div>
                            <div class='process_result_text'>
                                <div class='process_result_text_top clear_fix'>
                                    <p>일반</p>
                                    <p class='process_result_mobile'>모바일</p>
                                </div>
                                <p>${row.courseName}</p>
                                <div class='process_result_text_bottom clear_fix'>
                                    <p>교육비</p>
                                    <p class='process_result_payment'><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</p>
                                </div>
                            </div>
                        </div>
                        <div class='process_result_review con'>
                            <div class='clear_fix'>
                                <span><img src='/resources/homepage/img/process/${row.grade1}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade2}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade3}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade4}.png' alt=''></span>
                                <span><img src='/resources/homepage/img/process/${row.grade5}.png' alt=''></span>
                            </div>
                            <p>
                                평점 : <span>${row.grade}</span>
                                <span></span>
                                후기 : <span>${row.gradeCnt}</span>건
                            </p>
                        </div>
                        <div class='process_result_btn con'>
                            <button onclick="javascript:Popup.showSampleCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;">맛보기</button>
                            <button onclick="javascript:lfn_btn('cart',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;">장바구니</button>
                            <button onclick="javascript:lfn_btn('application',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;" class='process_result_admission'>수강신청</button>
                        </div>
                    </li>
</c:forEach>
                </ul>
            </div>
            <!-- Search Result Area END -->


            <!-- Pager Area -->
            <div class='process_pager clear_fix'>
                <div class='process_pager_prev clear_fix' id="pagingLayerPrev">
                    <div>&laquo;</div>
                    <div>&lsaquo;</div>
                </div>
                <ul class='clear_fix' id="pagingLayer">
                    <li>1</li>
                    <li>2</li>
                    <li>3</li>
                    <li>4</li>
                    <li>5</li>
                    <li>6</li>
                    <li>7</li>
                    <li>8</li>
                    <li>9</li>
                    <li>10</li>
                </ul>
                <div class='process_pager_next clear_fix' id="pagingLayerNext">
                    <div>&rsaquo;</div>
                    <div>&raquo;</div>
                </div>
            </div>
            <!-- Pager Area END -->
        </div>
        <!-- CONTENTS END -->

		<!-- FOOTER -->
       	<%@ include file="./mainBottom.jsp" %>
        <!-- FOOTER END -->
        
    </div>
    <script src='/resources/homepage/js/main.js'></script>
</body>

</html>