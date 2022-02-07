<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<% pageContext.setAttribute("lineChar", "\r"); %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%
try {
	// 만 65세 이상
	String validUserBirthday = (String)request.getSession().getAttribute("validUserBirthday");
	int bithdayYEAR = Integer.parseInt(validUserBirthday.substring(0, 4));
	//out.println(bithdayYEAR);
	int bithdayMONTH = Integer.parseInt(validUserBirthday.substring(4, 6));
	//out.println(bithdayMONTH);
	int bithdayDAY = Integer.parseInt(validUserBirthday.substring(6, 8));
	//out.println(bithdayDAY);
	Calendar current = Calendar.getInstance();
	int currentYear  = current.get(Calendar.YEAR);
	int currentMonth = current.get(Calendar.MONTH) + 1;
	int currentDay   = current.get(Calendar.DAY_OF_MONTH);
	int age = currentYear - bithdayYEAR;
	if (bithdayMONTH * 100 + bithdayDAY > currentMonth * 100 + currentDay) {
		age--;
	}
	if (age >= 65) {
		pageContext.setAttribute("age65", true);	
	}
} catch(Exception e) {
	System.out.println(e.getMessage());
	System.out.println("생년월일 값이 누락되었습니다.");
}
%>
<c:set var="CONTEXTPATH" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="isToday" />
<c:set var="file_upload_url" value="applyFileUpload.do" />
<c:set var="file_exp_allow" value="hwp,jpg,pdf" />
<c:set var="file_max_no" value="2" />
<c:set var="file_autoupload" value="true" />
<script type="text/javascript">
//<![CDATA[
          
	function validation(form) {
		
		if (!form.applyNm.value) {
			HHCommon.Alert("신청자명을 입력하세요.", form.applyNm);
			return false;
		}
		if (!form.birthday.value) {
			HHCommon.Alert("생년월일을 입력하세요.", form.birthday);
			return false;
		}
    	if (!HHCommon.NumberCheck(form.birthday.value)) {
    		HHCommon.Alert("생년월일은 숫자만 허용합니다.", form.birthday);
    		return false;
    	}
		if (!form.address.value) {
			HHCommon.Alert("주소를 입력하세요.", form.address);
			return false;
		}
		if ($('input[name="resiDence"]:checked').length == 0) {
			HHCommon.Alert("거주현황을 선택 해주세요.", form.resiDence[0]);
			return false;
		}
		if ($('input[name="resiDence"]:checked').length == '1' && form.address.value.indexOf('중구') < 0) {
			HHCommon.Alert("중구민만 신청 가능한 강좌입니다.<br /> 주소지가 잘못 기재되어 있을 경우 나의학습관리 > 개인정보수정에서 수정 가능합니다.", form.address);
			return false;
		}
		if ($('input[name="resiDence"]:checked').val() == '2') {
			if (!form.resiDenceWork.value) {
				HHCommon.Alert("거주현황의 직장명을 입력하세요.", form.resiDenceWork);
				return false;	
			}
		}
		if (!form.phone.value) {
			HHCommon.Alert("휴대전화를 입력 해주세요.", form.phone);
			return false;
		}
		if (form.phone.value.length != 12 && form.phone.value.length != 13) {
			HHCommon.Alert("휴대전화 번호를 올바르게 입력하세요.", form.phone);
			return false;
		}
		if ($('input[name="exemption"]:checked').length == 0) {
			HHCommon.Alert("수강료 감면을 선택하십시오.");
			return false;
		}
		
		var checked = $('input[name="exemption"]:checked').val();
		
		<c:if test="${eduProgramVO.eduType eq 'N' && eduProgramVO.eduMoney != '0'}">

			if(form.jfilename.value != "" && $('input[name="exemption"]:checked').length <= 0) {
				HHCommon.Alert("증빙서류를 첨부했습니다. 수강료 감면을 선택해주세요.");
				return false;
			}
			
			if ( checked != '0' && checked != '6' && $('input[name="exemption"]:checked').length > 0) {
				if (!form.jfilename.value) {
		    		HHCommon.Alert("수강료 감면을 선택하셨습니다.<br />수강료감면신청서를 다운로드 후 작성하여 증빙서첨부란에 파일을 첨부해주세요!.");
		    		return false;
		    	}
				if ($('tr.template-download').length != 2) {
					HHCommon.Alert("첨부파일 2개를 첨부해주세요.", form.files);
					return false;
				}
			}
			
			if ($('input[name="exemption"]:checked').val() != '1' && $('input[name="exemption"]:checked').val() != '2' && $('input[name="exemption"]:checked').val() != '3') {
				/* if (!form.payType[0].checked && !form.payType[1].checked && !form.payType[2].checked) {
					HHCommon.Alert("결제방법을 선택 해주세요.", form.payType[0]);
					return false;
				} */
				if ($('input[name="payType"]:checked').length == 0) {
					HHCommon.Alert("결제방법을 선택 해주세요.", form.payType[0]);
					return false;
				}
			}
			
		</c:if>
		
		if (confirm("입력하신 정보로 신청을 진행하시겠습니까?")) {
			return true;
		}
		return false;
	}

    function openApigoPopup(){
    	var pop = window.open("${pageContext.request.contextPath}/openApi/jusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
    }
    
    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
    	$('#address').val(roadAddrPart1 + " " + roadAddrPart2 + " " + addrDetail);
    }
    
    function fn_list() {
		var frm = document.getElementById('searchForm');
		frm.exec.value = "list";
		frm.submit();
	}
    
    function fn_exemptionClear() {
    	$('input[name="exemption"]').prop('checked', false);
    	$('#payTypeDis').show();
    }
	
	$(function() { 
		HHCommon.AutoHypenPhone($('#phone'));
		HHCommon.AutoHypenPhone($('#tel'));
		$('#phone').val(HHCommon.HypenPhoneChange($('#phone').val()));
		
		$('input[name="resiDence"]').click(function() {
			if ($(this).val() == '2') {
				$('#resiDenceWork').prop('disabled', false);
			} else {
				$('#resiDenceWork').prop('disabled', true);
			}
		});
		
		if ($('#payTypeDis').length > 0) {
			$('input[name="exemption"]').click(function() {
				if ($(this).val() == '1' || $(this).val() == '2' || $(this).val() == '3') {
					$('#payTypeDis').hide();
				} else {
					$('#payTypeDis').show();
				}
			});
		}
		
		if ('${age65}' == 'true') {
			$('input[name="exemption"]').prop('checked', false);
			$('#exemption06').prop('checked', true);
			$('#hidden1').css('display', 'none');
			$('#hidden2').css('display', 'none');
			$('#hidden3').css('display', 'none');
			$('#hidden4').css('display', 'none');
			$('#hidden5').css('display', 'none');
			$('#hidden6').css('display', 'none');
		} else {
			$('input[name="exemption"]').prop('checked', false);
			$('#exemption00').prop('checked', true);
			$('#hidden2 > td > .radio-inline:nth-child(3)').css('display', 'none');
		}
	});
	
//]]>
</script>
<div id="S_container">
	<div class="main_wrap">
		<!-- snb -->
		<%@include file="../leftmenu/leftmenu01.jsp"%>
		<!-- //snb -->
		 
		<div id="contents">
			<div id="con_header">
				<!-- linemap 
				<h1>평생교육프로그램</h1>
				<ul class="location">
					<li>홈</li>
					<li >온라인신청</li>
					<li >온라인 예약</li>
					<li  class="end">평생교육프로그램</li>
				</ul> -->
				<%@include file="../include/linemap.jsp"%>
				<!-- //linemap -->
			</div>
						
			<div id="con_body">
				<form:form commandName="search" name="searchForm" id="searchForm" action="./selectProgram.do" methodParam="post">
					<form:hidden path="menu" id="s_menu"/>
					<form:hidden path="smenu" id="s_smenu"/>
					<form:hidden path="exec" id="s_exec"/>
					<form:hidden path="currentPage" id="s_currentPage"/>
					<form:hidden path="pagePerCount" id="s_pagePerCount"/>
					<form:hidden path="searchTitle" id="s_searchTitle"/>
					<form:hidden path="searchKey" id="s_searchKey"/>
					<form:hidden path="eduCategory" id="s_eduCategory"/>
				</form:form>
				<form id="formEl" name="formEl" method="post" action="./programApplyInsertProc.do" onsubmit="return validation(this);">
					<input type="hidden" name="exec" id="exec" value="<c:out value="${search.exec}" />" />
					<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${search.currentPage}" />" />
					<input type="hidden" name="pagePerCount" id="pagePerCount" value="<c:out value="${search.pagePerCount}" />" />
					<input type="hidden" name="eduCategory" id="eduCategory" value="<c:out value="${search.eduCategory}" />" />
					<input type="hidden" name="timedir" id="timedir" value="${isToday}" />
					<input type="hidden" name="file_upload_url" id="file_upload_url" value="<c:out value="${file_upload_url}"/>" />
					<input type="hidden" name="file_exp_allow" id="file_exp_allow" value="<c:out value="${file_exp_allow}"/>" />
					<input type="hidden" name="file_max_no" id="file_max_no" value="<c:out value="${file_max_no}"/>" />
					<input type="hidden" name="file_autoupload" id="file_autoupload" value="<c:out value="${file_autoupload}"/>" />
					<input type="hidden" name="prgId" id="prgId" value="<c:out value="${search.prgId}" />" />
					<input type="hidden" name="applyOverCheck" id="applyOverCheck" value="<c:out value="${eduProgramApplyVO.applyOverCheck}" />" />
					<input type="hidden" name="payState" id="payState" value="<c:out value="${eduProgramApplyVO.payState}" />" />
					<%-- 대기인원 신청 메세지 출력 --%>
					<c:if test="${eduProgramApplyVO.applyOverCheck == 'true'}">
						<div class="alert alert-danger" role="alert">
							<strong style="font-size:1.4em;">해당 강좌는 신청인원이 마감되어 대기인원으로 신청됩니다.</strong>
						</div>
					</c:if>
					<h2 class="con_h2">신청강좌정보</h2>
					<table class="table table-bordered">
						<caption class="hidden">강좌정보</caption>
						<colgroup>
							<col style="width:15%;" />
							<col style="width:35%;" />
							<col style="width:15%;" />
							<col style="width:35%;" />
						</colgroup>
						<tbody>
							<tr>
								<th><span>일반/특강</span></th>
								<td><c:out value="${eduProgramVO.eduTypeNm}" /></td>
								<th><span>강좌기관</span></th>
								<td><c:out value="${eduProgramVO.eduCategoryNm}" /></td>
							</tr>
							<tr>
								<th><span>강좌명</span></th>
								<td colspan="3"><c:out value="${eduProgramVO.eduNm}" /></td>
							</tr>
							<tr>
								<th><span>교육대상</span></th>
								<td colspan="3">
									<c:forEach items="${commCodeList_EDU002}" var="codeVO" varStatus="status">
										<c:if test="${eduProgramVO.target eq codeVO.code}"><c:out value="${codeVO.codeNm}"/></c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th><span>접수기간</span></th>
								<td colspan="3">
									<c:out value="${eduProgramVO.acceptSdate}" /> ~ 
									<c:out value="${eduProgramVO.acceptEdate}" />
								</td>
							</tr>
							<tr>
								<th><span>교육기간</span></th>
								<td colspan="3">
									<c:out value="${eduProgramVO.edu_symd}" /> ~ 
									<c:out value="${eduProgramVO.edu_eymd}" />
								</td> 
							</tr>
							<tr>
								<th><span>교육시간</span></th>
								<td colspan="3">
									(
										<c:set var="dayweek" value=""/>
										<c:if test="${eduProgramVO.monDfk == '1'}"><c:set var="dayweek" value="${dayweek}월,"/></c:if>
										<c:if test="${eduProgramVO.tueDfk == '1'}"><c:set var="dayweek" value="${dayweek}화,"/></c:if>
										<c:if test="${eduProgramVO.wedDfk == '1'}"><c:set var="dayweek" value="${dayweek}수,"/></c:if>
										<c:if test="${eduProgramVO.thuDfk == '1'}"><c:set var="dayweek" value="${dayweek}목,"/></c:if>
										<c:if test="${eduProgramVO.friDfk == '1'}"><c:set var="dayweek" value="${dayweek}금,"/></c:if>
										<c:if test="${eduProgramVO.satDfk == '1'}"><c:set var="dayweek" value="${dayweek}토,"/></c:if>
										<c:if test="${eduProgramVO.sunDfk == '1'}"><c:set var="dayweek" value="${dayweek}일,"/></c:if>
										<c:out value="${fn:substring(dayweek, 0, fn:length(dayweek)-1)}"/>
									) 
									<c:out value="${eduProgramVO.eduStime}" /> ~ 
									<c:out value="${eduProgramVO.eduEtime}" /> 
								</td>
							</tr>
							<tr>
								<th><span>모집정원</span></th>
								<td colspan="3">
									<span class="label label-success">모집인원</span> : <fmt:formatNumber value="${eduProgramVO.applyNo}" pattern="#,###" /> 명 / 
									<span class="label label-warning">대기인원</span> : <fmt:formatNumber value="${eduProgramVO.waitApplyNo}" pattern="#,###" /> 명 
								</td>
							</tr>
							<tr>
								<th><span>강사명</span></th>
								<td colspan="3"><c:out value="${eduProgramVO.lecName}" /></td>
							</tr>
							<tr>
								<th><span>수업료</span></th>
								<td colspan="3">
									<c:choose>
									    <c:when test="${eduProgramVO.eduMoney == '0' || empty eduProgramVO.eduMoney}">
									        무료
									    </c:when>												
									    <c:otherwise>
									        <strong style="color:#cc231e;"><fmt:formatNumber value="${eduProgramVO.eduMoney}" pattern="#,###" /> 원</strong><br>
									        	*만65세 이상 어르신은 자동으로 50%할인된 금액으로 결제됩니다.
									    </c:otherwise>
									</c:choose>
								</td>
							</tr>
							</tr>
							<tr>
								<th><span>재료(교재)비</span></th> 
								<td colspan="3">
									<c:choose>
									    <c:when test="${eduProgramVO.subMoney == '0' || empty eduProgramVO.subMoney}">
									        
									    </c:when>												
									    <c:otherwise>
									    	<!-- 기존에 입력한 값이 숫자로만 되어 있는 형태가 아닌경우가 있어 예외처리 -->
									    	<c:set var="subMoney" value="${eduProgramVO.subMoney}" />
											<c:catch var="isNumber">
											   <c:set var="subMoney" value="${subMoney * 1}" />
											</c:catch>
											<c:if test="${isNumber == null}">
											    <strong style="color:#cc231e;"><fmt:formatNumber value="${eduProgramVO.subMoney}" pattern="#,###" /> 원</strong>
											</c:if>
											<c:if test="${isNumber != null}">
												<strong style="color:#cc231e;"><c:out value="${eduProgramVO.subMoney}"/></strong>
											</c:if>
									    </c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th><span>강좌소개</span></th>
								<td colspan="3"><c:out value="${fn:replace(eduProgramVO.eduContents, newLineChar, '<br />')}" escapeXml="false" /></td>
							</tr>
						</tbody>
					</table>
					
					<h2 class="con_h2 mt40">수강신청서 작성</h2>					
					<p style="color:#cc231e;">( <span class="glyphicon glyphicon-ok red-color"></span> ) <strong>표시는 필수입력 항목입니다.</strong></p>
					<table class="table table-bordered">
						<caption class="hidden">수강신청서 작성</caption>
						<colgroup>
							<col style="width:130px;" />
							<col style="width:auto;" />
							<col style="width:130px;" />
							<col style="width:auto;" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="applyNm">신청자명</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
								<td><input type="text" name="applyNm" id="applyNm" value="<c:out value="${sessionScope.validUserName}"/>" class="form-control" /></td>
								<th scope="row"><label for="birthday">생년월일</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
								<td class="form-inline">
									<input type="text" name="birthday" id="birthday" value="<c:out value="${sessionScope.validUserBirthday}"/>" maxlength="8" class="form-control" />
									<label class="radio-inline" for="gender01"><input type="radio" name="gender" id="gender01" value="M" checked="checked" />남</label>
									<label class="radio-inline" for="gender02"><input type="radio" name="gender" id="gender02" value="F" />여</label>
									<span class="help-block"><i class="glyphicon glyphicon-info-sign"></i> "YYYYMMDD" 형태로 숫자만 입력바랍니다.</span>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="address">주소</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
								<td colspan="3">
									<div class="form-inline">
										<input type="text" id="address" name="address" value="<c:out value="${sessionScope.validUserAddress01}"/> <c:out value="${sessionScope.validUserAddress02}"/>" readonly="readonly" class="form-control" style="width:80%;" />
										<!--  <button type="button" class="btn btn-default" onclick="openApigoPopup();">
								  			<i class="glyphicon glyphicon-search"></i>
							                <span>주소검색</span>
										</button> -->
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">거주현황 <span class="glyphicon glyphicon-ok red-color"></span></th>
								<td colspan="3" class="form-inline">
									<label class="radio-inline" for="resiDence01"><input type="radio" id="resiDence01" name="resiDence" checked="checked" value="1" />울산광역시 중구 거주자</label>
									<label class="radio-inline" for="resiDence02"><input type="radio" id="resiDence02" name="resiDence" value="2" />울산광역시 중구 직장인</label> 
									<span style="margin-left:8px;">(직장명 : </span><input type="text" name="resiDenceWork" id="resiDenceWork" disabled="disabled" class="form-control" />)
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="phone">휴대전화</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
								<td class="form-inline">
									<input type="text" name="phone" id="phone" value="<c:out value="${sessionScope.validUserMobile}"/>" maxlength="13" class="form-control" />
									<span class="help-block"><i class="glyphicon glyphicon-info-sign"></i> 하이폰은 자동입력됩니다.</span>
								</td>
								<th scope="row"><label for="tel">전화번호</label></th>
								<td class="form-inline">
									<input type="text" name="tel" id="tel" value="" maxlength="13" class="form-control" />
									<span class="help-block"><i class="glyphicon glyphicon-info-sign"></i> 하이폰은 자동입력됩니다.</span>
								</td>
							</tr>
							<c:if test="${eduProgramVO.eduMoney != '0'}"> 
							<tr id="hidden1">
								<th scope="row" rowspan="5">
									수강료 감면 <span class="glyphicon glyphicon-ok red-color"></span><br />(증빙서 첨부)
									<div style="margin-top:10px;">
									<!-- <button type="button" class="btn btn-xs btn-default" onclick="fn_exemptionClear();"><span>선택값 초기화</span></button> -->
									</div>
								</th>
								<th scope="row">면제</th>
								<td colspan="3">
									<label class="radio-inline" for="exemption01"><input type="radio" id="exemption01" name="exemption" value="1" />국민기초생활수급권자</label>
									<label class="radio-inline" for="exemption02"><input type="radio" id="exemption02" name="exemption" value="2" />장애인(1급~3급)</label> 
									<label class="radio-inline" for="exemption03"><input type="radio" id="exemption03" name="exemption" value="3" />국가유공자</label> 
								</td>
							</tr> 
							<tr id="hidden2">
								<th scope="row">50%감면</th>
								<td colspan="2">
									<label class="radio-inline" for="exemption04"><input type="radio" id="exemption04" name="exemption" value="4" />장애인(4급~6급)</label>
									<label class="radio-inline" for="exemption05"><input type="radio" id="exemption05" name="exemption" value="5" />한부모 가정</label> 
									<label class="radio-inline" for="exemption06"><input type="radio" id="exemption06" name="exemption" value="6" />만65세 이상 어르신</label> 
								</td>
							</tr>
							<tr id="hidden3">
								<th scope="row">20%감면</th>
								<td colspan="2">
									<label class="radio-inline" for="exemption07"><input type="radio" id="exemption07" name="exemption" value="7" />울산광역시장이 발급한 자원봉사증 소지자</label>
									<label class="radio-inline" for="exemption08"><input type="radio" id="exemption08" name="exemption" value="8" />다자녀 가구원</label> 
								</td>
							</tr>
							<tr id="hidden4">
								<th scope="row">해당사항없음</th>
								<td colspan="2">
									<label class="radio-inline" for="exemption00"><input type="radio" id="exemption00" name="exemption" value="0" />해당사항없음</label>
								</td>
							</tr>
							<tr id="hidden5">
								<td colspan="4">
									 <strong class="help-block"><i class="glyphicon glyphicon-info-sign"></i> 수강료는 중복 감면 되지 않습니다. 해당하는 사항 중 감면사항이 중복에 해당하는 경우라도 눞은 감면률 하나만 선택해주시기 바랍니다. 감면사항이 중복 해당하는 경우에는 높은 감면률로 적용됩니다.</strong>
								</td>
							</tr>
							<tr id="hidden6">
								<th scope="row"><label for="files">증빙서첨부</label></th>
								<td colspan="3">
									<div class="well">
										<p class="text-danger"><strong>수강료 감면에 해당되는 신청자는 아래의 "수강료감면신청서.hwp"를 다운로드 후 증빙서를 첨부하여 주시기 바랍니다.</strong></p>
										<ul class="fileAttachToolTip">
											<li>1. <a href="${CONTEXTPATH}/file/boardFileDown.do?bid=BD000304&amp;bmidx=721&amp;fNo=0" target="_blank" title="새창" class="text-primary">수강료감면신청서.hwp</a></li>
											<li>2. 증빙서류(각종 증명 카드 등)</li>
										</ul>
									</div>
									<div class="fileupload-buttonbar">
				            			<div class="col-lg-7">
				                			<span class="btn btn-success fileinput-button"><i class="glyphicon glyphicon-plus"></i> <span>파일첨부</span>
				                			<input type="file" name="files[]" id="files" multiple /></span>
									   		<input type="hidden" name="jfiledown" id="jfiledown" />
									   		<input type="hidden" name="jfileminetype" id="jfileminetype" />
									   		<input type="hidden" name="jfilesize" id="jfilesize" />
									   		<input type="hidden" name="jfilename" id="jfilename" />
									   		<input type="hidden" name="jfileuniqname" id="jfileuniqname" />
									   		<span class="fileupload-process"></span>
				            			</div>
										<div class="col-lg-5 fileupload-progress fade">
							   				<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
							       				<div class="progress-bar progress-bar-success" style="width:0%;"></div>
							   				</div>
							   				<div class="progress-extended">&nbsp;</div>
										</div>
		        					</div>
		        					<table role="presentation" class="table_view"><tbody class="files"></tbody></table>
									<script id="template-upload" type="text/x-tmpl">
									{% for (var i=0, file; file=o.files[i]; i++) { %}
    								<tr class="template-upload fade">
        								<td>
            								<span class="preview"></span>
        								</td>
        								<td>
            								<p class="name">{%=file.name%}</p>
            								<strong class="error text-danger"></strong>
        								</td>
        								<td>
            								<p class="size">Processing...</p>
            								<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        								</td>
        								<td>
            								{% if (!i && !o.options.autoUpload) { %}
                							<button class="btn btn-sm btn-primary start" disabled>
                								<i class="glyphicon glyphicon-upload"></i>
                								<span>업로드시작</span>
                							</button>
            								{% } %}
            								{% if (!i) { %}
                							<button class="btn btn-sm btn-warning cancel">
                								<i class="glyphicon glyphicon-ban-circle"></i>
                								<span>업로드취소</span>
                							</button>
            								{% } %}
        								</td>
    								</tr>
									{% } %}
									</script>
									<script id="template-download" type="text/x-tmpl">
									{% for (var i=0, file; file=o.files[i]; i++) { %}
    								<tr class="template-download fade">
        								<td>
            								<span class="preview">
            								{% if (file.thumbnailUrl) { %}
                								<img src="{%=file.thumbnailUrl%}" style="width:80px;">
                							{% } %}
            								</span>
        								</td>
        								<td>
            								<p class="name"><span>{%=file.name%}</span></p>
            								{% if (file.error) { %}
            									<div><span class="label label-danger">Error</span> {%=file.error%}</div>
            								{% } %}
        								</td>
        								<td>
            								<span class="size">{%=o.formatFileSize(file.size)%}</span>
        								</td>
        								<td>
											{% if (file.contentsInImageType) { %}
									
											{% } %}
            								{% if (file.deleteFileName) { %}
            									<button type="button" class="btn btn-sm btn-danger" data-type="{%=file.deleteType%}" data-filename="{%=file.deleteFileName%}" data-url="{%=file.deleteUrl%}">
            										<i class="glyphicon glyphicon-trash"></i>
            										<span>파일삭제</span>
            									</button>
            								{% } else { %}
            									<button class="btn btn-sm btn-warning cancel">
            										<i class="glyphicon glyphicon-ban-circle"></i>
            										<span>Cancel</span>
            									</button>	
            								{% } %}
        								</td>
    								</tr>
									{% } %}
									</script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/vendor/jquery.ui.widget.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/tmpl.min.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/load-image.all.min.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/canvas-to-blob.min.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.blueimp-gallery.min.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.iframe-transport.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-process.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-image.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-audio.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-video.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-validate.js"></script>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/jquery.fileupload-ui.js"></script>
									<script src="${CONTEXTPATH}/js/egovframework/story/client/applyUploadInit.js"></script>
									<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
									<!--[if (gte IE 8)&(lt IE 10)]>
									<script src="${CONTEXTPATH}/res/story/jfu-9.10.1/js/cors/jquery.xdr-transport.js"></script>
									<![endif]-->
									<strong class="help-block"><i class="glyphicon glyphicon-info-sign"></i> 첨부가능 파일수 : <c:out value="${file_max_no}"/>, 첨부가능 확장자 : <c:out value="${file_exp_allow}"/></strong>
								</td>
							</tr>
							</c:if>
						</tbody>
					</table>
					
					<%-- 강좌가 일반이면 유료강좌이므로 결제 선택 입력 양식 활성화 --%>
					<c:if test="${eduProgramVO.eduType eq 'N' && eduProgramVO.eduMoney != '0'}">
						<div id="payTypeDis">
							<h2 class="con_h2">결제방법 선택</h2>
							<div class="alimiInfoBox">
								<label class="radio-inline" for="payType01"><input type="radio" id="payType01" name="payType" value="SC0010" />카드결제</label>
								<label class="radio-inline" for="payType02"><input type="radio" id="payType02" name="payType" value="SC0030" />실시간계좌이체</label>
								<label class="radio-inline" for="payType03"><input type="radio" id="payType03" name="payType" value="SC0040" />가상계좌(무통장)</label>
							</div>
						</div>
					</c:if>
					<%-- 대기인원 신청 메세지 출력 --%>
					<c:if test="${eduProgramApplyVO.applyOverCheck == 'true'}">
						<div class="alert alert-danger" role="alert">
							<strong style="font-size:1.4em;">해당 강좌는 신청인원이 마감되어 대기인원으로 신청됩니다.</strong>
						</div>
					</c:if>
			  		<div id="buttonFieldSet">
			  			<button type="submit" class="btn btn-info">
				  			<i class="glyphicon glyphicon-ok-circle"></i>
			                <span><spring:message code="button.apply" /></span>
						</button>
						<button type="button" class="btn btn-default" onclick="fn_list();">
				  			<i class="glyphicon glyphicon-th-list"></i>
			                <span><spring:message code="button.list" /></span>
						</button>
					</div>
				</form>
			</div>
		</div>		
	</div>	
</div>
<hr />
<div class="modal fade" id="alertModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title"><i class="glyphicon glyphicon-exclamation-sign"></i> 알림</h4>
			</div>
			<div class="modal-body" id="alertModalBody"></div>
		</div>
	</div>
</div>
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title"><i class="glyphicon glyphicon-question-sign"></i> 알림</h4>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="confirmModalClose"><spring:message code="button.close" /></button>
				<button type="button" class="btn btn-primary" id="confirmModalSubmit"><spring:message code="button.confirm" /></button>
			</div>
		</div>
	</div>
</div>
