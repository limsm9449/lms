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
function f_categoryChg() {
	$("#code").val($("#parentCode").val());
}

function f_save() {
	if ( formValid.check("parentCode",{isNecess:true}) == false )
		return false;
	if ( formValid.check("code",{isNecess:true,maxLeng:10}) == false )
		return false;
	if ( formValid.check("codeName",{isNecess:true,maxLeng:100}) == false )
		return false;
	
	if ( confirm("저장하시겠습니까?") == true ) {
		btnUnbind("saveBtn");
		$.ajax({
			type : "POST",
			url : context + "/category/category1DepthIns.do",
			dataType : "json",
			data : $("#frm").serialize(),
			success : function(json){
				if ( json.rtnMode == "EXIST" ) {
					alert("<spring:message code="lms.msg.existData" text="-" />");
					btnBind("saveBtn");
				} else {
					alert("<spring:message code="lms.msg.insertOk" text="-" />");
					opener.lfn_btn("search");
					self.close();
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function f_close() {
	self.close();
}

</script>

<body>

<form id="frm" name="frm" method="post">
<input id="depth" name="depth" type="hidden" value="2"/>

<!-- wrap -->
<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">카테고리 생성: 중분류</h3>
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
    			  <tr>
    					<th>카테고리</th>
    					<td class="no_line input_l">
    					  	<select id="parentCode" name="parentCode" onchange="f_categoryChg()">
				              	<option value="">전체</option>
								<c:forEach var="row" items="${set.ddCategory1Depth}">
					              	<option value="${row.ddKey}">${row.ddValue}</option>
								</c:forEach>
							</select>
    					</td>
    				</tr>
    				<tr>
    					<th>중분류 코드</th>
    					<td class="no_line input_l"><input id="code" name="code"/></td>
    				</tr>
    				<tr>
    					<th>중분류명</th>
    					<td class="no_line input_l"><input id="codeName" name="codeName"/></td>
    				</tr>
    			</tbody>
    		</table>
    		<p class="f-small guide">*중분류 코드:  대분류 + 숫자(2자리)의 조합 ex)C0308, IT2114</p>
    	</div>
    
    <div style="text-align:center;"><a id="saveBtn" onclick="javascript:f_save();return false;" href="#" class="blueBtn">저장</a>&nbsp;<a href="#" class="blueBtn" onclick="window.close();">닫기</a></div>
	</div>
</div>

</form>
	

</body>
</html>

