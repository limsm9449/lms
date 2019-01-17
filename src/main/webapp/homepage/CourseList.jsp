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
            $("input[name=categorys]").prop("checked",true);
        }else{
            $("input[name=categorys]").prop("checked",false);
        }
    })
    
	<c:forEach var="row" items="${set.condiVO.categorys}" varStatus="idx">
		$("input[name=categorys][value=${row}]").prop("checked",true);
	</c:forEach>
	
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.condiVO.limitUnit});
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
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
	$('#viewTypeChg').val('Y'); 
	$('#pageNum').val(1); 
	
	lfn_btn('search');
}

</script>

<body>

<form name="frm" id="frm" method="post">
	<input type='hidden' id='courseId' name='courseId'>
	<input type='hidden' id='viewType' name='viewType'>
	<input type='hidden' id='viewTypeChg' name='viewTypeChg' value="N">

<frameset rows='*'>    
    <div class='wrap'>

		<!-- HEAD -->
       	<%@ include file="../common/mainTop.jsp" %>
       	<!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process' >
        	<div class='contents_wrap_box'>
	            <!-- QUICK MENU -->
	            <%@ include file="../common/mainQuickMenu.jsp" %>
	
	            <!-- Process -->
	            <div class='top_area'>
	                <div class='clear_fix'>
	                    <div class='process_history_box clear_fix'>
	                        <span>
	                            <img src='/resources/homepage/img/process/ic_home.jpg' alt=' '>
	                        </span>
	                        <p>HOME</p>
	                        <span>
	                            <img src='/resources/homepage/img/process/arr_right.jpg' alt=' '>
	                        </span>
	                        <p>전체과정</p>
	                    </div>
	                </div>
<c:if test="${!empty set.categoryMainCourseList}">	                
	                <h1>
	                    전체<span>과정</span>
	                </h1>
</c:if>	                
	            </div>
<c:if test="${!empty set.categoryMainCourseList}">	                
	            <ul class='process_list_wrap clear_fix'>
	<c:forEach var="row" items="${set.categoryMainCourseList}" varStatus="idx">
	                <li <c:if test="${idx.last}">class='last_right'</c:if>>
	                    <p class='process_category'>${row.c1CodeName}</p>
	                    <a href=''><img src='/cImage/contents/${row.courseCode}/mImg1.jpg' alt=' '></a>
	                    <div class='process_text_box'>
	                        <div class='process_info_box'>
	                            <div>
	                                <p>일반</p>
		<c:if test="${row.mobileYn eq 'Y'}">       	                                
	                                <p>모바일</p>
		</c:if>	                                
	                            </div>
	                            <p class='process_title'>
	                                ${row.courseName}
	                            </p>
	                        </div>
	                        <div class='process_btn_area clear_fix'>
	                            <button onclick="javascript:Popup.showSampleCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;">맛보기</button>
	                            <button onclick="javascript:lfn_btn('cart',{courseId:'${row.courseId}',cnt:'${row.cnt}'}); return false;">장바구니</button>
	                            <button onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class='admission'>수강신청</button>
	                        </div>
	                        <div class='process_score_box clear_fix'>
	                            <div class='process_score_image clear_fix' onclick="Popup.showPostscriptList('${row.courseId}')">
	                                <span><img src='/resources/homepage/img/process/${row.grade1}.png' alt=''></span>
	                                <span><img src='/resources/homepage/img/process/${row.grade2}.png' alt=''></span>
	                                <span><img src='/resources/homepage/img/process/${row.grade3}.png' alt=''></span>
	                                <span><img src='/resources/homepage/img/process/${row.grade4}.png' alt=''></span>
	                                <span><img src='/resources/homepage/img/process/${row.grade5}.png' alt=''></span>
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
	                </li>
	</c:forEach>
</c:if>	
	            </ul>
	            <!-- Process END -->

	            <!-- Search Area -->
	            <div class='process_search clear_fix'>
	                <div class='process_search_text con'>
	                    <p>과정명</p>
	                    <span><input type='text' id="courseName" name="courseName" value="${set.condiVO.courseName}" />
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
	                                <input type='checkbox' id='categorys' name='categorys' value="${row.code}">
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
	                            <input type='checkbox' id='workerCardYn' name='workerCardYn' value="Y" <c:if test="${set.condiVO.workerCardYn eq 'Y'}">checked</c:if>>
	                            <p>근로자카드</p>
	                            <input type='checkbox' id='supportEmployerYn' name='supportEmployerYn' value="Y" <c:if test="${set.condiVO.supportEmployerYn eq 'Y'}">checked</c:if>>
	                            <p>사업주지원</p>
	                            <input type='checkbox' id='normalCourseYn' name='normalCourseYn' value="Y" <c:if test="${set.condiVO.normalCourseYn eq 'Y'}">checked</c:if>>
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
	                            <select name='orderKind' id='orderKind'>
	                                <option value='Popularity' <c:if test="${set.condiVO.orderKind eq null || set.condiVO.orderKind eq 'Popularity'}">selected</c:if>>인기강의순</option>
	                                <option value='Recommendation' <c:if test="${set.condiVO.orderKind eq 'Recommendation'}">selected</c:if>>추천강의순</option>
	                            </select>
	                        </li>
	                        <li class='process_filter_item select2'>
	                            <select name='limitUnit' id='limitUnit' onchange="$('pageNum').val(1);">
<c:choose>
	<c:when test = "${set.condiVO.viewType eq null || set.condiVO.viewType eq '' || set.condiVO.viewType eq 'LIST'}">
	                                <option value='10' <c:if test="${set.condiVO.limitUnit eq '10'}">selected</c:if>>10개씩</option>
	                                <option value='20' <c:if test="${set.condiVO.limitUnit eq '20'}">selected</c:if>>20개씩</option>
	                                <option value='30' <c:if test="${set.condiVO.limitUnit eq '30'}">selected</c:if>>30개씩</option>
   	</c:when>
   	<c:otherwise>
	                                <option value='12' <c:if test="${set.condiVO.limitUnit eq '12'}">selected</c:if>>12개씩</option>
	                                <option value='24' <c:if test="${set.condiVO.limitUnit eq '24'}">selected</c:if>>24개씩</option>
	                                <option value='36' <c:if test="${set.condiVO.limitUnit eq '36'}">selected</c:if>>26개씩</option>
   	</c:otherwise>
</c:choose>    
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
	                                <img src='/cImage/contents/${row.courseCode}/sImg1.jpg' alt=' '>
	                            </div>
	                            <div class='process_result_text'>
	                                <div class='process_result_text_top clear_fix'>
	                                    <p>일반</p>
			<c:if test="${row.mobileYn eq 'Y'}">     	                                    
	                                    <p class='process_result_mobile'>모바일</p>
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
                        <li <c:if test="${idx.index % 4 eq 3}">  class='last_right'</c:if>>
			<c:choose>
				<c:when test = "${row.courseId ne null}">
                            <a href=''><img src='/cImage/contents/${row.courseCode}/sImg1.jpg' alt=' '></a>
                            <div class='process_text_box'>
                                <div class='process_info_box'>
                                    <div>
                                        <p>일반</p>
					<c:if test="${row.mobileYn eq 'Y'}">     	                                    
                                        <p>모바일</p>
					</c:if>                                     
                                    </div>
                                    <p class='process_title'>
                                        <a href="javascript:" onclick="lfn_btn('view',{courseId:'${row.courseId}'}); return false;">${row.courseName}</a>
                                    </p>
                                </div>
                                <div class='process_btn_area clear_fix'>
                                    <button onclick="javascript:Popup.showSampleCourse('${row.courseId}','${row.hPx + 100}','${row.vPx + 100}'); return false;">맛보기</button>
                                    <button onclick="javascript:lfn_btn('view',{courseId:'${row.courseId}'}); return false;" class='admission'>수강신청</button>
                                </div>
                                <div class='process_score_box clear_fix'>
                                    <div class='process_score_image clear_fix' onclick="Popup.showPostscriptList('${row.courseId}')">
                                        <span><img src='/resources/homepage/img/process/${row.grade1}.png' alt=''></span>
		                                <span><img src='/resources/homepage/img/process/${row.grade2}.png' alt=''></span>
		                                <span><img src='/resources/homepage/img/process/${row.grade3}.png' alt=''></span>
		                                <span><img src='/resources/homepage/img/process/${row.grade4}.png' alt=''></span>
		                                <span><img src='/resources/homepage/img/process/${row.grade5}.png' alt=''></span>
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
                            <div>&laquo;</div>
                            <div>&lsaquo;</div>
                        </div>
                        <ul class='clear_fix' id="pagingLayer">
                            <li class='on'>1</li>
                            <li>2</li>
                            <li>3</li>
                            <li>4</li>
                            <li>5</li>
                        </ul>
                        <div class='pager_next clear_fix' id="pagingLayerNext">
                            <div>&rsaquo;</div>
                            <div>&raquo;</div>
                        </div>
                    </div>
                </div>
	            <!-- Pager Area END -->
	        </div>
        </div>
        <!-- CONTENTS END -->

		<!-- FOOTER -->
       	<%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
        
    </div>
</frameset>

</form>

    
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
    
</body>

</html>