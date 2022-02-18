<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/storyCms/common/jsp/taglib.jsp" %>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%
request.setCharacterEncoding("UTF-8"); //한글깨지면 주석제거

//juso.go.kr 설정파일  
String JUSO_PROPERTIES_PATH = "";

// 도로명주소 검색API KEY
String jusoPopupKey = "";

String inputYn = request.getParameter("inputYn"); 
String roadFullAddr = request.getParameter("roadFullAddr"); 
String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
String engAddr = request.getParameter("engAddr"); 
String jibunAddr = request.getParameter("jibunAddr"); 
String zipNo = request.getParameter("zipNo"); 
String addrDetail = request.getParameter("addrDetail"); 
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
  		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0, user-scalable=yes">
		<title>주소검색</title> 
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
	</head>
	<script type="text/javascript">
	//<![CDATA[ 
		function init(){
			var url = location.href;
			var confmKey = "<%=jusoPopupKey%>";
			var inputYn= "<%=inputYn%>";
			
			if(inputYn != "Y"){
				document.form.confmKey.value = confmKey;
				document.form.returnUrl.value = url;
				document.form.action="//www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
				
				document.form.submit();
			} else {
				opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>");
				window.close();
			}
		}       
	//]]>
	</script>
	<body onload="init();">
		<form id="form" name="form" method="post">
			<input type="hidden" id="confmKey" name="confmKey" value=""/>
			<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		</form>
	</body>
</html>
