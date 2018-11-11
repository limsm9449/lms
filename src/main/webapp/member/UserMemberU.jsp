<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko' data-useragent='Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 나의강의실 - 회원정보수정</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/etc/signup.css'>
</head>

<script type="text/javascript">


$(document).ready(function() {
	$("#userYear").val("${set.data.birthDay}".substring(0,4));
	$("#userMonth").val("${set.data.birthDay}".substring(5,7));
	$("#userDay").val("${set.data.birthDay}".substring(8,10));
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			$("#sex").val($("input:radio[name=user_gender]:checked").val());
	  		$("#birthDay").val($("#userYear").val() + "-" + $("#userMonth").val() + "-" + $("#userDay").val());
			
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/userMemberUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
	
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
	if ( formValid.check("email",{isNecess:true,maxLeng:50,isEmail:true}) == false ) return false;
	
	return true;
}

</script>

<body>

<form id="frm" name="frm" method="post">
	<input type="hidden" name="userId" id="userId" value="${set.data.userId}" />
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">
	
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTop.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap_box' onmouseover='sub_hide()'>
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
                        <p>회원정보수정</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    회원정보수정
                </h1>
                <div class='signup_title_box'>
                </div>
                <div class='signup_input_list'>
                	
                    <div class='certification_name clear_fix'>
                        <p>이름</p>
                        <input type="text" name="userName" id="userName" value="${set.data.userName}" disabled>
                    </div>
                    <div class='certification_gender clear_fix'>
                        <p>성별</p>
                        <input type='radio' name='user_gender' id='g_male' value="M" <c:if test="${set.data.sex eq 'M' }">checked</c:if> ><span>남자</span>
                        <input type='radio' name='user_gender' id='g_female' value="F" <c:if test="${set.data.sex eq 'F' }">checked</c:if> ><span>여자</span>
                    </div>
                    <div class='certification_birth clear_fix'>
                        <p>생년월일</p>
                        <select id="userYear" name="userYear">
                                <option value=''>선택</option>
<c:forEach var="i" begin="${set.birthFromYear}" end="${set.birthToYear}" step="1" varStatus ="status">
    							<option value="${i}">${i}</option> 
</c:forEach>   
                            </select>
                        년
                        <select id="userMonth" name="userMonth">
                                <option value=''>선택</option>
<c:forEach var="i" begin="1" end="12" step="1" varStatus ="status">
	<c:if test="${i < 10}">
                                <option value="0${i}">${i}</option>
	</c:if>     
	<c:if test="${i >= 10}">
                                <option value="${i}">${i}</option>
	</c:if>     
</c:forEach>    
                            </select>
                            월
                            <select id="userDay" name="userDay">
                                <option value=''>선택</option>
<c:forEach var="i" begin="1" end="31" step="1" varStatus ="status">
	<c:if test="${i < 10}">
                                <option value="0${i}">${i}</option>
	</c:if>     
	<c:if test="${i >= 10}">
                                <option value="${i}">${i}</option>
	</c:if>     
</c:forEach>     
                            </select>
                        일
                    </div>
                    <div class='info_input_phone clear_fix'>
                        <p>휴대폰 번호</p>
                        <input type='text' name='mobile' id='mobile' value="${set.data.mobile}">
                    </div>
                    <div class='certification_name clear_fix'>
                        <p>E-Mail</p>
                        <input type="text" name="email" id="email" value="${set.data.email}"/>
                    </div>
                    <div class='info_input_address clear_fix'>
                        <p>주소</p>
                        <input type='text' name='homeZipcode' id='homeZipcode' value="${set.data.homeZipcode}">
                        <button onClick="window.open('${set.zipcodeUrl}', 'zipcode','width=900,height=650');">우편번호검색</button>
                        <input class="last_left" type='text' name='homeAddr' id='homeAddr' value="${set.data.homeAddr}">
                    </div>
                </div>
                <div class='signup_btn_box clear_fix'>
                    <button onclick='page.goHome();'>취소</button>
                    <button class='last' id="saveBtn" onclick="lfn_btn('save');">저장</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottom.jsp" %>
        <!-- FOOTER END -->
    </div>

    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>

</frameset>

</form>

</body>

</html>