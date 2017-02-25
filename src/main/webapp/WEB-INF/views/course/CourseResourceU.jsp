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
				url : context +"/courseResource/courseResourceUUpd.do",
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
		gfn_goPage('/courseResource/courseResourceList',top.gCondition.courseResource.param); 
	}
}

function lfn_validate() {
	//Validation 검사
	objWeeks = $("[id=weeks]");
	objTitles = $("[id=titles]");
	objDirectorys = $("[id=directorys]");

	//제목에 "일 경우 '로 변경
	for ( i = 0; i < objTitles.length; i++ ) {
		objTitles[i].value = objTitles[i].value.replaceAll("\"","'"); 
	}
	
	for ( i = 0; i < objWeeks.length; i++ ) {
		if ( formValid.check("weeks",{isNecess:true,isNum:true,maxLeng:2},i) == false )
			return false;
		if ( formValid.check("titles",{isNecess:true,maxLeng:300},i) == false )
			return false;
		if ( formValid.check("directorys",{isNecess:true,maxLeng:100},i) == false )
			return false;
		if ( formValid.check("pageCnts",{isNecess:true,isNum:true,maxLeng:2},i) == false )
			return false;
		if ( formValid.check("previewPages",{isNecess:true,isNum:true,maxLeng:2},i) == false )
			return false;
		//주차 검사
		for ( m = i + 1; m < objWeeks.length; m++ ) {
			if ( $(objWeeks[i]).val() == $(objWeeks[m]).val() ) {
				alert("<spring:message code="lms.msg.existSameWeek" text="-" />");
				$(objWeeks[m]).select();
				return false;
			}
		}
	}
	
	return true;
}

function f_add() {
	var cnt = $("[id=weeks]").length;
	
	var newitem = $("#mainTbl tr:eq(2)").clone();
    $("#mainTbl").append(newitem);
    
    //초기화
    $("[id=weeks]")[cnt].value = "";
    $("[id=titles]")[cnt].value = "";
    $("[id=directorys]")[cnt].value = "";
    $("[id=pageCnts]")[cnt].value = "10";
    $("[id=previewPages]")[cnt].value = "0";
    
    parent.lfn_resize();
}

function f_delete(obj) {
	if($("#mainTbl tr").length < 7){
		alert("<spring:message code="lms.msg.noDeleteMore" text="-" />");
		return false;
	}
	   
    jQuery(obj).parent().parent().remove();
    
    $("#mainTbl tr").removeClass("alt");
    $("#mainTbl tr:even").addClass("alt");
}
</script>

<body>

<form id="frm" name="frm" action="" method="post">
	<input id="courseCode" name="courseCode" value="${set.data.courseCode}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">과정 주차 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">과정 주차 관리</li>
        		</ul>
			</div>

		   	<!-- content body -->
		   	<div id="article">
		      	<h3 class="title">과정 주차 수정 ( <c:out value="${set.data.courseName}" escapeXml="" /> )</h3>
		      	
				<%-- 테이블 --%>
		   		<table summary="" id="mainTbl">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="70"></th>
	  						<th></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="70"></th>
	  						<th width="65"></th>
  						</tr>
						<tr>
							<th>주차</th>
							<th>목차</th>
							<th>경로</th>
							<th>페이지</th>
							<th>미리보기</th>
							<th class="no_line">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
							<tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				              	<td class="subject">
				              		<input id="orgWeeks" name="orgWeeks" value="${row.week}" type="hidden"/>
				              		<input id="weeks" name="weeks" value="${row.week}" style="width:55px;"/>
				              	</td>
				              	<td class="subject"><input id="titles" name="titles" value="${row.title}" style="width:480px;"/></td>
				              	<td class="subject"><input id="directorys" name="directorys" value="${row.directory}" style="width:55px;"/></td>
				              	<td class="subject"><input id="pageCnts" name="pageCnts" value="${row.pageCnt}" style="width:55px;"/></td>
				              	<td class="subject"><input id="previewPages" name="previewPages" value="${row.previewPage}" style="width:55px;"/></td>
				              	<td class="no_line subject">
				              		<c:if test="${set.data.subCnt eq '0'}"> 
				              			<a href="#" onclick="f_delete(this)" class="blueBtn">삭제</a>
				              		</c:if>
				              	</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
<c:if test="${set.data.subCnt eq '0'}"> 
					<a href="#" onclick="f_add()" class="blueBtn">추가</a>
</c:if>
					<a href="#" id="saveBtn" onclick="javascript:lfn_btn('save'); return false;" class="blueBtn">저장</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>

<iframe name="tranFrame" style="display:none;"></iframe>

</body>
</html>


