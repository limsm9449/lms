<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang='ko'>

<head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>과정리포트 채점결과</title>

	<%@ include file="../common/commMainInclude.jsp" %>
	
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/popup/popup_common.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
	$("#reportTutorContents").cleditor({height:105});
	$("#reportTutorContents").cleditor()[0].refresh();

	$("#attachFrame").attr("src","/board/attachReportV.do?" + "pSeq=${set.data.seq}&kind=C_REPORT&isMy=Y");
	$("#reportAttachFrame").attr("src","/board/attachReportV.do?" + "pSeq=${set.data.attachSeq}&kind=U_REPORT&isMy=Y");
	$("#reportAttachFrame2").attr("src","/board/attachU.do?" + "pSeq=${set.data.attachSeq}&kind=T_REPORT");
});

function lfn_btn(pKind, pParam) {
	if ( pKind =="save" ) {
		if ( confirm("저장하시겠습니까?") == true ) {
			$.ajax({ 
				type :"POST",
				url : context +"/report/userReportScoreSave.do",
				dataType :"json",
				data : $("#frm").serialize(),
				success : function(json){
					if ( json.rtnMode == "INSERT_OK") {
						alert("정상적으로 저장이 되었습니다.");
						opener.location.reload();
						window.close();
					}
				},
				error : function(e) {
					alert("<spring:message code="lms.msg.systemError" text="-" />");
				}
			})
		}
	}
}

</script>

<body>
<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/>
	<input type="hidden" id="userId" name="userId" value="${set.condiVO.userId}"/>
	 
    <!-- 과정리포트 제출 POPUP -->
    <div id='popup_report_submit' class='popup'>
        <div class='popup_fix'>
            <p class='popup_title'> 
                과정리포트 첨삭 관리
            </p>
        </div>
        <ul class='report_box manage clear_fix'>
            <li class='clear_fix'>
                <p>제목</p>
                <div class='result_area'>
                	<c:out value="${set.data.title}" escapeXml="" />
                </div>
            </li> 
            <li class='clear_fix view'>
                <p>내용</p>
				<div class='result_area'>
					<c:out value="${set.data.contents}" escapeXml="" />
				</div>                  
            </li>
            </li>
            <li class='clear_fix'>
                <p>출제파일</p>
                <div class='report_files'>
                	<iframe id="attachFrame" name="attachFrame"></iframe>
                </div>
            </li>
            <li class='clear_fix view'>
                <p>제출내용</p> 
				<div class='result_area'>
					<c:out value="${set.data.reportUserContents}" escapeXml="" />
				</div>                  
            </li>
            <li class='clear_fix view'>
                <p>제출파일</p>
                <div class='report_files'>
                	<iframe id="reportAttachFrame" name="reportAttachFrame"></iframe>
                </div>
            </li>
            <li class='clear_fix view'>
                <p>첨삭내용</p> 
				<div class='result_area'>
					<textarea name='reportTutorContents' id='reportTutorContents'><c:out value="${set.data.reportTutorContents}" escapeXml="" /></textarea>
				</div>                  
            </li>
            <li class='clear_fix view'>
                <p>첨삭파일</p>
                <div class='report_files'>
                	<iframe id="reportAttachFrame2" name="reportAttachFrame2"></iframe>
                </div>
            </li>
            <li class='clear_fix'>
                <p>점수</p>
                <input type='text' name='report' id='report' value="<c:out value="${set.data.report}" escapeXml="" />">
            </li>
        </ul>
        <div class='btn_submit'>
            <button onclick="javascript:lfn_btn('save'); return false;">저장하기</button>
        </div>
    </div>

</form>
    
</body>

</html>