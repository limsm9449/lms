<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.qp.lms.common.SessionUtil"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<% pageContext.setAttribute("newLineChar", "\n"); %>


<!DOCTYPE html>
<html lang='ko' data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - Main</title>

	<%@ include file="../common/commMainInclude.jsp" %> 

    <script src='/resources/homepageQch/js/jquery.bxslider.js'></script>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">

    <link rel='stylesheet' type='text/css' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' type='text/css' href='/resources/homepageQch/css/main.css?timestamp=<%=timestamp%>'>
    <link rel='stylesheet' href='/resources/homepageQch/css/IE_style.css'>    
</head>

<script type="text/javascript">

var courseInfo = {};
$(document).ready(function(){
	var isPc = ( gfn_deviceCheck() == "PC" ? true : false );
	//console.log(isPc);
	
	<c:forEach var="row" items="${set.mainFrame}" varStatus="idx">
		<c:set var = "detailList" value = "${set.mainFrameDetailHm[row.SEQ]}"/>
		<c:choose>
			<c:when test = "${row.FRAME_KIND eq 'DOT_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('#tab${row.SEQ} .slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + fn_getPcMobileImg(isPc, "${detailRow.BK_IMAGE_URL}") + "') 50% 0 no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'DOT_S_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('#tab${row.SEQ} .slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + fn_getPcMobileImg(isPc, "${detailRow.BK_IMAGE_URL}") + "') 50% 0 no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'THUMBNAIL_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_p_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 no-repeat";
				</c:forEach>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 no-repeat";
				</c:forEach>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_n_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'MP4'}">
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'IMAGE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					$(".slide_i_${detailRow.SEQ}").attr("src",fn_getPcMobileImg(isPc, "${detailRow.BK_IMAGE_URL}"));
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'IMAGE_MP4'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					<c:set var="imgs" value="${fn:split(detailRow.BK_IMAGE_URL,'^')}" />
					<c:forEach var="img" items="${imgs}" varStatus="g">
						<c:if test="${g.count == 1}">
							document.querySelector('.slide_mi1_${detailRow.SEQ}').style.background = "url('" + fn_getPcMobileImg(isPc, "${img}") + "') 50% 0 no-repeat";
						</c:if>
						<c:if test="${g.count == 2}">
							$(".slide_mi2_${detailRow.SEQ}").attr("src","${img}");
					    </c:if>
					</c:forEach> 
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'MP4_IMAGE'}">
			<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
				<c:set var="imgs" value="${fn:split(detailRow.BK_IMAGE_URL,'^')}" />
				<c:forEach var="img" items="${imgs}" varStatus="g">
					<c:if test="${g.count == 1}">
						$(".slide_mi1_${detailRow.SEQ}").attr("src","${img}");
					</c:if>
					<c:if test="${g.count == 2}">
						document.querySelector('.slide_mi2_${detailRow.SEQ}').style.background = "url('" + fn_getPcMobileImg(isPc, "${img}") + "') 50% 0 no-repeat";
				    </c:if>
				</c:forEach> 
			</c:forEach>
		</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>                    
	</c:forEach>
	
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit},${set.pageCnt});

	<c:forEach var="row" items="${set.noticePopupList}" varStatus="idx">
		if ( $.cookie(cookieName + "_notice_${row.SEQ}") != "Y" ) {
			Popup.showMainNoticePopup(${row.SEQ});
		}
	</c:forEach>

	<c:if test="${!empty set.condiVO.shap}">	      	
		gfn_goScreenPosition("${set.condiVO.shap}");
	</c:if>
	
	if ( $('.slider_wrap').length > 0 ) {
	    $('.slider_wrap').bxSlider({
	        mode: 'fade',
	        controls: false,
	        pager: true,
	        autoHover: true,
	        auto: true,
	        ease: 'cubic-sezier(0.42, 0, 0.58, 1)',
	        autocontrolsCombine: true,
	        autoControls: true,
	        touchEnabled: false,
	        shrinkItems: true,
	        pause: 5000,
	        speed: 800
	    });
	}	    

});

function fn_linkCall(seq) {
	if ( seq == 0 ) {
	}
	<c:forEach var="row" items="${set.mainFrame}" varStatus="idx">
		<c:set var = "detailList" value = "${set.mainFrameDetailHm[row.SEQ]}"/>
		<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
			<c:choose>
				<c:when test = "${row.FRAME_KIND eq 'MP4' || row.FRAME_KIND eq 'MP4_IMAGE' || row.FRAME_KIND eq 'IMAGE_MP4'}">
					else if ( seq == ${detailRow.SEQ} ) {
						fn_show("${detailRow.LINK_URL}");
					}
				</c:when>
				<c:otherwise>
					else if ( seq == ${detailRow.SEQ} ) {
						${detailRow.LINK_URL};
					}
				</c:otherwise>
			</c:choose> 
		</c:forEach>
	</c:forEach>
}

function fn_getPcMobileImg(isPc, fileName) {
	var rtnFileName = "";
	if ( isPc ) {
		rtnFileName = fileName;
	} else {
		var fileArray = fileName.split(".");
		var lastPos = fileName.lastIndexOf(".");
		rtnFileName = fileName.substring(0, lastPos) + "_m." + fileName.substring(lastPos + 1);
	}
	
	//console.log(rtnFileName);
	return rtnFileName;
}

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" ) {
			$("#pageNum").val(pParam.page);
			$("#shap").val("screen_postscript");
		}
		
		gfn_goPage("/main/content",$("#frm").serialize());
	}
}

function lfn_openChannel(channel) {
	<c:choose>
		<c:when test = "${session == null}">
			window.open("http://" + channel + "." + window.location.host.replace("www.",""));
		</c:when>
		<c:otherwise>
			$("#channel").val(channel);
			document.frm.action = "/openChannel.do";	
			document.frm.target = "tranFrame";	
			document.frm.submit();		
		</c:otherwise>
	</c:choose> 
}


</script>

<body>
<form name="frm" id="frm" method="post">
	<input type='hidden' id='channel' name='channel' value="">
	<input type='hidden' id='shap' name='shap' value="">
	<input type='hidden' id='mainViewMode' name='mainViewMode' value="${set.condiVO.mainViewMode}">
	
<frameset rows='*'>
    <div class="wrap" >
        <!-- HEAD -->
        <div id='width_text'></div>
        <!-- HEAD START -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuQch.jsp" %>

<c:forEach var="row" items="${set.mainFrame}" varStatus="idx">
	<c:set var = "detailList" value = "${set.mainFrameDetailHm[row.SEQ]}"/>
	<c:choose>
 		<c:when test = "${row.FRAME_KIND eq 'DOT_SLIDE'}">
 			<div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
	            <ul class='slider_wrap tabs' id='tab${row.SEQ}'>
					<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
		                <li class='slide_box slide_${detailRow.SEQ}' onclick="fn_linkCall(${detailRow.SEQ})">
		                    <div class='visual_box'>
		                        <div class='slide clear_fix'>
		                            <div class='slider_text_box'> 
		                                
		                            </div>
		                        </div>
		                    </div>
		                </li>
					</c:forEach>
	            </ul>
	      	</div>
        </c:when>
  		        <style>
				.tab_type1{
					width:1122px;
					margin: 0 auto 20px;
					font-weight: 300;
				}
				.tab_type1 ol{display: flex;}
				.tab_type1 li{
					flex:1;
					border: 1px solid #e8e8e8;
					background-color: #e8e8e8;
				}   
				.tab_type1 li:hover {
					border-color: #222 ;
					background-color: #fff;
					font-weight: 400;
					}
				.tab_type1 li a{
					display: block;
					height: 48px;
					text-align: center;
					line-height: 48px;
					font-weight:700;
				}
			</style>
		<div class='process_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">	
          	<nav class="tab_type1">
	              <ol>
	                  <li ><a href="#">전체</a></li>
	                  <li ><a href="#">직무/비지니스</a></li>
	                  <li><a href="#">IT/프로그래밍</a></li>
	                  <li><a href="#">디자인</a></li>
	                  <li><a href="#">인문/사회</a></li>
	                  <li><a href="#">초/중/고등 학습</a></li>
	                  <li><a href="#">생활/취미</a></li>
	                  <li><a href="#">자격증</a></li>
	              </ol>
          	</nav>
         </div> 	
 		<c:when test = "${row.FRAME_KIND eq 'DOT_S_SLIDE'}">
            <div class='process_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
	            <ul class='slider_wrap tabs' id='tab${row.SEQ}'>
					<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
		                <li class='slide_box slide_${detailRow.SEQ}' onclick="fn_linkCall(${detailRow.SEQ})">
		                    <div class='visual_box'>
		                        <div class='slide clear_fix'>
		                            <div class='slider_text_box'>
		                                
		                            </div>
		                        </div>
		                    </div>
		                </li>
					</c:forEach>
	            </ul>
            </div> 		
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'SLIDE'}">
            <div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
                <div class="r_bg">
                    <div class="r_bg_b2">
                            <div class="r_div">
                                <ul class='clear_fix' id="r_ul">
									<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                                    <li class='recommend slide_${detailRow.SEQ} clear_fix <c:if test="${idx2.last}">last_right</c:if>' onclick="fn_linkCall(${detailRow.SEQ})">
	                                        <p class='recommend_text'></p>
	                                    </li>
									</c:forEach>
                                </ul>
                            </div>
                    </div>
                </div>
            </div>			
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'THUMBNAIL_SLIDE'}">
            <div class='s_recommend_wrap lectures_wrap'>
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
            </div>
            <div class="star_slide" style="margin-bottom:${row.BOTTOM_HEIGHT}px">
            	<img id="star_back" src="/resources/homepageQch/img/main/star_b.png" alt="" width="74" onclick="back('thumbnailSlide_${row.SEQ}')">
           		<div class="slide" id="s_slide">
                    <ul id="thumbnailSlide_${row.SEQ}">
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="javascript:" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_p_${detailRow.SEQ}"></div></a>
						</c:forEach>
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="javascript:" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_${detailRow.SEQ}"></div></a>
						</c:forEach>
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="javascript:" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_n_${detailRow.SEQ}"></div></a>
						</c:forEach>
                      </ul>
                </div>
                <img id="star_next" src="/resources/homepageQch/img/main/star_n.png" alt="" width="74" onclick="next('thumbnailSlide_${row.SEQ}')">
           </div>
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'MP4'}">
 			<div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>

	            <div class="v1">
					<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
            			<a href="javascript:" onclick="fn_linkCall(${detailRow.SEQ})"><img src="${detailRow.BK_IMAGE_URL}" alt=""></a>
            		</c:forEach>
	            </div>
			</div>
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'IMAGE'}">
 			<div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	 				<div class="img_iframe" id="title_on" style="background:${detailRow.BK_COLOR};">
	                    <div class="q_iframimg">
	                		<img src="" class="slide_i_${detailRow.SEQ}" onclick="fn_linkCall(${detailRow.SEQ})" style="cursor:pointer">
	               		 </div>
	                </div>
	 			</c:forEach>
 			</div> 
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'IMAGE_MP4'}">
			<div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                <div class="img_iframe" id="title_on">
						<div class="top2_txt">
							<div class="p_v1_txt slide_mi1_${detailRow.SEQ}">
							</div>
							<div class="p_v1_vod">
								<div class="p_v1">
									<a onclick="fn_linkCall(${detailRow.SEQ})"><img src="" alt="" class="slide_mi2_${detailRow.SEQ}"></a>
								</div>
							</div>
						</div>
				 	</div>
	 			</c:forEach>
         	</div>        
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'MP4_IMAGE'}">
			<div class='recommend_wrap lectures_wrap' style="margin-bottom:${row.BOTTOM_HEIGHT}px">
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                <div class="img_iframe" id="title_on">
						<div class="top2_txt">
							<div class="p_v1_vod">
								<div class="p_v1">
									<a onclick="fn_linkCall(${detailRow.SEQ})"><img src="" alt="" class="slide_mi1_${detailRow.SEQ}"></a>
								</div>
							</div>
							<div class="p_v1_txt slide_mi2_${detailRow.SEQ}">
							</div>
						</div>
				 	</div>
	 			</c:forEach>
         	</div>        
       	</c:when>
        <c:otherwise>
        	메인 프레임 정보가 없습니다.
        </c:otherwise>
	</c:choose>                    
</c:forEach>

            <div class="m1">
                <div id="movie1">
                	<div class="v1_close" id="vclose" onClick="fn_close()">
                		<img src ="/resources/homepageQch/img/main/ic_menu_close.png" alt="">
                	</div>
                    <video id="video1" controls>
                         <source id="mp4" src="${detailRow.LINK_URL}" type="video/mp4">
                    </video>
                </div>
            </div>
             
            <div class='user_cs clear_fix'>
                <div class='user_cs_notice_box'>
                    
                
                
            </div>

        </div>
        
         <!-- CONTENTS END -->
	<div id='screen_postscript'></div>
	         
<c:if test = "${fn:length(set.postScriptList) > 0}">
    <div class="p_visual3_bg">    
        <div class="p_visual3">
                <!-- Search Result Area -->
                <div class='p_search_result'>
                    <ul class='p_result_list'>
	<c:forEach var="row" items="${set.postScriptList}" varStatus="idx">
                        <li class='clear_fix'>
                            <div class='p_result_con con clear_fix'>
                                <div class='p_result_img'>
                                    <a href="#" onclick="gfn_goPage('/main/mainCourseData','courseId=${row.courseId}')"><img src='/cImage/contents/${row.courseCode}/cImg.jpg' alt=' '></a>
                                </div>
                                <div class='p_result_text'>
                                    <p class="p_result_text_2">[ ${row.courseName} ]</p>
                                    <p class="p_result_text_3">${fn:replace(row.contents, newLineChar, "<br>")}</p>
                                </div>
                            </div>
                            <div class='p_result_review con'>
                                <div class='clear_fix'>
                                	<img src="/resources/homepageQch/img/main/u_line.png" alt='' class="u_line">
	                                <span><img src='/resources/homepageQch/img/course/${row.eval1}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.eval2}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.eval3}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/course/${row.eval4}.png' alt=''></span> 
	                                <span><img src='/resources/homepageQch/img/course/${row.eval5}.png' alt=''></span>
                                    <p class="p_result_text_4"><span  class="p_result_txt_name">by ${row.userName}</span><div class="p_result_txt_date">${row.updateDateStr}</div></p>
                                    <div><a href="#" onclick="gfn_goPage('/main/mainCourseData','courseId=${row.courseId}')" class="p_result_text_btn">더보기</a></div>                                        
                                </div>
                            </div>
                        </li>
	</c:forEach> 
                    </ul>
                </div>
              </div>
            </div>
            </div>
            
	<c:forEach var="row" items="${set.postScriptList}" varStatus="idx">
            <div class="mobile_recomm">
            	<div class='mobile_menu tutorial' id="mobile_r1">
                    <button id="menu_b_btn" onclick="gfn_goPage('/main/mainCourseData','courseId=${row.courseId}')">
                        <div class='p_result_text'>
                                <p class="p_result_text_2">[ ${row.courseName} ]</p>
                                <p class="p_result_text_3">${fn:replace(row.contents, newLineChar, "<br>")}</p>
                                <p class="p_result_text_4" id="t4">
                                    <span  class="p_result_txt_name">by ${row.userName}</span>
                                    <div class="p_result_txt_date">${row.updateDateStr}</div>
                                </p>
                                
                            </div>
                    </button>
                </div>
            </div>
	</c:forEach> 
            
            
			<input type='hidden' id='pageNum' name='pageNum' value="${set.condiVO.pageNum}">
        	<div class='p_pager_box'>
                <div class='p_pager clear_fix'>
	                <div class='p_pager_prev clear_fix' id="pagingLayerPrev">
	                </div>
	                <ul class='clear_fix' id="pagingLayer">
	                </ul>
	                <div class='p_pager_next clear_fix' id="pagingLayerNext">
	                </div>
                </div>
            </div>
</c:if>        
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
<script src='/resources/homepageQch/js/main.js'></script>
<script type="text/javascript">

var idxInfo = {};
function back(objId) {
	var imgs = $("#" + objId);
	var img_count = imgs.children().length;
	
	if ( idxInfo[objId] == undefined ) {
		idxInfo[objId] = 1;
	}
	
	if ( idxInfo[objId] > ( ( img_count / 3 ) - 1 ) * -1 ) {
      	imgs.animate({
        	left:'+=224px'
      	});
      	idxInfo[objId] = idxInfo[objId] - 1;
    }
}

function next(objId) {
	var imgs = $("#" + objId);
	var img_count = imgs.children().length;
	
	if ( idxInfo[objId] == undefined ) {
		idxInfo[objId] = 1;
	}
	
	if ( idxInfo[objId] < ( img_count / 3 ) + 1 ){
      	imgs.animate({
        	left:'-=224px'
      	});
      	idxInfo[objId] = idxInfo[objId] + 1;
    } 
}

function fn_show(mp4File){
	movie1.style.display= "block";
	vclose.style.display = "block";
	
	$("#mp4").attr("src", mp4File);
	video1.load();
	video1.play();
}

function fn_close(){
	movie1.style.display= "none";
	vclose.style.display = "none";
	
	video1.currentTime= 0;
	video1.pause();
}

</script>

</frameset>

<iframe name="tranFrame" id="tranFrame" style="display: none;"></iframe>

</form>

</body>

</html>