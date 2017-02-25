<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Calendar"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>



<script type="text/javascript">
var preUrl = "/guest/"; 

$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("회원가입 하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + preUrl + "joinMemberInsert.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "EXIST_USERID") {
						alert("아이디가 존재합니다.\n다른 아이디를 입력하세요.");
						btnBind("saveBtn");
						$("#userId").focus();
					} else if ( json.rtnMode == "EXIST_EMAIL") {
						alert("이메일주소가  존재합니다.\n다른 이메일주소를 입력하세요.");
						btnBind("saveBtn");
						$("#email").focus();
					} else if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 회원가입이 되었습니다.\n발송된 이메일을 통해서 인증을 하셔야 로그인이 가능합니다.");
						
						window.location = "/guest/joinFinal.do";
					}
				},
				error : function(e) {
					btnBind("saveBtn");
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="isExistUserId" ) {
		if ( formValid.check("userId",{isNecess:true,msg:"아이디를 입력하세요.",minLeng:7,maxLeng:15}) == false ) return false;
		if ( isUserId($("#userId").val()) == false ) {
			alert("아이디는 영문자와 숫자로 구성이 되어야 합니다.");
			$("#userId").focus();
			return false;
		}

		btnUnbind("checkBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "isExistUserId.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "EXIST") {
					alert("등록된 회원 아이디 입니다.");
					$("#userId").focus();
				} else {
					alert("등록 가능한 회원 아이디 입니다.");
					$("#userIdCheck").val("Y");
				}
				
				btnBind("checkBtn");
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function lfn_goBack() {
	page.goHome();
}

function lfn_validate() {
	if ( formValid.check("userId",{isNecess:true,msg:"아이디를 입력하세요.",minLeng:7,maxLeng:15}) == false ) return false;
	if ( formValid.check("userPassword",{isNecess:true,msg:"비밀번호를 입력하세요.",minLeng:6,maxLeng:15}) == false ) return false;
	if ( formValid.check("userPassword2",{isNecess:true,msg:"비밀번호 확인을 입력하세요.",minLeng:6,maxLeng:15}) == false ) return false;
	if ( isExistNumAlpha($("#userPassword").val()) == false ) {
		alert("영문/숫자(혼용)를 입력하셔야 합니다.");
		$("#userPassword").focus();
		return false;
	}
	if ( $("#userPassword").val() != $("#userPassword2").val() ) {
		alert("비밀번호는 일치해야 합니다.");
		$("#userPassword2").focus();
		return false;
	}
	if ( formValid.check("mobile1",{isNecess:true,msg:"휴대전화번호를 입력하세요.",maxLeng:3}) == false ) return false;
	if ( formValid.check("mobile2",{isNecess:true,msg:"휴대전화번호를 입력하세요.",minLeng:3,maxLeng:4,isNum:true}) == false ) return false;
	if ( formValid.check("mobile3",{isNecess:true,msg:"휴대전화번호를 입력하세요.",minLeng:4,maxLeng:4,isNum:true}) == false ) return false;
	if ( formValid.check("email",{isNecess:true,msg:"이메일주소를 입력하세요.",maxLeng:50,isEmail:true}) == false ) return false;
	if ( $("#userIdCheck").val() != "Y" ) {
		alert("회원 아이디 검색을 하셔야 합니다.");
		$("#userId").focus();
		return false;
	}
	
	return true;
}

</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="compCd" name="compCd" value="<c:out value="${set.condiVO.compCd}"/>">

<!-- skipnav -->
<div id="skipnav"><a href="#side" class="skip">좌측메뉴 바로가기</a></div>
<div id="skipnav"><a href="#contents" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->
<!-- wrap -->
<div id="wrap" class="site">
  <%@ include file="../home/userTop.jsp" %>
  <hr />
  <!-- container -->
  <div id="container" class="site">
    	<!-- side -->
		<div id="side" class="site">
			<h2 class="s_mid">회원<span class="blue">가입</span></h2>
			<ul class="snb">
				<li><a href="javascript:" onclick="page.goPage('/guest/join');" class="here">회원가입</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/privacy');">개인정보 취급방침</a></li>
			</ul>
		</div>
		<!-- end side -->
		
   		<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>회원가입<span>&gt;</span>회원정보입력</div>
			<!-- title -->
			<h3 class="tit_big">회원가입</h3>
		      <div class="artcle">
		        <div class="joinflow_box">
		          <img src="/resources/images/sub/img_joinflow_3.png" alt="가입순서 3단계 회원정보입력" />
		          <p class="big_2"><span class="blue">회원정보입력</span></p>
		          <p><img src="/resources/images/sub/icon/icon_bullet_1.png" />&nbsp;표시는 반드시 입력하셔야 하는 필수 정보입니다.</p>
		        </div>
		        <div class="user_join_box">
		          <table>
		            <caption>회원가입폼</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="150"></th>
		    						<th></th>
		    					</tr>
		  					</thead>
		  					<tbody>
		              <tr>
		                <th><label for="userName" class="must">이름</label></th>
		                <td>${set.condiVO.userName}<input type="hidden" name="userName" id="userName" value="${set.condiVO.userName}"/></td>
		              </tr>
		              <tr>
		                <th><label for="sex" class="must">성별</label></th>
		                <td>
		                	<c:if test="${set.condiVO.sex eq 'M' }">남</c:if>
		                	<c:if test="${set.condiVO.sex ne 'M' }">여</c:if>
		                	<input name="sex" id="sex" type="hidden" value="${set.condiVO.sex}"/>
		                </td>
		              </tr>
		              <tr>
		                <th><label for="birthDay" class="must">생년월일</label></th>
		                <td>${set.condiVO.birthDay}<input name="birthDay" id="birthDay" type="hidden" value="${set.condiVO.birthDay}"/></td>
		              </tr>
		              <tr>
		                <th><label for="userId" class="must">아이디</label></th>
		                <td>
		                  <input type="text" name="userId" id="userId" onchange="$('#userIdCheck').val('N');"/>
		                  <input type="hidden" name="userIdCheck" id="userIdCheck" />
		                  <a href="#" id="checkBtn" onClick="javascript:lfn_btn('isExistUserId'); return false;"><img src="/resources/images/sub/btn_id_chk.png" /></a>
		                </td>
		              </tr>
		              <tr>
		                <th><label for="userPassword" class="must">비밀번호</label></th>
		                <td><input type="password" name="userPassword" id="userPassword" /><span> ※ 영문/숫자(혼용) 6~12글자 이내로 입력</span></td>
		              </tr>
		              <tr>
		                <th><label for="userPassword2" class="must">비밀번호 확인</label></th>
		                <td><input type="password" name="userPassword2" id="userPassword2" /><span> ※ 비밀번호를 한번 더 입력, 잊지 않도록 주의하세요.</span></td>
		              </tr>
		              <tr>
		                <th><label for="mobile1" class="must">휴대전화번호</label></th>
		                <td>
		                  <select name="mobile1" id="mobile1">
				            <option value="">선택</option>
				            <c:forEach var="row" items="${set.ddMobile}">
						       <option value="${row.ddKey}">${row.ddValue}</option>
							</c:forEach>
						  </select>
						  <input type="text" name="mobile2" id="mobile2" maxlength="4" title="휴대전화 중간번호" />
						  <input type="text" name="mobile3" id="mobile3" maxlength="4" title="휴대전화 마지막번호" />
		                </td>
		              </tr>
		              <tr>
		                <th><label for="email" class="must">이메일주소</label></th>
		                <td><input type="text" name="email" id="email" title="이메일 주소" /></td>
		              </tr>
		            </tbody>  
		          </table>
		          <div class="center_btn">
		            <a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;""><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="/"><img src="/resources/images/sub/btn_censel.png" /></a>
		          </div>
		        </div>
		      </div>
			
		</div>
		<!-- end content -->
		
	</div>
  <!-- end container -->
  <!-- footer_wrap -->
	<%@ include file="../home/bottom.jsp" %>
  <!-- end footer_wrap -->
</div>

</form>
	
</body>
</html>


