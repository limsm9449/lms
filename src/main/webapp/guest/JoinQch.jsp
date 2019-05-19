<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang='ko' data-useragent='Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)'>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1'>
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>
    <title>Q learning - 회원가입 - 이용약관</title>

    <%@ include file="../common/commMainInclude.jsp" %>

    <link href='https://fonts.googleapis.com/css?family=Nanum+Gothic' rel='stylesheet'>

    <link rel='stylesheet' href='/resources/homepageQch/css/initialization.css'>
    <link rel='stylesheet' href='/resources/homepageQch/css/etc/signup.css'>
</head>

<script type="text/javascript">
$(document).ready(function() {
});


function lfn_btn(pKind, pParam) {
	if ( pKind == "all" ) {
		if ( $("#all").is(":checked") ) {
            $("#chk1").prop("checked", "checked");
            $("#chk2").prop("checked", "checked");
		} else {
            $("#chk1").prop("checked", "");
            $("#chk2").prop("checked", "");
		}
	} else if ( pKind == "next" ) {
		if ( $("input[name=chk1]:checked").length == 0) {
			alert("이용약관에 동의하셔야 합니다.");
			return false;
		}

		if ( $("input[name=chk2]:checked").length == 0) {
			alert("개인정보취급방침 동의하셔야 합니다.");
			return false;
		}

		gfn_goPage("/guest/join2",$("#frm").serialize());
	}
}

</script>

<body>
<frameset rows='*'>
    <div class='wrap'>
        <!-- HEAD -->
        <%@ include file="../common/mainTopQch.jsp" %>
        <!-- HEAD END -->

        <!-- QUICK MENU -->
        <%@ include file="../common/mainQuickMenuQch.jsp" %>

        <!-- CONTENTS -->
        <div class='contents_wrap_box' >

            <!-- Top -->
            <div class='top_area'>
                <div class='clear_fix'>
                    <div class='process_history_box clear_fix'>
                        <span>
                            <img src='/resources/homepageQch/img/course/ic_home.jpg' alt=' '>
                        </span>
                        <p>HOME</p>
                        <span>
                            <img src='/resources/homepageQch/img/course/arr_right.jpg' alt=' '>
                        </span>
                        <p>회원가입</p>
                    </div>
                </div>
            </div>
            <!-- Top END -->

            <div class='util_wrap'>
                <h1>
                    회원가입
                </h1>
                <div class='util_step_box clear_fix'>
                    <div class='active pd'>
                        <span><img src='/resources/homepageQch/img/etc/ic_step1_active.png' alt=''></span>
                        <p>이용약관</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepageQch/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepageQch/img/etc/ic_step2.png' alt=''></span>
                        <p>가입여부<span></span>확인</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepageQch/img/etc/arr_right.png' alt=''></div>
                    <div>
                        <span><img src='/resources/homepageQch/img/etc/ic_step3.png' alt=''></span>
                        <p>회원정보<span></span>입력</p>
                    </div>
                    <div class='arrow'><img src='/resources/homepageQch/img/etc/arr_right.png' alt=''></div>
                    <div class='last_right pd'>
                        <span><img src='/resources/homepageQch/img/etc/ic_step4.png' alt=''></span>
                        <p>가입완료</p>
                    </div>
                </div>
                <div class='signup_all_agree_box clear_fix'>
                    <input type='checkbox' name='all' id='all' onclick="lfn_btn('all')">
                    <p>이용약관, 개인정보 수집 및 이용 안내에 대한 내용을 모두 확인하고 동의합니다.</p>
                </div>
                <div class='signup_title_box'>
                    <p class='signup_title'>이용약관</p>
                    <p>
                        큐러닝에 오신 것을 환영합니다. 무료 회원가입으로 큐러닝의 각종 서비스를 제공 받으실 수 있습니다. <span></span>고객님께서 입력하신 회원정보와 웹사이트의 모든 정보는 완벽한 보안체계에 의해 암호화 되어 안전하게 보호 됩니다. <span></span>큐러닝은 공정거래위원회에서 심의한 표준약관을 따르고 있습니다.
                    </p>
                </div>
                <div class='signup_terms_box'>
                    <div>
                        <p>회원 이용 약관</p>                        
                        <div class='signup_terms_text'>
                            <strong class='title'>제 1 조</strong>
                            (목적)이 약관은 <strong>㈜큐피플(이하 '회사')</strong>에서 제공하는 이러닝서비스 <strong>www.qlearning.co.kr(이하 '큐러닝'이라 함)</strong>의 이용에 관한 조건 및 절차와 기타 필요한 사항을 규정하는 것을 목적으로 합니다.<br><br>
                            <strong class='title'>제 2 조 (용어 정의)</strong>
                            이 약관에서 사용하는 용어의 의미는 다음과 같습니다.<br>
                            <strong>'회원'</strong>이라 함은 서비스를 제공받기 위해서 회사가 인정하는 절차의 가입을 통하여 이용자번호(ID)를 부여 받은 자를 말합니다.<br>
                            <strong>'이용자번호(ID)'</strong>라 함은 가입회원의 식별과 회원의 서비스 이용을 위해 고객이 선정하고 회사가 부여하는 영어문자와 숫자의 조합을 말합니다.<br>
                            <strong>'비밀번호'</strong>라 함은 회원이 부여 받은 이용자번호(ID)와 일치되는 회원임을 확인하고 회원의 권익보호를 위하여 회원이 선정한 문자와 숫자의 조합을 말합니다.<br>
                            제 1 항에서 정의하는 것을 제외한 용어는 관계법령 및 서비스 이용안내에서 정하는 바에 따릅니다.
                            <strong class='title'>제 3 조 (약관의 공지)</strong>
                            이 약관의 내용은 큐러닝 내용 중 <strong>"회원 이용 약관"</strong> 란을 통하여 게시하며 약관이 변경 또는 일부 수정될 경우 회사는 지체 없이 <strong>"공지사항"</strong>을 통해 공지합니다.
                            <strong class='title'>제 4 조 (약관외 준칙)</strong>
                            이 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법 및 기타 관련법령의 규정에 의합니다.
                            <strong class='title'>제 5 조 (큐러닝의 이용)</strong>
                            이용계약은 본 약관에 동의한 고객이 회사가 정하는 방법으로 신청 회사의 이용 승낙에 의하여 성립합니다.<br>
                            제 1항의 규정에 의해 고객이 이용 신청을 할 때에는 회사가 이용자 관리시 필요로 하는 사항을 반드시 입력해야 합니다.<br>
                            회사는 이용자가 허위 정보를 입력하거나 서비스 운용상 필요한 경우에 이용 승인을 유보 또는 이용을 거절할 수 있습니다.<br>
                            회원정보는 언제든지 수정이 가능하지만, 이름과 아이디는 변경이 불가능하므로 작성시 주의해야 합니다.
                            <strong class='title'>제 6 조 (약관의 동의)</strong>
                            회원이 등록절차를 거처 동의 버튼을 누름으로써 본 약관에 동의한 것으로 간주합니다.
                            <strong class='title'>제 7 조 (큐러닝의 이용)</strong>
                            회원은 가입 신청시 회원이 지정한 이용자번호(ID)와 비밀번호를 통해 서비스에 로그인하여 큐러닝을 이용합니다.<br>
                            큐러닝의 이용은 연중무휴, 1일 24시간을 원칙으로 합니다. 단, 회사가 업무 또는 기술상의 사유로 서비스가 일시 중지되거나, 운영상 목적으로 일시 중지될 수 있습니다.
                            <strong class='title'>제 8 조 (회사의 의무)</strong>
                            회사는 법령 및 본 약관에서 금하는 행위를 하지 않으며 서비스 제공과 관련해 알고 있는 회원의 개인정보를 본인의 승낙 없이 제3자에게 누설하거나 배포하지 않습니다.단, 법률에 의한 국가기관의 요구나 수사상의 목적, 개인을 식별할 수 없는 인구통계학적 자료로는 제공될 수 있습니다.회사는 회원이 제기하는 의견이나 불만이 정당하다고 인정되면 즉시 처리합니다. 다만, 즉시 처리가 곤란할 경우에는 회원에게 그 사유와 일정을 통보하여야 합니다.회사는 지속적이고 안정적인 서비스를 제공하기 위하여 설비에 장애가 있거나 망실된 때에는 이를 지체 없이 수리 또는 복구합니다. 다만, 천재지변이나 비상사태, 기타 부득이한 경우에는 그 서비스를 일시 중단하거나 중지할 수 있습니다.이때, 회사는 지체 없이 회원에게 통보하여야 합니다.
                            <strong class='title'>제 9 조 (회원의 의무)</strong>
                            회사는 이용자가 다음 사항에 해당하는 행위를 하였을 경우 별도의 사전 통보 없이 큐러닝의 이용 계약을 해지할 수 있습니다.<br>
                            가. 다른 회원의 이용자번호(ID)를 부정하게 사용하는 행위<br>
                            나. 서비스를 이용하여 얻은 정보를 회사의 사전 승낙 없이 회원의 이용 이외의 목적으로 복제하거나 이를 출판, 방송, 온라인 상의 공개 등에 사용하거나 제3자에게 제공하는 행위<br>
                            다. 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상하는 행위<br>
                            라. 공공질서 및 미풍양속에 위배되는 내용의 정보, 문장, 도형 등을 타인에게 유포하는 행위<br>
                            마. 반국가적, 반사회적, 범죄적 행위와 결부된다고 판단되는 행위<br>
                            바. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 행위<br>
                            사. 기타 관계 법령에 위배되는 행위<br>
                            회원은 이 약관에서 규정하는 사항과 서비스 이용안내 또는 주의사항 그리고 관계 법령을 준수하여야 합니다.<br>
                            회원이 설치하는 단말기 등은 전기통신설비의 기술기준에 관한 규칙이 정하는 기준에 적합하여야 하며, 서비스에 장애를 주지 않아야 합니다.<br>
                            이용자번호(ID)와 비밀번호의 관리책임은 회원 본인에게 있으며 이용자번호(ID)와 비밀번호의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다. <br>비밀번호가 타인에게 노출 된 경우 즉시 변경하여야 하며 본인의 이용자번호(ID)가 부정하게 사용된 경우 회원은 반드시 회사에 그 사실을 통보하여야 합니다.
                            <strong class='title'>제 10 조 (이용요금의 종류)</strong>
                            회사가 제공하는 서비스는 무료 또는 유료로 구분하여 제공될 수 있습니다.
                            <strong class='title'>제 11 조 (정보의 제공)</strong>
                            회사는 회원이 서비스 이용에 필요하다고 인정되는 다양한 정보를 전자우편이나 일반우편 등의 방법으로 회원에게 제공할 수 있으며 회원은 수신거부 이메일을 회사에 보내거나 회원정보에서 메일수신 여부를 수정 함으로써 정보수신 거부를 할 수 있습니다.<br>
                            개인 유료서비스 이용시 결제정보. 유료교육서비스를 이용하실 경우 결제정보를 회사에 온라인으로 기입하여 신청을 하여야 합니다.이 때 신용카드번호 및 비밀번호 등 개인결제수단의 주요정보는 회사가 보관하지 않으며, 회원은 결제상 문제발생시 결제취소를 요청할 수 있고 회사는 회원이 학습을 시작하지 않았음을 확인한 경우에 한하여 이를 처리할 책임이 있습니다.<br>
                            회원 불만사항 및 의견수렴. 회사는 회원의 불만사항 및 의견을 수렴할 수 있도록 홈페이지 내에 고객지원을 위한 메뉴를 제공합니다.
                            <strong class='title'>제 12 조 (저작권)</strong>
                            큐러닝에 게재된 자료에 대한 권리는 다음 각 호와 같습니다.<br>
                            게시물에 대한 권리와 책임은 게시자에게 있으며, 회사는 게시자의 동의 없이 이를 영리적 목적으로 사용할 수 없습니다. 단, 비영리적 목적인 경우 회사는 게시자의 동의 없이도 이를 사용할 수 있으며 서비스내의 게재권을 갖습니다.<br>
                            게시자의 사전 동의 없이는 이용자는 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적 목적으로 이용할 수 없습니다.
                            <strong class='title'>제 13 조 (게시물 삭제)</strong>
                            회사는 회원이 게시하거나 제공하는 서비스 내용이 다음 각 호에 해당한다고 판단될 경우 사전 통지 없이 삭제할 수 있습니다.<br>
                            다른 회원 또는 제3자를 비방하거나 명예를 손상시키는 내용인 경우<br>
                            허위 사실의 유포<br>
                            공공질서 및 미풍양속에 위반되는 내용인 경우<br>
                            지적재산권 등 기타 타인의 권리를 침해하는 내용인 경우<br>
                            회사의 서비스 내용과 합치하지 않는 경우<br>
                            기타 관계법령에 위반된다고 판단되는 경우
                            <strong class='title'>제 14 조 (개인정보보호정책)</strong>
                            회사는 회원이 가입시 기재한 개인정보 및 서비스를 제공하면서 획득한 금융거래정보 등의 내용을 보호하기 위해 노력합니다. 회원의 개인정보보호에 관하여는 회사의 '개인정보보호정책' 및 관련법령이 정한 바에 의합니다.
                            <strong class='title'>제 15 조 (이의신청 및 손해배상청구금지)</strong>
                            회사는 회원의 부주의로 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다. 또한 회원은 회사에서 제공하는 서비스 이용시 발생되는 어떠한 문제에 대해서도 무료서비스에 대해서는 회사 및 관계 기관에 손해배상 청구를 할 수 없으며 회사는 이에 대해 책임을 지지 아니합니다.
                            <strong class='title'>제 16 조 (취소 및 환불정책)</strong>
                            구입하신 강좌에 대해 회원님의 개인적 사정 또는 변심에 의한 환불은 7일 이내에만 가능합니다. 기타 자세한 사항은 안내문의(02-888-7805)를 이용하시기 바랍니다.<br>
                            부칙<br><br>
                            <p>(시행일) 이 약관은 2014년 9월 1일부터 시행합니다.</p>
                        </div>
                        <div class='signup_checkbox_area clear_fix'>
                            <input type='checkbox' name='chk1' id='chk1'>
                            <p>회원 이용 약관에 동의합니다.</p>
                        </div>
                    </div>
                    <div>
                        <p>개인정보취급방침</p>
                        <div class='signup_terms_text'>
                            <strong class='title'>제1조 개인정보의 처리 목적</strong>
                            <strong>(주)큐피플 ('큐러닝')</strong>은(는) 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.<br>
                            홈페이지 회원가입 및 관리<br>
                            회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만14세 미만 아동 개인정보 수집 시 법정대리인 동의 여부 확인, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.<br>
                            재화 또는 서비스 제공<br>
                            물품배송, 콘텐츠 제공, 본인인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.<br>
                            마케팅 및 광고에의 활용<br>
                            신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공 , 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.<br>
                            개인영상정보<br>
                            범죄의 예방 및 수사 등을 목적으로 개인정보를 처리합니다.<br>
                            <strong class='title'>제2조 개인정보처리 위탁</strong>
                            <strong>(주)큐피플 ('큐러닝')</strong>은(는) 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.<br>
                            <strong>(주)큐피플 ('큐러닝')</strong>은(는) 위탁계약 체결시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적·관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리·감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.<br>
                            위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.
                            <strong class='title'>제3조 정보주체의 권리,의무 및 그 행사방법</strong>
                            이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.<br>
                            정보주체는 (주)큐피플 ('큐러닝')에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.<br>
                            가. 개인정보 열람요구<br>
                            나. 오류 등이 있을 경우 정정 요구<br>
                            다. 삭제요구<br>
                            라. 처리정지 요구<br>
                            제1항에 따른 권리 행사는 (주)큐피플 ('큐러닝')에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 (주)큐피플 ('큐러닝')은(는) 이에 대해 지체 없이 조치하겠습니다.<br>
                            정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 (주)큐피플 ('큐러닝')은(는) 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br>
                            제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
                            <strong class='title'>제4조 개인정보의 파기</strong>
                            <strong>(주)큐피플 ('큐러닝')</strong>은(는) 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.<br>
                            파기절차<br>
                            이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.<br>
                            파기기한<br>
                            이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.<br>
                            파기방법<br>
                            전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.
                            <strong class='title'>제5조 개인정보의 안전성 확보 조치</strong>
                            <strong>(주)큐피플 ('큐러닝')</strong>은(는) 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.<br>
                            개인정보 취급 직원의 최소화 및 교육<br>
                            개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.<br>
                            개인정보의 암호화<br>
                            이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.<br>
                            개인정보에 대한 접근 제한<br>
                            개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.<br>
                            접속기록의 보관 및 위변조 방지<br>
                            개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.
                            <strong class='title'>제6조 개인정보 보호책임자 작성</strong>
                            (주)큐피플('큐러닝') 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.<br><br>
                            ▶ 개인정보 보호책임자<br>
                            성명 : 최삼열<br>
                            직급 : 부장<br>
                            연락처 : 02-888-7805(내선 208), sy.choi@qpeople.co.kr, F: 02-888-7908<br>
                            ※ 개인정보 보호 담당부서로 연결됩니다.<br><br>
                            정보주체께서는 (주)큐피플('큐러닝') 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. (주)큐피플('큐러닝') 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
                            <strong class='title'>제7조 개인정보 처리방침 변경</strong>
                            이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
                        </div>
                        <div class='signup_checkbox_area clear_fix'>
                            <input type='checkbox' name='chk2' id='chk2'>
                            <p>개인정보취급방침에 동의합니다.</p>
                        </div>
                    </div>
                </div>
                <div class='signup_btn_box clear_fix'>
                    <button class='last' href="#" onclick="javascript:lfn_btn('next');">다음</button>
                </div>
            </div>

        </div>
        <!-- CONTENTS END -->

        <!-- FOOTER -->
        <%@ include file="../common/mainBottomQch.jsp" %>
        <!-- FOOTER END -->
    </div>
    <!-- Local -->
    <script src='/resources/homepageQch/js/main.js'></script>
</frameset>
</body>

</html>