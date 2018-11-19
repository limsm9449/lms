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
    <title>나의강의실 - 학습</title>
    
    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepage/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepage/css/classroom/study.css'>
    
    <script src='/resources/homepage/js/dev_sub.js?timestamp=<%=timestamp%>'></script>
</head>

<script type="text/javascript">

var flag = "NOTICE";

$(document).ready(function(){
});
</script>

<body>
<frameset rows='*'>    
    <div class='wrap clear_fix'>
        <div class='study_left_area'>
            <div class='study_title_box'>
                <p>[스마트러닝]</p>
                <a href='#' onclick="alert('작업중입니다.'); return false">강사소개</a>
                <h1>
                    ${set.courseInfo.courseName}
                </h1>

            </div>
            <div class='study_day_box clear_fix'>
                <p class='study_day_dday'>D</p>
                <span>-</span>
                <p class='study_day_dday'>${set.courseInfo.remainDay}</p>
                <p class='study_day_date'>
                    학습기간
                    <span></span>
                    ${set.courseInfo.cFromDate} ~ ${set.courseInfo.cToDate} (${set.courseInfo.cPeriod}일간)
                </p>
            </div>
            <div class='study_current_box clear_fix'>
                <p>나의 학습현황</p>
                <div class='study_table_box'>
                    <table>
                        <tr class='study_current_table_line'>
                            <th class="study_current_table_title">항목</th>
                            <th class="study_current_table_title d">반영기준</th>
                            <th class="study_current_table_title">나의현황</th>
                            <th class="study_current_table_title">과락기준</th>
                        </tr>
<c:if test="${set.courseInfo.progressRate ne '0'}">                            
                        <tr class='study_current_table_line'>
                            <td>진도율</td>
                            <td class='d'><span>${set.courseInfo.progressRate}%</span>반영</td>
                            <td><span>${set.courseInfo.progressRate}%</span></td>
                            <td>${set.courseInfo.progressFail}점</td>
                        </tr>
</c:if>                        
<c:if test="${set.courseInfo.examRate ne '0'}">                            
                        <tr class='study_current_table_line'>
                            <td>최종평가</td> 
                            <td class='d'><span>${set.courseInfo.examRate}%</span>반영</td>
                            <td>${set.courseInfo.exam}점</td>
                            <td>${set.courseInfo.examFail}점</td>
                        </tr>
</c:if>                        
<c:if test="${set.courseInfo.discussionRate ne '0'}">                            
                        <tr class='study_current_table_line'>
                            <td>토론</td> 
                            <td class='d'><span>${set.courseInfo.discussionRate}%</span>반영</td>
                            <td>${set.courseInfo.discussion}점</td>
                            <td>${set.courseInfo.discussionFail}점</td>
                        </tr>
</c:if>                        
<c:if test="${set.courseInfo.reportRate ne '0'}">                            
                        <tr class='study_current_table_line'>
                            <td>레포트</td> 
                            <td class='d'><span>${set.courseInfo.reportRate}%</span>반영</td>
                            <td>${set.courseInfo.report}점</td>
                            <td>${set.courseInfo.reportFail}점</td>
                        </tr>
</c:if>                        
                        <tr class='study_current_table_line back'>
                            <td>총점</td>
                            <td class='d'></td>
                            <td><span>${set.courseInfo.total}점</span></td> 
                            <td>${set.courseInfo.totalFail}점</td>
                        </tr>
                    </table>
                    <p>* 수료기준은 각 항목의 환산점수 총점이 ${set.courseInfo.totalFail}점 이상입니다.</p>
                </div>
                <div class='study_graph clear_fix'>
                    <div class='average'>
                        <div>
                            <p id='percentage_average'>${set.courseInfo.periodProgress}%</p>
                            <span></span>
                        </div>
                        <p>권장</p>
                    </div>
                    <div class='my'>
                        <div class='left_margin'>
                            <p id='percentage_my'>${set.courseInfo.progress}%</p>
                            <span></span>
                        </div>
                        <p>MY</p>
                    </div>
                </div>
            </div>
            <div class='study_start_btn'>
                <button onclick="javascript:Popup.showUserCourse('${set.courseInfo.courseId}','${set.courseInfo.hPx + 100}','${set.courseInfo.vPx + 100}');">학습시작</button>
            </div>
            <div class='study_support_box'>
                <div class='study_tab_area clear_fix'>
                    <button onclick='study_btn_click(this); flag = "NOTICE";' class='on' id='notice'>과정 공지사항</button>
                    <button onclick='study_btn_click(this); flag = "QNA";' id='qna'>질문 답변</button>
                    <a href='#' onclick="javascript:Popup.showUserBoard(flag,'${set.courseInfo.courseId}'); return false;">MORE +</a>
                </div>
                <ul class='study_support_list_box notice'>
<c:forEach var="row" items="${set.boardNoticeList}" varStatus="idx"> 
                    <li>
                        <a href='#' onclick="javascript:Popup.showUserBoard('NOTICE','${set.courseInfo.courseId}','${row.seq}'); return false;" class='clear_fix'>
                            <p class='study_support_text'>${row.title}</p>
                            <p class='study_support_date'>${row.createDate}</p>
                        </a>
                    </li>
</c:forEach>                    
                </ul>
                <ul class='study_support_list_box qna'>
<c:forEach var="row" items="${set.boardQnaList}" varStatus="idx"> 
                    <li>
                        <a href='#' onclick="javascript:Popup.showUserBoard('QNA','${set.courseInfo.courseId}','${row.seq}'); return false;" class='clear_fix'>
                            <p class='study_support_text'>${row.title}</p>
                            <p class='study_support_date'>${row.createDate}</p>
                        </a>
                    </li>
</c:forEach>                    
                </ul>
            </div>
            <div class='study_btn_area pc clear_fix'>
                <button onclick='open_popup("popup_standard", true)'>학습/수료<span></span>기준</button>
                <button onclick='open_popup("popup_guide", true)'>학습<span></span>가이드</button>
                <button onclick='open_popup("popup_video_setting", true)'>동영상<span></span>설정</button>
                <button onclick='open_popup("popup_preference", true)'>환경<span></span>설정</button>
                <button onclick="Popup.showUserBoard('QNA','${set.courseInfo.courseId}'); return false;" class='last_right'>학습<span></span>질문답변</button>
            </div>
            <div class='study_remote_support_btn'>
                <button onclick="opener.page.goPage('/main/service', 'shap=screen_remoteService');">원격지원 서비스</button>
            </div>
        </div>
        <div class='study_right_area'>
            <div class='study_my_progress'>
                나의 학습 정보<a href=''></a>
            </div>
            <p>
                <span>아직 진도율 <strong>${set.courseInfo.progress}%</strong>입니다.</span> 오늘은 꼭 1개 단원 이상 학습 바랍니다. 화이팅!
            </p>
            <div class='study_list clear_fix'>
                <p class='study_list_table_title'>학습목차</p>
                <div class='study_list_table_wrap'>
                    <table>
                        <tr class='study_list_table_line'>
                            <th class='line_1'>차시명</th>
                            <th class='line_2'>학습시간</th>
                            <th class='line_3'>학습완료일자</th>
                            <th class='line_4'>관심</th>
                            <th class='line_5 last_right'>학습</th>
                        </tr>
<c:forEach var="row" items="${set.week}" varStatus="idx"> 
                        <tr class='study_list_table_line'>
                            <td class='text_left'>
                                <span>${idx.index + 1}</span>
                                <p onclick="javascript:Popup.showUserCourseWeek('${set.courseInfo.courseId}','${row.week}','${set.courseInfo.hPx + 100}','${set.courseInfo.vPx + 100}')">${row.title}</p>
                            </td>
                            <td>${row.weekTime}분</td>
                            <td>${row.studyEnd}</td> 
                            <td>
                                <img src='/resources/homepage/img/course/star_active.png' alt=' '>
                            </td>
                            <td class='last_right'>
                                <button onclick="javascript:Popup.showUserCourseWeek('${set.courseInfo.courseId}','${row.week}','${set.courseInfo.hPx + 100}','${set.courseInfo.vPx + 100}')">시작</button>
                            </td>
                        </tr>
</c:forEach>                        
                    </table>
                </div>
            </div>
            <div class='sutdy_estimation'>
                <p class='study_list_table_title'>평가항목</p>
                <div class='study_estimation_table_wrap'>
                    <table>
                        <tr class='study_estimation_table_line'>
                            <th class='line_1 mobile'>NO</th>
                            <th class='line_2 mobile'>항목</th>
                            <th class='line_3'>제출일</th>
                            <th class='line_4 mobile'>점수</th>
                            <th class='line_5 last_right'>채점일</th>
                        </tr>
<c:forEach var="row" items="${set.exam}" varStatus="idx"> 
                        <tr class='study_estimation_table_line'>
                            <td class='line_1 mobile'>${idx.index + 1}</td>
	<c:if test="${row.week eq '0'}">                            
                            <td class='line_2 mobile'>최종 학습평가</td>
	</c:if>                            
	<c:if test="${row.week ne '0'}">                            
                            <td class='line_2 mobile'>${row.week} 주 진행 학습평가</td>
	</c:if>                            
                            <td>${row.submitDate}</td>
                            <td class='line_4 esti_btn mobile'>
	<c:choose>
		<c:when test="${idx.index eq 0 && row.examYn eq 'N'}">
                                <button onclick="Popup.showExam('${set.courseInfo.courseId}', '${row.week}');">응시하기</button> 
		</c:when>
		<c:when test="${idx.index eq 0 && row.examYn eq 'Y'}">
                                <button onclick="Popup.showExamResult('${set.courseInfo.courseId}', '${row.week}');">완료</button>
		</c:when>
		<c:when test="${row.totalCnt eq '0'}">
                                <button onclick="Popup.showExam('${set.courseInfo.courseId}', '${row.week}');">응시하기</button>
		</c:when>
		<c:otherwise>
                                <button onclick="Popup.showExamResult('${set.courseInfo.courseId}', '${row.week}');">완료</button>
		</c:otherwise>
	</c:choose>                            
                            </td>
                            <td class='last_right'>
                                ${row.scoreDate}
                            </td>
                        </tr>
</c:forEach>                 
                    </table>
                </div> 
            </div>
            <div class='study_btn_area mobile clear_fix'>
                <button>학습/수료<span></span>기준</button>
                <button>학습<span></span>가이드</button>
                <button>동영상<span></span>설정</button>
                <button>환경<span></span>설정</button>
                <button onclick="Popup.showUserBoard('QNA','${set.courseInfo.courseId}');" class='last_right'>학습<span></span>질문답변</button>
            </div>
        </div>
        <div class='study_bottom_area clear_fix'>
            <div class='study_bottom_box'>
                <a href='#' onclick="javascript:Popup.showUserBoard('NOTICE','${set.courseInfo.courseId}'); return false;">공지사항</a>
                <span></span>
                <a href='#' onclick="javascript:Popup.showUserBoard('DATA','${set.courseInfo.courseId}'); return false;">자료실</a>
                <span></span>
                <a href='#' onclick="javascript:Popup.showUserBoard('FREE','${set.courseInfo.courseId}'); return false;">자유게시판</a>
                <span></span>
                <a href='#' onclick="javascript:Popup.showProgress('${set.courseInfo.courseId}'); return false;">진도상세보기</a>
                <span></span>
<c:choose>
	<c:when test="${set.courseInfo.postscriptYn eq 'Y'}">
             	<a href='#' onclick="javascript:Popup.showPostscriptV('${set.courseInfo.courseId}'); return false;">학습후기</a>
	</c:when>
	<c:otherwise>
             	<a href='#' onclick="javascript:Popup.showPostscript('${set.courseInfo.courseId}'); return false;">학습후기</a>
	</c:otherwise>
</c:choose>                 
                
                <span></span>
                <a href='#' onclick="javascript:Popup.showUserBoard('QNA','${set.courseInfo.courseId}'); return false;">학습 질문답변</a>
            </div>
        </div>
    </div>
</frameset>
</body>

</html>