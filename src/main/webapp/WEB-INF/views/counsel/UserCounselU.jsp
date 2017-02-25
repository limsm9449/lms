<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>

</head>

<%
	String returnParameter = 
			"findString=" + request.getParameter("findString") +
			"&pageNum=" + request.getParameter("pageNum") +
			"&seq=" + request.getParameter("seq")
			;
%>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context + "/counsel/userCounselUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="list" ) {
		gfn_goPage("/counsel/userCounselList","<%=returnParameter%>"); 
	}
}

function lfn_validate() {
	if ($("#title").val() == "") {
	    alert('제목을 입력해 주세요.');
	    $("#title").select();
	    return false;
	}  

	if ($("#category").val() == "") {
	    alert('분류를 선택해 주세요.');
	    $("#category").select();
	    return false;
	}  
	
	if ($("textarea[name='contents']").val() == "") {
	    alert('내용을 입력해주세요.');
	    return false;
	} 
	
	if ( formValid.check("title",{maxLeng:200}) == false )
		return false;
	if ( checkByte($("textarea[name='contents']").val()) > board_contents_length ) {
		alert("입력 가능한 자릿수를 넘었습니다. (" + checkByte($("textarea[name='contents']").val()) + ")");
		$("textarea[name='contents']").Focus();
		return false;
	}	
	
	return true;
}


</script>

<body>

<form id="frm" name="frm" method="post">

<input type="hidden" id="seq" name="seq" value="${set.condiVO.seq}"/>


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
   	 		String menuId = "userCounselList";
   	 	%>
		<%@ include file="../home/userLeft.jsp" %>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>나의정보<span>&gt;</span>상담내역</div>
			<!-- title -->
			<h3 class="tit_big">상담내역</h3>
		      <div class="artcle">
		        <div class="qna_list_box">
		          <p class="big_2"><span class="blue">수정하기</span></p>
		          <div id="bod_search_r">
		            <a href="javascript:" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_go_list.png" alt="목록으로 돌아가기" /></a>
		          </div>
		          <div id="bodinput_box">
		            <form name="frm" method="post">
		            <table>
		              <caption>질문하기 폼</caption>
		    					<thead>
		    					  <tr class="guide">
		      						<th width="90"></th>
		      						<th></th>
		      					</tr>
		    					</thead>
		    					<tbody>
		                <tr>
		                  <th><label for="subject">제목</label></th>
		                  <td><input type="text" name="title" id="title" class="full" value="${set.data.title}"/></td>
		                </tr>
		                <tr>
		                  <th><label for="category">분류</label></th>
		                  <td>
		                    <select id="category" name="category">
					            <option value="">전체</option>
								<c:forEach var="row" items="${set.ddCategory}">
					              	<option value="${row.ddKey}" <c:if test="${set.data.category eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
								</c:forEach>
							</select>
		                  </td>
		                </tr>
		                <tr>
		                  <th><label for="contents">내용</label></th>
		                  <td>
		                    <textarea id="contents" name="contents">${set.data.contents}</textarea>
		                  </td>
		                </tr>
		              </tbody>  
		            </table>
		            <div class="center_btn">
		              <a href="javascript:" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;"><img src="/resources/images/sub/btn_reg.png" /></a>&nbsp;<a href="javascript:" onclick="javascript:lfn_btn('list'); return false;"><img src="/resources/images/sub/btn_censel.png" /></a>
		            </div>
		            </form>
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