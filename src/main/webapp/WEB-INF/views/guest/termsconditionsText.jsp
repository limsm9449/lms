<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>QLearning - main</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style>
  body { padding:5px; margin:0; font-size: 12px; color: #666; }
  p { margin: 0; padding: 0; }
  ol,ul { padding: 0; margin:0; }
  ol.sublist { list-style: outside decimal; padding-left: 3px; margin-left: 20px;}
  ol.sublist li {margin-bottom: 5px; }
  ol.subsublist { list-style: none; padding-left: 3px; margin-left: 20px;}
  ol.subsublist li { margin-bottom: 2px; }
  ul.unlist { list-style: outside disc; padding-left: 3px; margin-left: 20px;}
  ul.unlist li { margin-bottom: 2px; }
  .top_list { margin: 0 3px 10px; }
  .lh6 { font-size: 13px; margin: 30px 0 10px; line-height: 1.6; font-weight: bold; }
  .lh6:first-child { margin: 10px 0 10px; }
  .ls1 { font-size: 12px; margin: 3px 0 10px 5px; font-weight: normal; color: #333; }
  .ls2 { font-size: 12px; margin: 3px 0 0 5px; font-weight: normal; }
  em.emphasis { font-style: normal; font-weight: bold; color: #0180d3; line-height: 1.8; }
</style>
</head>
<body>
  <ol class="top_list">
    <li class="lh6">제 1 조 (목적)
      <p class="ls1">이 약관은 <em class="emphasis">㈜큐피플(이하 '회사')</em>에서 제공하는 이러닝서비스 <em class="emphasis">www.qlearning.co.kr(이하 '큐러닝'이라 함)</em>의 이용에 관한 조건 및 절차와 기타 필요한 사항을 규정하는 것을 목적으로 합니다.</p>
    </li>
    <li class="lh6">제 2 조 (용어 정의)
      <p class="ls1">이 약관에서 사용하는 용어의 의미는 다음과 같습니다.</p>
      <ol class="sublist ls2">
        <li><em class="emphasis">'회원'</em>이라 함은 서비스를 제공받기 위해서 회사가 인정하는 절차의 가입을 통하여 이용자번호(ID)를 부여 받은 자를 말합니다.</li>
        <li><em class="emphasis">'이용자번호(ID)'</em>라 함은 가입회원의 식별과 회원의 서비스 이용을 위해 고객이 선정하고 회사가 부여하는 영어문자와 숫자의 조합을 말합니다.</li>
        <li><em class="emphasis">'비밀번호'</em>라 함은 회원이 부여 받은 이용자번호(ID)와 일치되는 회원임을 확인하고 회원의 권익보호를 위하여 회원이 선정한 문자와 숫자의 조합을 말합니다.</li>
      </ol>
      <p class="ls1">제 1 항에서 정의하는 것을 제외한 용어는 관계법령 및 서비스 이용안내에서 정하는 바에 따릅니다.</p>
    </li>
    <li class="lh6">제 3 조 (약관의 공지)
      <p class="ls2">이 약관의 내용은 큐러닝 내용 중 <em class="emphasis">"회원 이용 약관"</em> 란을 통하여 게시하며 약관이 변경 또는 일부 수정될 경우 회사는 지체 없이 <em class="emphasis">"공지사항"</em>을 통해 공지합니다.</p>
    </li>
    <li class="lh6">제 4 조 (약관외 준칙)
      <p class="ls2">이 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법 및 기타 관련법령의 규정에 의합니다.</p>
    </li>
    <li class="lh6">제 5 조 (큐러닝의 이용)
      <ol class="sublist ls2">
        <li>이용계약은 본 약관에 동의한 고객이 회사가 정하는 방법으로 신청 회사의 이용 승낙에 의하여 성립합니다.</li>
        <li>제 1항의 규정에 의해 고객이 이용 신청을 할 때에는 회사가 이용자 관리시 필요로 하는 사항을 반드시 입력해야 합니다.</li>
        <li>회사는 이용자가 허위 정보를 입력하거나 서비스 운용상 필요한 경우에 이용 승인을 유보 또는 이용을 거절할 수 있습니다.</li>
        <li>회원정보는 언제든지 수정이 가능하지만, 이름과 아이디는 변경이 불가능하므로 작성시 주의해야 합니다.</li>
      </ol>
    </li>
    <li class="lh6">제 6 조 (약관의 동의)
      <p class="ls2">회원이 등록절차를 거처 동의 버튼을 누름으로써 본 약관에 동의한 것으로 간주합니다.</p>
    </li>
    <li class="lh6">제 7 조 (큐러닝의 이용)
      <ol class="sublist ls2">
        <li>회원은 가입 신청시 회원이 지정한 이용자번호(ID)와 비밀번호를 통해 서비스에 로그인하여 큐러닝을 이용합니다.</li>
        <li>큐러닝의 이용은 연중무휴, 1일 24시간을 원칙으로 합니다. 단, 회사가 업무 또는 기술상의 사유로 서비스가 일시 중지되거나, 운영상 목적으로 일시 중지될 수 있습니다.</li>
      </ol>
    </li>
    <li class="lh6">제 8 조 (회사의 의무)
      <p class="ls2">회사는 법령 및 본 약관에서 금하는 행위를 하지 않으며 서비스 제공과 관련해 알고 있는 회원의 개인정보를 본인의 승낙 없이 제3자에게 누설하거나 배포하지 않습니다.<br />단, 법률에 의한 국가기관의 요구나 수사상의 목적, 개인을 식별할 수 없는 인구통계학적 자료로는 제공될 수 있습니다.<br />회사는 회원이 제기하는 의견이나 불만이 정당하다고 인정되면 즉시 처리합니다. 다만, 즉시 처리가 곤란할 경우에는 회원에게 그 사유와 일정을 통보하여야 합니다.<br />회사는 지속적이고 안정적인 서비스를 제공하기 위하여 설비에 장애가 있거나 망실된 때에는 이를 지체 없이 수리 또는 복구합니다. 다만, 천재지변이나 비상사태, 기타 부득이한 경우에는 그 서비스를 일시 중단하거나 중지할 수 있습니다.<br />이때, 회사는 지체 없이 회원에게 통보하여야 합니다.</p>
    </li>
    <li class="lh6">제 9 조 (회원의 의무)
      <ol class="sublist ls2">
      <li>회사는 이용자가 다음 사항에 해당하는 행위를 하였을 경우 별도의 사전 통보 없이 큐러닝의 이용 계약을 해지할 수 있습니다.</li>
      <ol class="subsublist ls2">
        <li>가. 다른 회원의 이용자번호(ID)를 부정하게 사용하는 행위</li>
        <li>나. 서비스를 이용하여 얻은 정보를 회사의 사전 승낙 없이 회원의 이용 이외의 목적으로 복제하거나 이를 출판, 방송, 온라인 상의 공개 등에 사용하거나 제3자에게 제공하는 행위</li>
        <li>다. 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상하는 행위</li>
        <li>라. 공공질서 및 미풍양속에 위배되는 내용의 정보, 문장, 도형 등을 타인에게 유포하는 행위</li>
        <li>마. 반국가적, 반사회적, 범죄적 행위와 결부된다고 판단되는 행위</li>
        <li>바. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 행위</li>
        <li>사. 기타 관계 법령에 위배되는 행위</li>
      </ol>
      <li>회원은 이 약관에서 규정하는 사항과 서비스 이용안내 또는 주의사항 그리고 관계 법령을 준수하여야 합니다.</li>
      <li>회원이 설치하는 단말기 등은 전기통신설비의 기술기준에 관한 규칙이 정하는 기준에 적합하여야 하며, 서비스에 장애를 주지 않아야 합니다.</li>
      <li>이용자번호(ID)와 비밀번호의 관리책임은 회원 본인에게 있으며 이용자번호(ID)와 비밀번호의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다. 비밀번호가 타인에게 노출 된 경우 즉시 변경하여야 하며 본인의 이용자번호(ID)가 부정하게 사용된 경우 회원은 반드시 회사에 그 사실을 통보하여야 합니다.</li>
      </ol>
    </li>
    <li class="lh6">제 10 조 (이용요금의 종류)
      <p class="ls2">회사가 제공하는 서비스는 무료 또는 유료로 구분하여 제공될 수 있습니다.</p>
    </li>
    <li class="lh6">제 11 조 (정보의 제공)
      <p class="ls1">회사는 회원이 서비스 이용에 필요하다고 인정되는 다양한 정보를 전자우편이나 일반우편 등의 방법으로 회원에게 제공할 수 있으며 회원은 수신거부 이메일을 회사에 보내거나 회원정보에서 메일수신 여부를 수정 함으로써 정보수신 거부를 할 수 있습니다.</p>
      <ol class="sublist ls2">
        <li>개인 유료서비스 이용시 결제정보. <br />
          유료교육서비스를 이용하실 경우 결제정보를 회사에 온라인으로 기입하여 신청을 하여야 합니다.<br />
          이 때 신용카드번호 및 비밀번호 등 개인결제수단의 주요정보는 회사가 보관하지 않으며, 회원은 결제상 문제발생시 결제취소를 요청할 수 있고 회사는 회원이 학습을 시작하지 않았음을 확인한 경우에 한하여 이를 처리할 책임이 있습니다.
        </li>
        <li>회원 불만사항 및 의견수렴. <br />
          회사는 회원의 불만사항 및 의견을 수렴할 수 있도록 홈페이지 내에 고객지원을 위한 메뉴를 제공합니다.
        </li>
      </ol>
    </li>
    <li class="lh6">제 12 조 (저작권)
      <p class="ls1">큐러닝에 게재된 자료에 대한 권리는 다음 각 호와 같습니다.</p>
      <ol class="sublist ls2">
        <li>게시물에 대한 권리와 책임은 게시자에게 있으며, 회사는 게시자의 동의 없이 이를 영리적 목적으로 사용할 수 없습니다. 단, 비영리적 목적인 경우 회사는 게시자의 동의 없이도 이를 사용할 수 있으며 서비스내의 게재권을 갖습니다.</li>
        <li>게시자의 사전 동의 없이는 이용자는 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적 목적으로 이용할 수 없습니다.</li>
      </ol>
    </li>
    <li class="lh6">제 13 조 (게시물 삭제)
      <p class="ls1">회사는 회원이 게시하거나 제공하는 서비스 내용이 다음 각 호에 해당한다고 판단될 경우 사전 통지 없이 삭제할 수 있습니다.</p>
      <ol class="sublist ls2">
        <li>다른 회원 또는 제3자를 비방하거나 명예를 손상시키는 내용인 경우</li>
        <li>허위 사실의 유포</li>
        <li>공공질서 및 미풍양속에 위반되는 내용인 경우</li>
        <li>지적재산권 등 기타 타인의 권리를 침해하는 내용인 경우</li>
        <li>회사의 서비스 내용과 합치하지 않는 경우</li>
        <li>기타 관계법령에 위반된다고 판단되는 경우</li>
      </ol>
    </li>
    <li class="lh6">제 14 조 (개인정보보호정책)
      <p class="ls2">회사는 회원이 가입시 기재한 개인정보 및 서비스를 제공하면서 획득한 금융거래정보 등의 내용을 보호하기 위해 노력합니다. 회원의 개인정보보호에 관하여는 회사의 '개인정보보호정책' 및 관련법령이 정한 바에 의합니다.</p>
    </li>
    <li class="lh6">제 15 조 (이의신청 및 손해배상청구금지)
      <p class="ls2">회사는 회원의 부주의로 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다. 또한 회원은 회사에서 제공하는 서비스 이용시 발생되는 어떠한 문제에 대해서도 무료서비스에 대해서는 회사 및 관계 기관에 손해배상 청구를 할 수 없으며 회사는 이에 대해 책임을 지지 아니합니다.</p>
    </li>
    <li class="lh6">제 16 조 (취소 및 환불정책)
      <p class="ls2">구입하신 강좌에 대해 회원님의 개인적 사정 또는 변심에 의한 환불은 7일 이내에만 가능합니다. 기타 자세한 사항은 안내문의(02-888-7805)를 이용하시기 바랍니다.</p>
    </li>
    <li class="lh6">부칙
      <ol class="sublist ls2">
        <li>(시행일) <br />
        이 약관은 2014년 9월 1일부터 시행합니다.</li>
      </ol>
    </li>
  </ol>
</body>
</html>