<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="FCK" uri="http://java.fckeditor.net" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commBoardInclude.jsp" %>

</head>

<script type="text/javascript">

var preUrl = "/counsel/"; 

$(document).ready(function() {
	
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="answer" ) {
		gfn_goPage(preUrl + "counselAnswer",$("#frm").serialize()); 
	} else if ( pKind =="list" ) {
		gfn_goPage(preUrl + "counselList",top.gCondition.counsel.param); 
	}
}

</script>

<body>


<form id="frm" name="frm" action="" method="post">
	<input id="seq" name="seq" value="${set.condiVO.seq}" type="hidden"/>

<div id="wrap">
	<div id="container">
    	<div id="contents">
      		<div id="content_head">
        		<h1 class="title">상담내역</h1>
        		<ul class="gnb">
	          		<li>HOME</li>
	          		<li>상담관리</li>
	          		<li class="last">상담내역</li>
        		</ul>
			</div>

			<div id="article">
				<%-- 조건 --%>
		    	<h3 class="title">상담 상세</h3>
		      	
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
							<th>제목</th>
							<td class="no_line"><c:out value="${set.data.title}" escapeXml="true" />
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="no_line"><c:out value="${set.data.contents}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>답변</th>
							<td class="no_line"><c:out value="${set.data.answer}" escapeXml="" /></td>
						</tr>
						<tr>
							<th>등록일자</th>
							<td class="no_line">${set.data.createDate}
							</td>
						</tr>
					</tbody>
				</table>

				<%-- 하단버튼 --%>
		  		<div class="tool_btn">
					<a href="#" onclick="javascript:lfn_btn('answer'); return false;" class="blueBtn">답변</a>
					<a href="#" onclick="javascript:lfn_btn('list'); return false;" class="blueBtn">리스트</a>
		  		</div>
		  		
		  		<iframe id="replyFrame" name="replyFrame" class="autoHeight" scrolling="auto" frameborder="0" style="width:700px;"></iframe>
		  		
			</div>
			<!-- end content body -->
		</div>
	</div>
</div>


</form>


</body>
</html>


