<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="now" class="java.util.Date" />
<script>
//<![CDATA[

	function goPage(curPage){
        var frm = document.getElementById('listForm');
        frm.page.value = curPage;
        frm.action = './applyList.ulsan?mId=${mId}';
        frm.submit();
        return false;
    }

	function fn_search() {
     	if( $('#appEndDate').val() != null && $('#appEndDate').val() != '' ){
    		if( $('#appStartDate').val() == null || $('#appStartDate').val() == '' ){
    			alert("시작일자를 입력해주세요");
    		}
    	}
    	if( $('#appStartDate').val() != null && $('#appStartDate').val() != '' ){
    		if( $('#appEndDate').val() == null || $('#appEndDate').val() == '' ){
    			alert("종료일자를 입력해주세요");
    		}
    	}
    	if ($('#appStartDate').val() && $('#appEndDate').val()) {
    		var appStartDate = $('#appStartDate').val().split('-').join('');
    		var appEndDate = $('#appEndDate').val().split('-').join('');
    		if (parseInt(appStartDate) > parseInt(appEndDate)) {
    			alert("검색기간의 시작일자가 종료일자보다 큽니다.");
    			$('#appEndDate').val('');
    			return false;
    		}
    	}
    	
        var frm = document.getElementById('listForm');
        frm.page.value = 1;
        frm.action = './applyList.do?mId=${mId}';
        frm.submit();
    }
    
	$(function() {

		$(".datepicker").datepicker({
			dateFormat: 'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			yearSuffix: '년'
		});
		
		$('a[href="#fn_list"]').bind('click', function() {
			fn_list($('#listForm'));
		});
    	
	});


//]]>
</script>
<div class="content_box">
	<form name="listForm" id="listForm" action="./jobOffer.ulsan?mId=${mId}" method="post">
	<input type="hidden" name="page" id="page" value="${page}" />

	<fieldset class="board_search">
		<legend class="hidden">검색</legend>
		<div class="list_topsearch">
			<ul class="top_scbox set_label">
				<li>
					<dl>
						<dt class="input_tit">입사지원일</dt>
						<dd>
							<label for="appStartDate" class="yymmdd">시작일</label>
							<input type="text" name="appStartDate" id="appStartDate" value="<c:out value='${searchVO.appStartDate}'/>" class="box_width20 datepicker" maxlength="10" readonly="readonly" />
							 <span class="yymmdd_cn">~</span>
							<label for="appEndDate" class="yymmdd">종료일</label>
							<input type="text" name="appEndDate" id="appEndDate" value="<c:out value='${searchVO.appEndDate}'/>" class="box_width20 datepicker" maxlength="10" readonly="readonly" />
						</dd>
					</dl>
				</li>
			</ul>
			<div class="bd_btnbox ta_r m_b_10">
				<button type="submit" onclick="fn_search();return false;" class="bd_btn btn_config"><span><spring:message code="button.inquire" /></span></button>
			</div>
		</div>
	</fieldset>

	<div class="mypage_managebox">
		<div class="total_count2">총 <strong>${totalCnt}</strong>건</div>
		<div class="myp1_list">
			<ul>
				<c:forEach var="resultVO" items="${resultList}" varStatus="status">
				<li>
					<ul class="myp1_inner">
						<li>
							<dl>
								<dt class="blind">채용공고명</dt>
								<dd>
									<ul class="mp_cplist">
										<li>
											<c:if test="${!empty dvsn1List}" >
												<c:set var="workExList" value="${fn:split(resultVO.workEx, ',')}" />
												<c:forEach var="tmpVO" items="${workExList}" varStatus="workExstatus">
													<c:forEach var="dvsn1List" items="${dvsn1List}" varStatus="status">
													<c:if test="${fn:indexOf(tmpVO, dvsn1List.code) >= 0}">
														<c:if test="${dvsn1List.code eq '03'}">경력무관</c:if>
														<c:if test="${dvsn1List.code ne '03'}">
															<c:out value="${dvsn1List.codeNm}"/>
															<c:if test="${!workExstatus.last}">, </c:if>
														</c:if>
													</c:if>
													</c:forEach>
												</c:forEach>
											</c:if>
										</li>
										<li>
											<c:if test="${!empty acaList}" >
												<c:set var="acaAbilityList" value="${fn:split(resultVO.academicAbility, ',')}" />
												<c:forEach var="tmpVO" items="${acaAbilityList}" varStatus="academiAbilityStatus">
													<c:if test="${academiAbilityStatus.index eq 0 }">
														<c:forEach var="acaList" items="${acaList}" varStatus="status">
															<c:if test="${fn:indexOf(tmpVO, acaList.code) >= 0}">
																<c:out value="${acaList.codeNm}"/>
															</c:if>
														</c:forEach>
													</c:if>
												</c:forEach>
												<c:if test="${fn:length(acaAbilityList) > 1}">
												외&nbsp;<c:out value="${fn:length(acaAbilityList)-1}"/>건
												</c:if>
											</c:if>
										</li>
									</ul>
								</dd>
							</dl>
						</li>
					</ul>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
		
	</form>
</div>
