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

var preUrl = "/compUser/"; 

$(document).ready(function() {
		f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" || pKind == "paging" || pKind == "refresh" ) {
		if ( pKind == "search" )
			$("#pageNum").val(1);
		else if ( pKind == "paging" )
			$("#pageNum").val(pParam.page);
		
		gfn_goPage(preUrl + "compUserList",$("#frm").serialize());	
	} else if ( pKind == "formDownload") {
		document.frm.action = context + "/compUser/ExcelFormCompanyUser.do";
		document.frm.target = "excelFrame";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind == "excelUpload" ) {
		Popup.showPopup("/compManager/ExcelUpload.jsp",400,200,"upload");
	} else if ( pKind == "new" ) {
		lfn_setCondition();
		
		gfn_goPage("/member/memberN","screen=compUser&compCd=<c:out value="${set.compCd}"/>");
	} else if ( pKind == "delete" ) {
		var selIds = gfn_cbCheckedValues("chk");
		if ( selIds == "" ) {
			alert("선택된 데이타가 없습니다.");
			return false;
		}
		if ( confirm("삭제 하시겠습니까?") == false )
			return false;
		
		btnUnbind("deleteBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "compUserDel.do",
			dataType :"json",
			data : 'selIds=' + selIds,
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					alert("삭제 하였습니다.");
					lfn_btn("search");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "view") {
		lfn_setCondition();
		
		gfn_goPage("/member/memberV","screen=compUser&userId=" + pParam.userId);
	}
}

function lfn_setCondition() {
	top.gCondition.compUser = {
		param : "searchKind=" + $("#searchKind").val() +
				"&searchStr=" + $("#searchStr").val() +
				"&pageNum=" + $("#pageNum").val()
	}	
}

</script>

<body>

<form id="frm" name="frm" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">직원 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>직원 관리</li>
	          		<li class="last">직원 관리</li>
        		</ul>
			</div>

			<div id="article">
		    	<h3 class="title">직원 관리</h3>

				<%-- 조건 --%>
		       	<div id="search">
		      		<div class="search_1">
		            	<label for="f_subject">검색 조건</label>
						<select id="searchKind" name="searchKind">
			              	<option value="USER_ID" <c:if test="${set.condiVO.searchKind eq '' || set.condiVO.searchKind eq 'USER_ID'}">selected</c:if>>사용자 ID</option>
			              	<option value="USER_NAME" <c:if test="${set.condiVO.searchKind eq 'USER_NAME'}">selected</c:if>>사용자명</option>
						</select>
						<input type="text" id="searchStr" name="searchStr" value="<c:out value="${set.condiVO.searchStr}"/>" onkeydown="lfn_enter()">
		            </div>
		        	<div class="search_2">
		             	<input type="button" class="blueBtn" id="search_btn" onclick="javascript:lfn_btn('search');return false;" value="검색" />
		           	</div>
		   		</div>
		   		
				<%-- 테이블 --%>
		   		<table summary="">
					<thead>
					  	<tr class="guide">
	  						<th width="30"></th>
	  						<th width="100"></th>
	  						<th></th>
	  						<th width="130"></th>
	  						<th width="130"></th>
	  						<th width="190"></th>
	  						<th width="80"></th>
  						</tr>
						<tr>
							<th><input type="checkbox" id="allChk" name="allChk" onclick="gfn_allChk('allChk','chk')"></th>
							<th>사용자 ID</th>
							<th>사용자 명</th>
							<th>전화번호</th>
							<th>핸드폰</th>
							<th>E-mail</th>
							<th class="no_line">수강 과목수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty set.list}">
							<tr>
								<td colspan="7" class="no_line center"><spring:message code="lms.msg.noSearchData" text="-" /></td>
							</tr>
						</c:if>
						<c:forEach var="row" items="${set.list}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
				            	<td class="center"><input type="checkbox" id="chk" name="chk" value="${row.userId}" onclick="gfn_chk('allChk','chk')" <c:if test="${row.courseCnt ne 0}">disabled</c:if>></td>
				            	<td class="subject"><a href="#" onclick="javascript:lfn_btn('view',{userId:'${row.userId}'}); return false;" class="click">${row.userId}</a></td>
				            	<td class="subject">${row.userName}</td>
				            	<td class="subject">${row.homeTel}</td>
				            	<td class="subject">${row.mobile}</td>
				            	<td class="subject">${row.email}</td>
				            	<td class="no_line right">${row.courseCnt}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
				
				<%-- 페이징 --%>
				<div id="paging"></div>
				
				<%-- 하단버튼 --%>
				<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('formDownload'); return false;" class="blueBtn">양식 다운로드</a>
					<a href="#" onclick="javascript:lfn_btn('excelUpload'); return false;" class="blueBtn">일괄업로드</a>
					<a href="#" onclick="javascript:lfn_btn('new'); return false;" class="blueBtn">직원 생성</a>
					<a href="#" id="deleteBtn" onclick="javascript:lfn_btn('delete'); return false;" class="blueBtn">직원 삭제</a>
				</div>
		   	</div>
		</div>
	</div>
</div>
	
	
</form>

<iframe id="excelFrame" name="excelFrame" style="display:none;"></iframe>

</body>
</html>


