var firstLoad = "Y";

var currentCourseId = 0;
var currentWeek = 0;
var currentPage = 0;
var totalWeek = 0;
var isSaveOk = false;	
var isSample = false;	



//컨텐츠와 연결하기 위한 함수 
var etop = {
	goNext : function() {
		alert("goNext");
	},
	eduChk : function() {
		alert("eduChk");
	},
	goNext : function() {
		alert("goNext");
	},
	// 차시 처음 들어올때..
	getPageInfo : function() {
		alert("getPageInfo");
	},
	// 차시를 나갈때..
	setPageInfo : function() {
		alert("setPageInfo");
	},
	currentPage : ""
}

var weeks = [], pages = [], directorys = [], titles = [], clips = [], myWeeks = [];
var rootDirectory = "";
var mobileYn = "N";
var oldCurrentWeek = 0;

var QP_API = {
	/**
	 * 초기값 세팅
	 * @param pCourseId
	 * @param pCurrentWeek
	 * @param pCurrentPage
	 * @param pTotalWeek
	 */
	init : function(pCurrentCourseId, pCurrentWeek, pCurrentPage, pTotalWeek, pIsSaveOk, pIsSample, pUserId) {
		currentCourseId = pCurrentCourseId;
		currentWeek = pCurrentWeek;
		currentPage = pCurrentPage;
		totalWeek = pTotalWeek;		
		isSaveOk = pIsSaveOk; 
		isSample = pIsSample;
		
		if ( weeks.length == 0 ) {
			$.ajax({
				type :"POST",
				url : context +"/ns/education/resourceInfo.do",
				dataType :"json",
				async : false,
				data : "courseId=" + currentCourseId + "&userId=" + ( pUserId == undefined ? "" : pUserId ),
				success : function(json){
					if ( json.contentsUrl != "-" ) {
						contents = json.contentsUrl;
					}
					
					for ( var i = 0; i < json.resourceList.length; i++ ) {
						if ( isSample ) {
							weeks.push(json.resourceList[i].week); 
							pages.push(json.resourceList[i].previewPage); 
							directorys.push(json.resourceList[i].rootDirectory + "/" + json.resourceList[i].directory + "/"); 
							titles.push(json.resourceList[i].title);
							myWeeks.push("Y"); 
						} else {
							weeks.push(json.resourceList[i].week); 
							pages.push(json.resourceList[i].pageCnt); 
							directorys.push(json.resourceList[i].rootDirectory + "/" + json.resourceList[i].directory + "/"); 
							titles.push(json.resourceList[i].title);
							myWeeks.push(json.resourceList[i].myWeek); 
						}
					}
					
					for ( var i = 0; i < json.resourcePageList.length; i++ ) {
						clips.push({
							week : json.resourcePageList[i].week,
							clip : json.resourcePageList[i].clip,
							fromPage : json.resourcePageList[i].fromPage,
							toPage : json.resourcePageList[i].toPage
						});
					}
					
					if ( json.resourceList.length > 0 ) {
						rootDirectory = json.resourceList[0].rootDirectory; 
					}
				},
				error : function(e) {
					alert("오류 발생");
				}
			})
		}
	},
		
	/**
	 * 다음 페이지로 이동
	 */
	goNextPage : function() {
		//페이지가 0이거나(샘플보기가 없는 경우), 마지막 페이지면 다음 차시로 넘어간다.
		if ( pages[currentWeek - 1] == 0 || currentPage == pages[currentWeek - 1] ) {
			//이전 페이지 완료 처리
			QP_API.updPrevPage();

			//마지막 페이지이면...
			if ( currentWeek == totalWeek ) {
				alert("해당 차시의 마지막 페이지입니다.");
			}

			console.log("currentWeek : " + currentWeek);

			//다음 차시를 구한다.
			var isNext = false;
			for ( i = currentWeek; i < totalWeek; i++ ) {
				// 2019.1.23 ????
				if ( myWeeks[i] == "Y" && pages[i] != 0) {
					currentWeek = i + 1;
					isNext = true;
					break;
				}
			}

			//차시가 변경이 되면 설문기능 반영을 위해서 강의창을 refresh 한다.
			if ( isNext == true ) {
				opener.location.reload();
			}
			
			if ( isNext == false && isSample == false) {
				$.ajax({
					type :"POST",
					url : context +"/education/progressComplete.do",
					dataType :"json",
					data : "courseId=" + currentCourseId,
					success : function(json){
						var msg = "";
						if ( json.IsExam == "Y") {
							msg += ( msg == "" ? "" : ", " ) + "레포트";
						}
						if ( json.IsReport == "Y") {
							msg += ( msg == "" ? "" : ", " ) + "시험";
						}
						if ( json.IsDiscussion == "Y") {
							msg += ( msg == "" ? "" : ", " ) + "설문지 작성";
						}
						if ( json.isOther == "Y" && msg != "") {
							alert("과정의 진도가 끝났습니다. " + msg + "을 해주세요.");
						} else {
							alert("과정의 진도가 끝났습니다.");
						}
					},
					error : function(e) {
						alert("오류 발생");
					}
				})
			} else if ( isNext == false && isSample == true) {
				alert("과정의 Sample이 끝났습니다.");
			} else {
				//다음 차수 오픈
				QP_API.openWeek(currentWeek);
			}
		} else {
			//이전 페이지 완료 처리
			QP_API.updPrevPage();
			
			QP_API.openPage(QP_API.nextPageHtml());
		}
	},	

	/**
	 * 이전 페이지로 이동
	 */
	goPrevPage : function() {
		//이전 페이지로 갈 경우 현재 페이지 완료 처리
		QP_API.updPage();
		
		if ( currentPage == 1 ) {
			if ( currentWeek == 1 ) {
				alert("1차시 입니다.");
			} else {
				//이전 차시를 구한다.
				for ( i = currentWeek - 2; i >= 0; i-- ) {
					if ( myWeeks[i] == "Y" && pages[i] != 0) {
						currentWeek = i + 1;
						break;
					}
				}

				console.log("currentWeek : " + currentWeek);
				
				QP_API.goPage(pages[currentWeek - 1]);
			}
		} else {
			QP_API.openPage(QP_API.prevPageHtml());
		}
	},

	/**
	 * 특정 페이지로 이동 
	 * @param page
	 */
	goPage : function(page) {
		currentPage = parseInt(page);

		//top.eduContent.document.getElementsByName("contents")[0].src = QP_API.currPageHtml();
		$("#eduContent").attr("src", contents + directorys[currentWeek - 1] + QP_API.currPageHtml());
		console.log(contents + directorys[currentWeek - 1] + QP_API.currPageHtml());
		
		QP_API.showPageInfo();
		
		//현재 페이지 시작 처리
		QP_API.updPage();
	},
	
	/**
	 * 페이지 오픈
	 * @param page
	 */
	openPage : function(htmlPage) {
		//top.eduContent.document.getElementsByName("contents")[0].src = htmlPage;
		$("#eduContent").attr("src", contents + directorys[currentWeek - 1] + htmlPage);
		console.log(contents + directorys[currentWeek - 1] + htmlPage);
		
		QP_API.showPageInfo();
		
		//현재 페이지 시작 처리
		QP_API.updPage();
	},

	/**
	 * 차수 오픈
	 * @param page
	 */
	openWeek : function(week) {
		if ( mobileYn == "Y" ) {
			currentWeek = week;
			
			document.frm.action = contents + rootDirectory + "/mp4/" + ( currentWeek < 10 ? "0" : "" ) +  currentWeek + ".html";
			document.frm.target = "eduContent";
			document.frm.method = "GET";	
			document.frm.submit();

			//현재 페이지 시작 처리
			QP_API.updPage();
		} else {
			currentWeek = week;
			currentPage = 1;
			
			document.frm.action = contents + directorys[currentWeek - 1] + QP_API.currPageHtml();
			document.frm.target = "eduContent";
			document.frm.method = "GET";	
			document.frm.submit();

			QP_API.showPageInfo();
			
			//현재 페이지 시작 처리
			QP_API.updPage();
		}
	},

	/**
	 * 마지막 페이지 오픈
	 * @param page
	 */
	openLastPage : function() {
		if ( mobileYn == "Y" ) {
			document.frm.action = contents + rootDirectory + "/mp4/" + ( currentWeek < 10 ? "0" : "" ) +  currentWeek + ".html";
			document.frm.target = "eduContent";
			document.frm.method = "GET";	
			document.frm.submit();

			//현재 페이지 시작 처리
			QP_API.updPage();
		} else {
			document.frm.action = contents + directorys[currentWeek - 1] + QP_API.currPageHtml();
			document.frm.target = "eduContent";
			//document.frm.method = "GET";	
			document.frm.submit();
	 
			QP_API.showPageInfo();
			
			//현재 페이지 시작 처리
			QP_API.updPage();
		}
	},

	/**
	 * 이전 페이지 완료 처리
	 */
	updPrevPage : function() {
		if ( isSaveOk == true ) {
			$.ajax({
				async : false,
				type : "POST",
				url : context + "/education/updPrevPage.do",
				dataType : "json",
				data : {courseId : currentCourseId,
					    week : currentWeek,
					    page : currentPage},
				success : function(json){
				}
			});
		}
	},
	
	/**
	 * 현재 페이지 시작 처리
	 */
	updPage : function() {
		if ( isSaveOk == true ) {
			$.ajax({
				async : false,
				type : "POST",
				url : context + "/education/updPage.do",
				dataType : "json",
				data : {courseId : currentCourseId,
					    week : currentWeek,
					    page : currentPage},
				success : function(json){
					if ( json.rtnMode == "DAY_OVER" ) {
						$("#eduContent").attr("src", "");
						
						alert("하루에 학습 할 수 있는 차수는 " + json.rtnMessage + "차시 입니다. 내일 다시 학습을 해주세요.");
						window.close();
					} else {
						console.log("updPage success");
					}
				}
			});
		}
	},
	
	/**
	 * 이전페이지
	 * @returns
	 */
	prevPageHtml : function() {
		currentPage = currentPage - 1; 
		return QP_API.currPageHtml();
	},

	/** 
	 * 다음 페이지
	 * @returns
	 */
	nextPageHtml : function() {
		currentPage = currentPage + 1; 
		return QP_API.currPageHtml();
	},

	/**
	 * 현재 페이지
	 * @returns {String}
	 */
	currPageHtml : function() {
		//return (1000 + currentPage) + ".html";
		console.log(( currentWeek > 9 ? currentWeek : "0" + currentWeek ) + "_" + ( currentPage > 9 ? currentPage : "0" + currentPage ) + ".html");
		return ( currentWeek > 9 ? currentWeek : "0" + currentWeek ) + "_" + ( currentPage > 9 ? currentPage : "0" + currentPage ) + ".html";
	},

	showPageInfo : function() {
		if ( $(".now_page").length > 0 ) {
			$(".now_page").html(currentPage);
			$(".total_page").html(pages[currentWeek - 1]);
			
			if ( oldCurrentWeek != currentWeek ) {
				//차시 오픈
				left_menu_open(document.getElementById("left_week_" + currentWeek), "main");
				oldCurrentWeek = currentWeek;
			}
			
			$.each($(".left_bottom_ul > li"), function(i) {
				$(this).removeClass("first_depth");
			});
			
			for ( var i = 0; i < clips.length; i++ ) {
				if ( parseInt(clips[i].week) == currentWeek && parseInt(clips[i].fromPage) <= currentPage && parseInt(clips[i].toPage) >= currentPage ) {
					$("#left_page_" + currentWeek + "_" + clips[i].clip).addClass("first_depth");
					break;
				}
			}
		}
	},

	clickPage : function(cWeek, cPage) {
		currentWeek = cWeek;
		currentPage = cPage;
		
		//클릭시 차시는 열려있기에 flag를 변경해줌.
		oldCurrentWeek = currentWeek;
		
		QP_API.openPage(QP_API.currPageHtml());
		
	},

	a : function() {
	}
}







/**
 * 페이지 이동
 * @param idx
 */
function f_viewEdu(idx) {
	currentWeek = idx;
	currentPage = 1;
	QP_API.updPage();
	
	document.frm.action = contents + directorys[currentWeek - 1] + "start.html";
	document.frm.target = "eduContent";
	document.frm.method = "GET";	
	document.frm.submit();
} 


function gfn_qpApiLog() {
	console.log("weeks");
	console.log(weeks);
	console.log("pages");
	console.log(pages);
	console.log("directorys");
	console.log(directorys);
	console.log("titles");
	console.log(titles);
	console.log("clips");
	console.log(clips);
	console.log("myWeeks");
	console.log(myWeeks);
	console.log("currentWeek : " + currentWeek + ", oldCurrentWeek : " + oldCurrentWeek + ", currentPage : " + currentPage);
}