<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commBoardInclude.jsp" %>


</head>

<script type="text/javascript">
var gCondition = {
}
</script>


<script type="text/javascript">
var preUrl = "/board/"; 

$(document).ready(function() {
	f_makePageNavigator("paging",${set.condiVO.pageNum},${set.totalCount},${set.pageUnit});
});


</script>

<body>

<div id="popup_wrap">
  <div class="pop_header">
    <h3 class="title">팝업게시판</h3>
    <p class="closeBtn" onClick="window.close();">Close</p>
  </div>
  <div class="pop_content_noscroll">
    <iframe src="${set.condiVO.url}"></iframe>
  </div>
</div>




</body>
</html>


