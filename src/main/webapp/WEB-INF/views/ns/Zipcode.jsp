<%@ page contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
<title>
</title>

<%@ include file="../common/commInclude.jsp" %>


</head>

<script type="text/javascript">

$(document).ready(function() {
		$("#findString").focus();
	} 
);

function lfn_btn(pKind, pParam) {
	if ( pKind == "search" ) {
		if ( $("#findString").val() == "" ) {
			alert("주소를 입력하셔야 합니다.");
			$("#findString").focus();
			
			return false;
		}

		f_submitSelf("/ns/getZipcode");
	}
}

function f_sel(pHomeZip1, pHomeZip2, pHomeAddr1,pSeq) {
	opener.$("#homeZip1").val(pHomeZip1);
	opener.$("#homeZip2").val(pHomeZip2);
	opener.$("#homeAddr1").val(pHomeAddr1);
	opener.$("#homeZipcodeSeq").val(pSeq);
	self.close();
}

</script>

<body>


<form id="frm" name="frm" method="post">
<div id="popWrap">	
	<h2>우편번호 검색</h2>
	<div id="popCont">
		<div id="jibun">
		<h4>찾고자 하는 지역의 읍/면/동을 입력하시고 ‘찾기’ 버튼을 클릭하세요. (ex. 삼성동,개포동)</h4>
		<div class="box ac" style="margin-bottom:18px">
			<form name="jibunForm" id="form" method="post" onSubmit="return false">
			<input type="text" id=findString name="findString" value="${set.condiVO.findString}" style="width:300px" title="검색어 입력">
			<input type="image" src="<c:url value="/resources/images/btn/btn_s_search.gif"/>" alt="찾기" class="bn img" onclick="javascript:lfn_btn('search'); return false;">
			</form>
		</div>
		<h4>우편번호를 클릭하세요.</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="list">
			<thead>
			<tr>
				<th width="90">우편번호</th>
				<th width="*">주소</th>
			</tr>
			</thead>
		</table>
		<div class="scr" style="width:401px;height:300px;padding:0 0 17px 0;overflow:auto;">			
			<table border="0" cellpadding="0" cellspacing="0" class="list" style="width:384px">
			    <colgroup>
		         <col align='center' width="90" />
		         <col align='center' width="*"/>
		        </colgroup>
				<tbody>
					<c:forEach var="row" items="${set.zipcode}">
						<tr>
							<td><a href="#" onclick="f_sel('${row.homeZip1}','${row.homeZip2}','${row.homeAddr1}','${row.seq}'); return false;">${row.homeZip}</a></td>
							<td class="cont" style=".padding-right:17px">${row.homeAddr}</td>							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div id="popFooter">
		<a href="javascript:self.close()"><img src="<c:url value="/resources/images/btn/btn_close.gif"/>" alt="close"></a>	
	</div>
</div>

</form>
	
</body>
</html>



</div>
</div>
	