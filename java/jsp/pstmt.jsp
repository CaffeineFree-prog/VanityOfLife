<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="egovframework.storyCms.common.util.StringUtil"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%
// 아래 Service 및 VO 임포트 모듈에 맞게 수정해야함!!
%>
<%@ page import="egovframework.storyCms.sys.unit.api.cold.service.ColdMngService" %>
<%@ page import="egovframework.storyCms.sys.unit.api.cold.service.ColdMngVO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
InitialContext ic = new InitialContext();
DataSource ds = (DataSource) context.getBean("dataSourceIam-tibero");

Connection con	= null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String boardId = "BBS_0"; // 게시판ID

StringBuilder sb = new StringBuilder();
try{

	con = ds.getConnection();

	sb.append("SELECT ");
	sb.append("	DATA_SID, BOARD_ID, BOARD_SID, DATA_IDX, DATA_REF, DATA_DEP, USER_ID, USER_PW");
	sb.append("FROM RFC ");
	sb.append("WHERE ");
	sb.append("	BOARD_ID = ? ");
	sb.append("	AND DELETE_STATUS <> 'D' ");
	sb.append("ORDER BY DATA_SID ASC");

	//System.out.println("Query : " + sb.toString());

	pstmt = con.prepareStatement(sb.toString());
	pstmt.setString(1, boardId);

	rs = pstmt.executeQuery();

	List<EgovMap> resultList = new ArrayList<EgovMap>();

	while(rs.next()){
		EgovMap egovMap = new EgovMap();
		egovMap.put("dataContent", rs.getString("DATA_CONTENT"));

		resultList.add(egovMap);
	}

	int totalCount = resultList.size();
	out.println("총 " + totalCount + "건<br />");

	// 아래 서비스와 최상단 Service와 VO 수정해야함!!
	ColdMngService service = (ColdMngService) context.getBean("ColdMngService");
	for(int i=0;i<resultList.size();i++){
		EgovMap egovMap = resultList.get(i);
		// VO 및 데이터 세팅은 각 모듈에 맞게 수정해야함!!
		ColdMngVO insertVO = new ColdMngVO();
		if(egovMap.get("dataContent") != null && !egovMap.get("dataContent").toString().isEmpty()){
			insertVO.setCategory(egovMap.get("dataContent").toString());
		}
		service.insert(insertVO);

		out.println("시설명 : " + egovMap.get("dataTitle").toString() + " Insert 완료!! (총 " + (i+1) + "건 Insert됨)<br />");

	}

	out.println("<a href=\"./index.jsp\">목록으로</a>");
}catch(Exception e){
	out.print(e.toString());
	if(pstmt != null){
		pstmt.close();
	}
	if(rs != null){
		rs.close();
	}
	if(con != null){
		con.close();
	}
}finally{
	if(pstmt != null){
		pstmt.close();
	}
	if(rs != null){
		rs.close();
	}
	if(con != null){
		con.close();
	}
}
%>
