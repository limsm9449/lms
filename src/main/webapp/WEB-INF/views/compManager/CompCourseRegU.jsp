<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

</head>

<script type="text/javascript">
var preUrl = "/compCourseReg/"; 

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
					//alert("신청되었습니다.");
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
					//alert("신청 취소 되었습니다.");
					lfn_btn("refresh");
				}
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "application") {
		var cnt = 0;
	    $("input[id='chk2']").each(function(i) {
	    	if ( $(this).prop("disabled") == false ) {
	    		cnt++;
	    	}
	    });
		
		if ( cnt == 0 ) {
			alert("신청자가 없습니다.");
			return false;
		}
		
		if ( confirm("강좌신청 하시겠습니까?") == false )
			return false;
		
		gfn_goPage(preUrl + "application",$("#frm").serialize());
	} else if ( pKind == "refresh") {
		gfn_goPage(preUrl + "compCourseRegU",$("#frm").serialize());
	} else if ( pKind == "list") {
		gfn_goPage(preUrl + "compCourseRegList",top.gCondition.compCourseReg.param);
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">강좌 신청 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>강좌 관리</li>
	          		<li class="last">강좌 신청 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">강좌 신청</h3>
				
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
							<th>과정</th>
							<td class="no_line">
								<input id="courseId" name="courseId" type="hidden" value="${set.data.courseId}"/>
								${set.data.courseName}
							</td>
						</tr>
						<tr>
							<th>차수</th>
							<td class="no_line">${set.data.chasu}</td>
						</tr>
						<tr>
							<th>과정비용</th>
							<td class="no_line"><fmt:formatNumber value="${set.data.courseCost}" type="number"/> 원</td>
						</tr>
						<tr>
							<th>오픈여부</th>
							<td class="no_line">${set.data.openYn}</td>
						</tr>
						<tr>
							<th>교육일수</th>
							<td class="no_line">${set.data.cPeriod}</td>
						</tr>
						<tr>
							<th>레포트</th>
							<td class="no_line">${set.data.reportRate} %</td>
						</tr>
						<tr>
							<th>시험</th>
							<td class="no_line">${set.data.examRate} %</td>
						</tr>
						<tr>
							<th>토론</th>
							<td class="no_line">${set.data.discussionRate} %</td>
						</tr>
						<tr>
							<th>강의진도</th>
							<td class="no_line">${set.data.progressRate} %</td>
						</tr>
					</tbody>
				</table>


				<div class="manage_mem">
				  	<div class="before">
				    	<table>
				      		<thead>
						        <tr class="guide">
		      						<th width="50"></th>
		      						<th></th>
		      						<th width="18"></th>
		      					</tr>
		      					<tr>
		      						<th><input type="checkbox" id="allChk1" name="allChk1" onclick="gfn_allChk('allChk1','chk1')"></th>
		      						<th class="no_line">신청자명</th>
		      						<th class="no_line"></th>
		      					</tr>
				      		</thead>
				    	</table>
				    	<!-- member scroll list -->
				    	<div class="scroll">
	  				    	<table>
	  				      		<thead>
	  				        		<tr class="guide">
	        							<th width="50"></th>
	        							<th></th>
	        						</tr>
		  				     	</thead>
		  				      	<tbody>
									<c:forEach var="row" items="${set.noRegisterUserList}" varStatus="idx">
							            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
											<td class="center"><input type="checkbox" id="chk1" name="chk1" value="${row.userId}" onclick="gfn_chk('allChk1','chk1')"></td>
							            	<td class="center">${row.userName}</td>
							            </tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="add_del">
					    <a href="#" id="registerBtn" onclick="javascript:lfn_btn('register'); return false;" ><img src="/resources/images/admin/common/btn_mem_add.png" /></a>
					  	<a href="#" id="registerCancelBtn" onclick="javascript:lfn_btn('registerCancel'); return false;" ><img src="/resources/images/admin/common/btn_mem_del.png" /></a>
					</div>
						
					<div class="after">
				    	<table>
				      		<thead>
				        		<tr class="guide">
		      						<th width="50"></th>
		      						<th></th>
		      						<th width="80"></th>
		      						<th width="18"></th>
      							</tr>
      							<tr>
		      						<th><input type="checkbox" id="allChk2" name="allChk2" onclick="gfn_allChk('allChk2','chk2')"></th>
		      						<th>신청자명</th>
		      						<th class="no_line">승인상태</th>
		      						<th class="no_line"></th>
      							</tr>
				      		</thead>
				    	</table>
				    	<!-- member scroll list -->
				    	<div class="scroll">
  				    		<table>
  				      			<thead>
  				        			<tr class="guide">
		        						<th width="50"></th>
		        						<th></th>
		        						<th width="80"></th>
		        					</tr>
        						</thead>
	  				      		<tbody>
									<c:forEach var="row" items="${set.registerUserList}" varStatus="idx">
							            <tr <c:if test="${idx.count%2 eq 1}"> class="alt"</c:if>>
											<td class="center"><input type="checkbox" id="chk2" name="chk2" value="${row.userId}" onclick="gfn_chk('allChk2','chk2')" <c:if test="${row.status eq 'A' || row.status eq 'B'}">disabled</c:if>></td>
							            	<td class="center">${row.userName}</td>
							            	<td class="center"><c:if test="${row.status eq 'A'}"><img src="/resources/images/admin/common/icon_adm.png" /></c:if><c:if test="${row.status ne 'A'}"><img src="/resources/images/admin/common/icon_wait.png" /></c:if></td>
							            </tr>
									</c:forEach> 
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('application'); return false;" class="blueBtn">강좌신청</a>
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


