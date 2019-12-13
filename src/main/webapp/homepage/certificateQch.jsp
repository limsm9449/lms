<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>수료증</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/mypage/mypage_clear.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	if ( "${set.dataHm.COMPLETE_YN}" != "Y" ) {
		self.close();
	}
});

// 지정영역 인쇄
var initBody;
function printDiv () {
	window.onbeforeprint = beforeDivs();
	window.print();
	window.onafterprint = afterDivs();
}
function beforeDivs () {
	initBody = document.body.innerHTML;
	document.body.innerHTML = objContents.innerHTML;
}
function afterDivs () {
	document.body.innerHTML = initBody;
}
</script>


<body style='background:#fff;overflow:hidden;'>
<frameset rows='*'>
    <div class="class_btn"><button onClick="javascript:printDiv()">인쇄하기</button> <button onClick="javascript:window.close();">닫기</button></div>
    <div id="objContents">
    <div class='wrap'>
        <!-- CONTENTS -->
   		<div class="class_all"><img src="/resources/homepageQch/img/myclass/classbg.png"/></div>
        <div class="class_bg">
        	<table>
            	<tr>
                	<th>수료번호 : </th>
                    <td>${set.dataHm.COURSE_CODE}-${set.dataHm.CERTIFICATE_NO}</td>
                </tr>
                <tr>
                	<th>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명 :</th>
                    <td>${set.dataHm.USER_NAME}</td>
                </tr>
                <tr>
                	<th>교육과정 : </th>
                    <td>${set.dataHm.COURSE_NAME}</td>
                </tr>
                <tr>
                	<th>교육기간 : </th>
                    <td>${set.dataHm.C_FROM_DATE} ~ ${set.dataHm.C_TO_DATE}</td>
                </tr>
                <tr>
                	<th>교육시간 :</th>
                    <td>${set.dataHm.STUDY_HOUR}시간</td>
                </tr>
            </table>
            
             <span>발급일 : ${set.dataHm.CERTIFICATE_DATE}</span>
        </div>

        <!-- CONTENTS END -->
    </div>
    </div>
</frameset>
<script src='/resources/homepageQch/js/sub.js'></script>

</body>
</html>