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
	if ( pKind == "save" ) {
		if ( $("#codeName").val() == "" ) {
			alert("<spring:message code="lms.msg.inputNecessary" text="-" />");
			$("#codeName").focus();
			return false;
		}
	
		if ( confirm("저장하시겠습니까?") == true ) {
			btnUnbind("saveBtn");
			$.ajax({
				type : "POST",
				url : context + "/category/categoryUUpd.do",
				dataType : "json",
				data : $("#frm").serialize(),
				success : function(json){
					alert("<spring:message code="lms.msg.updateOk" text="-" />");
					opener.lfn_btn("refresh");
					self.close();
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "delete" ) {
		if ( confirm("삭제하시겠습니까?") == true ) {
			btnUnbind("deleteBtn");
			$.ajax({
				type : "POST",
				url : context + "/category/categoryUDel.do",
				dataType : "json",
				data : $("#frm").serialize(),
				success : function(json){
					alert("<spring:message code="lms.msg.deleteOk" text="-" />");
					opener.lfn_btn("refresh");
					self.close();
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	} else if ( pKind == "close" ) {
		self.close();
	}
}


</script>

<body>

<form id="frm" name="frm" method="post">
	<input id="code" name="code" type="hidden" value="<c:out value="${set.data.code}"/>"/>


<!-- wrap -->
<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">카테고리 수정</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">
    	<div id="div1">
        	<table class="input">
    			<caption></caption>
    			<thead>
  			  	<tr class="guide">
  						<th width="120"></th>
  						<th></th>
  					</tr>
    			</thead>
    			<tbody>
 
<c:choose>
	<c:when test="${set.condiVO.depth eq '1'}">
		<tr>
			<td>대분류 코드</td>
			<td class="no_line input_l"><c:out value="${set.data.code}"/><input id="useYn" name="useYn" type="hidden" value="Y"/></td>
		</tr>
		<tr>
			<td>대분류 명</td>
			<td><c:out value="${set.data.codeNames}"/> <input id="codeName" name="codeName" value="<c:out value="${set.data.codeName}"/>"/></td>
		</tr>
	</c:when>
	<c:when test="${set.condiVO.depth eq '2'}">
		<tr>
			<td>중분류 코드</td>
			<td><c:out value="${set.data.code}"/><input id="useYn" name="useYn" type="hidden" value="Y"/></td>
		</tr>
		<tr>
			<td>단계</td>
			<td><c:out value="${set.data.codeNames}"/></td>
		</tr>
		<tr>
			<td>중분류 명</td>
			<td><input id="codeName" name="codeName" value="<c:out value="${set.data.codeName}"/>"/></td>
		</tr>
	</c:when>
	<c:when test="${set.condiVO.depth eq '3'}">
		<tr>
			<td>소분류 코드</td>
			<td><c:out value="${set.data.code}"/></td>
		</tr>
		<tr>
			<td>단계</td>
			<td><c:out value="${set.data.codeNames}"/></td>
		</tr>
		<tr>
			<td>소분류 명</td>
			<td><input id="codeName" name="codeName" value="<c:out value="${set.data.codeName}"/>"/></td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.useYn" text="-" /></td>
			<td>
				<select id="useYn" name="useYn">
	              	<option value="Y" <c:if test="${set.data.useYn eq 'Y'}">selected</c:if>>Y</option>
	              	<option value="B" <c:if test="${set.data.useYn eq 'N'}">selected</c:if>>N</option>
				</select>
			</td>
		</tr>
	</c:when>
</c:choose>	
			</table>
			<p class="f-small guide">*연결된 과정이 없어야 삭제 및 사용여부 변경이 가능함.</p>
    	</div>
    <div style="text-align:center;">
<c:if test="${set.data.subCnt eq 0}">
	<a id="deleteBtn" onclick="javascript:lfn_btn('delete');return false;" href="#" class="blueBtn">삭제</a>
</c:if>	    
    <a id="saveBtn" onclick="javascript:lfn_btn('save');return false;" href="#" class="blueBtn">저장</a>&nbsp;<a href="#" class="blueBtn" onclick="window.close();">닫기</a></div>
	</div>
</div>	

</form>
	

</body>
</html>

