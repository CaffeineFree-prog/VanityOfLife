<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/storyCms/common/jsp/taglib.jsp" %>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@page import="egovframework.storyCms.action.service.StoryCmsActionVO"%>
<%@page import="egovframework.storyCms.common.util.SessionUtil"%>
<%@page import="egovframework.storyCms.common.util.WriterUtil"%>
<%@page import="egovframework.storyCms.user.service.UserLoginVO"%>
<%
UserLoginVO userLoginVO = (UserLoginVO) SessionUtil.getUserSessionObj(request);
if (userLoginVO != null) {
	WriterUtil.flushJSAlert(response, 
			WriterUtil.createJsAlertContent("회원님은 이미 로그인 되었습니다.",
					"location.href='" + request.getContextPath() + "/job/main.do';"));
	return;	
}

String INTEGRATE_PROPERTIES_PATH = EgovProperties.getPathProperty("Globals.ConfPath") + System.getProperty("file.separator") + "integrate.properties";
String clientId = EgovProperties.getProperty(INTEGRATE_PROPERTIES_PATH, "oauth.clientId");
String returnUrl = EgovProperties.getProperty(INTEGRATE_PROPERTIES_PATH, "oauth.redirectUri");
request.getSession().setAttribute("siteCode", ((StoryCmsActionVO) request.getAttribute("storyCmsActionVO")).getSiteInfoVO().getSiteCode());
%>
<script src="<c:url value='/storyCms/common/js/oauth2.common-1.1.2.js' />"></script>
<script>
  $(function() {
		$("#authorize").click(function() {
			var param = {
				client_id : "<%=clientId%>",
				redirect_uri : "<%=returnUrl%>",
				response_type : "token",
				scope : "calendar,personalinfo,readboard",
				state : window.createNonce(5)
			};
			sessionStorage.setItem('state', param.state);
			sessionStorage.setItem('siteCode', "${storyCmsActionVO.siteInfoVO.siteCode}");
          
			var authorizeUrl = "https://logins.ulsan.go.kr/oauth2/auth";
			HHCommon.NewWinPop(authorizeUrl + "?" + $.param(param),
					"loginPopup",
					650,
					650,
					"yes","yes","yes");
		});
	});
</script>
<div class="content_box">
  <div class="login_box">
    <div class="login_inner">
      <h2><span><c:out value="${storyCmsActionVO.siteInfoVO.siteNm}"/> 로그인</span></h2>
      <p class="login_txt">울산시 통합회원 <span class="line_4bk">아이디/비밀번호로 로그인</span></p>
      <fieldset>
        <legend>로그인</legend>
        <div class="btn_area">
          <a href="javascript:;" id="authorize" class="login_btn"><span>통합 로그인</span></a>
        </div>
      </fieldset>
      <ul class="login_member">
        <li><a href="https://www.ulsan.go.kr/s/logins/contents.ulsan?mId=001001001000000000" target="_blank" title="회원가입" rel="noopener noreferrer">회원가입</a></li>
        <li><a href="https://www.ulsan.go.kr/s/logins/contents.ulsan?mId=001002001000000000" target="_blank" title="아이디/비밀번호찾기" rel="noopener noreferrer">아이디/비밀번호찾기</a></li>
      </ul>
    </div>
  </div>
</div>
