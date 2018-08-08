<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

<%-- CLEditor --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/CLEditor/jquery.cleditor.css"/>" />
<script type="text/javascript" src="<c:url value="/resources/CLEditor/jquery.cleditor.min.js"/>"></script>

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
			btnUnbind("mailBtn");
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


<form id="frm" name="frm" method="post">

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
   	 		String menuId = "mailQuesttion";
   	 	%>
		<%@ include file="../home/userLeft3.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>학습지원<span>&gt;</span>1:1메일문의</div>
			<!-- title -->
			<h3 class="tit_big">1:1메일문의</h3>
		      <div class="artcle">
		      	<div class="faq_msg_box">
		      		<p class="big_2"><span class="blue">큐러닝</span>에 문의하세요.</p>
		      		<p class="info">온라인 교육문의 및 학습지원센터를 통해서도 찾지도 못하신 문의는 1:1 메일문의로 자세히 안내 받으실 수 있습니다.<br />
									컨텐츠 오류와 같이 학습 중 불편하신 사형이나 건의하고자 하는 사항 그리고 큐러닝을 칭찬하는 모든 사항들을 이곳에 남겨 주세요. <br />
									빠른 시일 내에 답변해드리겠습니다.
							</p>
							<p class="time">※ 1:1 메일 상담시간 : 평일 08:00 ~17:00</p>
		      	</div>
		        <div id="send_mail_box">
		          <form name="frm" method="post">
		          <table class="send_mail_form">
		            <caption>질문하기 폼</caption>
		  					<thead>
		  					  <tr class="guide">
		    						<th width="90"></th>
		    						<th></th>
		    						<th width="90"></th>
		    						<th></th>
		    					</tr>
		  					</thead>
		  					<tbody>
		  					  <tr>
		                <th><label for="userName">이름</label></th>
		                <td colspan="3"><input type="text" name="userName" id="userName" /></td>
		              </tr>
		              <tr>
		                <th><label for="email">메일주소</label></th>
		                <td><input type="text" name="email" id="email" class="half" /></td>
		                <th class="updown_border"><label for="mobile">전화번호</label></th>
		                <td><input type="text" name="mobile" id="mobile" class="half" /></td>
		              </tr>
		              <tr>
		                <th><label for="subject">제목</label></th>
		                <td colspan="3"><input type="text" name="mailSubject" id="mailSubject" class="full" /></td>
		              </tr>
		              <tr>
		                <th><label for="category">분류</label></th>
		                <td colspan="3">
			                <select id="category" name="category">
					            <option value="">분류를 선택해주세요</option>
								<c:forEach var="row" items="${set.ddMailList}">
					              	<option value="${row.ddKey}">${row.ddValue}</option>
								</c:forEach>
							</select>
		                </td>
		              </tr>
		              
		              <tr class="last_line">
		                <th><label for="contents">내용</label></th>
		                <td colspan="3">
		                  <textarea id="mailContents" name="mailContents" style="margin: 5px 0;width: 95%;height: 350px;border: 1px solid #e5e5e5;"></textarea>
		                </td>
		              </tr>
		            </tbody>  
		          </table>
		          <div class="center_btn">
		            <a id="mailBtn" href="javascript:" onclick="lfn_btn('sendMailQuestion');"><img src="/resources/images/sub/btn_reg.png" /></a>&nbsp;<a href="javascript:" onclick="page.refresh();"><img src="/resources/images/sub/btn_censel.png" /></a>
		          </div>
		          </form>
		        </div>
		      </div>
			<br />
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


