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
				url : context +"/courseCode/courseCodeUUpd.do",
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
		gfn_goPage('/courseCode/courseCodeList',top.gCondition.courseCode.param); 
	}
}

function lfn_validate() {
	if ( formValid.check("courseName",{isNecess:true,maxLeng:200}) == false )
		return false;
	if ( formValid.check("teacherId",{isNecess:true}) == false )
		return false;
	if ( formValid.check("hPx",{isNecess:true,isNum:true,maxLeng:4}) == false )
		return false;
	if ( formValid.check("vPx",{isNecess:true,isNum:true,maxLeng:4}) == false )
		return false;
	if ( formValid.check("directory",{isNecess:true,maxLeng:100}) == false )
		return false;
	
	return true;
}



</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseCode" name="courseCode" value="${set.data.courseCode}"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 코드 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 코드 관리</li>
        		</ul>
			</div>

		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">과정 코드 수정</h3>
		      	
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
							<th>카테고리</th>
							<td class="no_line"><c:out value="${set.data.categoryName}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>과정코드</th>
							<td class="no_line"><c:out value="${set.data.courseCode}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>과정명</th>
							<td class="no_line"><input id="courseName" name="courseName" value="${set.data.courseName}"/></td>
						</tr>
						<tr>
							<th>강사</th>
							<td class="no_line">
								<select id="teacherId" name="teacherId">
					              	<option value="">전체</option>
									<c:forEach var="row" items="${set.ddTeacher}">
						              	<option value="${row.ddKey}" <c:if test="${set.data.teacherId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>가로</th>
							<td class="no_line"><input id="hPx" name="hPx" value="${set.data.hPx}"/></td>
						</tr>
						<tr>
							<th>세로</th>
							<td class="no_line"><input id="vPx" name="vPx" value="${set.data.vPx}"/></td>
						</tr>
						<tr>
							<th>디렉토리</th>
							<td class="no_line"><input id="directory" name="directory" value="${set.data.directory}"/></td>
						</tr>
						<tr>
							<th>포인트</th>
							<td class="no_line"><input id="point" name="point" value="${set.data.point}"/></td>
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
						<tr>
							<th>설문지 여부</th>
							<td class="no_line">
								<select id="qgId" name="qgId">
					              	<option value="0">전체</option>
									<c:forEach var="row" items="${set.ddQuestGroup}">
						              	<option value="${row.ddKey}" <c:if test="${set.data.qgId eq row.ddKey}">selected</c:if>>${row.ddValue}</option>
									</c:forEach>
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


