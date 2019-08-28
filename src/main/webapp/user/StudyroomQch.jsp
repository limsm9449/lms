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
    <title>학습창</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/myclass/classroom.css'>
</head>

<script src='/resources/homepageQch/js/main.js?timestamp=<%=timestamp%>'></script>
<script type="text/javascript" src="/resources/js/qpApi.js?timestamp=<%=timestamp%>"></script>

<script>

resources = '/resources/homepageQch/';

$(document).ready(function() {
	<c:choose>
		<c:when test="${set.courseInfo eq null}">
			alert("정상적으로 등록한 과정이 아닙니다.");
			window.close();
		</c:when>
		<c:otherwise>
			$("textarea[name='contents']").cleditor();
			
			<%-- 초기값 세팅 --%>
			QP_API.init(${set.condiVO.courseId}, ${set.courseInfo.lastWeek}, ${set.courseInfo.lastPage}, ${set.courseInfo.totalWeek}, true, false, "${set.condiVO.userId}");
	
			QP_API.openLastPage();
		</c:otherwise>
	</c:choose>
});

function mobile_show(){
	index.style.display="block";
	index_close.style.display = "block";
	index_bg.style.background = "rgba(0,0,0,0.5)";
	index_bg.style.height = "100%";
}
function mobile_close(){
	index.style.display="none";
	index_close.style.display = "none";
	index_bg.style.background = "none";
	index_bg.style.height = "0";
}

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("학습 Q&A를 등록하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn"); 
		$.ajax({
			type :"POST",
			url : context + "/board/boardQnaIns.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "INSERT_OK") {
					alert("학습 Q&A를 등록하였습니다.\n나의 Q&A 작성 내용과 답변내용은 [마이페이지 > 나의 활동관리 > 학습 Q&A 내역]에서 확인할 수 있습니다.");
					$("#title").val("");
					$("textarea[name='contents']").val("");
					btnBind("saveBtn");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}


function lfn_validate() {
	if ($("#title").val() == "") {
	    alert('제목을 입력해 주세요.');
	    $("#title").select();
	    return false;
	}  
	
	if ($("textarea[name='contents']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( formValid.check("title",{maxLeng:200}) == false )
		return false;
	if ( checkByte($("textarea[name='contents']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='contents']").val()) + ")");
		$("textarea[name='contents']").Focus();
		return false;
	}	
	
	return true;
}

</script>
	
	
<body>

<form id="frm" name="frm" action="" method="post">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>

<frameset rows='*'>
         <!--header-->
         <div class="cl_top">
         	<div class="mobile_topbtn" onclick="mobile_show();">
            	<img src="/resources/homepageQch/img/myclass/top_btn.png">
            </div>
            <div class="top_title">
        		${set.courseInfo.courseName}
            </div>
            <a class="top_exit" href="#" onclick="page.goPage('/normalUser/attendCourseList','');">닫기</a>
         </div>
         <!-----left----->   
         <div class="cl_bg" id="index_bg">
         <div class="cl_close" id="index_close" onClick="mobile_close();">
         	<img src="/resources/homepageQch/img/myclass/close.png">
         </div>
         
         <div class="cl_left" id="index">
             <div class="cl_fixed">
<c:forEach var="row" items="${set.resourceList}" varStatus="idx">
	<c:if test="${row.myWeek eq 'Y'}">                   
                <div class='left_menu tutorial'>
                    <button onclick='left_menu_open(this, "main")' class="left_b_btn" id="left_week_${row.week}">
                        <div class='left_txt'>
                                <p>${row.week}회차</p>
                                <p>${row.title}</p>
                        </div>
                    </button>
                    <ul class="left_bottom_ul">
		<c:set var="subIdx" value="1"/>                     
		<c:forEach var="row2" items="${set.resourcePageList}" varStatus="idx2">
			<c:if test="${row2.week eq row.week}">             
                        <li class="left_bottom_txt <c:if test="${subIdx eq 1}">first_depth</c:if>" onclick="QP_API.clickPage(${row.week}, ${row2.fromPage});" id="left_page_${row.week}_${row2.clip}">${row2.title}</li>
                        <c:set var="subIdx" value="${subIdx + 1}"/>     
        	</c:if>
   		</c:forEach>               
                    </ul>
                </div>
	</c:if>                
</c:forEach>               
             </div>
         </div>
         </div>
         
        <!------------------------------video--->
        <div class="videohtml">
        
        	<div class="innerhtml" >
        		<iframe name="eduContent" id="eduContent" class="innerframe" src="" style="width:100%;height: ${set.courseInfo.vPx}px;"></iframe>
            </div>
            
            <!-----------------nav-------------->
            <div class="video_nav">
                <div class="nav_btn_group">
                    <img src="/resources/homepageQch/img/myclass/b_btn.png" style="cursor:pointer" class="b_btn" onclick="QP_API.goPrevPage();">
                    <span class="leftbtn_txt">이전</span>
                    
                    <span class="nav_num">
                        <span class="now_page">1</span>
                          /  
                        <span class="total_page">13</span>
                    </span>
                    
                    <img src="/resources/homepageQch/img/myclass/n_btn.png" style="cursor:pointer" class="n_btn" onclick="QP_API.goNextPage();">
                    <span class="rightbtn_txt">다음</span>
                </div>
        	</div>
            
            <!-----------------학습Q&A------------->
            <div class="qa_nav">
            	<div class="qa_bottom">
                    <div class="qa_title">
                        학습 Q&A
                    </div>
                    <div class="qa_title_txt">
                    	강의내용과 관련하여 궁금한 내용을 물어보세요.
                    </div>
                    <div class="memo_write">
                    	<input class="memo_title" name='title' id='title' placeholder="제목을 입력해 주십시오.">
                    	<textarea class="memo_content" id="contents" name="contents" placeholder="내용을 입력해 주십시오."></textarea>
                    </div>
                    <div class="memo_savebtn">
                    	<div class="memo_save_txt">
                        	나의 Q&A 작성 내용과 답변내용은 [마이페이지 > 나의 활동관리 > 학습 Q&A 내역]에서 확인할 수 있습니다.  
                        </div>
                    	<div id="saveBtn" class="m_savebtn" onclick="javascript:lfn_btn('save');">
                        	저장
                        </div>
                    </div>
                </div>
            </div>
        </div>
</frameset>

</form>

</body>

</html>