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
				url : context +"/set/settingSave.do",
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
		page.goPage("/set/settingList");
	}
}

function lfn_validate() {
	//Validation 검사
	objOptionValues = $("[id=optionValues]");

	for ( i = 0; i < objOptionValues.length; i++ ) {
		if ( formValid.check("optionValues",{isNecess:true,maxLeng:100},i) == false )
			return false;
	}
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" method="post">
	
<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">환경설정</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>시스템 관리</li>
	          		<li class="last">환경설정</li>
        		</ul>
			</div>


		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">환경설정</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="" id="mainTbl">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="250"></th>
	  						<th></th>
  						</tr>
						<tr>
							<th>설정키</th>
							<th class="no_line">설정값</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.settingList}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject"><input id="optionKeys" name="optionKeys" value="${row.optionKey}" style="width:80%;" readonly/></td>
				              	<td class="no_line subject"><input id="optionValues" name="optionValues" value="${row.optionValue}" style="width:95%;"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
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



