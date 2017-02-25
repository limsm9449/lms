<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commAdminInclude.jsp" %>

<style>
  table {border: 1px solid #e0e0e0; border-collapse: collapse; table-layout: fixed; }
  table tbody tr {border-bottom: 1px solid #e0e0e0; height: 25px;}
  table tbody td { padding-left: 10px; }
  /* input file css */
  .file_url { float:left; width: 150px; margin-right: 5px;}
  .file_btn_group { position:relative; width: 70px; height: 23px; overflow: hidden; margin-bottom: 5px; }
  .file_button { position: absolute; top:0px; }
  .hidden_inputfile { cursor:pointer; font-size: 45px; position: absolute; right: 0px; top: 0px; opacity: 0; filter: alpha(opacity=0); -ms-filter: "alpha(opacity=0)"; -khtml-opacity: 0; -moz-opacity: 0; }
  
  /*table */
  .title_bg td { -moz-box-shadow:inset 0px -15px 0px 0px #f4f5f7; -webkit-box-shadow:inset 0px -15px 0px 0px #f4f5f7; box-shadow:inset 0px -15px 0px 0px #f4f5f7; background-color:#ffffff; }
  .file_list { height: 40px; padding:0;}
  .sum_bottom { background-color: #f6f7f8; }
  div.scroll {  padding: 5px 10px;  overflow-y: auto; overflow-x: hidden; }
  div.scroll li { height: 24px; margin-bottom: 5px;}
  div.scroll li span { display:block; text-align: right; margin: -17px 0 0 20px;}
</style>

</head>

<script type="text/javascript">

var preUrl = "/board/"; 

$(document).ready(function() {
	var bodyHeight = $(document).height();
	parent.$("#attachFrame").height(bodyHeight);
	top.gfn_resize();
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="delete" ) {
		$("#seq").val(pParam.seq);
		document.frm.action = context + preUrl + "attachDel.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind =="attachIns" ) {
		document.frm.action = context + preUrl + "attachIns.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	} else if ( pKind =="refresh" ) {
		gfn_goPage(preUrl + "attachI",$("#frm").serialize());
	} 
}

</script>

<body>

<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">

<div id="contents">
	<div id="div1">
		<input id="seq" name="seq" value="0" type="hidden"/>
		<input id="pSeq" name="pSeq" value="${set.condiVO.pSeq}" type="hidden"/>
		<input id="kind" name="kind" value="${set.condiVO.kind}" type="hidden"/>
		<input id="mode" name="mode" value="TEMP" type="hidden"/>

	    <div class="file_btn_group">
	      <a class="grayBtn file_button">파일찾기</a>
	      <input type="file" name="newFile" class="hidden_inputfile" title="" onChange="javascript:lfn_btn('attachIns'); return false;">
	    </div>
	    
	    <!-- file_list -->
    	<table>
			<thead>
		  	<tr class="guide">
					<th></th>
					<th width="100"></th>
				</tr>
			</thead>
			<tbody>
				<tr class="title_bg">
					<td class="no_line">파일이름</td>
					<td class="no_line center">파일크기</td>
				</tr>
				<tr>
					<td colspan="2" class="file_list">
					  <div class="scroll">
					    <ul>
<c:forEach var="row" items="${set.list}" varStatus="idx">
    					  <li>${row.orgFileName} <a href="javascript:" class="grayBtn" onclick="javascript:lfn_btn('delete',{seq:'${row.seq}'}); return false;">삭제</a><span><fmt:formatNumber value="${row.fileSize/1000}" pattern="#,##0"/> KB</span></li>
</c:forEach>
    					</ul>
  					</div>
					</td>
				</tr>
				<tr class="sum_bottom">
					<td colspan="2">파일개수: ${fn:length(set.list)} 개</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
	
</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>


