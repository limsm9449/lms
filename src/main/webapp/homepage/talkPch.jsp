<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html lang='ko'>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>talk talk</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">

    <link rel='stylesheet' type='text/css' href='/resources/homepagePch/css/initialization.css'>
    <link rel='stylesheet' type='text/css' href='/resources/homepagePch/css/main.css'>
    <link rel='stylesheet' type='text/css' href='/resources/homepagePch/css/talk.css'>
</head>

<script type="text/javascript">

var isFirstTalk = 0;
var isLastTalk = 0;

$(document).ready(function(){
	fn_chatToBottom();
	
	setInterval(function() {
			lfn_btn("next");
		}, 10 * 1000);
});

function fn_chatToBottom() {
	$(".t_chat").prop("scrollTop", $(".t_chat").prop("scrollHeight"));
}

function lfn_btn(pKind, pParam) {
	if ( pKind == "add" ) {
		if ( $("#contents").val() == "" ) {
			alert("내용을 입력하세요.");
			return;
		}
		
		$("#seq").val(isLastTalk);
		$.ajax({
			type :"POST",
			url : context + "/main/talkIns.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				$("#contents").val("");
				
				fn_nextTalk(json.talkList);
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "prev" ) {
		$("#seq").val(isFirstTalk);
		$.ajax({
			type :"POST",
			url : context + "/main/talkPrev.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				fn_prevTalk(json.talkList);
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	} else if ( pKind == "next" ) {
		$("#seq").val(isLastTalk);
		$.ajax({
			type :"POST",
			url : context + "/main/talkNext.do",
			dataType :"json",
			data : $("#frm").serialize(),
			success : function(json){
				fn_nextTalk(json.talkList);
			},
			error : function(e) {
				alert("<spring:message code="lms.msg.systemError" text="-" />");
			}
		})
	}
}

function fn_nextTalk(list) {
	for ( var i = 0; i < list.length; i++ ) {
		if ( $("#dt_" + list[i].DATE_STR_ID).length == 0 ) {
			var dtHtml = "    <div class='t_day_line' id='dt_" + list[i].DATE_STR_ID + "'>" + 
							"	<div class='t_day_bg'>" + 
							"	    <div class='t_day'>" + 
							"		" + list[i].DATE_STR +  
							"	    </div>" + 
							"	</div>" + 
							"    </div>";
			$(".t_chat").append( dtHtml );
		}

		if ( list[i].MY_YN == "Y" ) {
			$(".t_chat").append( fn_myTalkContents( list[i] ) );
		} else if ( list[i].MY_YN == "N" && list[i].TEACHER_YN == "Y" ) {
			$(".t_chat").append( fn_teacherTalkContents( list[i] ) );
		} else {
			$(".t_chat").append( fn_otherTalkContents( list[i] ) );
		}
	}	
	
	if ( list.length > 0 ) {
		fn_chatToBottom();
		
		isLastTalk = list[list.length - 1].SEQ;
	}
}

function fn_prevTalk(list) {
	for ( var i = 0; i < list.length; i++ ) {
		if ( $("#dt_" + list[i].DATE_STR_ID).length == 0 ) {
			var dtHtml = "    <div class='t_day_line' id='dt_" + list[i].DATE_STR_ID + "'>" + 
							"	<div class='t_day_bg'>" + 
							"	    <div class='t_day'>" + 
							"		" + list[i].DATE_STR +  
							"	    </div>" + 
							"	</div>" + 
							"    </div>";
			$(".t_chat").prepend( dtHtml );
		}
		
		if ( list[i].MY_YN == "Y" ) {
			$("#dt_" + list[i].DATE_STR_ID).after( fn_myTalkContents( list[i] ) );
		} else if ( list[i].MY_YN == "N" && list[i].TEACHER_YN == "Y" ) {
			$("#dt_" + list[i].DATE_STR_ID).after( fn_teacherTalkContents( list[i] ) );
		} else {
			$("#dt_" + list[i].DATE_STR_ID).after( fn_otherTalkContents( list[i] ) );
		}
	}	
	
	if ( list.length > 0 ) {
		$(".t_chat").prop("scrollTop", 0);
		
		isFirstTalk = list[list.length - 1].SEQ;
	}
}

function fn_myTalkContents(row) {
	var rtn = "<div class='me_chat'>  " + 
			 "	<div class='me_time'>  " + 
			 "	    " + row.AM_PM + " " + row.CREATE_DATE_STR +
			 "	</div>" + 
			 "	<div class='me_box'> " + 
			 "	    <div class='me_textbox'>" + 
			 "		<p class='me_txt'>" + row.CONTENTS.replace(/\n/gi,"<br>") + "</p>" + 
			 "	    </div>" + 
			 "	</div>" + 
			 "</div>";
	console.log(row);
	console.log(rtn);
	
	return rtn;
}

function fn_teacherTalkContents(row) {
	var rtn = "<div class='tch_chat'>  " + 
			 "	<div class='tch_box'> " + 
			 "	    <div class='tch_face'>" + 
			 "		<img src='/cImage/user/" + row.USER_ID + "_talk.jpg'>" + 
			 "	    </div>" + 
			 "	    <div class='tch_textbox'>" + 
			 "		<p class='tch_txt'>" + row.CONTENTS.replace(/\n/gi,"<br>") + "</p>" + 
			 "	    </div>" + 
			 "	</div>" + 
			 "	<div class='tch_time'>  " + 
			 "	    " + row.AM_PM + " " + row.CREATE_DATE_STR  +
			 "	</div>" + 
			 "</div>";
	//console.log(row);
	//console.log(rtn);
	
	return rtn;
}

function fn_otherTalkContents(row) {
	var rtn= "<div class='you_chat'>  " + 
			 "	<div class='you_box'> " + 
			 "	    <div class='you_face'>" + 
			 "		<p class='you_id'>" + row.USER_ID5 + "</p>" + 
			 "	    </div>" + 
			 "	    <div class='you_textbox'>" + 
			 "		<p class='you_txt'>" + row.CONTENTS.replace(/\n/gi,"<br>") + "</p>" + 
			 "	    </div>" + 
			 "	</div>" + 
			 "	<div class='you_time'>  " + 
			 "	    " + row.AM_PM + " " + row.CREATE_DATE_STR  +
			 "	</div>" + 
			 "</div>";
	//console.log(row);
	//console.log(rtn);
	
	return rtn;			 
}

</script>

<body>

<form name="frm" id="frm" method="post">
	<input type='hidden' id='seq' name='seq'>
	
<frameset rows='*'>
    <div class="wrap">
        <!-- HEAD -->
        <div id='width_text'></div>
        <!-- PC HEADER -->
        <%@ include file="../common/mainTopPch.jsp" %>
        <!-- HEAD END -->

        <!-- CONTENTS -->
        <div class='contents_wrap' id="p_top">
            <!-- QUICK MENU -->
            <%@ include file="../common/mainQuickMenuPch.jsp" %>

<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            <!-- VISUAL -->
            <div class="t_bg">
            
                <div class="t_title">
                    <p><span>Talk Talk</span>방</p>
                </div> 
                <div class="t_title_txt">
                    <p>강사님과 학습자 여러분의 자유로운 대화 공간입니다.</p>
                </div>
                
                <!--------------대화방--------------->
                
                <div class="t_view">
                	<div class="t_chat_view">
                
                        <!-------이전 대화-------->
                        <div class="back_txt" onclick="lfn_btn('prev');">     
                            <div class="back_txt_btn">
                                이전 대화 보기
                            </div>
                        </div>
                        <!------------------------>
                        
                        <!--------------채팅 div ----------------->
                        <div class="t_chat">    
<c:set var="dt" value=""/>

<c:forEach var="row" items="${set.talkList}" varStatus="idx">
	<c:if test="${idx.first}">     	  
		<script type="text/javascript">
			isFirstTalk = ${row.SEQ};
		</script>
	</c:if>
	<c:if test="${idx.last eq true}">     	  
		<script type="text/javascript">
			isLastTalk = ${row.SEQ};
		</script>
	</c:if>
	
	<c:if test="${dt ne row.DATE_STR}">     	  
                            <div class="t_day_line" id="dt_${row.DATE_STR_ID}">    
                                <div class="t_day_bg">
                                    <div class="t_day">
                                        ${row.DATE_STR}
                                    </div>
                                </div>
                            </div>
		<c:set var="dt" value="${row.DATE_STR}"/>                            	
	</c:if>
	
	<c:choose>
		<c:when test = "${row.MY_YN eq 'Y'}">
                            <div class="me_chat">  
                                <div class="me_time">  
                                    ${row.AM_PM} ${row.CREATE_DATE_STR}
                                </div>
                                <div class="me_box"> 
                                    <div class="me_textbox">
                                        <p class="me_txt">${fn:replace(row.CONTENTS, newLineChar, "<br>")}</p>
                                    </div>
                                </div>
                            </div>
	   	</c:when>
		<c:when test = "${row.MY_YN eq 'N' && row.TEACHER_YN eq 'Y'}">
                            <div class="tch_chat">  
                                <div class="tch_box"> 
                                    <div class="tch_face">
                                        <img src="/cImage/user/${row.USER_ID}_talk.jpg">
                                    </div>
                                    <div class="tch_textbox">
                                        <p class="tch_txt">${fn:replace(row.CONTENTS, newLineChar, "<br>")}</p>
                                    </div>
                                </div>
                                <div class="tch_time">  
                                    ${row.AM_PM} ${row.CREATE_DATE_STR}
                                </div>
                            </div>
	   	</c:when>
	   	<c:otherwise>
                            <div class="you_chat">  
                                <div class="you_box"> 
                                    <div class="you_face">
                                        <p class="you_id">${row.USER_ID5}</p>
                                    </div>
                                    <div class="you_textbox">
                                        <p class="you_txt">${fn:replace(row.CONTENTS, newLineChar, "<br>")}</p>
                                    </div>
                                </div>
                                <div class="you_time">  
                                    ${row.AM_PM} ${row.CREATE_DATE_STR}
                                </div>
                            </div>
	   	</c:otherwise>
	</c:choose>    
</c:forEach>                        
                        </div>
                    </div>
                    <!--------------채팅 입력창----------------->
                    <c:if test = "${set.talkNotice ne null and set.talkNotice ne ''}">
                    	${set.talkNotice}
                    </c:if>
                    <div class="t_typing">
                    	<table class="t_table">
                    	<tr>
                        	<td class="t_0"><textarea class="t_typing_txt" id="contents" name="contents" autofocus onFocus=""></textarea></td>
                            <td class="t_2">
                                <div class="t_typing_btn" onclick="lfn_btn('add')">
                                    등록
                                </div>
                        	</td>
                        </tr>
                    </table>
                    </div>
                    
                    
                    <!------------------------------------------->
                </div>
            </div>
            

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomPch.jsp" %>
        <!-- FOOTER END -->
    </div>
    <script src='/resources/homepagePch/js/main.js'></script>
    
</frameset>
</form>

</body>

</html>