<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>LG유플러스 본인인증 통합창</title>
<script type="text/javascript">
</script>
</head>
<body>
<form method="post" name ="LGD_PAYINFO" id="LGD_PAYINFO" action="/guest/authOnlyReq">
	<div>
		<table>	
            <tr>
                <td>상점아이디(t를 제외한 아이디) </td>
                <td><input type="text" name="CST_MID" id="CST_MID" value="lgdacomxpay"/></td>
            </tr>
            <tr>
                <td>서비스,테스트 </td>
                <td><input type="text" name="CST_PLATFORM" id="CST_PLATFORM" value="test"/></td>
            </tr>
            <tr>
                <td>
					생년월일 <br/>
					또는 사업자번호
				</td>
                <td><input type="text" name="LGD_BUYERSSN" value="${set.condiVO.birthDay}"/> &nbsp;&nbsp; *휴대폰 대체 인증시 000000 으로 넘길것</td>
            </tr>
            <tr>
                <td>성명</td>
                <td><input type="text" name="LGD_BUYER" value="${set.condiVO.userName}"/></td>
            </tr>
            <tr>
                <td>이용가능 인증수단</td>
                <td>
					<select id="LGD_CUSTOM_USABLEPAY" name="LGD_CUSTOM_USABLEPAY">
						<option value="ASC001" selected="selected">신용카드인증</option>		
						<option value="ASC004" >계좌인증</option>		
						<option value="ASC007" >휴대폰대체인증</option>	
					</select>
                </td>
            </tr>
            <tr>
                <td>타임스탬프</td>
                <td><input type="text" name="LGD_TIMESTAMP" value="20150826151511"/></td>
            </tr>
            <tr>
                <td>신용평가사 고유 코드</td>
                <td><input type="text" name="LGD_MOBILE_SUBAUTH_SITECD" value="123456789abc"/></td>
            </tr>
            <tr>
                <td>계좌이체 실명확인여부</td>
                <td>
					<select name="LGD_NAMECHECKYN">
						<option value="N">실명확인안함</option>
						<option value="Y">실명확인함</option>
					</select>
				</td>
            </tr>
            <tr>
                <td>휴대폰본인확인SMS발송여부</td>
                <td>
					<select name="LGD_HOLDCHECKYN">
						<option value="Y">SMS발송함</option>
						<option value="N">SMS발송안함</option>
					</select>
				</td>
            </tr>
            <tr>
                <td>인증창 호출 방식 </td>
                <td>
                	<select name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE">
						<option value="iframe">iframe</option>
					</select>
				</td>
            </tr>													
            <tr>
				<!--요청인증타입 (자동채움) -->
                <td><input type="hidden" name="LGD_PAYTYPE" id="LGD_PAYTYPE"/></td>
            </tr>
            <tr>
				<!-- LG유플러스으로부터 부여받은 인증키 (자동채움) -->
                <td><input type="hidden" name="LGD_AUTHONLYKEY" id="LGD_AUTHONLYKEY"/></td>
            </tr>			             
             <tr>
                <td>
                <input type="submit" value="확인" /><br/>
                </td>
            </tr>
        </table>
	</div>
</form>
</body>
</html>