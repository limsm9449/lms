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
    <title>Q learning - 마이페이지 - 비밀번호 변경</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_main.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_table.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_re.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage.css'>
</head>


<script type="text/javascript">

$(document).ready(function() {
	$("#userPassword").focus();	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/memberChangePasswordUpdate.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "PASSWORD_ERROR") {
						alert("기존 비밀번호가 틀립니다.");
						$("#userPassword").focus();
						btnBind("saveBtn");
					} else if ( json.rtnMode == "PASSWORD_OK") {
						alert("비밀번호가 변경되었습니다.");
						page.goHome();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

function lfn_validate() {
	if ( formValid.check("userPassword",{isNecess:true,maxLeng:15}) == false )
		return false;
	if ( formValid.check("newUserPassword",{isNecess:true,minLeng:6,maxLeng:12}) == false )
		return false;
	if ( formValid.check("newUserPassword2",{isNecess:true,minLeng:6,maxLeng:12}) == false )
		return false;
	if ( isExistNumAlpha($("#newUserPassword").val()) == false ) {
		alert("영문/숫자(혼용)를 입력하셔야 합니다.");
		$("#newUserPassword").focus();
		return false;
	}
	if ( $("#newUserPassword").val() != $("#newUserPassword2").val() ) {
		alert("비밀번호는 일치해야 합니다.");
		$("#newUserPassword2").focus();
		return false;
	}
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap process'>
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>
            
            <div class='contents_wrap_box'>
                <!-- Top -->
                <div class='top_area'>
                    <div class='clear_fix'>
                        <div class='process_history_box clear_fix'>
                            <span>
                                <img src='/resources/homepagePch/img/course/ic_home.jpg' alt=' '>
                            </span>
                            <p>HOME</p>
                            <span>
                                <img src='/resources/homepagePch/img/course/arr_right.jpg' alt=' '>
                            </span>
                            <p>마이페이지</p>
                        </div>
                    </div>
                    <h1>
                        <span>마이</span>페이지
                    </h1>
                </div>
                <!-- Top END -->

                <div class='classroom_subtitle'>
                </div>

                <!-- TAB AREA -->
                <div class='register_method_tab clear_fix'>
                    <a href='javascript:' onclick="page.goPage('/main/myOrder');"><button id="g1">주문/신청 <span></span>조회</button></a>
                    <a href='javascript:' onclick="page.goPage('/main/myPoint');"><button id="point_2">포인트<span></span></button></a>
                    <a href='javascript:'><button class="on">나의 <span></span>활동관리</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/userMemberU');"><button>회원<span></span>정보수정</button></a>
                    <a href="javascript:" onclick="page.goPage('/member/memberChangePassword');"><button>비밀번호 <span></span>변경</button></a>
                </div>

                <!-- REGISTER PC VERSION -->
                <div class='register_method_pc1'>
                    <!-- <img src='../../img/notice/pc.jpg' alt=' '> -->
                    <ol>
                        
                        <!-- Contents -->
                    <div class="pra_point">
                        	<ul>
                        		<li>나의 활동관리는 내가 등록한 문의 및 질문글과 답변글을 조회하는 페이지입니다.</li>
                            	<li>서비스 관련 질문은 고객지원의 1:1메일문의를 이용해 주세요.</li>
                             </ul>
                    </div>
                    <div class="pra2_point">
                        <div class="t1_point">
                            상담내역
                        </div>
                        <div class="t1_point_txt">
                            1:1 메일 문의에 대한 답변을 확인하실 수 있습니다.
                        </div>
                        <div class='t1_point_btn'>
                            <button class='process_result_pra' onclick="page.goPage('/counsel/userCounselList');">더보기</button>
                         </div>
                    </div>
                    <table class="pra_table">
                    	<tr class="pra_table_top">
                        	<td class="pra_table_top_1">번호</td>
                            <td class="pra_table_top_2">분류</td>
                            <td class="pra_table_top_3">제목</td>
                            <td class="pra_table_top_4">등록일</td>
                            <td class="pra_table_top_5">답변상태</td>
                        </tr>
<c:if test="${empty set.myCounselList}">
						<tr class="last_line">
							<td colspan="5" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if>                          
<c:forEach var="row" items="${set.myCounselList}" varStatus="idx">
                        <tr>
                        	<td class="pra_table_mid_1">${idx.count}</td>
                            <td class="pra_table_mid_2">${row.categoryName}</td>
                            <td class="pra_table_mid_3"><a href="#" onClick="javascript:page.goPage('/counsel/userCounselV','seq=${row.seq}');  return false;">${row.title}</a></td>
                            <td class="pra_table_mid_4">${row.createDate}</td>
                            <td class="pra_table_mid_5">${row.answerYn}</td>
                        </tr>
</c:forEach>                        
                    </table>
                    
					<!-- Search Result Area -->
                    <div class="pra2_point">
                        <div class="t1_point">
                            학습 Q&A 내역
                        </div>
                        <div class="t1_point_txt">
                            강의에 관련된 질문내역을 확인할 수 있습니다. 
                        </div>
                        <div class='t1_point_btn t2'>
                            <button class='process_result_pra' onclick="page.goPage('/main/myQnaList');">더보기</button>
                         </div>
                    </div>
                    <table class="QA_table">
                    	<tr class="QA_table_top">
                        	<td class="QA_table_top_1">과정명</td>
                            <td class="QA_table_top_2">제목</td>
                            <td class="QA_table_top_3">답변여부</td>
                            <td class="QA_table_top_4">등록일</td>
                        </tr>
<c:if test="${empty set.myQnaList}">
						<tr class="last_line">
							<td colspan="4" class="last center" style="border-right:none"><spring:message code="lms.msg.noSearchData" text="-" /></td>
						</tr>
</c:if>                          
<c:forEach var="row" items="${set.myQnaList}" varStatus="idx">
                        <tr>
                        	<td class="QA_table_mid_1">
                                <div class='process_result_text'>
                                    <div class='process_result_text_top clear_fix'>
                                        <p>일반</p>
	<c:if test="${row.mobileYn eq 'Y'}">	                                        
                                        <p class='process_result_mobile'>모바일</p>
	</c:if>  
                                    </div>
                                    <p>${row.courseName}</p>
                                    <div class='process_result_text_bottom clear_fix'>
                                        <p>교육기간</p>
                                        <p class='process_result_payment'>${row.cFromDate} ~ ${row.cToDate} (${row.cPeriod}일)</p>
                                    </div>
                                </div>
                            </td>
                            <td class="QA_table_mid_2"><a href="#" onClick="javascript:page.goPage('/main/myQnaV','seq=${row.seq}');  return false;">${row.title}</a></td>
                            <td class="QA_table_mid_3">${row.answerYn}</td>
                            <td class="QA_table_mid_4">${row.createDateStr}</td>
                        </tr>
</c:forEach>                        
                    </table>
                    <!-- Search Result Area END -->
            </div>
        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
</frameset>

</form>

<script src='/resources/homepagePch/js/main.js'></script>


</body>
</html>