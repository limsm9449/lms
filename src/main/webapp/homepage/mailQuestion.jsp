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
    <title>Q learning - 공지사항 등록</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

	<%-- CLEditor --%>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor/jquery.cleditor.css"/>" />
	<script type="text/javascript" src="<c:url value="/resources/CLEditor/jquery.cleditor.min.js"/>"></script>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/support/mail.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	$("textarea[name='mailContents']").cleditor({height:450});
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "sendMailQuestion" ) {
		if ( $("#userName").val() == "" ) {
			alert("이름을 입력하세요.");
			$("#userName").focus();
			return;
		}
		if ( $("#email").val() == "" ) {
			alert("메일주소를 입력하세요.");
			$("#email").focus();
			return;
		}
		if ( $("#mobile").val() == "" ) {
			alert("전화번호를 입력하세요.");
			$("#mobile").focus();
			return;
		}
		if ( $("#category").val() == "" ) {
			alert("분류를 선택하세요.");
			$("#category").focus();
			return;
		}
		if ( $("#mailSubject").val() == "" ) {
			alert("제목을 입력하세요.");
			$("#mailSubject").focus();
			return;
		}
		if ( $("#mailContents").val() == "" ) {
			alert("내용을 입력하세요.");
			$("#mailContents").focus();
			return;
		}
		
		if ( confirm("문의메일을 보내시겠습니까?") == true ) {
			$.ajax({
				type :"POST",
				url : context + "/ns/sendMailQuestion.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "OK") {
						alert("문의 메일을 보냈습니다.");
						
						page.refresh();
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
<form name="frm" id="frm" method="post">
	<div style="display:none">
		<!-- 이것은 자동이동을 막기위함이다. -->
		<input type="submit" onclick="return false;" />
		<input type="text"/>
	</div>

    <frameset rows='*'>
        <div class='wrap'>
            <!-- PC HEADER -->
            <%@ include file="../common/mainTop.jsp" %>
            <!-- HEAD END -->

            <!-- CONTENTS -->
            <div class='contents_wrap support' >
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
                            1:1메일<span>문의</span>
                        </h1>
                        <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepage/img/support/mail_bg.jpg' alt=' '></span>
                            <p class='top_title'>
                                <strong>큐러닝</strong>에 문의하세요.
                            </p>
                            <p>
                                온라인 교육문의 및 학습지원센터를 통해서도 찾지 못하신 문의는 1:1 메일문의로 <span></span>자세히 안내받으실 수 있습니다. <span></span>콘텐츠 오류와 같이 학습 중 불편한 사항이나 건의하고자 하는 내용, 그리고 <span></span>큐러닝을 칭찬하는 모든 사항들을 이곳에 남겨주세요. <span></span>빠른 시일 내에 답변해드리겠습니다.
                            </p>
                            <p class='time'>
                                &#8251; 1:1 메일 상담시간 : 평일 09:00 ~ 18:00
                            </p>
                        </div>
                    </div>
                    <!-- Top END -->

                    <!-- Contents -->
                    <div class='mail_ask clear_fix'>
                        <div class='form_box clear_fix'>
                            <div class='title'>
                                <p>이름</p>
                            </div>
                            <div>
                                <input type="text" name="userName" id="userName" >
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>이메일</p>
                            </div>
                            <div>
                                <input type="text" name="email" id="email">
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>연락처</p>
                            </div>
                            <div>
                                <input type="text" name="mobile" id="mobile">
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>문의분류</p>
                            </div>
                            <div>
				                <select id="category" name="category">
						            <option value="">분류를 선택해주세요</option>
									<c:forEach var="row" items="${set.ddMailList}">
						              	<option value="${row.ddKey}">${row.ddValue}</option>
									</c:forEach>
								</select>
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>제목</p>
                            </div>
                            <div>
                                <input type="text" name="mailSubject" id="mailSubject">
                            </div>
                        </div>
                        <div class='form_box clear_fix flex'>
                            <div class='title'>
                                <p>내용</p>
                            </div>
                            <div>
                                <textarea id="mailContents" name="mailContents" style="margin: 5px 0;width: 95%;height: 350px;border: 1px solid #e5e5e5;"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class='detail_btn_area'>
                        <a href='javascript:' onclick="page.goHome();">취소</a>
                        <a href="javascript:" onclick="lfn_btn('sendMailQuestion');" class='bg_color'>등록하기</a>
                    </div> 
                    <!-- Contents END -->
                </div>
            </div>
            <!-- CONTENTS END -->

            <!-- FOOTER -->
            <%@ include file="../common/mainBottom.jsp" %>
            <!-- FOOTER END -->
        </div>
    </frameset>
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</body>

</html>