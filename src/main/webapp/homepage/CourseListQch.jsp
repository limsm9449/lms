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
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/course/process.css'>
</head>


<script type="text/javascript">

$(document).ready(function(){
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.condiVO.limitUnit});
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		f_submitSelf("/main/courseList");	
	} else if ( pKind == "view" ) {
		$("#courseId").val(pParam.courseId);
		
		gfn_goPage("/main/mainCourseData",$("#frm").serialize());
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
						//top.location = "/login.do?preUrl=/main/courseList.do";		
						location = "/login.do?preUrl=/main/courseList.do";
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_viewTypeChg(kind) {
	$('#viewType').val(kind); 
	$('#pageNum').val(1); 
	
	lfn_btn('search');
}

</script>

<body>

<form name="frm" id="frm" method="post">
	<input type='hidden' id='courseId' name='courseId'>
	<input type='hidden' id='viewType' name='viewType' value="${set.condiVO.viewType}">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD START -->
	     <%@ include file="../common/mainTopQch.jsp" %>
	     <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>
            
            <div class='contents_wrap_box'>
                    <!-- Top -->
                    <div class='top_area'>
                        <div class='clear_fix'>
                            <div class='process_history_box clear_fix'>
                                <span>
                                    <img src='/resources/homepageQch/img/course/ic_home.jpg' alt=' '>
                                </span>
                                <p>HOME</p>
                                <span>
                                    <img src='/resources/homepageQch/img/course/arr_right.jpg' alt=' '>
                                </span>
                                <p>전체과정</p>
                            </div>
                        </div>
                        <h1>
                            전체<span>과정</span>
                        </h1>
                    </div>
                    <!-- Top END -->

                    <!-- Filter Area -->
                    <div class='process_filter clear_fix'>
                        <div>
                            <ul class='clear_fix'>
                            	<li class='process_filter_item select1'>
		                            <select class="form-control" id="CB_LEVEL1">
                                        <option value="">전체</option>
                                        <option value="C02">비지니스</option>
                                        <option value="C03">IT/프로그래밍</option>
                                        <option value="C04">디자인</option>
                                        <option value="C05">인문/사회</option>
                                        <option value="C06">초/중/고등학습</option>
                                        <option value="C07">생활/취미</option>
                                        <option value="C08">자격증</option>
                                    </select>
                                </li>
                                <li class='process_filter_item select2'>
		                            <select name='orderKind' id='orderKind' onchange="$('pageNum').val(1); lfn_btn('search');">
		                                <option value='Popularity' <c:if test="${set.condiVO.orderKind eq null || set.condiVO.orderKind eq 'Popularity'}">selected</c:if>>인기강의순</option>
		                                <option value='Recommendation' <c:if test="${set.condiVO.orderKind eq 'Recommendation'}">selected</c:if>>추천강의순</option>
		                            </select>
                                </li>
<c:choose>
	<c:when test = "${set.condiVO.viewType eq null || set.condiVO.viewType eq '' || set.condiVO.viewType eq 'LIST'}">
		                        <li class='process_filter_item list'>
		                            <p class='on' onclick="lfn_viewTypeChg('LIST')">리스트</p>
		                        </li>
		                        <li class='process_filter_item image'>
		                            <p onclick="lfn_viewTypeChg('IMAGE');">이미지</p>
		                        </li>
   	</c:when>
   	<c:otherwise>
		                        <li class='process_filter_item list'>
		                            <p onclick="lfn_viewTypeChg('LIST')">리스트</p>
		                        </li>
		                        <li class='process_filter_item image'>
		                            <p class='on' onclick="lfn_viewTypeChg('IMAGE');">이미지</p>
		                        </li>
   	</c:otherwise>
</c:choose>
                            </ul>
                        </div>
                    </div>
                    <!-- Filter Area END -->

<c:choose>
	<c:when test = "${set.condiVO.viewType eq null || set.condiVO.viewType eq '' || set.condiVO.viewType eq 'LIST'}">
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
	                                <img src='/cImage/contents/${row.courseCode}/bImg.jpg' alt=' '>
	                            </div>
	                            <div class='process_result_text'>
	                                <div class='process_result_text_top clear_fix'>
	                                    <p>일반</p>
			<c:if test="${row.mobileYn eq 'Y'}">     	                                    
	                                    <p class='process_result_mobile'>모바일</p>
			</c:if>	                                    
			<c:if test="${row.offlineYn eq 'Y'}">     	                                    
	                                    <p class='process_result_offline'>오프라인</p>
			</c:if>	                                    
	                                </div>
	                                <p><a href="javascript:" onclick="lfn_btn('view',{courseId:'${row.courseId}'}); return false;">${row.courseName}</a></p>
	                                <div class='process_result_text_bottom clear_fix'>
	                                    <p>교육비</p>
	                                    <p class='process_result_payment'><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class='process_result_review con'>
	                            <div class='clear_fix' onclick="Popup.showPostscriptList('${row.courseId}')">
	                                <span><img src='/resources/homepageQch/img/course/${row.grade1}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.grade2}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.grade3}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.grade4}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.grade5}.png' alt=''></span>
	                            </div>
	                            <p>
	                                평점 : <span>${row.grade}</span>
	                                <span></span>
	                                후기 : <span>${row.gradeCnt}</span>건
	                            </p>
	                        </div>
	                        <div class='process_result_btn con'>
			<c:choose>
				<c:when test = "${row.previewYn eq 'N' || row.offlineYn eq 'Y'}">
	                            <button onclick="" class="no_btnclick">맛보기</button>
			   	</c:when>
			   	<c:otherwise>
	                            <button onclick="javascript:Popup.showSampleCourseQch('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;">맛보기</button>
			   	</c:otherwise>
			</c:choose>			
	                            <button onclick="javascript:lfn_btn('cart',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;">장바구니</button>
	                            <button onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class='process_result_admission'>수강신청</button>
	                        </div>
	                    </li>
		</c:forEach>
	                </ul>
	            </div>
	            <!-- Search Result Area END -->
   	</c:when>
   	<c:otherwise>
               	<div class='process_search_result'>
                    <ul class='process_list_wrap clear_fix'>
		<c:forEach var="row" items="${set.courseList}" varStatus="idx">
                        <li <c:if test="${idx.index % 3 eq 2}">  class='last_right'</c:if>>
			<c:choose>
				<c:when test = "${row.courseId ne null}">
                            <a href=''><img src='/cImage/contents/${row.courseCode}/cImg.jpg' alt=' '></a>
                            <div class='process_text_box'>
                                <div class='process_info_box'>
                                    <div>
                                        <p>일반</p>
					<c:if test="${row.mobileYn eq 'Y'}">     	                                    
                                        <p class='process_result_moblie'>모바일</p>
					</c:if>                                     
					<c:if test="${row.offlineYn eq 'Y'}">     	                                    
	                                    <p class='process_result_offline'>오프라인</p>
					</c:if>	                                    
                                    </div>
                                    <p class='process_title'>
                                        <a href="javascript:" onclick="lfn_btn('view',{courseId:'${row.courseId}'}); return false;">${row.courseName}</a>
                                    </p>
                                </div>
                                <div class='process_btn_area clear_fix'>
					<c:choose>
						<c:when test = "${row.previewYn eq 'N' || row.offlineYn eq 'Y'}">
		                            <button onclick="" class="no_btnclick">맛보기</button>
					   	</c:when>
					   	<c:otherwise>
		                            <button onclick="javascript:Popup.showSampleCourseQch('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;">맛보기</button>
					   	</c:otherwise>
					</c:choose>			
		                            <button onclick="javascript:lfn_btn('cart',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;">장바구니</button>
                                    <button onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class='admission'>수강신청</button>
                                </div>
                                <div class='process_score_box clear_fix'>
                                    <div class='process_score_image clear_fix' onclick="Popup.showPostscriptList('${row.courseId}')">
                                        <span><img src='/resources/homepageQch/img/course/${row.grade1}.png' alt=''></span>
		                                <span><img src='/resources/homepageQch/img/course/${row.grade2}.png' alt=''></span>
		                                <span><img src='/resources/homepageQch/img/course/${row.grade3}.png' alt=''></span>
		                                <span><img src='/resources/homepageQch/img/course/${row.grade4}.png' alt=''></span>
		                                <span><img src='/resources/homepageQch/img/course/${row.grade5}.png' alt=''></span>
                                    </div>
                                    <p class='process_score_text'>
                                        평점 : <span id='process_score_num'>${row.grade}</span> / 후기 : <span id='process_review_num'>${row.gradeCnt}</span>건
                                    </p>
                                </div>
                                <div class='process_payment_box clear_fix'>
                                    <p>교육비</p>
                                    <p class='process_payment'><fmt:formatNumber value="${row.courseCost}" type="number"/> 원</p>
                                </div>
                            </div>
			   	</c:when>
			   	<c:otherwise>
			   				<!-- 강좌가 없음 -->	
			   	</c:otherwise>
			</c:choose>    
                        </li>
		</c:forEach>                        
                   	</ul>
                </div>
                <!-- Search Result Area END -->
   	</c:otherwise>
</c:choose>  

                    <!-- Pager Area -->
                    <input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
                    <div class='pager_box'>
                        <div class='pager clear_fix'>
                            <div class='pager_prev clear_fix' id="pagingLayerPrev">
	                        </div>
	                        <ul class='clear_fix' id="pagingLayer">
	                        </ul>
	                        <div class='pager_next clear_fix' id="pagingLayerNext">
	                        </div>
                        </div>
                    </div>
                    <!-- Pager Area END -->
                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottomQch.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>

</form>
    
    <script src='/resources/homepageQch/js/sub.js'></script>
    
</body>

</html>