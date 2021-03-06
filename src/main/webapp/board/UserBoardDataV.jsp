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
    <title>Q learning - 자료실</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_detail.css'>
</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	$("#attachFrame").attr("src","/board/attachV.do?" + "pSeq=${set.condiVO.seq}&kind=B_DATA");
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("deleteBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "boardDataDel.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					page.goPage('/board/userBoardDataList', decodeURIComponent('${set.condiVO.prevParams}'));
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="update" ) {
		gfn_goPage(preUrl + "userBoardDataU",$("#frm").serialize()); 
	}
}

</script>

<body style='background:#fff'>
<form id="frm" name="frm" action="" method="post">
	<input id="courseId" name="courseId" value="${set.condiVO.courseId}" type="hidden"/>
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>
	<input id="prevParams" name="prevParams" type="hidden" value="${set.condiVO.prevParams}">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <div class='contents_wrap_box popup'>
                <!-- TOP -->
                <div class='top_area'>
                    <h1>
                        자료실 <span>상세</span>보기
                    </h1>
                    <div class='top_text_box clear_fix'>
                        <span><img src='/resources/homepage/img/support/notice_bg.jpg' alt=' '></span>
                        <p class='top_title'>Reference Room</p>
                        <p>
                            유익한 자료를 제공합니다. <span></span>필요한 자료들을 찾아보고 활용하세요.
                        </p>
                    </div>
                </div>
                <!-- TOP END -->

                <div class='notice_detail_box question'>
                    <div class='notice_title_box'>
                        <p><c:out value="${set.data.title}" escapeXml="true" /></p>
                    </div>
                    <div class='notice_info_box clear_fix'>
                        <div class='notice_visit'>
                            <p class='type'>작성자</p>
                            <p>${set.data.userName}</p>
                        </div>
                        <div class='btn_box'>
<c:if test="${set.condiVO.isEdit eq 'Y' && session.userId eq set.data.userId}">
                            <button onclick="lfn_btn('delete');">삭제</button>
                            <button onclick="lfn_btn('update');">수정</button>
</c:if>                            
                        </div>
					</div>                                                
                    <div class='notice_info_box clear_fix'>
                        <div class='notice_visit'>
                            <p class='type'>조회</p>
                            <p>${set.data.viewCnt}</p>
                        </div>
                        <div class='notice_regDate'>
                            <p class='type'>등록일</p>
                            <p>${set.data.createDate}</p>
                        </div>
                    </div>
                    <div class='iframe_contents'>
                        <c:out value="${set.data.contents}" escapeXml="" />
                    </div>
                    <iframe id="attachFrame" name="attachFrame" style="width:100%;height:100px"></iframe>
                </div>
                <div class='detail_btn_area'>
                    <button onclick="page.goPage('/board/userBoardDataList', decodeURIComponent('${set.condiVO.prevParams}'));">목록으로</button>
                </div>

            </div>
        </div>
        <!-- CONTENTS END -->
    </div>
</frameset>

</form>
<script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>
</html>