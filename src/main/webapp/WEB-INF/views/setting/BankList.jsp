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
				url : context +"/set/bankSave.do",
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
		page.goPage("/set/bankList");
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
	var cnt = $("[id=seqs]").length;
	
	var newitem = $("#mainTbl tr:eq(2)").clone();
    $("#mainTbl").append(newitem);
    
    //초기화
    $("[id=seqs]")[cnt].value = "";
    $("[id=bankNames]")[cnt].value = "";
    $("[id=accNos]")[cnt].value = "";
    $("[id=users]")[cnt].value = "";
    $("[id=useYns]")[cnt].value = "Y";
    
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
        		<h1 class="title">은행</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>시스템 관리</li>
	          		<li class="last">은행</li>
        		</ul>
			</div>


		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">은행</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="" id="mainTbl">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="40"></th>
	  						<th width="150"></th>
	  						<th></th>
	  						<th width="100"></th>
	  						<th width="70"></th>
  						</tr>
						<tr>
							<th>NO</th>
							<th>은행</th>
							<th>계좌번호</th>
							<th>예금주</th>
							<th class="no_line">사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.bankList}">
							<tr>
				              	<td class="subject"><input id="seqs" name="seqs" value="1" style="width:80%;" readonly/></td>
				              	<td class="subject"><input id="bankNames" name="bankNames" value="" style="width:95%;"/></td>
				              	<td class="subject"><input id="accNos" name="accNos" value="" style="width:97%;"/></td>
				              	<td class="subject"><input id="users" name="users" value="" style="width:95%;"/></td>
				              	<td class="no_line center">
				              		<select id="useYns" name="useYns">
				              			<option value="Y" selected>Y</option>
				              			<option value="N">N</option>
				              		</select>
				              	</td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.bankList}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject"><input id="seqs" name="seqs" value="${row.seq}" style="width:80%;" readonly/></td>
				              	<td class="subject"><input id="bankNames" name="bankNames" value="${row.bankName}" style="width:95%;"/></td>
				              	<td class="subject"><input id="accNos" name="accNos" value="${row.accNo}" style="width:97%;"/></td>
				              	<td class="subject"><input id="users" name="users" value="${row.user}" style="width:95%;"/></td>
				              	<td class="no_line center">
				              		<select id="useYns" name="useYns">
				              			<option value="Y" <c:if test="${row.useYn eq 'Y'}">selected</c:if>>Y</option>
				              			<option value="N" <c:if test="${row.useYn eq 'N'}">selected</c:if>>N</option>
				              		</select>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="f_add()" class="blueBtn">추가</a>
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
					<a href="#" onclick="javascript:lfn_btn('refresh'); return false;" class="blueBtn">취소</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>


</form>


</body>
</html>



