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
    <link rel='stylesheet' href='/resources/homepageCch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageCch/css/mypage/mypage_register.css'>   
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
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>
	<input type="hidden" id="seq" name="seq" value="${set.condiVO.seq}"/>

<frameset rows='*'>
    <div class='wrap'>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopCch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuCch.jsp" %>

            <div class='contents_wrap_box'>
                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepageCch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepageCch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>상담상세보기</p>
                        </div>
                    </div>
                    <h1>
                        상담 <span>상세</span>보기
                    </h1>
                </div>
                <!-- Top END -->

				<div class='notice_register clear_fix'>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>제목</p>
                        </div>
                        <div>
                            <input type='text' name='title' id='title' value="${set.data.title}" readonly>
                        </div>
                    </div>
                    <div class='form_box clear_fix'>
                        <div class='title'>
                            <p>분류</p>
                        </div>
                        <div>
                            <select name='category' id='category' class='type' disabled>
                                <option value=''>분류를 선택해주세요.</option>
<c:forEach var="row" items="${set.ddCategory}">
				              	<option value="${row.ddKey}" <c:if test="${set.data.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class='form_box clear_fix flex'>
                        <div class='title'>
                            <p>내용</p>
                        </div>
                        <div class='editor_area'>
                        	${set.data.contents}
                        </div>
                    </div>
                    <div class='form_box clear_fix flex'>
                        <div class='title'>
                            <p>답변</p>
                        </div>
                        <div class='editor_area'>
                        	${set.data.answer}
                        </div>
                    </div>
                </div>
                <div class='detail_btn_area'>
<c:if test="${set.data.answerYn eq 'X'}">	                
                    <button onclick="lfn_btn('update');" class='bg_color'>수정</button>
                    <button id="saveBtn" onclick="lfn_btn('delete');">삭제</button>
</c:if>                    
                    <button onclick="lfn_btn('list');">리스트</button>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomCch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepageCch/js/main.js'></script>

</body>
</html>