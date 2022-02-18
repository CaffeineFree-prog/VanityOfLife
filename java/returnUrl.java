
//로그인을 하지 않았다면
Cookie cookie = new Cookie("afterLoginReturnUrl", "/url.do?mId=" + mId);
cookie.setPath("/");
cookie.setMaxAge(60*60);
res.addCookie(cookie);
String returnUrl = req.getContextPath() + "/contents.do";
WriterUtil.flushJSAlert(res,
		WriterUtil.createJsAlertContent("로그인을 해주시기 바랍니다.", "location.href='" + returnUrl + "';"));
return null;

//로그인 후
Cookie[] cookies = req.getCookies();
if(cookies != null) {
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("afterLoginReturnUrl") && StringUtil.isNotBlank(cookie.getValue())) {
			String returnUrl = cookie.getValue();
			cookie = new Cookie("afterLoginReturnUrl", null);
			cookie.setMaxAge(0);
			cookie.setPath("/");
			res.addCookie(cookie);
			WriterUtil.flushJSAlert(res, 
					WriterUtil.createJsAlertContent("로그인 되었습니다.",
							"location.href='"+req.getContextPath() + returnUrl  + "';"));
		}
	}
}
