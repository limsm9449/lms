/* 팝업을 위한 스크립트 */

var gDivPopup = new Array();
var gWinPopup = new Array();

var Popup = {
	/**
	 * DIV 팝업을 보여준다.
	 * @param pDiv
	 * @param pWidth
	 * @param pHeight
	 * @param pUrl
	 */
	showDivPopup : function(pDiv,pWidth,pHeight,pUrl,pParam) {
		//기존 영역을 삭제한다.
		$("#" + pDiv).remove();
		
		var htmlStr = 	"<div id='" + pDiv + "' style='position:absolute;margin:0px;display:block;z-index:100;width:" + pWidth + "px;height:" + pHeight + "px;'>" +
					   		"<iframe id='" + pDiv + "Iframe' style='width:100%;height:100%' frameborder='1' scrolling='no'></iframe>" + 
					   	"</div>";
		$("body").append(htmlStr);
		
		//화면의 중간에 배치
		$("#" + pDiv).css("left", ($(window).width() / 2 - pWidth / 2) + "px");
		$("#" + pDiv).css("top", ($(window).height() / 2 - pHeight / 2) + "px");
		
		//보여줄 내용을 호출
		$("#" + pDiv + "Iframe").attr("src",context + pUrl + ".do" + (pParam == undefined ? "?divId=" + pDiv : "?" + pParam + "&divId=" + pDiv));
		
		gDivPopup[pDiv] = pDiv;
	},
	
	/**
	 * DIV 팝업을 닫는다.
	 * @param pDiv
	 */
	hideDivPopup : function(pDiv) {
		$("#" + pDiv + "Iframe").css("display","none");
	},
	
	/**
	 * 전체 DIV 팝업을 닫는다.
	 */
	hideAllDivPopup : function() {
		for ( var i in gDivPopup )
			popup.hideDivPopup(pDivPopup[i]);
	},
	
	/**
	 * 팝업을 오픈한다.
	 * @param pUrl
	 * @param pWidth
	 * @param pHeight
	 * @param pName
	 * @param pOpt
	 */
	showPopup : function(pUrl,pWidth,pHeight,pName,pOpt) {
		var url = pUrl;
		var left = window.screen.availWidth / 2 - pWidth / 2;
		var top = window.screen.availHeight / 2 - pHeight / 2;
		var opts = 'top=' + top + 
				     ',left=' + left +
				     ',width=' + pWidth + 
				     ',height=' + pHeight +
				     ',' + (pOpt == null || pOpt == undefined ? 'scrollbars=no,resizable=no,status=no,toolbar=no,menubar=no' : pOpt); 
		var popupName = (pName == null || pName == undefined ? "gWinPopup" : pName); 

		gWinPopup[popupName] = window.open(url,popupName,opts);
		gWinPopup[popupName].focus();
	},

	/**
	 * 전체 팝업을 닫는다.
	 */
	hideAllPopup : function() {
		for ( var i in gWinPopup )
			gWinPopup[i].close();
	},

	/**
	 * 과정 Master 상세 팝업을 보여준다.
	 * @returns
	 */
	showCourseMaster : function(pCourseCode) {
		Popup.showPopup(context + "/courseMaster/courseMasterPV.do?courseCode=" + pCourseCode,900,740,"courseMasterPopup");
	},
	
	/**
	 * 과정 상세 팝업을 보여준다.
	 * @returns
	 */
	showCourse : function(pCourseId, pChasu) {
		Popup.showPopup(context + "/courseManage/courseManagePV.do?courseId=" + pCourseId + "&chasu=" + pChasu,900,600,"coursePopup");
	},

	/**
	 * 게시판 팝업을 보여준다.
	 * @returns
	 */
	showBoard : function(pKind,pCourseId) {
		if ( pKind == "NOTICE" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardNoticeList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else if ( pKind == "FREE" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardFreeList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else if ( pKind == "DATA" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardDataList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else if ( pKind == "QNA" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardQnaList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else if ( pKind == "REPORT" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardReportList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else if ( pKind == "DISCUSSION" )
			Popup.showPopup(context + "/common/boardPopup.do?url=" + encodeURIComponent(context + "/board/boardDiscussionList.do?courseId=" + pCourseId + "&isPopup=Y"),920,800,"boardPopup");
		else
			alert("구분자 오류");
	},

	/**
	 * 게시판 팝업을 보여준다.
	 * @returns
	 */
	showUserBoard : function(pKind,pCourseId,pSeq) {
		if ( pSeq == undefined ) {
			if ( pKind == "NOTICE" )
				Popup.showPopup(context + "/board/userBoardNoticeList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else if ( pKind == "FREE" )
				Popup.showPopup(context + "/board/userBoardFreeList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else if ( pKind == "DATA" )
				Popup.showPopup(context + "/board/userBoardDataList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else if ( pKind == "QNA" )
				Popup.showPopup(context + "/board/userBoardQnaList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else if ( pKind == "REPORT" )
				Popup.showPopup(context + "/board/userBoardReportList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else if ( pKind == "DISCUSSION" )
				Popup.showPopup(context + "/board/userBoardDiscussionList.do?courseId=" + pCourseId,900,850,"boardPopup");
			else
				alert("구분자 오류");
		} else {
			if ( pKind == "NOTICE" )
				Popup.showPopup(context + "/board/userBoardNoticeV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else if ( pKind == "FREE" )
				Popup.showPopup(context + "/board/userBoardFreeV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else if ( pKind == "DATA" )
				Popup.showPopup(context + "/board/userBoardDataV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else if ( pKind == "QNA" )
				Popup.showPopup(context + "/board/userBoardQnaV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else if ( pKind == "REPORT" )
				Popup.showPopup(context + "/board/userBoardReportV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else if ( pKind == "DISCUSSION" )
				Popup.showPopup(context + "/board/userBoardDiscussionV.do?courseId=" + pCourseId + "&seq=" + pSeq + "&prevParams=" + encodeURIComponent("courseId=" + pCourseId),900,850,"boardPopup");
			else
				alert("구분자 오류");
		}
	},

	/**
	 * 진도 팝업을 보여준다.
	 * @returns
	 */
	showProgress : function(pCourseId) {
		Popup.showPopup(context + "/education/progress.do?courseId=" + pCourseId + "&isPopup=Y",900,850,"boardPopup");
	},

	/**
	 * 진도 팝업을 보여준다.
	 * @returns
	 */
	showUserProgress : function(pCourseId) {
		Popup.showPopup(context + "/education/userProgress.do?courseId=" + pCourseId + "&isPopup=Y",750,710,"boardPopup");
	},

	/**
	 * 시험 팝업을 보여준다.
	 * @returns
	 */
	showExam : function(pCourseId, pWeek) {
		Popup.showPopup(context + "/exam/userExam.do?courseId=" + pCourseId + "&week=" + pWeek,900,800,"educationSubPopup");
	},

	showExamResult : function(pCourseId) {
		Popup.showPopup(context + "/exam/userExamResult.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	/**
	 * 강좌 수강자 상세 팝업을 보여준다.
	 * @param pUserId
	 */
	showCompanyRegister : function(pCourseId) {
		alert("보여줄 예정..")
	},

	/**
	 * 강좌시작
	 * @param pUserId
	 * @param pWidth
	 * @param pHeight
	 */
	showUserCourse : function(pCourseId,pWidth,pHeight) {
		Popup.showPopup(context + "/education/eduHome.do?courseId=" + pCourseId + "&week=" + "&isPopup=Y",pWidth,pHeight);
	},

	/**
	 * 강좌시작(주차별)
	 * @param pCourseId
	 * @param pWeek
	 * @param pWidth
	 * @param pHeight
	 */
	showUserCourseWeek : function(pCourseId,pWeek,pWidth,pHeight) {
		Popup.showPopup(context + "/education/eduHome.do?courseId=" + pCourseId + "&week=" + pWeek + "&isPopup=Y",pWidth,pHeight);
	},

	/**
	 * 강좌종료후 다시보기시작
	 * @param pUserId
	 * @param pWidth
	 * @param pHeight
	 */
	showReviewCourse : function(pCourseId,pWidth,pHeight) {
		Popup.showPopup(context + "/education/eduHome.do?courseId=" + pCourseId + "&isPopup=Y",pWidth,pHeight);
	},
	
	/**
	 * 미리보기
	 * @param pUserId
	 * @param pWidth
	 * @param pHeight
	 */
	showSampleCourse : function(pCourseId,pWidth,pHeight) {
		Popup.showPopup(context + "/guest/eduSampleHome.do?courseId=" + pCourseId + "&isPopup=Y",pWidth,pHeight);
	},

	/**
	 * 미리보기 (관리자용)
	 * @param pUserId
	 * @param pWidth
	 * @param pHeight
	 */
	showViewCourse : function(pCourseId,pWeek,pWidth,pHeight) {
		Popup.showPopup(context + "/education/viewHome.do?courseId=" + pCourseId + "&week=" + pWeek + "&isPopup=Y",pWidth,pHeight);
	},

	/**
 	 * 컨텐츠 미리보기
	 * @param pCourseCode
	 * @param pJucha
	 * @param pWidth
	 * @param pHeight
	 */
	showViewContents : function(pCourseCode,pWeek,pWidth,pHeight) {
		Popup.showPopup(context + "/education/contentsHome.do?courseCode=" + pCourseCode + "&week=" + pWeek,pWidth,pHeight);
	},
	
	/**
	 * 설문지 작성
	 * @param pCourseId
	 * @param pQgId
	 */
	showQuest : function(pCourseId) {
		Popup.showPopup(context + "/quest/userQuest.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	showQuestResult : function(pCourseId) {
		Popup.showPopup(context + "/quest/userQuestResult.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	showReport : function(pCourseId) {
		Popup.showPopup(context + "/report/userReport.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	showReportResult : function(pCourseId) {
		Popup.showPopup(context + "/report/userReportResult.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	showReportScore : function(pCourseId, userId) {
		Popup.showPopup(context + "/report/userReportScore.do?courseId=" + pCourseId + "&userId=" + userId,900,800,"educationSubPopup");
	},

	/**
	 * 수강후기
	 * @param pCourseId
	 */
	showPostscriptList : function(pCourseId) {
		Popup.showPopup(context + "/postscript/postscriptList.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},
	
	/**
	 * 수강후기 작성
	 * @param pCourseId
	 */
	showPostscript : function(pCourseId) {
		Popup.showPopup(context + "/postscript/postscriptN.do?courseId=" + pCourseId,900,800,"educationSubPopup");
	},

	/**
	 * 수강후기 조회
	 * @param pCourseId
	 */
	showPostscriptV : function(pCourseId) {
		Popup.showPopup(context + "/postscript/postscriptV.do?courseId=" + pCourseId,900,800);
	},
	
	/**
	 * 패스워드 변경
	 */
	showPasswordChange : function() {
		Popup.showPopup(context + "/member/memberChangePassword.do",400,250);
	},
	
	/**
	 * 사용자 조회
	 */
	showUserSearch : function(kind) {
		if ( kind != undefined )
			Popup.showPopup(context + "/common/userSearchList.do",700,520,"userSearch");
		else
			Popup.showPopup(context + "/common/userSearchList.do?screen=" + kind,700,520,"userSearch");
			
	},

	showStudyroom : function(pCourseId) {
		Popup.showPopup(context + "/user/studyroom.do?courseId=" + pCourseId, 1185, 810, "studyroom");
	}


}


