<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

<style>
  .file_url { float:left; width: 150px; margin-right: 5px;}
  .file_btn_group { position:relative; width: 70px; height: 23px; overflow: hidden; margin-bottom: 5px; }
  .file_button { position: absolute; top:0px; }
  .hidden_inputfile { cursor:pointer; font-size: 45px; position: absolute; right: 0px; top: 0px; opacity: 0; filter: alpha(opacity=0); -ms-filter: "alpha(opacity=0)"; -khtml-opacity: 0; -moz-opacity: 0; }
</style>


</head>

<script type="text/javascript">

function lfn_btn(pKind, pParam) {
	if ( pKind == "update" ) {
		gfn_goPage("/member/teacherU",$("#frm").serialize());
	} else if ( pKind == "pictureUpload") {
		document.frm.action = context + "/member/pictureUpload.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind == "refresh") {
		gfn_goPage("/member/teacherV",$("#frm").serialize());
	} else if ( pKind == "list") {
		gfn_goPage("/member/teacherList",top.gCondition.teacher.param);
	}
}


</script>

<body>


<form id="frm" name="frm" method="post" enctype="multipart/form-data">

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">강사 관리</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>사용자</li>
	          		<li class="last">강사 관리</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">강사 상세</h3>
		      	
				<table class="view">
					<caption></caption>
					<thead>
					  	<tr class="guide">
	  						<th width="130"></th>
	  						<th></th>
	  					</tr>
					</thead>
					<tbody>
						<tr class="bn">
							<th>회원 아이디</th>
							<td class="no_line">
								<input type="hidden" id="userId" name="userId" value="${set.data.userId}" >
								<input type="hidden" id="seq" name="seq" value="${set.data.seq}" >
								${set.data.userId}
							</td>
						</tr>
						<tr>
							<th>이름 (국문)</th>
							<td class="no_line">${set.data.userName}</td>
						</tr>
						<tr>
							<th>성별</th>
							<td class="no_line">
								<select id="sex" name="sex" disabled>
									<option value="" <c:if test="${set.data.sex == null }">selected</c:if>></option>
									<option value="M" <c:if test="${set.data.sex eq 'M'}">selected</c:if>>남</option>
									<option value="F" <c:if test="${set.data.sex eq 'F'}">selected</c:if>>여</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td class="no_line">${set.data.birthDay}</td>
						</tr>
						<tr>
							<th class="necessary">휴대전화번호</th>
							<td class="no_line">${set.data.mobile1} - ${set.data.mobile2} - ${set.data.mobile3}</td>
						</tr>
						<tr>
							<th class="necessary">이메일주소</th>
							<td class="no_line">${set.data.email}</td>
						</tr>
						<tr>
							<th >사진</th>
							<td class="no_line">
<c:if test="${empty set.data.picture}">							
								<img src="/resources/images/sub/img_base_photo.png"></img>
</c:if>								
<c:if test="${!empty set.data.picture}">							
								<img src="/cImage/teacher/${set.data.picture}"></img>
</c:if>								
								<br>파일명은 사용자 ID와 동일하게 해주세요.(사이즈: 137*169)
							    <div class="file_btn_group">
							      <a class="grayBtn file_button">파일찾기</a> 
							      <input type="file" name="newFile" class="hidden_inputfile" title="" onChange="lfn_btn('pictureUpload'); return false;">
							    </div>								
							</td>
						</tr>
						<tr>
							<th >경력</th>
							<td class="no_line">${set.data.career}</td>
						</tr>
					</tbody>
				</table>
				
				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('update'); return false;" class="blueBtn">수정</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>

</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>
	
</body>
</html>


