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
    <title>Q learning - 1:1 메일문의</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

	<%-- CLEditor --%>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor/jquery.cleditor.css"/>" />
	<script type="text/javascript" src="<c:url value="/resources/CLEditor/jquery.cleditor.min.js"/>"></script>
	
    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/notice_main.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/notice/mail.css'> 
    <style>
     .aaa {
    	position: relative;
	    left: 12px;
	    top: 10px;
	    width: 82.5% !important;
	    padding-bottom: 20px;
     }
    </style>
</head>

<script type="text/javascript">
$(document).ready(function() {
	//$("textarea[name='mailContents']").cleditor({height:450});
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
        <!-- HEAD START -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
       	 	<%@ include file="../common/mainQuickMenuQch.jsp" %>
       	 	<!-- QUICK MENU -->

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
                            <p>고객지원</p>
                            
                        </div>
                    </div>
                    <h1 class="two_h1">
                        고객<span>지원</span>
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href="javascript:" onclick="page.goPage('/main/noticeList');"><button id="g1">공지<span></span>사항</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/faqList');"><button>자주 <span></span>묻는 질문</button></a>
                    <a href="javascript:"><button class="on">1:1 <span></span>메일문의</button></a>
                    <a href="javascript:" onclick="page.goPage('/main/tutorial');"><button>학습<span></span>지원</button></a>
                    <a href="javascript:" onclick="page.goPage('/guest/bankInfo');"><button>입금계좌<span></span>안내</button></a>
                </div>

               
                
                
                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc3'>
                    <!-- <img src='/resources/homepageQch/img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        <li class='pc_list_item'>
                            <h1 class="two_h1">
                            1:1 메일<span class="two_h1_span">문의</span>
                        	</h1>
                        <div class='top_text_box clear_fix'>
                            <span><img src='/resources/homepageQch/img/notice/notice3_bg.png' alt=' '></span>
                            <p class='top_title'>
                                <strong>큐러닝</strong>에 문의하세요.
                            </p>
                            <p>
                                온라인 교육문의 및 학습지원센터를 통해서도 찾지 못하신 문의는 1:1 메일문의로 <span></span>자세히 안내받으실 수 있습니다. <span></span>컨텐츠 오류와 같이 학습 중 불편한 사항이나 건의하고자 하는 내용, 그리고 <span></span>큐러닝을 칭찬하는 모든 사항들을 이곳에 남겨주세요. <span></span>빠른 시일 내에 답변해드리겠습니다.
                            </p>
                            <p class='time'>
                                &#8251; 1:1 메일 상담시간 : 평일 08:00 ~ 17:00
                            </p>
                        </div>
                        <div class='mail_ask clear_fix'>
	                        <div class='form_box clear_fix flex'>
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
	                            <div class="aaa">
	                                <textarea id="mailContents" name="mailContents" style="margin: 5px 0;width: 95%;height: 350px;border: 1px solid #e5e5e5;"></textarea>
	                            </div>
	                        </div>
	                    </div>

                    <div class='detail_btn_area'>
                        <a href='javascript:' onclick="page.goHome();">취소</a>
                        <a href="javascript:" onclick="lfn_btn('sendMailQuestion');" class='bg_color'>등록하기</a>
                    </div> 
                        <!-- Contents -->
                    
                    <!-- Contents END -->
                        </li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>
<script src='/resources/homepageQch/js/main.js'></script>

</form>
</body>

</html>