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

function f_save() {
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

<form id="frm" name="frm" action="" method="post">
<input id="depth" name="depth" type="hidden" value="1"/>

<!-- wrap -->
<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">카테고리 생성: 대분류</h3>
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
    					<th>대분류 코드</th>
    					<td class="no_line input_l"><input type="text" id="code" name="code"/></td>
    				</tr>
    				<tr>
    					<th>대분류명</th>
    					<td class="no_line input_l"><input type="text" id="codeName" name="codeName"/></td>
    				</tr>
    			</tbody>
    		</table>
    		<p class="f-small guide">*대분류 코드:  알파벳과 숫자(2자리)의 조합 ex)C03, IT21</p>
    	</div>
    
    <div style="text-align:center;"><a id="saveBtn" onclick="javascript:f_save();return false;" href="#" class="blueBtn">저장</a>&nbsp;<a href="#" class="blueBtn" onclick="window.close();">닫기</a></div>
	</div>
</div>

</form>

</body>
</html>

