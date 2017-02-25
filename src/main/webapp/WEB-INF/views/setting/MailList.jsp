<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("수정하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/set/mailSave.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
						lfn_btn("refresh");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="refresh" ) {
		page.goPage("/set/mailList");
	}
}

function lfn_validate() {
	//Validation 검사
	objKinds = $("[id=kinds]");
	objEmails = $("[id=emails]");

	for ( i = 0; i < objKinds.length; i++ ) {
		if ( formValid.check("kinds",{isNecess:true,maxLeng:40},i) == false )
			return false;
		if ( formValid.check("emails",{isNecess:true,maxLeng:50},i) == false )
			return false;
	}
	
	return true;
}

function f_add() {
	var cnt = $("[id=kinds]").length;
	
	var newitem = $("#mainTbl tr:eq(2)").clone();
    $("#mainTbl").append(newitem);
    
    //초기화
    $("[id=kinds]")[cnt].value = "";
    $("[id=emails]")[cnt].value = "";
    
    parent.lfn_resize();
}

function f_delete(obj) {
	if($("#mainTbl tr").length == 3){
		alert("삭제하실 수 없습니다.");
		return false;
	}
	   
    jQuery(obj).parent().parent().remove();
    
    $("#mainTbl tr").removeClass("alt");
    $("#mainTbl tr:even").addClass("alt");
}


</script>

<body>

<form id="frm" name="frm" method="post">
	
<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">1:1 메일 담당자</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>시스템 관리</li>
	          		<li class="last">1:1 메일 담당자</li>
        		</ul>
			</div>


		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">1:1 메일 담당자</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="" id="mainTbl">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="150"></th>
	  						<th></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>분류</th>
							<th>이메일</th>
							<th class="no_line">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.mailList}">
							<tr>
				              	<td class="subject"><input id="kinds" name="kinds" value="${row.kind}" style="width:97%"/></td>
				              	<td class="subject"><input id="emails" name="emails" value="${row.email}" style="width:99%;"/></td>
				              	<td class="no_line subject">
			              			<a href="#" onclick="f_delete(this)" class="blueBtn">삭제</a>
				              	</td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.mailList}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject"><input id="kinds" name="kinds" value="${row.kind}" style="width:97%;"/></td>
				              	<td class="subject"><input id="emails" name="emails" value="${row.email}" style="width:99%;"/></td>
				              	<td class="no_line subject">
			              			<a href="#" onclick="f_delete(this)" class="blueBtn">삭제</a>
				              	</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="f_add()" class="blueBtn">추가</a>
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>


</form>


</body>
</html>



