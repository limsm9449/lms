<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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

var preUrl = "/courseResource/"; 

function lfn_btn(pKind, pParam) {
	if ( pKind == "excelUpload" ) {
		document.frm.action = context + preUrl + "excelUpload.do";
		document.frm.target = "tranFrameS";
		document.frm.method = "POST";	
		document.frm.submit();
	}
}

function lfn_tran(pRtnMode, pRtnData) {
	if ( pRtnMode == "INSERT_OK") {
		alert("일괄등록 하였습니다.");
		opener.lfn_btn("search");
		self.close();
	} else if ( pRtnMode == "DUPLICATION") {
		alert(pRtnData + " 과정코드는 이미 등록된 과정코드입니다.");	
		self.close();
	}
}


</script>

<body>

<form id="frm" name="frm" action="" method="post" enctype="multipart/form-data">

<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">과정 주차 일괄업로드</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content">

* 양식 다운로드를 먼저 하신후에 해당 과정에 대한 주차를 넣어주신후에 일괄업로드를 수행해주세요.<br>
  - 과정당 한번만 일괄등록이 가능합니다.<br><br>

	    <div class="file_btn_group">
	      <a class="grayBtn file_button">파일찾기</a>
	      <input type="file" name="newFile" class="hidden_inputfile" title="" onChange="javascript:lfn_btn('excelUpload'); return false;">
	    </div>
</div>
	    
</form>

<iframe id="tranFrameS" name="tranFrameS" style="display:none;"></iframe>

</body>
</html>


