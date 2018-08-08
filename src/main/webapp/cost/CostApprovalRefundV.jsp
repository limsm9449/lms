<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	if ( pKind =="refundUpd" ) {
		if ( lfn_validate() == false )
			return false;
		
		if ( confirm("환불처리 하시겠습니까?") = true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type :"POST",
				url : context +"/cost/costRefundUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("환불처리 되었습니다.");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="list" ) {
		gfn_goPage('/cost/costApprovalList',top.gCondition.costApproval.param); 
	}
}

function lfn_validate() {
	if ( formValid.check("refundCost",{isNecess:true,isNum:true}) == false )
		return false;
	if ( formValid.check("refundBank",{isNecess:true}) == false )
		return false;
	if ( formValid.check("refundAccNum",{isNecess:true}) == false )
		return false;
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="approvalId" name="approvalId" value="${set.condiVO.approvalId}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">입금 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>입금 관리</li>
	          		<li class="last">입금 관리</li>
        		</ul>
			</div>
			    	
			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">환불처리</h3>

				<%-- 테이블 --%>
		   		<table summary="" class="view">
					<thead>
					  	<tr class="guide">
	  						<th></th>
	  						<th width="90"></th>
	  						<th width="90"></th>
  						</tr>
						<tr>
							<th>과정명</th>
							<th>비용</th>
							<th class="no_line">수강생수</th>
						</tr>
					</thead>
					<tbody>			
						<c:forEach var="row" items="${set.courseList}" varStatus="idx">
				            <tr>
				            	<td>${row.courseName}</td>
				            	<td class="right"><fmt:formatNumber value="${row.courseCost}" type="number"/></td>
				            	<td class="no_line rigjt">
				            		<c:choose>
				            			<c:when test="${row.kind eq 'C'}">
				            				${row.compUserCnt}
				            			</c:when>
				            			<c:otherwise>
				            				1
				            			</c:otherwise>
				            		</c:choose>
				            	</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
	
				<h3 class="title">결재내역</h3>
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>	
						<tr>
							<th>총 금액</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.totalCost}" type="number"/></td>
						</tr>
						<tr>
							<th>사용 Point</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.paymentPoint}" type="number"/></td>
						</tr>
						<tr>
							<th>결재 금액</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.paymentCost}" type="number"/></td>
						</tr>
						<tr>
							<th>결재 방법</th>
							<td class="no_line">${set.data.paymentKind}</td>
						</tr>
					</tbody>
				</table>
					
				<h3 class="title">환불</h3>
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th>환불 금액</th>
							<td class="no_line"><input type="text" id="refundCost" name="refundCost"></td>
						</tr>
						<tr>
							<th>환불은행</th>
							<td class="no_line"><input type="text" id="refundBank" name="refundBank"></td>
						</tr>
						<tr>
							<th>환불계좌번호</th>
							<td class="no_line"><input type="text" id="refundAccNum" name="refundAccNum"></td>
						</tr>
					</tbody>
				</table>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('refundUpd'); return false;" class="blueBtn">환불처리</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>				

			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>

</body>
</html>


