<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/storyCms/common/jsp/taglib.jsp" %>
<jsp:useBean id="now" class="java.util.Date" />
<%
    /*
     * @File Name : list.jsp
     * @Description : 청년수당신청
     * @  수정일      수정자            수정내용
     * @ -------        --------    ---------------------------
     * @ 2022-02-07	최보은		최초생성 및 PG작업
     * @ ------------------------------------------------------
     */
%>
<script type="text/javascript">

	function fn_hideModal(){
		$('#ytapplyModal').hide();
	}
	
	function fn_showModal(){
		$('#ytapplyModal').show();
	}
	
	$(function() {
		$('#ytapplyModal').hide();
	});

</script>
<div class="content_box">
	<p>
	    <a href="#" class="btn_one col_1"><i class="btn_icon bcon10"></i><span>울산페이 지급형 수령방법 안내 다운로드 </span></a>
	  </p>
	<div class="bd_btnbox ta_c">
	
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" /></c:set> 
		
		<fmt:parseDate value="2022-02-09 09:00" pattern="yyyy-MM-dd HH:mm" var="startDate"/>
		<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd HH:mm" var="applyStdt" />
		<fmt:parseDate value="2022-03-11 18:00" pattern="yyyy-MM-dd HH:mm" var="endDate"/>
		<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd HH:mm" var="applyEddt" />

		<c:choose>
			<c:when test="${sysYear >= applyStdt && sysYear <= applyEddt }">
				<a href="./step01.do?mId=${mId}" class="bd_btn btn_config">청년수당신청하기</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:fn_showModal();" class="bd_btn btn_config">청년수당신청하기</a>
			</c:otherwise>
		</c:choose>
		
	</div>
	
	<!-- 재접수 안내팝업 ST-->
	<div class="ytapply_layer" id="ytapplyModal">
		<div class="ytapplylayer_box" style="top:600px;">
			<p class="ytap_txt">청년수당 1차 신청이 마감되었습니다. <br><strong class="fc_r_01">22.4.1 이후</strong> 재접수 예정입니다</p>
			<div class="ytap_close"><a href="javascript:;" onclick="fn_hideModal();"><span class="blind">닫기</span></a></div>
		</div>
		<div class="ytaplayer_bg"></div>
	</div>
	<!-- 재접수 안내팝업 ED-->
	
</div>
