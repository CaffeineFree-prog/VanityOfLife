<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/storyCms/job/js/myresume.js"></script>
<script type="text/javascript">

	var gfv_count = '${fn:length(fileList)+2}';

	var edbgIndex = -1;
	var workExIndex = -1;
	var certIndex = -1;
	var ecaIndex = -1;
	
	var language = ${language};
	var certificate = ${certificate};
	var driver = ${driver};
	var jobListJson = ${jobListJson};
	
	/* 항목추가랑 삭제버튼 시작 */
	function fn_addEdbgStatus(){
		
		edbgIndex++;
		var addEdbgStr = "";
		
		addEdbgStr += "<ul class=\"sp2d_inner\" >";
		addEdbgStr += "		<li>";
		addEdbgStr += "			<dl>";
		addEdbgStr += "				<dt><label for=\"acbgVOList[" + edbgIndex + "].acbgInstNm\" >학교명</label></dt>";
		addEdbgStr += "				<dd>";
		addEdbgStr += "					<input type=\"text\" name=\"acbgVOList[" + edbgIndex + "].acbgInstNm\" id=\"acbgVOList[" + edbgIndex + "].acbgInstNm\" class=\"sp2d_bsize1 length\" />" ;
		addEdbgStr += "				</dd>";
		addEdbgStr += "			</dl>";
		addEdbgStr += "		</li>";
		addEdbgStr += "		<li>";
		addEdbgStr += "			<dl>";
		addEdbgStr += "				<dt class=\"thbtn_dt\" >기간</dt>" ;
		addEdbgStr += "				<dd>";
		addEdbgStr += "					<label for=\"acbgVOList[" + edbgIndex + "].instStartDt\" class=\"blind\">시작일</label>" ;
		addEdbgStr += "					<input type=\"text\" name=\"acbgVOList[" + edbgIndex + "].instStartDt\" id=\"acbgVOList[" + edbgIndex + "].instStartDt\" class=\"sp2d_bsize2 datepicker\"  maxlength=\"10\" placeholder=\"YYYY-MM-DD\" readonly />" ;
		addEdbgStr += "					~" ;
		addEdbgStr += "					<label for=\"acbgVOList[" + edbgIndex + "].instEndDt\" class=\"blind\">졸업일</label>" ;
		addEdbgStr += "					<input type=\"text\" name=\"acbgVOList[" + edbgIndex + "].instEndDt\" id=\"acbgVOList[" + edbgIndex + "].instEndDt\" class=\"sp2d_bsize2 datepicker\"  maxlength=\"10\" placeholder=\"YYYY-MM-DD\" readonly />" ;
		addEdbgStr += "				</dd>";
		addEdbgStr += "			</dl>";
		addEdbgStr += "		</li>";
		addEdbgStr += "		<li>";
		addEdbgStr += "			<dl>";
		addEdbgStr += "				<dt><label for=\"acbgVOList[" + edbgIndex + "].major\">전공학과</label></dt>" ;
		addEdbgStr += "				<dd>";
		addEdbgStr += "					<input type=\"text\" name=\"acbgVOList[" + edbgIndex + "].major\" id=\"acbgVOList[" + edbgIndex + "].major\" class=\"sp2d_bsize1\"  />" ;
		addEdbgStr += "				</dd>" ;
		addEdbgStr += "			</dl>" ;
		addEdbgStr += "		</li>" ;
		addEdbgStr += "		<li>" ;
		addEdbgStr += "			<dl>" ;
		addEdbgStr += "				<dt><label for=\"acbgVOList[" + edbgIndex + "].instFnshStatus\">상태</label></dt>" ;
		addEdbgStr += "				<dd>" ;
		addEdbgStr += "					<select name=\"acbgVOList[" + edbgIndex + "].instFnshStatus\" id=\"acbgVOList[" + edbgIndex + "].instFnshStatus\">" ;
											<c:forEach var="edbgStatus" items="${edbgStatus}">
		addEdbgStr += "						<option value=\"<c:out value='${edbgStatus.code}'/>\"><c:out value='${edbgStatus.codeNm}'/></option>";
											</c:forEach>
		addEdbgStr += "					</select>" ;
		addEdbgStr += "				</dd>" ;
		addEdbgStr += "			</dl>" ;
		addEdbgStr += "		</li>" ;
		//if(edbgIndex > 0){
			addEdbgStr += "		<li>" ;
			addEdbgStr += "			<dl>" ;
			addEdbgStr += "				<dt class=\"thbtn_dt del_btn\">관리</dt>";
			addEdbgStr += "				<dd>";
			addEdbgStr += "					<button type=\"button\" onclick=\"fn_deleteAdbgStatus('" + edbgIndex + "');\" class=\"bd_btn \"><span>삭제</span></button>" ;
			addEdbgStr += "				</dd>" ;
			addEdbgStr += "			</dl>" ;
			addEdbgStr += "		</li>" ;
		//}
		addEdbgStr += "	</ul>" ;

		$('#addEdbgStatus').append(addEdbgStr);
		
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
			changeYear: true,
			changeMonth: true,
			yearRange: 'c-100:c+5',
			yearSuffix: '년'
		});
		
	}
	

	function validator(form) {
		
		for (var i = 0; i <= ecaIndex ; i++) {
			
			var start = $("input[name='ecaVOList[" + i + "].ecaStartDt']").val();
			var end = $("input[name='ecaVOList[" + i + "].ecaEndDt']").val();
			var ecaInstNm = $("input[name='ecaVOList[" + i + "].ecaInstNm']").val();
			var ecaCn = $("input[name='ecaVOList[" + i + "].ecaCn']").val();
			
    		if( ecaInstNm == null || ecaInstNm == '' ){
    			alert("대외활동 기관을 입력해주세요");
    			return false;
    		}
    		if( ecaCn == null || ecaCn == '' ){
    			alert("대외활동 내용을 입력해주세요");
    			return false;
    		}
    		if( start == null || start == '' ){
    			alert("대외활동 시작일를 입력해주세요");
    			return false;
    		}
    		if( end == null || end == '' ){
    			alert("대외활동 종료일을 입력해주세요");
    			return false;
    		}
	    	if ( start && end ) {
	    		var appStartDate = $("input[name='ecaVOList[" + i + "].ecaStartDt']").val().split('-').join('');
	    		var appEndDate = $("input[name='ecaVOList[" + i + "].ecaEndDt']").val().split('-').join('');
	    		if (parseInt(appStartDate) > parseInt(appEndDate)) {
	    			alert("대외활동 시작일자가 종료일자보다 큽니다.");
	    			$("input[name='ecaVOList[" + i + "].ecaEndDt']").val('');
	    			return false;
	    		}
	    	}
			
		}
		for (var i = 0; i <= certIndex ; i++) {
			
			var certType = $("select[name='certificateVOList[" + i + "].certType']").val();
			var certNm = $("input[name='certificateVOList[" + i + "].certNm']").val();
			var certScore = $("input[name='certificateVOList[" + i + "].certScore']").val();
			var issuInstNm = $("input[name='certificateVOList[" + i + "].issuInstNm']").val();
			var issuDt = $("input[name='certificateVOList[" + i + "].issuDt']").val();
			
    		if( certType == null || certType == '' ){
    			alert("자격증 종류를 선택해주세요");
    			return false;
    		}
    		if( certNm == null || certNm == '' ){
    			alert("자격증명을 입력해주세요");
    			return false;
    		}
    		if( certScore == null || certScore == '' ){
    			alert("급수/어학점수를 입력해주세요");
    			return false;
    		}
    		if( issuInstNm == null || issuInstNm == '' ){
    			alert("발급기관을 입력해주세요");
    			return false;
    		}
    		if( issuDt == null || issuDt == '' ){
    			alert("취득일을 입력해주세요");
    			return false;
    		}
			
		}
		for (var i = 0; i <= workExIndex ; i++) {
			
			var start = $("input[name='workexpVOList[" + i + "].workStartDt']").val();
			var end = $("input[name='workexpVOList[" + i + "].workEndDt']").val();
			var companyNm = $("input[name='workexpVOList[" + i + "].companyNm']").val();
			var deptJbgdNm = $("input[name='workexpVOList[" + i + "].deptJbgdNm']").val();
			var workCn = $("input[name='workexpVOList[" + i + "].workCn']").val();
			
    		if( companyNm == null || companyNm == '' ){
    			alert("회사명을 입력해주세요");
    			return false;
    		}
    		if( deptJbgdNm == null || deptJbgdNm == '' ){
    			alert("부서직급을 입력해주세요");
    			return false;
    		}
    		if( workCn == null || workCn == '' ){
    			alert("담당업무를 입력해주세요");
    			return false;
    		}
    		if( start == null || start == '' ){
    			alert("근무기간 시작일를 입력해주세요");
    			return false;
    		}
    		if( end == null || end == '' ){
    			alert("근무기간 종료일을 입력해주세요");
    			return false;
    		}
	    	if ( start && end ) {
	    		var appStartDate = $("input[name='workexpVOList[" + i + "].workStartDt']").val().split('-').join('');
	    		var appEndDate = $("input[name='workexpVOList[" + i + "].workEndDt']").val().split('-').join('');
	    		if (parseInt(appStartDate) > parseInt(appEndDate)) {
	    			alert("근무기간 시작일자가 종료일자보다 큽니다.");
	    			$("input[name='workexpVOList[" + i + "].workEndDt']").val('');
	    			return false;
	    		}
	    	}
			
		}
		
		for (var i = 0; i <= edbgIndex ; i++) {
			
			var start = $("input[name='acbgVOList[" + i + "].instStartDt']").val();
			var end = $("input[name='acbgVOList[" + i + "].instEndDt']").val();
			var acbgInstNm = $("input[name='acbgVOList[" + i + "].acbgInstNm']").val();
			var major = $("input[name='acbgVOList[" + i + "].major']").val();
			
    		if( acbgInstNm == null || acbgInstNm == '' ){
    			alert("학교명을 입력해주세요");
    			return false;
    		}
    		if( major == null || major == '' ){
    			alert("전공을 입력해주세요");
    			return false;
    		}
    		if( start == null || start == '' ){
    			alert("학력 시작일를 입력해주세요");
    			return false;
    		}
    		if( end == null || end == '' ){
    			alert("학력 종료일을 입력해주세요");
    			return false;
    		}
	    	if ( start && end ) {
	    		var appStartDate = $("input[name='acbgVOList[" + i + "].instStartDt']").val().split('-').join('');
	    		var appEndDate = $("input[name='acbgVOList[" + i + "].instEndDt']").val().split('-').join('');
	    		if (parseInt(appStartDate) > parseInt(appEndDate)) {
	    			alert("학력 시작일자가 종료일자보다 큽니다.");
	    			$("input[name='acbgVOList[" + i + "].instStartDt']").val('');
	    			return false;
	    		}
	    	}
			
			/* var inputArr = $('#addEdbgStatus > ul.sp2d_inner').find("input[type='text']");
			var startDtInput = null;
			var endDtInput = null
			for(var j=0;j<inputArr.length;j++){
				if(inputArr.prop("name").indexOf("instStartDt") > 0){
					startDtInput = inputArr[j];
				}
				if(inputArr.prop("name").indexOf("instEndDt") > 0){
					endDtInput = inputArr[j];
				}
			}
			
			if(startDtInput == null || !startDtInput.val()){
				alert("학력 시작일을 입력하세요");
				startDtInput.focus();
				return false;
			} */
		}
		
    	if(!HHCommon.EmailPassCheck(form.email.value)) {
			alert("이메일주소가 유효하지 않습니다.");
            return false;
		}
    	if (!form.title.value) {
			alert("이력서 제목을 입력해주세요.");
			form.title.focus();
			return false;
		}
    	if (!form.roadNmAddr.value) {
			alert("주소를 입력해주세요.");
			form.roadNmAddr.focus();
			return false;
		}
    	if (!form.brthYr.value) {
			alert("출생년도를 입력해주세요.");
			form.brthYr.focus();
			return false;
		}
    	if (!form.tel.value) {
			alert("연락처를 입력해주세요.");
			form.tel.focus();
			return false;
		}
		return true;
	}

	$(function() {
		

	
		HHCommon.AutoHypenPhone($('#tel'));
		HHCommon.AutoHypenPhone($('#picTelno'));
		HHCommon.NumberNotClear($("#brthYr"));
		
		$("input:radio[name=workEx]").click(function(){
	        if($("input[name=workEx]:checked").val() == "02"){
	            $(".speck3_career").show();
	        }else if($("input[name=workEx]:checked").val() == "01"){
	              $(".speck3_career").hide();
	              $("#workExYear").val('0');
	              $("#workExMonth").val('0');
	        }
		});
	
		$('a[href="#fn_list"]').bind('click', function() {
			fn_list($('#listForm'));
		});
		
		//$(".category_choice").css("display","none");
		fn_occupationInit();

		$("#firstOccupation").change(function (){
			fn_occupationSecondList();
		});

		$("#secondOccupation").change(function (){
			fn_occupationThirdList();
		});

		$("#thirdOccupation").change(function (){
			$(".category_choice").css("display","block");
			fn_handleOnChange();
		});

		$(document).on("click", "li a.sel_delete", function(){
			var idx = $(this).parent().index();
			$("#selectValue li").eq(idx).remove();
			if($("#selectValue li").length < 1) {
				$(".category_choice").css("display","none");
			}
		});
		
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
		
		 $("input[name='profilePhoto1']").change(function(){
			 fn_readImage(this, '#profileImage');
		});
		 
		var check_value = $("#tempGugun").val().split('|');

		for (var j = 0; j < check_value.length; j++) {
			for (var i = 0; i < $("#gugunLi > dl > dd #gugun").length ; i++) {
				if( $("#gugunLi > dl > dd #gugun")[i].value == check_value[j] ){
					$("#gugunLi > dl > dd #gugun")[i].setAttribute("checked", "checked");
				}
			}
		}
		
		$("input[type='checkbox']").click(function (){
			if($(this).hasClass("uncheckAll")){
				$(this).parent().parent().find("input[type='checkbox']").each(function (){
					if(!$(this).hasClass("uncheckAll")){
						$(this).attr("checked", false);
					}
				});
			}else{
				$(this).parent().parent().find("input[type='checkbox']").each(function (){
					if($(this).hasClass("uncheckAll")){
						$(this).attr("checked", false);
					}
				});
			}
		});
		
	});
	
</script>
<div class="content_box">		
	<form id="writeForm" name="writeForm" action="./writeProc.do" method="post" onsubmit="return validator(this);" enctype="multipart/form-data">
		<input type="hidden" name="atchFileId" value="<c:out value='${searchVO.atchFileId}'/>" />
		<input type="hidden" name="profilePhoto" value="<c:out value='${searchVO.profilePhoto}'/>" />
		<input type="hidden" name="mId" value="${mId}">

		<h2 class="tit_h2">이력서 등록</h2>
		<h3 class="tit_h3">기본정보</h3>
		<div class="mp_speck1">
			<div class="speck1_img">
				<div class="profileImage">
					<img id="profileImage" src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${searchVO.profilePhoto}"/>&fileSn=0' onerror='this.src="${pageContext.request.contextPath}/storyCms/job/images/pic.png"' alt="증명사진">
				</div>
			</div>
			<div class="speck1_data">
				<ul>
					<li>
						<dl>
							<dt><label for="title">이력서 제목</label></dt>
							<dd><input type="text" name="title" id="title" value="<c:out value='${searchVO.title}'/>" /></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><label for="name">이름</label></dt>
							<dd>
							<input type="text" name="name" id="name" value="<c:out value='${sessionScope.USER_LOGIN_INFO.userNm}'/>" />
							</dd>
						</dl>
					</li>
					<li class="addline">
						<dl>
							<dt><label for="roadNmAddr">주소</label></dt>
							<dd>
								<input type="text" id="roadNmAddr" name="roadNmAddr" value="<c:out value='${searchVO.roadNmAddr}'/>" />
								<button type="button" class="bd_btn btn_print" onclick="HHCommon.JusoApiPopupOpen('${pageContext.request.contextPath}/storyCms/common/component/jusoPopup.jsp');"><span>주소찾기</span></button>
							</dd>
						</dl>
					</li>
					<li class="file_img">
						<dl>
							<dt><label for="profilePhoto1">이력서 사진</label></dt>
							<dd><input type="file" id="profilePhoto1" name="profilePhoto1"></dd>
						</dl>
					</li>
					<li class="sp1d_line2 yearline">
						<dl>
							<dt><label for="brthYr">출생년도</label></dt>
							<dd><input type="text" name="brthYr" id="brthYr" value="<c:out value='${searchVO.brthYr}'/>" /> 년생</dd>
						</dl>
					</li>
					<li class="sp1d_line2">
						<dl>
							<dt><label for="gender">성별</label></dt>
							<dd>
								<select name="gender" id="gender">
									<c:forEach var="genderType" items="${genderType}">
										<option value="<c:out value="${genderType.code}"/>" <c:if test="${genderType.code eq searchVO.gender}">selected="selected"</c:if>><c:out value="${genderType.codeNm}"/></option>
									</c:forEach>
								</select>
							</dd>
						</dl>
					</li>
					<li class="sp1d_line2">
						<dl>
							<dt><label for="tel">연락처</label></dt>
							<dd><input type="text" name="tel" id="tel" value="<c:out value='${searchVO.tel}'/>" /></dd>
						</dl>
					</li>
					<li class="sp1d_line2">
						<dl>
							<dt><label for="email">이메일</label></dt>
							<dd><input type="text" name="email" id="email" value="<c:out value='${searchVO.email}'/>" /></dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		
		
		<h3 class="tit_h3">학력</h3>
		<div class="mp_speck2">
			<div class="speck2_radio">
				<dl>
					<dt>학력</dt>
					<dd>
						<c:if test="${!empty edbgType}" >
							<c:forEach var="edbgType" items="${edbgType}" varStatus="status">
									<label for="edbgType_${status.index}"><input type="radio" id="edbgType_${status.index}" name="acbgStatus" value="<c:out value='${edbgType.code}'/>" <c:if test="${edbgType.code eq searchVO.acbgStatus}">checked="checked"</c:if> /><c:out value="${edbgType.codeNm}"/></label>
							</c:forEach>	
						</c:if>
					</dd>
				</dl>
			</div>
			<div class="speck2_data">
				<ul >
					<li class="thead_box">
						<ul class="sp2d_inner">
							<li>학교명</li>
							<li>기간</li>
							<li>전공학과</li>
							<li>상태</li>
							<li>관리</li>
						</ul>
					</li>
					<!-- db에 담겨있던 데이터들 위에 -->
 					<c:forEach var="acbgVOList" items="${searchVO.acbgVOList}" varStatus="status">
					<li >
						<ul class="sp2d_inner">
							<li>
								<dl>
									<dt><label for="acbgInstNm">학교명</label></dt>
									<dd>
										<input type="text" name="acbgInstNm_${acbgVOList.acbgUnqId}" id="acbgInstNm_${acbgVOList.acbgUnqId}" class="sp2d_bsize1" value="<c:out value='${acbgVOList.acbgInstNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt">기간</dt>
									<dd>
										<label for="instStartDt" class="blind">시작일</label>
										<input type="text" name="instStartDt_${acbgVOList.acbgUnqId}" id="instStartDt_${acbgVOList.acbgUnqId}" class="sp2d_bsize2" value="<c:out value='${acbgVOList.instStartDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
										~
										<label for="instEndDt" class="blind">졸업일</label>
										<input type="text" name="instEndDt_${acbgVOList.acbgUnqId}" id="instEndDt_${acbgVOList.acbgUnqId}" class="sp2d_bsize2" value="<c:out value='${acbgVOList.instEndDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="major">전공학과</label></dt>
									<dd>
										<input type="text" name="major_${acbgVOList.acbgUnqId}" id="major_${acbgVOList.acbgUnqId}" class="sp2d_bsize1" value="<c:out value='${acbgVOList.major}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="instFnshStatus">상태</label></dt>
									<dd>
										<select name="instFnshStatus_${acbgVOList.acbgUnqId}" id="instFnshStatus_${acbgVOList.acbgUnqId}" onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;" >
											<c:forEach var="edbgStatus" items="${edbgStatus}">
												<option value="<c:out value="${edbgStatus.code}"/>" <c:if test="${edbgStatus.code eq acbgVOList.instFnshStatus}">selected="selected"</c:if>><c:out value="${edbgStatus.codeNm}"/></option>
											</c:forEach>
										</select>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt del_btn">관리</dt>
									<dd>
										<button type="button" onclick="fn_deleteDBresume( this, '<c:out value="${acbgVOList.acbgUnqId}"/>', '<c:out value="${acbgVOList.esntlId}"/>' );" class="bd_btn "><span>삭제</span></button>
									</dd>
								</dl>
							</li>
						</ul>
					</li>
					</c:forEach>
					<!-- 추가(or 새로) 내용 밑에 -->
					<li id="addEdbgStatus">
					</li>
				</ul>
				<div class="bd_btnbox m_t_15 speck_btbox">
					<button type="button" onclick="fn_addEdbgStatus();" class="bd_btn btn_submit"><span>+ 항목추가</span></button>
				</div>
			</div>
		</div>
		
		<h3 class="tit_h3">경력</h3>
		<div class="mp_speck3">
			<div class="speck3_radio">
				<dl>
					<dt>경력</dt>
					<dd>
						<c:if test="${!empty wexStatus}" >
							<c:forEach var="wexStatus" items="${wexStatus}" varStatus="status">
								<label for="workEx_${status.index}"><input type="radio" id="workEx_${status.index}" name="workEx" value="<c:out value='${wexStatus.code}'/>" <c:if test="${wexStatus.code eq searchVO.workEx}">checked="checked"</c:if> /><c:out value="${wexStatus.codeNm}"/></label>
							</c:forEach>	
						</c:if>
						<div class="speck3_career">
							(	
								<label for="workExYear">
									<c:choose>
										<c:when test="${empty searchVO.workExYear}">
											<input type="text" name="workExYear" id="workExYear" class="sp3d_bsize3" value="0" />년
										</c:when>  
										<c:otherwise>
											<input type="text" name="workExYear" id="workExYear" class="sp3d_bsize3" value="${searchVO.workExYear}" />년
										</c:otherwise>
									</c:choose>
								</label>
								<label for="workExMonth">
									<c:choose>
										<c:when test="${empty searchVO.workExMonth}">
											<input type="text" name="workExMonth" id="workExMonth" class="sp3d_bsize3" value="0" />개월
										</c:when>
										<c:otherwise>
											<input type="text" name="workExMonth" id="workExMonth" class="sp3d_bsize3" value="${searchVO.workExMonth}" />개월
										</c:otherwise>
									</c:choose>
								</label>
							)
						</div>
					</dd>
				</dl>
			</div>
			<div class="speck3_data">
				<ul>
					<li class="thead_box">
						<ul class="sp3d_inner">
							<li>회사명</li>
							<li>근무기간</li>
							<li>부서/직급</li>
							<li>담당업무</li>
							<li>관리</li>
						</ul>
					</li>
					<!-- db에 담겨있던 데이터들 위에 -->
 					<c:forEach var="workexpVOList" items="${searchVO.workexpVOList}" varStatus="status">
					<li>
						<ul class="sp3d_inner">
							<li>
								<dl>
									<dt><label for="companyNm">회사명</label></dt>
									<dd>
										<input type="text" name="companyNm_${workexpVOList.workUnqId}" id="companyNm_${workexpVOList.workUnqId}" class="sp3d_bsize1" value="<c:out value='${workexpVOList.companyNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt">근무기간</dt>
									<dd>
										<label for="workStartDt" class="blind">시작일</label>
										<input type="text" name="workStartDt_${workexpVOList.workUnqId}" id="workStartDt_${workexpVOList.workUnqId}" class="sp3d_bsize2" value="<c:out value='${workexpVOList.workStartDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
										~
										<label for="workEndDt" class="blind">퇴사일</label>
										<input type="text" name="workEndDt_${workexpVOList.workUnqId}" id="workEndDt_${workexpVOList.workUnqId}" class="sp3d_bsize2" value="<c:out value='${workexpVOList.workEndDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly/>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="deptJbgdNm">부서/직급</label></dt>
									<dd>
										<input type="text" name="deptJbgdNm_${workexpVOList.workUnqId}" id="deptJbgdNm_${workexpVOList.workUnqId}" class="sp3d_bsize1" value="<c:out value='${workexpVOList.deptJbgdNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="workCn">담당업무</label></dt>
									<dd>
										<input type="text" name="workCn_${workexpVOList.workUnqId}" id="workCn_${workexpVOList.workUnqId}" class="sp3d_bsize1" value="<c:out value='${workexpVOList.workCn}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt del_btn">관리</dt>
									<dd>
										<button type="button" onclick="fn_deleteDBresume( this, '<c:out value="${workexpVOList.workUnqId}"/>', '<c:out value="${workexpVOList.esntlId}"/>' );" class="bd_btn "><span>삭제</span></button>
									</dd>
								</dl>
							</li>
						</ul>
					</li>
					</c:forEach>
					<!-- 추가(or 새로) 내용 밑에 -->
					<li id="addWorkExpStatus">
					</li>
				</ul>
				<div class="bd_btnbox m_t_15 speck_btbox">
					<button type="button" onclick="fn_addWorkExpStatus();" class="bd_btn btn_submit"><span>+ 항목추가</span></button>
				</div>
			</div>
		</div>
		
		<h3 class="tit_h3">보유자격증-어학,자격증,면허,수료증</h3>
		<div class="mp_speck4">
			<div class="speck4_data">
				<ul>
					<li class="thead_box">
						<ul class="sp4d_inner">
							<li>구분</li>
							<li>자격증명/면허명/교육이수명</li>
							<li>급수/어학점수</li>
							<li>발급기관</li>
							<li>취득일</li>
							<li>관리</li>
						</ul>
					</li>
					<!-- db에 담겨있던 데이터들 위에 -->
 					<c:forEach var="certificateVOList" items="${searchVO.certificateVOList}" varStatus="status">
					<li>
						<ul class="sp4d_inner">
							<li>
								<dl>
									<dt><label for="certTypeDB">구분</label></dt>
									<dd>
										<input type="text" name="certTypeDB_${certificateVOList.certUnqId}" id="certTypeDB_${certificateVOList.certUnqId}" class="sp4d_bsize1" value="<c:out value='${certificateVOList.certTypeNm}'/>"  readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="certNm">자격증명/면허명/교육이수명</label></dt>
									<dd>
										<input type="text" name="certNm_${certificateVOList.certUnqId}" id="certNm_${certificateVOList.certUnqId}" class="sp4d_bsize1" value="<c:out value='${certificateVOList.certNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="certScore">급수/어학점수</label></dt>
									<dd>
										<input type="text" name="certScore_${certificateVOList.certUnqId}" id="certScore_${certificateVOList.certUnqId}" class="sp4d_bsize1" value="<c:out value='${certificateVOList.certScore}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="issuInstNm">발급기관</label></dt>
									<dd>
										<input type="text" name="issuInstNm_${certificateVOList.certUnqId}" id="issuInstNm_${certificateVOList.certUnqId}" class="sp4d_bsize1" value="<c:out value='${certificateVOList.issuInstNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="issuDt">취득일</label></dt>
									<dd>
										<input type="text" name="issuDt_${certificateVOList.certUnqId}" id="issuDt_${certificateVOList.certUnqId}" class="sp4d_bsize1" value="<c:out value='${certificateVOList.issuDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt del_btn">관리</dt>
									<dd>
										<button type="button" onclick="fn_deleteDBresume( this, '<c:out value="${certificateVOList.certUnqId}"/>', '<c:out value="${certificateVOList.esntlId}"/>' );" class="bd_btn "><span>삭제</span></button>
									</dd>
								</dl>
							</li>
						</ul>
					</li>
					</c:forEach>
					<!-- 추가(or 새로) 내용 밑에 -->
					<li id="addCertificate">
					</li>
				</ul>
				<div class="bd_btnbox m_t_15 speck_btbox">
					<button type="button" onclick="fn_addCertificate();" class="bd_btn btn_submit"><span>+ 항목추가</span></button>
				</div>
			</div>
		</div>
		
		<h3 class="tit_h3">대외활동</h3>
		<div class="mp_speck5">
			<div class="speck5_data">
				<ul>
					<li class="thead_box">
						<ul class="sp5d_inner">
							<li>기관/장소</li>
							<li>기간</li>
							<li>내용</li>
							<li>관리</li>
						</ul>
					</li>
					<!-- db에 담겨있던 데이터들 위에 -->
					<c:forEach var="ecaVOList" items="${searchVO.ecaVOList}" varStatus="status">
					<li>
						<ul class="sp5d_inner">
							<li>
								<dl>
									<dt><label for="ecaInstNm">기관/장소</label></dt>
									<dd>
										<input type="text" name="ecaInstNm_${ecaVOList.ecaUnqId}" id="ecaInstNm_${ecaVOList.ecaUnqId}" class="sp5d_bsize1" value="<c:out value='${ecaVOList.ecaInstNm}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt">기간</dt>
									<dd>
										<label for="ecaStartDt" class="blind">시작일</label>
										<input type="text" name="ecaStartDt_${ecaVOList.ecaUnqId}" id="ecaStartDt_${ecaVOList.ecaUnqId}" class="sp5d_bsize2 " value="<c:out value='${ecaVOList.ecaStartDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
										~
										<label for="ecaEndDt" class="blind">마감일</label>
										<input type="text" name="ecaEndDt_${ecaVOList.ecaUnqId}" id="ecaEndDt_${ecaVOList.ecaUnqId}" class="sp5d_bsize2 " value="<c:out value='${ecaVOList.ecaEndDt}'/>" maxlength="10" placeholder="YYYY-MM-DD" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><label for="ecaCn">내용</label></dt>
									<dd>
										<input type="text" name="ecaCn_${ecaVOList.ecaUnqId}" id="ecaCn_${ecaVOList.ecaUnqId}" class="sp5d_bsize1" value="<c:out value='${ecaVOList.ecaCn}'/>" readonly />
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt class="thbtn_dt del_btn">관리</dt>
									<dd>
										<button type="button" onclick="fn_deleteDBresume( this, '<c:out value="${ecaVOList.ecaUnqId}"/>', '<c:out value="${ecaVOList.esntlId}"/>' );" class="bd_btn "><span>삭제</span></button>
									</dd>
								</dl>
							</li>
						</ul>
					</li>
					</c:forEach>
					<!-- 추가(or 새로) 내용 밑에 -->
					<li id="addEca">
					</li>
				</ul>
				<div class="bd_btnbox m_t_15 speck_btbox">
					<button type="button" onclick="fn_addEca();" class="bd_btn btn_submit"><span>+ 항목추가</span></button>
				</div>
			</div>
		</div>
		
		<h3 class="tit_h3">보유기술</h3>
		<div class="mp_speck6">
			<label for="skills" class="blind">보유기술</label>
			<textarea name="skills" id="skills" rows="15" class="bd_txtarea"><c:out value="${searchVO.skills}"/></textarea>
		</div>
		
		<h3 class="tit_h3">경력기술서</h3>
		<div class="mp_speck6">
			<label for="careerDesc" class="blind">경력기술서</label>
			<textarea name="careerDesc" id="careerDesc" rows="15" class="bd_txtarea"><c:out value="${searchVO.careerDesc}"/></textarea>
		</div>
		
		<h3 class="tit_h3">자기소개서</h3>
		<div class="mp_speck6">
			<label for="selfIntro" class="blind">자기소개서</label>
			<textarea name="selfIntro" id="selfIntro" rows="15" class="bd_txtarea"><c:out value="${searchVO.selfIntro}"/></textarea>
		</div>
		
		<h3 class="tit_h3">첨부파일</h3>
		<div class="mp_speck7">
			<table class="tbl_bd_view txt_l valg_m">
				<caption>첨부파일</caption>
				<colgroup>
					<col class="w_pct0">
					<col class="w_auto">
				</colgroup>
				<tbody>
					첨부파일 url
				</tbody>
			</table>
		</div>
		
		<h3 class="tit_h3">기타사항</h3>
		<div class="mp_speck8">
			<div class="list_topsearch">
				<ul class="top_scbox">
					<li>
						<dl>
							<dt>직종선택</dt>
							<input type="hidden" id="tempSort" value="<c:out value='${searchVO.sort}'/>" />
							<dd>
								<div class="category_box">
									<label for="firstOccupation" class="blind">1차 직종</label>
									<select name="firstOccupation" class="ctgr_list" id="firstOccupation">
									</select>
									<label for="secondOccupation" class="blind">2차 직종</label>
									<select name="secondOccupation" class="ctgr_list" id="secondOccupation">
									</select>
									<label for="thirdOccupation" class="blind">3차 직종</label>
									<select name="thirdOccupation" class="ctgr_list" id="thirdOccupation">
									</select>
								</div>
								<c:set var="categoryChoiceStyle" value=" style=\"display:none;\""/>
								<c:choose>
									<c:when test="${!empty searchVO.searchSortList}">
										<c:set var="categoryChoiceStyle" value=""/>
									</c:when>
								</c:choose>
								<div class="category_choice" ${categoryChoiceStyle}>
									<ul id="selectValue">
										<c:if test="${!empty searchVO.searchSortList}" >
											<c:forEach var="tmpVO" items="${searchVO.searchSortList}" varStatus="searchStatus">
												<c:set var="loop_flag" value="false" />
												<c:forEach var="codeVO" items="${jobList}" varStatus="jobStatus">
													<c:if test="${tmpVO eq codeVO.occupationId and not loop_flag}">
														<li><input type="hidden" value="${codeVO.occupationId}" name="searchSortList" /><span><c:out value="${codeVO.occupationNm}"/></span><a class="sel_delete" style="cursor:pointer;">삭제</a></li>
														<c:set var="loop_flag" value="true" />
													</c:if>
												</c:forEach>
											</c:forEach>
										</c:if>
									</ul>
								</div>
							</dd>
						</dl>
					</li>
					
					<li id="gugunLi">
						<dl>
							<dt>희망지역</dt>
							<input type="hidden" id="tempGugun" value="<c:out value='${searchVO.gugun}'/>" />
							<dd>
								<label for="gugun_all"><input type="checkbox" id="gugun_all" name="gugun" class="uncheckAll" value="all">울산 전체</label>
								<c:if test="${!empty gugun}" >
									<c:forEach var="gugun" items="${gugun}" varStatus="status">
										<label for="gugun_${status.index}"><input type="checkbox" id="gugun_${status.index}" name="gugun" value="<c:out value='${gugun.code}'/>" <c:if test="${fn:indexOf(searchVO.gugun, gugun.code ) >= 0}">checked="checked"</c:if>>  <c:out value='${gugun.codeNm}'/></label> 
									</c:forEach>
								</c:if>
							</dd>
						</dl>
					</li>
					<li class="ppinfo_agree">
						<dl>
							<dt>인재정보 제공 동의여부</dt>
							<dd>
								<p class="point pt_c_b"><em>동의하시면 인재정보로 노출되어 기업의 입사제안을 받으실 수 있습니다.</em></p>
								<div class="ppif_agrbox">
									<label for="agreement1"><input type="radio" id="agreement1" name="agreement" value="Y" <c:if test="${searchVO.agreement eq 'Y' || searchVO.agreement eq '' || empty searchVO.agreement }">checked="checked"</c:if>/>동의</label>
									<label for="agreement2"><input type="radio" id="agreement2" name="agreement" value="N" <c:if test="${searchVO.agreement eq 'N'}">checked="checked"</c:if>/>동의하지 않습니다.</label>
								</div>
							</dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		
		<div class="bd_btnbox ta_c m_t_20">
			<button type="submit" class="bd_btn btn_config last_btn" onclick=""><span>등록</span></button>
		</div>
		
	</form>
</div>
