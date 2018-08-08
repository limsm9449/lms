<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>QLearning - main</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style>
  body { padding:5px; margin:0; font-size: 12px; color: #666;}
  p { margin: 0; padding: 0; }
  ol,ul { padding: 0; margin:0; }
  ol.sublist { list-style: outside decimal; padding-left: 3px; margin-left: 20px;}
  ol.sublist li {margin-bottom: 5px; }
  ol.subsublist { list-style: none; padding-left: 3px; margin-left: 20px;}
  ol.subsublist li { margin-bottom: 2px; }
  ul.unlist { list-style: outside disc; padding-left: 3px; margin-left: 20px;}
  ul.unlist li { margin-bottom: 2px; }
  .top_list { margin:30px 3px 10px; }
  .lh6 { font-size: 13px; margin: 30px 0 10px; line-height: 1.6; font-weight: bold; }
  .lh6:first-child { margin: 10px 0 10px; }
  .ls1 { font-size: 12px; margin: 3px 0 10px 5px; font-weight: normal; color: #333; }
  .ls2 { font-size: 12px; margin: 3px 0 0 5px; font-weight: normal; }
  em.emphasis { font-style: normal; font-weight: bold; color: #0180d3; line-height: 1.8; }
  .notice { margin-bottom: 10px; padding: 10px 15px; -moz-border-radius:4px; -webkit-border-radius:4px; border-radius:4px;  	border:1px solid #e5e5e5;  }
</style>
</head>
<body>
  <div class="notice">
    <em class="emphasis">(주)큐피플 ('www.qlearning.co.kr'이하  '큐러닝')</em>은(는) 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.<br />
    <em class="emphasis">(주)큐피플 ('큐러닝')</em> 은(는) 회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.<br />
    ○ 본 방침은부터 <em class="emphasis">2014</em>년 <em class="emphasis">9</em>월 <em class="emphasis">1</em>일부터 시행됩니다.
  </div>
  <ol class="top_list">
    <li class="lh6">제1조 개인정보의 처리 목적
      <p class="ls1"><em class="emphasis">(주)큐피플 ('큐러닝')</em>은(는) 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.</p>
      <ol class="sublist ls2">
        <li>홈페이지 회원가입 및 관리<br />
        회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만14세 미만 아동 개인정보 수집 시 법정대리인 동의 여부 확인, 각종 고지·통지, 고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.</li>
        <li>재화 또는 서비스 제공<br />
        물품배송, 콘텐츠 제공, 본인인증, 요금결제·정산 등을 목적으로 개인정보를 처리합니다.</li>
        <li>마케팅 및 광고에의 활용<br />
        신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공 , 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.</li>
        <li>개인영상정보<br />
        범죄의 예방 및 수사 등을 목적으로 개인정보를 처리합니다.</li>
      </ol>
    </li>
    <li class="lh6">제2조 개인정보처리 위탁
      <ol class="sublist ls2">
        <li><em class="emphasis">(주)큐피플 ('큐러닝')</em>은(는) 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</li>
        <li><em class="emphasis">(주)큐피플 ('큐러닝')</em>은(는) 위탁계약 체결시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적·관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리·감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</li>
        <li>위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.</li>
      </ol>
    </li>
    <li class="lh6">제3조 정보주체의 권리,의무 및 그 행사방법
      <p class="ls1">이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.</p>
      <ol class="sublist ls2">
        <li>정보주체는 (주)큐피플 ('큐러닝')에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.<br />
          <ol class="subsublist ls2">
            <li>가. 개인정보 열람요구</li>
            <li>나. 오류 등이 있을 경우 정정 요구</li>
            <li>다. 삭제요구</li>
            <li>라. 처리정지 요구</li>
          </ol>
        </li>
        <li>제1항에 따른 권리 행사는 (주)큐피플 ('큐러닝')에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 (주)큐피플 ('큐러닝')은(는) 이에 대해 지체 없이 조치하겠습니다.</li>
        <li>정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 (주)큐피플 ('큐러닝')은(는) 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
        <li>제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
      </ol>
    </li>
    <li class="lh6">제4조 개인정보의 파기
      <p class="ls1"><em class="emphasis">(주)큐피플 ('큐러닝')</em>은(는) 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.</p>
      <ul class="unlist ls2">
        <li>파기절차<br />
          이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.
        </li>
        <li>파기기한<br />
          이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
        </li>
        <li>파기방법<br />전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</li>
      </ul>
    </li>
    <li class="lh6">제5조 개인정보의 안전성 확보 조치
      <p class="ls1"><em class="emphasis">(주)큐피플 ('큐러닝')</em>은(는) 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.</p>
      <ol class="sublist ls2">
        <li>개인정보 취급 직원의 최소화 및 교육<br />
          개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
        </li>
        <li>개인정보의 암호화<br />
          이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
        </li>
        <li>개인정보에 대한 접근 제한<br />
          개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
        </li>
        <li>접속기록의 보관 및 위변조 방지<br /> 
          개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.
        </li>
      </ol>
    </li>
    <li class="lh6">제6조 개인정보 보호책임자 작성
      <ol class="sublist ls2">
        <li>(주)큐피플('큐러닝') 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
           <br /><br />▶ 개인정보 보호책임자 <br/>성명 :조중열<br/>직급 :차장<br/>연락처 :02-888-7805(내선 301), guycat@qpeople.co.kr, 02-888-7908<br/>※ 개인정보 보호 담당부서로 연결됩니다.<br /><br />
        </li>
        <li>정보주체께서는 (주)큐피플('큐러닝') 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. (주)큐피플('큐러닝') 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.</p>
      </ol>
    </li>
    <li class="lh6">제7조 개인정보 처리방침 변경
      <p class="ls2">이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.</p>
    </li>
  </ol>
</body>
</html>
