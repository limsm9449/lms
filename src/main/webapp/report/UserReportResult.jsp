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
	$("#contents").cleditor({height:105});
	$("#contents").cleditor()[0].disable(true).refresh();
	
	$("#reportUserContents").cleditor({height:105});
	$("#reportUserContents").cleditor()[0].disable(true).refresh();
	
	$("#reportTutorContents").cleditor({height:105});
	$("#reportTutorContents").cleditor()[0].disable(true).refresh();
	
	$("#attachFrame").attr("src","/board/attachReportV.do?" + "pSeq=${set.data.seq}&kind=C_REPORT&isMy=Y");
	$("#reportAttachFrame").attr("src","/board/attachReportV.do?" + "pSeq=${set.data.attachSeq}&kind=U_REPORT&isMy=Y");
	$("#reportAttachFrame2").attr("src","/board/attachReportV.do?" + "pSeq=${set.data.attachSeq}&kind=T_REPORT&isMy=Y");
});

</script>

<body>
<form id="frm" name="frm" action="" method="post">
	<input type="hidden" id="courseId" name="courseId" value="${set.condiVO.courseId}"/>
	 
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
                <input type='text' value="<c:out value="${set.data.title}" escapeXml="" />" disabled="disabled">
            </li> 
            <li class='clear_fix view'>
                <p>내용</p>
                <div class='result_area'>
					<textarea name='contents' id='contents' disabled="disabled"><c:out value="${set.data.contents}" escapeXml="" /></textarea>
				</div>                  
            </li>
            </li>
            <li class='clear_fix'>
                <p>출제파일</p>
                <iframe id="attachFrame" name="attachFrame" style="width:675px;height:100px"></iframe>
            </li>
            <li class='clear_fix view'>
                <p>제출내용</p> 
				<div class='result_area'>
					<textarea name='reportUserContents' id='reportUserContents' disabled="disabled"><c:out value="${set.data.reportUserContents}" escapeXml="" /></textarea>
				</div>
            </li>
            <li class='clear_fix view'>
                <p>제출파일</p>
                <iframe id="reportAttachFrame" name="reportAttachFrame" style="width:675px;height:100px"></iframe>
            </li>
            <li class='clear_fix view'>
                <p>첨삭내용</p> 
                <div class='result_area'>
					<textarea name='reportTutorContents' id='reportTutorContents' disabled="disabled"><c:out value="${set.data.reportTutorContents}" escapeXml="" /></textarea>
				</div>                  
            </li>
            <li class='clear_fix view'>
                <p>첨삭파일</p>
                <iframe id="reportAttachFrame2" name="reportAttachFrame2" style="width:675px;height:100px"></iframe>
            </li>
            <li class='clear_fix'>
                <p>점수</p>
                <p class='result_area'>${set.data.report} 점</p>
            </li>
        </ul>
        <div class='btn_submit'>
            <button onclick="javascript:window.close()">닫기</button>
        </div>
    </div>

</form>
    
</body>

</html>