<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");

String LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");

HashMap payReqMap = (HashMap)session.getAttribute("PAYREQ_MAP");//���� ��û��, Session�� �����ߴ� �Ķ���� MAP 
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<head>
	<script type="text/javascript">

		function setLGDResult() {
			parent.payment_return();
			try {
			} catch (e) {
				alert(e.message);
			}
		}
		
	</script>
</head>
<body onload="setLGDResult()">
<p><h1>RETURN_URL (�������)</h1></p>
<div>
<p>LGD_RESPCODE (����ڵ�) : <%= LGD_RESPCODE %></p>
<p>LGD_RESPMSG (����޽���): <%= LGD_RESPMSG %></p>

<% 
String LGD_AUTHONLYKEY	= "";
String LGD_PAYTYPE 	= request.getParameter("LGD_PAYTYPE");

if("0000".equals(LGD_RESPCODE)){
	LGD_AUTHONLYKEY = request.getParameter("LGD_AUTHONLYKEY");
	payReqMap.put("LGD_RESPCODE"	, LGD_RESPCODE);
	payReqMap.put("LGD_RESPMSG"		, LGD_RESPMSG);
	payReqMap.put("LGD_AUTHONLYKEY"	, LGD_AUTHONLYKEY);
	payReqMap.put("LGD_PAYTYPE"		, LGD_PAYTYPE);

%><form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO"><%		
	for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' id='" + key + "' value='" + payReqMap.get(key) + "'>" );
	}
%></form><%
}
else{
	out.println("LGD_RESPCODE:" + LGD_RESPCODE + " ,LGD_RESPMSG:" + LGD_RESPMSG); //���� ���п� ���� ó�� ���� �߰�
}

%>

</div>
</body>
</html>