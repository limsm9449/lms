<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>

<%@ include file="../common/commInclude.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	var today = new Date();
	$("#approvalId").val(today.getTime());
});

function lfn_btn(pKind, pParam) {
	if ( pKind == "approval") {
		btnUnbind("approvalBtn");
		
		$.ajax({
			type :"POST",
			url : context +"/main/approval.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "OK") {
					alert("결재가 완료 되었습니다.\n나의 강의실에서 과정을 들으시면 됩니다.");
					self.close();
					opener.page.goHome();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}

}

</script>

<body>

<form id="frm" name="frm" method="post">
<input id="courseId" name="courseId" type="hidden" value="${set.condiVO.courseId}"/>
<input id="totalCost" name="totalCost" type="hidden" value="${set.condiVO.totalCost}"/>
<input id="paymentPoint" name="paymentPoint" type="hidden" value="${set.condiVO.paymentPoint}"/>
<input id="paymentCost" name="paymentCost" type="hidden" value="${set.condiVO.paymentCost}"/>
<input id="paymentKind" name="paymentKind" type="hidden" value="${set.condiVO.paymentKind}"/>
<input id="paymentBank" name="paymentBank" type="hidden" value="${set.condiVO.paymentBank}"/>
<input id="approvalId" name="approvalId" type="hidden" value=""/>

	<table>
		<tr>
			<td>결재금액</td>
			<td>
				${set.condiVO.paymentCost}
			</td>
		</tr>
	</table>

	<a href="#" id="approvalBtn" onclick="javascript:lfn_btn('approval'); return false;">결재</a>

* 추후에 결재모듈이 들어와야 함 
</form>

</body>

</html>
