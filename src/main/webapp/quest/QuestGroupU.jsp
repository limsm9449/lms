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
				url : context +"/quest/questGroupUpd.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "UPDATE_OK") {
						alert("<spring:message code="lms.msg.updateOk" text="-" />");
						lfn_btn("list");
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind =="list" ) {
		gfn_goPage('/quest/questGroupList',top.gCondition.questGroup.param); 
	}
}

function lfn_validate() {
	if ( formValid.check("groupName",{isNecess:true,maxLeng:200}) == false )
		return false;
	if ( formValid.check("useYn",{isNecess:true}) == false )
		return false;
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="qgId" name="qgId" value="${set.data.qgId}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">설문지 그룹관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>설문관리</li>
	          		<li class="last">설문지 그룹관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">설문지 그룹 수정</h3>
		      	
				<table class="input">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr>
							<th>설문지 그룹명</th>
							<td class="no_line"><input id="groupName" name="groupName" value="${set.data.groupName}"/></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td class="no_line">
								<select id="useYn" name="useYn">
									<option value="Y" <c:if test="${set.data.useYn eq 'Y'}">selected</c:if>>Y</option>
									<option value="N" <c:if test="${set.data.useYn eq 'N'}">selected</c:if>>N</option>
								</select>							
							</td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
		  			<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
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


