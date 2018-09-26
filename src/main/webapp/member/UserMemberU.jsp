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


$(document).ready(function() {
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/member/userMemberUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
	
						lfn_goBack();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "list") {
		lfn_goBack();
	}
}

function lfn_goBack() {
	if ( "<c:out value="${set.condiVO.screen}"/>" == "compUser" )
		gfn_goPage("/compUser/compUserList",top.gCondition.compUser.param);
	else if ( "<c:out value="${set.condiVO.screen}"/>" == "admin" )
		gfn_goPage("/member/memberList",top.gCondition.member.param);
}

function lfn_validate() {
	if ( formValid.check("email",{isNecess:true,maxLeng:50,isEmail:true}) == false ) return false;
	
	return true;
}

</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="screen" name="screen" value="<c:out value="${set.condiVO.screen}"/>">
	<input type="hidden" id="compCd" name="compCd" value="<c:out value="${set.data.compCd}"/>">


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
		<%
   	 		String menuId = "userMemberU";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의정보<span>&gt;</span>회원정보수정</div>
			<!-- title -->
			<h3 class="tit_big">회원정보수정</h3>
		      <div class="artcle">
		        <div class="joinflow_box">
		          <p>입력하신 회원님의 개인정보를 안전하게 하기 위해 최선을 다하고 있으며,회원님의 동의없이 제 3자에게 제공되지 않으며, 개인정보취급방침에 따라 외부 위협으로부터 안전하게 보고하고 있습니다.</p>
		          <p class="big_2"><span class="blue">회원정보입력</span></p>
		          <p><img src="/resources/images/sub/icon/icon_bullet_1.png" />&nbsp;표시는 반드시 입력하셔야 하는 필수 정보입니다.</p>
		        </div>
		        <div class="user_join_box">
		          <form name="frm" method="post">
		          <input name="compCd" id="compCd" type="hidden" value="" />
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
		                <td>${set.data.userName}</td>
		              </tr>
		              <tr>
		                <th><label for="userId" class="must">아이디</label></th>
		                <td>${set.data.userId}<input type="hidden" name="userId" id="userId" value="${set.data.userId}" /></td>
		              </tr>
		              <tr>
		                <th><label for="sex" class="must">성별</label></th>
		                <td>${set.data.sexName}</td>
		              </tr>
		              <tr>
		                <th><label for="birthDay" class="must">생년월일</label></th>
		                <td>${set.data.birthDay}</td>
		              </tr>
		              <tr>
		                <th><label for="mobile1" class="must">휴대전화번호</label></th>
		                <td>
		                  <input type="text" id="mobile" name="mobile" style="width:120px" maxlength="13" value="${set.data.mobile}">
		                </td>
		              </tr>
		              <tr>
		                <th><label for="homeTel1">전화번호</label></th>
		                <td>
		                  <input type="text" id="homeTel" name="homeTel" style="width:120px" maxlength="13" value="${set.data.homeTel}">
		                </td>
		              </tr>
		              <tr>
		                <th><label for="email" class="must">이메일주소</label></th>
		                <td><input type="text" name="email" id="email" title="이메일 주소" value="${set.data.email}" /></td>
		              </tr>
		            </tbody>  
		          </table>
		          <div class="center_btn">
		            <a href="javascript:" id="saveBtn" onclick="lfn_btn('save');"><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="javascript:" onclick="window.location='/member/userMemberU.do';"><img src="/resources/images/sub/btn_censel.png" /></a>
		          </div>
		          </form>
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

