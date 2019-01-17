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
</head>

<script type="text/javascript">

var courseInfo = {};
$(document).ready(function(){
	var isPc = ( gfn_deviceCheck() == "PC" ? true : false );
	console.log(isPc);
	
	<c:forEach var="row" items="${set.mainFrame}" varStatus="idx">
		<c:set var = "detailList" value = "${set.mainFrameDetailHm[row.SEQ]}"/>
		<c:choose>
			<c:when test = "${row.FRAME_KIND eq 'DOT_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('#tab${row.SEQ} .slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + fn_getPcMobileImg(isPc, "${detailRow.BK_IMAGE_URL}") + "') 50% 0 / contain no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'DOT_S_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('#tab${row.SEQ} .slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + fn_getPcMobileImg(isPc, "${detailRow.BK_IMAGE_URL}") + "') 50% 0 / contain no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 / contain no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'THUMBNAIL_SLIDE'}">
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_p_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 / contain no-repeat";
				</c:forEach>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 / contain no-repeat";
				</c:forEach>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
					document.querySelector('.slide_n_${detailRow.SEQ}').style.background = "${detailRow.BK_COLOR} url('" + "${detailRow.BK_IMAGE_URL}" + "') 50% 0 / contain no-repeat";
				</c:forEach>
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'IMAGE'}">
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'IMAGE_MP4'}">
			</c:when>
			<c:when test = "${row.FRAME_KIND eq 'MP4_IMAGE'}">
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>                    
	</c:forEach>
	
	f_makePageNavigator("pagingLayer",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	
	<c:if test="${!empty set.condiVO.shap}">	      	
		gfn_goScreenPosition("${set.condiVO.shap}");
	</c:if>
});

function fn_linkCall(seq) {
	if ( seq == 0 ) {
	}
	<c:forEach var="row" items="${set.mainFrame}" varStatus="idx">
		<c:set var = "detailList" value = "${set.mainFrameDetailHm[row.SEQ]}"/>
		<c:if test = "${row.FRAME_KIND ne 'IMAGE'}">
			<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
				else if ( seq == ${detailRow.SEQ} ) {
					${detailRow.LINK_URL};
				}
			</c:forEach>
		</c:if>
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
	
	console.log(rtnFileName);
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

</script>

<body>
<form name="frm" id="frm" method="post">
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
 			<div class='recommend_wrap lectures_wrap'>
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
 		<c:when test = "${row.FRAME_KIND eq 'DOT_S_SLIDE'}">
            <div class='process_wrap lectures_wrap'>
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
            <div class='recommend_wrap lectures_wrap'>
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
	                                        <p class='recommend_text' onclick='location.href = "/resources/homepageQch/html/course/register_course.html"'></p>
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
            <div class="star_slide">
            	<img id="star_back" src="/resources/homepageQch/img/main/star_b.png" alt="" width="74">
           		<div class="slide" id="s_slide">
                    <ul id="slide_ul">
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="#" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_p_${detailRow.SEQ}"></div></a>
						</c:forEach>
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="#" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_${detailRow.SEQ}"></div></a>
						</c:forEach>
						<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                        <a href="#" onclick="fn_linkCall(${detailRow.SEQ})"><div class="star slide_n_${detailRow.SEQ}"></div></a>
						</c:forEach>
                      </ul>
                </div>
                <img id="star_next" src="/resources/homepageQch/img/main/star_n.png" alt="" width="74">
           </div>
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'IMAGE'}">
 			<div class='recommend_wrap lectures_wrap'>
	 			<c:if test = "${row.FRAME_NAME ne ''}">
	 				<p>
	                    ${row.FRAME_NAME}
	                </p>
	 			</c:if>
	 			<c:if test = "${row.FRAME_DESC ne ''}">
	 				 <p class='pc'>${row.FRAME_DESC}</p>
	 			</c:if>
				<c:forEach var="detailRow" items="${detailList}" varStatus="idx2">
	                <div class="v1">
	                	<a onclick="v1_show()"><img src="${detailRow.BK_IMAGE_URL}" alt=""></a>
	                </div>
	                <div class="m1">
	                    <div id="movie1">
	                    	<div class="v1_close" id="vclose" onClick="v_close()">
	                    		<img src ="/resources/homepageQch/img/main/ic_menu_close.png" alt="">
	                    	</div>
	                        <video id="video1" controls>
	                             <source src="${detailRow.LINK_URL}" type="video/mp4">
	                        </video>
	                    </div>
	                </div>
				</c:forEach>
             </div>
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'IMAGE_MP4'}">
 			IMAGE_MP4<br>
 			<c:set var="detailList" value="${fn:split(row.BK_IMAGE_URL,'^')}" />
			<c:forEach var="telNum" items="${tel}" varStatus="idx2">
				<c:if test="${idx2.count == 1}"></c:if>
				<c:if test="${idx2.count == 2}"></c:if>
			</c:forEach> 
        </c:when>
 		<c:when test = "${row.FRAME_KIND eq 'MP4_IMAGE'}">
 			MP4_IMAGE<br>
 			<c:set var="detailList" value="${fn:split(row.BK_IMAGE_URL,'^')}" />
			<c:forEach var="telNum" items="${tel}" varStatus="idx2">
				<c:if test="${idx2.count == 1}"></c:if>
				<c:if test="${idx2.count == 2}"></c:if>
			</c:forEach> 
        </c:when>
        <c:otherwise>
        	메인 프레임 정보가 없습니다.
        </c:otherwise>
	</c:choose>                    
</c:forEach>
             
            <div class='user_cs clear_fix'>
                <div class='user_cs_notice_box'>
                    
                
                
            </div>

        </div>
        
         <!-- CONTENTS END -->
	<div id='screen_postscript'></div>
	         
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
	                                <span><img src='/resources/homepageQch/img/process/${row.eval1}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/process/${row.eval2}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/process/${row.eval3}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/process/${row.eval4}.png' alt=''></span>
	                                <span><img src='/resources/homepageQch/img/process/${row.eval5}.png' alt=''></span>
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
        
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
    <script src='/resources/homepageQch/js/main.js'></script>
    <script type="text/javascript">
    $(document).ready(function(){
      var imgs;
	  var star_count = 1;
	  var min_count = -4;
	  var max_count = 6;

      imgs = $(".slide ul");
      img_count = imgs.children().length;

      //버튼을 클릭했을 때 함수 실행
      $('#star_back').click(function () {
        back();
      });
      $('#star_next').click(function () {
        next();
      });

      function back() {
        if(star_count!=min_count){
          imgs.animate({
            left:'+=224px'
          });
		  star_count--;
        }
      }
      function next() {
        if(star_count!=max_count){
          imgs.animate({
            left:'-=224px'
          });
		  star_count++;
        } 
      }


      //이미지 끝까지 가면 버튼 사라지기
	


    });
	
	$(document).ready(function(){
      var r_imgs;
      var r_img_position = 1;
	  var r_count = 1;
	  var r_min_count = -4;
	  var r_max_count = 6;

      r_imgs = $("#r_ul");
      r_img_count = r_imgs.children().length;

      //버튼을 클릭했을 때 함수 실행
      $('#recc_back').click(function () {
        r_back();
      });
      $('#recc_next').click(function () {
        r_next();
      });

      function r_back() {
        if(r_count!=r_min_count){
          r_imgs.animate({
            left:'+=364px'
          });
          r_img_position--;
		  r_count--;
        }
      }
      function r_next() {
        if(r_count!=r_max_count){
          r_imgs.animate({
            left:'-=364px'
          });
          r_img_position++;
		  r_count++;
        }
		
      }
	   });
  </script>

</frameset>

</form>

</body>

</html>