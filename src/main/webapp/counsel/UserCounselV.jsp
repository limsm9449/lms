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
    <title>Q learning - 나의강의실 - 상담내역 상세보기</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/notice_detail.css'>
</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		if ( confirm("삭제하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + "/counsel/userCounselDel.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "DELETE_OK") {
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="update" ) {
		gfn_goPage("/counsel/userCounselU","seq=${set.condiVO.seq}"); 
	} else if ( pKind =="list" ) {
		gfn_goPage("/counsel/userCounselList",""); 
	}
}

</script>

<body style='background:#fff'>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="seq" name="seq" value="${set.condiVO.seq}"/>

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap qna' onmouseover='sub_hide()'>
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
                            <p>나의강의실</p>
                            <span>
                                <img src='/resources/homepage/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>상담상세보기</p>
                        </div>
                    </div>
                    <h1>
                        상담 <span>상세</span>보기
                    </h1>
                </div>
                <!-- Top END -->

                <div class='notice_detail_box question'>
                    <div class='notice_title_box'>
                        <p>${set.data.title}</p>
                    </div>
                    <div class='notice_info_box clear_fix'>
                        <div class='notice_regDate'>
                            <p class='type'>등록일</p>
                            <p>${set.data.createDate}</p>
                        </div>
                    </div>
                    <div class='iframe_contents'>
                        ${set.data.contents}
                    </div>
                </div>
                <div class='notice_detail_box answer'>
                    <div class='notice_title_box'>
                        <p>답변</p>
                    </div>
                    <div class='iframe_contents'>
                        ${set.data.answer}
                    </div>
                </div>
                <div class='detail_btn_area'>
                    <button onclick="lfn_btn('update');" class='bg_color'>수정</button>
                    <button id="saveBtn" onclick="lfn_btn('delete');">삭제</button>
                    <button onclick="lfn_btn('list');">취소</button>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepage/js/dev_sub.js'></script>

</body>
</html>