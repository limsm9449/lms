<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>


<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">
$(document).ready(function() {
});

var preUrl = "/approvalNormal/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "refund" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("환불처리를 하시겠습니까?") == false )
			return false;
		
		btnUnbind("saveBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "approvalNormalRefundUpd.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "UPDATE_OK") {
					alert("환불처리가 완료되었습니다.");
					opener.lfn_btn("search");
					self.close();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "close" ) {
		self.close();
	}
}

function lfn_validate() {
	if ( formValid.check("refundBank",{isNecess:true,maxLeng:20}) == false )
		return false;
	if ( formValid.check("refundAccNum",{isNecess:true,isAccountNum:true,maxLeng:20}) == false )
		return false;
	if ( formValid.check("refundCost",{isNecess:true,isNum:true}) == false )
		return false;
	
	return true;
}

</script>

<body>

* 환불처리

<form id="frm" name="frm" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}" />
	<input type="hidden" id="userId" name="userId" value="${set.condiVO.userId}" />
	
	<div>
		<table>
			<tr>
				<td>입금금액</td>
				<td><fmt:formatNumber value="${set.data.paymentCost}" type="number"/></td>
			</tr>
			<tr>
				<td>환불 은행</td>
				<td><input type="text" id="refundBank" name="refundBank"/></td>
			</tr>
			<tr>
				<td>환불 계좌번호</td>
				<td><input type="text" id="refundAccNum" name="refundAccNum"/></td>
			</tr>
			<tr>
				<td>환불금액</td>
				<td><input type="text" id="refundCost" name="refundCost"/></td>
			</tr>
		</table>
	</div>

	<a href="#" id="saveBtn" onclick="javascript:lfn_btn('refund'); return false;"><img src="<c:url value="/resources/images/btn/btn_save.gif"/>"></a>
	<a href="#" onclick="javascript:lfn_btn('close'); return false;"><img src="<c:url value="/resources/images/btn/btn_cancel.gif"/>"></a>
	
</form>

</body>
</html>


