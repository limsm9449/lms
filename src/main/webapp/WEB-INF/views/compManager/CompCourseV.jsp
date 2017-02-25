<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>

</head>

<script type="text/javascript">
var preUrl = "/compCourse/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind =="register" ) {
		if ( "${set.data.openYn}" == "N" ) {
			alert("해당 강좌는 신청하실 수 없습니다.\n관리자에게 문의 하시기 바랍니다.");
			return false;
		}
		
		var selIds = gfn_cbCheckedValues("chk1");
		if ( selIds == "" ) {
			alert("선택된 데이타가 없습니다.");
			return false;
		}
		if ( confirm("신청 하시겠습니까?") == false )
			return false;
		
		btnUnbind("registerBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "compCourseRegister.do",
			dataType :"json",
			data : 'courseId=${set.condiVO.courseId}&addUserIds=' + selIds,
			success : function(json){
				if ( json.rtnMode == "INSERT_OK") {
					alert("신청되었습니다.");
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind =="registerCancel" ) {
		var selIds = gfn_cbCheckedValues("chk2");
		if ( selIds == "" ) {
			alert("선택된 데이타가 없습니다.");
			return false;
		}
		if ( confirm("신청 취소 하시겠습니까?") == false )
			return false;
		
		btnUnbind("registerCancelBtn");
		$.ajax({
			type :"POST",
			url : context + preUrl + "compCourseRegisterCancel.do",
			dataType :"json",
			data : 'courseId=${set.condiVO.courseId}&delUserIds=' + selIds,
			success : function(json){
				if ( json.rtnMode == "DELETE_OK") {
					alert("신청 취소 되었습니다.");
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "application") {
		var selIds = gfn_cbCheckedValues("chk2");
		if ( selIds == "" ) {
			alert("선택된 데이타가 없습니다.");
			return false;
		}
		
		gfn_goPage(preUrl + "application",$("#frm").serialize());
	} else if ( pKind == "refresh") {
		gfn_goPage(preUrl + "compCourseU",$("#frm").serialize());
	} else if ( pKind == "list") {
		gfn_goPage(preUrl + "compCourseList",top.gCondition.compCourse.param);
	}
}

</script>

<body>


* <spring:message code="lms.title.courseView" text="-" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
	<a href="#" onclick="javascript:f_popup('/board/boardNotice',{displayName:'board',option:'width=1000,height=520',urlParams:'kind=C&pSeq=${set.data.courseId}&mode=P'}); return false;">공지사항</a>
	&nbsp;
	<a href="#" onclick="javascript:f_popup('/board/boardFree',{displayName:'board',option:'width=1000,height=520',urlParams:'kind=C&pSeq=${set.data.courseId}&mode=P'}); return false;">자유게시판</a>
	&nbsp;
	<a href="#" onclick="javascript:f_popup('/board/boardData',{displayName:'board',option:'width=1000,height=570',urlParams:'kind=C&pSeq=${set.data.courseId}&mode=P'}); return false;">자료실</a>
	&nbsp;
	<a href="#" onclick="javascript:f_popup('/board/boardQna',{displayName:'board',option:'width=1000,height=520',urlParams:'kind=C&pSeq=${set.data.courseId}&mode=P'}); return false;">Q&A</a>
	&nbsp;
	<a href="#" onclick="javascript:f_popup('/board/boardData',{displayName:'board',option:'width=1000,height=570',urlParams:'kind=R&pSeq=${set.data.courseId}&mode=P'}); return false;">레포트</a>
	&nbsp;
	<a href="#" onclick="javascript:f_popup('/board/boardDiscussion',{displayName:'board',option:'width=1000,height=520',urlParams:'kind=C&pSeq=${set.condiVO.courseId}&mode=P'}); return false;">토론게시판</a>
	&nbsp;

<form id="frm" name="frm" action="" method="post">
	<table>
		<tr>
			<td><spring:message code="lms.label.courseName" text="-" /></td>
			<td>
				<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>
				${set.data.courseName}
			</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.chasu" text="-" /></td>
			<td>${set.data.chasu}</td>
		</tr>
		<tr>
			<td>과정비용</td>
			<td><fmt:formatNumber value="${set.data.courseCost}" type="number"/></td>
		</tr>
		<tr>
			<td>오픈여부</td>
			<td>${set.data.openYn}</td>
		</tr>
		<tr>
			<td>교육일수</td>
			<td>${set.data.cPeriod}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.reportRate" text="-" /></td>
			<td>${set.data.reportRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.examRate" text="-" /></td>
			<td>${set.data.examRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.discusstionRate" text="-" /></td>
			<td>${set.data.discussionRate}</td>
		</tr>
		<tr>
			<td><spring:message code="lms.label.progressRate" text="-" /></td>
			<td>${set.data.progressRate}</td>
		</tr>
	</table>

	<table>
		<tr>
			<td>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allChk1" name="allChk1" onclick="gfn_allChk('allChk1','chk1')"></th>
							<th>신청자명</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.noRegisterUserList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
								<td><input type="checkbox" id="chk1" name="chk1" value="${row.userId}" onclick="gfn_chk('allChk1','chk1')"></td>
				            	<td>${row.userName}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
			<td>
				<a href="#" id="registerBtn" onclick="javascript:lfn_btn('register'); return false;">신청</a>
				<a href="#" id="registerCancelBtn" onclick="javascript:lfn_btn('registerCancel'); return false;">취소</a>
			</td>
			<td>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allChk2" name="allChk2" onclick="gfn_allChk('allChk2','chk2')"></th>
							<th>등록자명</th>
							<th>승인상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${set.registerUserList}" varStatus="idx">
				            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
								<td><input type="checkbox" id="chk2" name="chk2" value="${row.userId}" onclick="gfn_chk('allChk2','chk2')" <c:if test="${row.status eq 'A'}">disabled</c:if>></td>
				            	<td>${row.userName}</td>
				            	<td>${row.statusName}</td>
				            </tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	
	<br>
	<a href="#" onclick="javascript:lfn_btn('list'); return false;">리스트</a>&nbsp;&nbsp;
	<a href="#" onclick="javascript:lfn_btn('application'); return false;">강좌신청</a>

</form>


</body>
</html>


