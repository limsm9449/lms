<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>
</title>

<%@ include file="../common/commUserInclude.jsp" %>


</head>

<script type="text/javascript">

$(function() { 
    $(".tab_content").hide(); 
    $(".tab_content:first").show(); 
    
    $("ul.tabs li").click(function() { 
      $("ul.tabs li").removeClass("active");
      $(this).addClass("active");
      $(".tab_content").hide(); 
      var activeTab = $(this).attr("rel"); 
      $("#"+activeTab).fadeIn() 
    }); 
});

function form_chk() {
  	if ($("#tab1").css('display')!='block') return;
  
  	var f = document.frm;
  
  	if (f.userName.value=="") {
    	alert("이름을 입력해 주세요.");
    	f.userName.focus();
    	return;
  	}
  	
  	var rdo = f.user_gender;
  	var chk_v = "";
  	for (var i=0; i<rdo.length; i++) {
    	if (rdo[i].checked==true) {
      		chk_v = rdo[i].value;
    	}
  	}
  	if (chk_v=="") {
	    alert("성별을 선택해 주세요.");
    	return;
  	} else {
  		$("#sex").val(chk_v);
  	}
  
  	if (f.user_year.value=="") {
    	alert("생년을 선택해 주세요.");
    	f.user_year.focus();
    	return;
  	} else if (f.user_month.value=="") {
    	alert("생월을 선택해 주세요.");
    	f.user_month.focus();
    	return;
  	} else if (f.user_day.value=="") {
    	alert("생일을 선택해 주세요.");
    	f.user_day.focus();
    	return;
  	} else {
  		$("#birthDay").val(f.user_year.value + "-" + f.user_month.value + "-" + f.user_day.value);
  	}
  
	$.ajax({
		type :"POST",
		url : context + "/guest/joinCheck.do",
		dataType :"json",
		data : $("#frm").serialize(),
		success : function(json){
			if ( json.rtnMode == "EXIST") {
				alert("이미 가입하셨습니다.");
				page.goPage('/ns/searchUserIdV');
			} else if ( json.rtnMode == "NOT_EXIST") {
				document.frm.action = context + "/guest/join3.do";
				document.frm.target = "_self";
				document.frm.method = "POST";	
				document.frm.submit();
			}
		},
		error : function(e) {
			alert("<spring:message code="lms.msg.systemError" text="-" />");
		}
	})
}
</script>

<body>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="compCd" name="compCd" value="<c:out value="${set.condiVO.compCd}"/>">
	<input type="hidden" id="sex" name="sex">
	<input type="hidden" id="birthDay" name="birthDay">

<!-- skipnav -->
<div id="skipnav"><a href="#side" class="skip">좌측메뉴 바로가기</a></div>
<div id="skipnav"><a href="#contents" class="skip">컨텐츠 바로가기</a></div>
<!-- skipnav -->
<!-- wrap -->
<div id="wrap" class="site">
  <%@ include file="../home/userTop.jsp" %>
  <hr />
  <!-- container -->
  <div id="container" class="site">
    	<!-- side -->
		<div id="side" class="site">
			<h2 class="s_mid">회원<span class="blue">가입</span></h2>
			<ul class="snb">
				<li><a href="javascript:" onclick="page.goPage('/guest/join');" class="here">회원가입</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/termsconditions');">서비스이용약관</a></li>
				<li><a href="javascript:" onclick="page.goPage('/guest/privacy');">개인정보 취급방침</a></li>
			</ul>
		</div>
		<!-- end side -->
		
    	<!-- contents -->
		<div id="contents" class="site">
			<!-- location -->
			<div id="location"><a href="/" class="home">HOME</a><span>&gt;</span>회원가입<span>&gt;</span>가입여부확인</div>
			<!-- title -->
			<h3 class="tit_big">회원가입</h3>
		      <div class="artcle">
		        <div class="joinflow_box">
		          <img src="/resources/images/sub/img_joinflow_2.png" alt="가입순서 2단계 가입여부확인" />
		          <p class="big_2"><span class="blue">가입여부확인</span></p>
		          <p>주민등록번호 입력 없이 휴대폰 인증으로 회원가입이 가능합니다.</p>
		        </div>
		        <div class="chk_register_box">
		          <ul class="tabs">
		            <li class="active" rel="tab1"><span>생년월일</span></li>
		            <li rel="tab2"><span>아이핀(i-pin)으로 찾기</span></li>
		          </ul>
		          <div class="tab_contents">
		            <!-- tab1 -->
		            <div id="tab1" class="tab_content">
		              <fieldset>
		                <legend>생년월일으로 가입확인 </legend>
		                <dl>
		                  <dt><label for="user_name">이름(한글/영문)</label></dt>
		                  <dd><input type="text" id="userName" name="userName" style="width: 180px;" /></dd>
		                  <dt>성별</dt>
		                  <dd>
		                    <input type="radio" id="g_male" name="user_gender" value="M" /> <label for="g_male">남</label>
		                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                    <input type="radio" id="g_female" name="user_gender" value="F" /> <label for="g_female">여</label>
		                  </dd>
		                  <dt><label for="user_year">생년월일</label></dt>
		                  <dd class="noleft">
		                    <select id="user_year" name="user_year">
		                      <option value="">선택</option>
		                      <option value="1930">1930</option>
		                      <option value="1931">1931</option>
		                      <option value="1932">1932</option>
		                      <option value="1933">1933</option>
		                      <option value="1934">1934</option>
		                      <option value="1935">1935</option>
		                      <option value="1936">1936</option>
		                      <option value="1937">1937</option>
		                      <option value="1938">1938</option>
		                      <option value="1939">1939</option>
		                      <option value="1940">1940</option>
		                      <option value="1941">1941</option>
		                      <option value="1942">1942</option>
		                      <option value="1943">1943</option>
		                      <option value="1944">1944</option>
		                      <option value="1945">1945</option>
		                      <option value="1946">1946</option>
		                      <option value="1947">1947</option>
		                      <option value="1948">1948</option>
		                      <option value="1949">1949</option>
		                      <option value="1950">1950</option>
		                      <option value="1951">1951</option>
		                      <option value="1952">1952</option>
		                      <option value="1953">1953</option>
		                      <option value="1954">1954</option>
		                      <option value="1955">1955</option>
		                      <option value="1956">1956</option>
		                      <option value="1957">1957</option>
		                      <option value="1958">1958</option>
		                      <option value="1959">1959</option>
		                      <option value="1960">1960</option>
		                      <option value="1961">1961</option>
		                      <option value="1962">1962</option>
		                      <option value="1963">1963</option>
		                      <option value="1964">1964</option>
		                      <option value="1965">1965</option>
		                      <option value="1966">1966</option>
		                      <option value="1967">1967</option>
		                      <option value="1968">1968</option>
		                      <option value="1969">1969</option>
		                      <option value="1970">1970</option>
		                      <option value="1971">1971</option>
		                      <option value="1972">1972</option>
		                      <option value="1973">1973</option>
		                      <option value="1974">1974</option>
		                      <option value="1975">1975</option>
		                      <option value="1976">1976</option>
		                      <option value="1977">1977</option>
		                      <option value="1978">1978</option>
		                      <option value="1979">1979</option>
		                      <option value="1980">1980</option>
		                      <option value="1981">1981</option>
		                      <option value="1982">1982</option>
		                      <option value="1983">1983</option>
		                      <option value="1984">1984</option>
		                      <option value="1985">1985</option>
		                      <option value="1986">1986</option>
		                      <option value="1987">1987</option>
		                      <option value="1988">1988</option>
		                      <option value="1989">1989</option>
		                      <option value="1990">1990</option>
		                      <option value="1991">1991</option>
		                      <option value="1992">1992</option>
		                      <option value="1993">1993</option>
		                      <option value="1994">1994</option>
		                      <option value="1995">1995</option>
		                      <option value="1996">1996</option>
		                      <option value="1997">1997</option>
		                      <option value="1998">1998</option>
		                      <option value="1999">1999</option>
		                      <option value="2000">2000</option>
		                      <option value="2001">2001</option>
		                      <option value="2002">2002</option>
		                      <option value="2003">2003</option>
		                    </select> 년
		                    &nbsp;&nbsp;
		                    <select id="user_month" name="user_month">
		                      <option value="">선택</option>
		                      <option value="01">1</option>
		                      <option value="02">2</option>
		                      <option value="03">3</option>
		                      <option value="04">4</option>
		                      <option value="05">5</option>
		                      <option value="06">6</option>
		                      <option value="07">7</option>
		                      <option value="08">8</option>
		                      <option value="09">9</option>
		                      <option value="10">10</option>
		                      <option value="11">11</option>
		                      <option value="12">12</option>
		                    </select> 월
		                    &nbsp;&nbsp;
		                    <select id="user_day" name="user_day">
		                      <option value="">선택</option>
		                      <option value="01">1</option>
		                      <option value="02">2</option>
		                      <option value="03">3</option>
		                      <option value="04">4</option>
		                      <option value="05">5</option>
		                      <option value="06">6</option>
		                      <option value="07">7</option>
		                      <option value="08">8</option>
		                      <option value="09">9</option>
		                      <option value="10">10</option>
		                      <option value="11">11</option>
		                      <option value="12">12</option>
		                      <option value="13">13</option>
		                      <option value="14">14</option>
		                      <option value="15">15</option>
		                      <option value="16">16</option>
		                      <option value="17">17</option>
		                      <option value="18">18</option>
		                      <option value="19">19</option>
		                      <option value="20">20</option>
		                      <option value="21">21</option>
		                      <option value="22">22</option>
		                      <option value="23">23</option>
		                      <option value="24">24</option>
		                      <option value="25">25</option>
		                      <option value="26">26</option>
		                      <option value="27">27</option>
		                      <option value="28">28</option>
		                      <option value="29">29</option>
		                      <option value="30">30</option>
		                      <option value="31">31</option>
		                    </select> 일
		                  </dd>
		                </dl>
		              </fieldset>
		            </div>
		            <!-- end tab1 -->
		            <!-- tab2 -->
		            <div id="tab2" class="tab_content">
		              <p class="center">아이핀 인증을 통한 가입을 원하시면 아이핀 인증 버튼을 눌러 아이핀 인증 절차를 진행하여 주십시오.</p>
		              <div class="center_btn">
		                <a href="#"><img src="/resources/images/sub/btn_ipin.png" /></a>
		              </div>
		            </div>
		            <!-- end tab2 -->
		          </div>
		        </div>
		        <hr class="line" />
		        <div class="div_description">
		          <p>주민등록 번호 입력 없이 휴대폰 인증으로 회원가입이 가능합니다.</p>
		          <p class="strong">이름, 생년월일, 성별은 가입 후에 변경이 불가능합니다. 추후 본인확인을 위해 정확하게 가입 부탁드립니다.</p>
		          <p>회원가입 후 고용보험과정을 수강 신청 시 노동부에 고용보험신고를 위해 주민등록 번호를 수집하고 있습니다.</p>
		          <p>가급적 신분증과 동일한 정보를 입력하시면 향후 고용보험 과정 수강 시 본인 확인이 용의합니다.</p>
		        </div>
		        <div class="center_btn">
		          <a href="#" onclick="javascript:form_chk();"><img src="/resources/images/sub/btn_ok.png" /></a>&nbsp;<a href="main.html"><img src="/resources/images/sub/btn_censel.png" /></a>
		        </div>
		      </div>
			
		</div>
		<!-- end content -->
		
	</div>
  <!-- end container -->
  
  <!-- footer_wrap -->
	<%@ include file="../home/bottom.jsp" %>
  <!-- end footer_wrap -->
</div>

</form>
	
</body>
</html>


