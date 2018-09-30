<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
    <title>LG유플러스 전자결제 결제취소</title>
</head>
<body>
    <form method="post" id="LGD_PAYINFO" action="/paymentGateway/cancel.do">
    <input type="hidden" name="approvalId" value="<%=request.getParameter("approvalId")%>"/>
    <div>
        <table>	
            <tr>
                <td>상점아이디</td>
                <td><input type="text" name="CST_MID" value="<%=request.getAttribute("g_CST_MID")%>"/></td>
            </tr>
            <tr>
                <td>서비스,테스트 </td>
                <td><input type="text" name="CST_PLATFORM" value="<%=request.getAttribute("g_CST_PLATFORM")%>"/></td>
            </tr>
            <tr>
                <td>LG유플러스 거래번호 </td>
                <td><input type="text" name="LGD_TID" value="<%=request.getParameter("payApprovalId")%>"/></td>
            </tr>
 
            <tr>
                <td>
                <input type="submit" value="결제 취소"/><br/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
