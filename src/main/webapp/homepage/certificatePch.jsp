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
    <link rel='stylesheet' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepagePch/css/mypage/mypage_clear.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	if ( "${set.dataHm.COMPLETE_YN}" != "Y" ) {
		self.close();
	}
});

</script>


<body style='background:#fff'>
<frameset rows='*'>
    <div class='wrap'>
        <!-- CONTENTS -->
              <div>  
                    <div class="class_bg">
                    	<table>
                        	<tr>
                            	<td>수료번호 : </td>
                                <td>${set.dataHm.COURSE_CODE}-${set.dataHm.CERTIFICATE_NO}</td>
                            </tr>
                            <tr>
                            	<td>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명 :</td>
                                <td>${set.dataHm.USER_NAME}</td>
                            </tr>
                            <tr>
                            	<td>교육과정 : </td>
                                <td>${set.dataHm.COURSE_NAME}</td>
                            </tr>
                            <tr>
                            	<td>교육기간 : </td>
                                <td>${set.dataHm.C_FROM_DATE} ~ ${set.dataHm.C_TO_DATE}</td>
                            </tr>
                            <tr>
                            	<td>교육시간 :</td>
                                <td>${set.dataHm.STUDY_HOUR}시간</td>
                            </tr>
                        </table>
                        
                       	<table class="tday">
                        	<tr>
                            	<td>발급일 :</td>
                                <td>${set.dataHm.CERTIFICATE_DATE}</td>
                            </tr>
                        </table>
                        
                    </div>
               </div>

        <!-- CONTENTS END -->
    </div>
</frameset>
<script src='/resources/homepagePch/js/sub.js'></script>

</body>
</html>