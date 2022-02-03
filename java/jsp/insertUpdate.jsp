<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<jsp:useBean id="now" class="java.util.Date" />
<script>

	var userIndex = -1;

     function validator(form) {
    	if (!form.entNm.value) {
    		alert("기업을 선택해주세요.", form.entNm);
    		return false;
    	}
		for (var i = 0; i <= userIndex ; i++) {
			if(!$("input[name='insertEachList[" + i + "].userNm']").val()){
				alert("취업자를 입력하세요.");
				$("input[name='insertEachList[" + i + "].userNm']").focus();
				return false;
			}
			if(!$("input[name='insertEachList[" + i + "].userJumin']").val()){
				alert("주민번호를 입력하세요.");
				$("input[name='insertEachList[" + i + "].userJumin']").focus();
				return false;
			}
			if(!$("input[name='insertEachList[" + i + "].incentive']").val()){
				alert("지원금액을 입력하세요.");
				$("input[name='insertEachList[" + i + "].incentive']").focus();
				return false;
			}
		}
    	return true;
    }

    function fn_list(form) {
		form.submit();
		return false;
	}

	function setUserInfo(userId, userPathNm, userNm, userTypeNm, userJumin, jobseekEndDt, isEmergency, userEtc, createDt, userTel, idx){
		$("input[name='insertEachList[" + idx + "].userId']").val(userId);
		$("input[name='insertEachList[" + idx + "].userNm']").val(userNm);
		var realJumin = userJumin.substring(0,6) + "-" + userJumin.substring(7,13);
		$("input[name='insertEachList[" + idx + "].userJumin']").val(realJumin);
		$("input[name='insertEachList[" + idx + "].incentive']").val();
	}

	function fn_dataDel(idx){
		$("input[name='insertEachList[" + idx + "].userId']").val('');
		$("input[name='insertEachList[" + idx + "].userNm']").val('');
		$("input[name='insertEachList[" + idx + "].userJumin']").val('');
		$("input[name='insertEachList[" + idx + "].incentive']").val('0');
	}

	function fn_selectJobSeeker(idx){
		window.open("/selectJobSeeker.do?idx=" + idx , "구직자 검색","width=1500, height=1000, left=200, top=300");
	}

	function fn_selectEntList(){
		window.open("/selectEntList.do?isChecked=I", "기업 검색","width=1500, height=1000, left=200, top=300");
	}

    function setEntInfo(entId, entNm, entOwner, entNo, entType, createDt){
		$('#entId').val(entId);
		$('#entNm').val(entNm);
		$('#entOwner').val(entOwner);
		$('#entNo').val(entNo);
		$('#entType').val(entType);
		$('#creatDt').val(createDt);
	}

	function fn_dataDelEnt(){
		$('#entId').val('');
		$('#entNm').val('');
		$('#entOwner').val('');
		$('#entNo').val('');
		$('#entType').val('');
		$('#creatDt').val('');
	}

	function setInfo(){

	}

	//취업자 추가
	function fn_addUser(){
		userIndex++;
		var htmlStr = "";

		htmlStr += "<div id=\"insertEachListDiv_" + userIndex + "\" class=\"mb20\">";
		htmlStr += "	<div class=\"alert alert-success\" style=\"margin-bottom:0px;\">";
		htmlStr += "		<strong><span class=\"glyphicon glyphicon-info-sign\"></span> 고용정보 (신규)</strong>";
		htmlStr += "		<button type=\"button\" class=\"btn btn-danger\" style=\"float:right;position:relative;top:-6px;\" onclick=\"fn_delUser(" + userIndex + ");return false;\"><i class=\"glyphicon glyphicon-minus\">삭제</i></button>";
		htmlStr += "	</div>";
		htmlStr += "	<table class=\"table table-striped table_lh\" summary=\"\" style=\"border:1px solid #ddd;\">";
		htmlStr += "		<caption class=\"hidden\">수상경력 (신규)</caption>";
		htmlStr += "		<colgroup>";
		htmlStr += "			<col style=\"width:15%;\" />";
		htmlStr += "			<col style=\"width:auto;\" />";
		htmlStr += "		</colgroup>";
		htmlStr += "		<tbody>";
		htmlStr += "			<input type=\"hidden\" name=\"insertEachList[" + userIndex + "].userId\" id=\"insertEachList_" + userIndex + "_userId\" class=\"form-control\" value=\"\" />";
		htmlStr += "			<tr>";
		htmlStr += "				<th scope=\"row\" class=\"reqBg\"><label for=\"insertEachList[" + userIndex + "].userNm\">취업자 이름</label> <span class=\"glyphicon glyphicon-ok red-color\"></span></th>";
		htmlStr += "				<td>";
		htmlStr += "					<input type=\"text\" name=\"insertEachList[" + userIndex + "].userNm\" id=\"insertEachList_" + userIndex + "_userNm\" class=\"form-control\" style=\"display:inline-block; width:20%\" value=\"\" readonly />";
		htmlStr += "					<button type=\"button\" class=\"btn btn-info\"  onclick=\"fn_selectJobSeeker(" + userIndex + ");return false;\">구직자 검색</button>";
		htmlStr += "					<button type=\"button\" class=\"btn btn-danger\"  onclick=\"fn_dataDel(" + userIndex + ");return false;\">구직자 삭제</button>";
		htmlStr += "				</td>";
		htmlStr += "			</tr>";
		htmlStr += "			<tr>";
		htmlStr += "				<th scope=\"row\" class=\"reqBg\"><label for=\"insertEachList[" + userIndex + "].userJumin\">주민등록번호</label> <span class=\"glyphicon glyphicon-ok red-color\"></span></th>";
		htmlStr += "				<td>";
		htmlStr += "					<input type=\"text\" name=\"insertEachList[" + userIndex + "].userJumin\" id=\"insertEachList_" + userIndex + "_userJumin\" class=\"form-control\" value=\"\" readonly />";
		htmlStr += "				</td>";
		htmlStr += "			</tr>";
		htmlStr += "			<tr class=\"form-inline\">";
		htmlStr += "				<th scope=\"row\" class=\"reqBg\"><label for=\"insertEachList[" + userIndex + "].incentive\">지원금액</label> <span class=\"glyphicon glyphicon-ok red-color\"></span></th>";
		htmlStr += "				<td>";
		htmlStr += "					<input type=\"text\" name=\"insertEachList[" + userIndex + "].incentive\" id=\"insertEachList_" + userIndex + "_incentive\" class=\"form-control\" onkeypress=\"fn_onlyNumber();\" value=\"0\" /> 원";
		htmlStr += "				</td>";
		htmlStr += "			</tr>";
		htmlStr += "		</tbody>";
		htmlStr += "	</table>";
		htmlStr += "</div>";

		$("#userListDiv").append(htmlStr);
	}

	//신규 취업자 삭제
		function fn_delUser(idx) {
		if(idx == userIndex){
			$("div#insertEachListDiv_" + idx).remove();
			userIndex--;
		}else{
			alert("마지막으로 추가된 버튼부터 삭제해야 합니다.");
		}
	}

	// 기존 등록된 취업자 삭제
	function fn_delDBUser(unqId) {
		HHCommon.Confirm('등록된 취업자를 삭제하시겠습니까?', function(confirm) {
			$("div#eachDiv_" + unqId).hide();
			var titleStr = $("div#eachDiv_" + unqId).find("input#eachList_" + unqId + "_userNm").val();
			var htmlStr = "";
			htmlStr += "<li class=\"label label-info pt5 pb5 mr5\">";
			htmlStr += "	<input type=\"hidden\" name=\"deleteEachList\" value=\"" + unqId + "\" />";
			htmlStr += "	<span>" + titleStr + "</span>&nbsp;&nbsp;";
			htmlStr += "	<button type=\"button\" class=\"btn btn-danger\" onclick=\"fn_restoreEach('" + unqId + "');return false;\"><i class=\"glyphicon glyphicon-repeat\"> 복구</i></button>";
			htmlStr += "</li>";
			if($("div#deleteEachDiv").find("ul.list-inline").find("li").length == 0) {
				$("div#deleteEachDiv").show();
			}
			$("div#deleteEachDiv").find("ul.list-inline").append(htmlStr);

		});
	}

	// 삭제된 취업자 복구
	function fn_restoreEach(unqId){
		$("div#eachDiv_" + unqId).show();
		$("input[name='deleteEachList'][value='" + unqId + "']").parent().remove();
		if($("div#deleteEachDiv").find("ul.list-inline").find("li").length == 0) {
			$("div#deleteEachDiv").hide();
		}
	}

	function fn_onlyNumber(){
		if((event.keyCode<48)||(event.keyCode>57))
		event.returnValue=false;
	}

	$(function() {

		HHCommon.NumberNotClear($('#landingJobNum'));
		HHCommon.NumberNotClear($('#incentiveTot'));

		$('a[href="#fn_list"]').bind('click', function() {
			fn_list($('#listForm'));
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


	});
</script>
<div id="container">
	<!-- 기본정보 include -->
	<c:import url="/WEB-INF/jsp/egovframework/storyCms/sys/include/top.jsp"></c:import>
	<div id="contentarea">
		<form:form commandName="searchVO" name="listForm" id="listForm" action="./list.do?mId=${mId}" methodParam="post">
			<form:hidden path="searchTxt"/>
			<form:hidden path="searchType"/>
			<form:hidden path="page"/>
		</form:form>
		<c:set var="acitonUrl" value="./insertProc.do?mId=${mId}" />
		<c:if test="${not empty resultVO.unqId }">
			<c:set var="acitonUrl" value="./updateProc.do?mId=${mId}" />
		</c:if>
		<form id="insertForm" name="insertForm" action="${acitonUrl}" method="post" onsubmit="return validator(this);" enctype="multipart/form-data">
		<c:if test="${not empty resultVO.unqId }">
			<input type="hidden" name="unqId" value="<c:out value="${resultVO.unqId}"/>" />
		</c:if>
		<input type="hidden" name="userId" id="userId" value="" />
		<input type="hidden" name="entId" id="entId" value="<c:out value="${resultVO.entId}" />" />
		<input type="hidden" name="page" value="${searchVO.page}" />
		<input type="hidden" name="searchTxt" value="${searchVO.searchTxt}" />
		<input type="hidden" name="searchType" value="${searchVO.searchType}" />
			<div class="contents">
				<div class="page-header">
					<h2><span class="glyphicon glyphicon-info-sign"></span> <c:out value="${curSysMenuNm}"/> 등록</h2>
					<div class="requiredField">
						<small><span class="glyphicon glyphicon-ok red-color"></span>는 필수 입력사항입니다.</small>
					</div>
				</div>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-tag"></span> 기본정보</h3>
					</div>
		  			<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table_lh" summary="">
								<caption><c:out value="${curSysMenuNm}"/> 등록</caption>
								<colgroup>
									<col style="width:15%;" />
									<col style="width:auto;" />
								</colgroup>
								<tbody>
							        <tr class="form-inline">
										<th scope="row"><label for="bisYear">사업연도</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<c:set var="now" value="<%=new java.util.Date()%>" />
											<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
											<select name="bisYear" id="bisYear" title="사업연도" class="form-control">
												<c:forEach var="bisYearVO" items="${bisYear}" varStatus="status">
													<option value="<c:out value="${bisYearVO.code}" />"  <c:if test="${sysYear eq bisYearVO.code}">selected="selected"</c:if> ><c:out value="${bisYearVO.codeNm}" /></option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-tag"></span> 기업정보</h3>
					</div>
		  			<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table_lh" summary="">
								<caption><c:out value="${curSysMenuNm}"/> 등록</caption>
								<colgroup>
									<col style="width:15%;" />
									<col style="width:auto;" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="entNm">기업명</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="entNm" id="entNm" value="<c:out value="${resultVO.entNm}" />" class="form-control" style="display:inline-block; width:20%;" readonly />
											<button type="button" value="기업검색" class="btn btn-info" onclick="fn_selectEntList();return false;">
												<i class="glyphicon glyphicon-trash"></i>
												<span>기업 검색</span>
											</button>
											<button type="button" value="기업삭제" class="btn btn-danger" onclick="fn_dataDelEnt();return false;">
												<i class="glyphicon glyphicon-trash"></i>
												<span>기업 삭제</span>
											</button>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="entOwner">대표자</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="entOwner" id="entOwner" value="<c:out value="${resultVO.entOwner}" />"class="form-control" readonly />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="entNo">사업자등록번호</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="entNo" id="entNo" value="<c:out value="${resultVO.entNo}" />" class="form-control" readonly />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="entType">업종</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="entType" id="entType" class="form-control" value="<c:out value="${resultVO.codeNm}"/>" readonly/>
										</td>
									</tr>
									<!-- 고용정보 -->
									<tr class="form-inline">
										<th scope="row"><label for="landingJobNum">취업인원</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<c:out value="${resultVO.landingJobNum}" /> 명
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- 고용정보 -->
				<div class="panel panel-info">
				  	<div class="panel-heading">
				  		<h3 class="panel-title"><span class="glyphicon glyphicon-tag"></span> 고용정보</h3>
				  		<button type="button" class="btn btn-info" style="float:right;position:relative;top:-29px;" onclick="fn_addUser();return false;"><i class="glyphicon glyphicon-plus">추가</i></button>
				  	</div>
				  	<div id="userListDiv" class="panel-body">
				  		<c:forEach var="eachVO" items="${resultVO.eachList}" varStatus="status">
				  		<div id="eachDiv_${eachVO.eachUnqId}" class="mb20">
				  			<input type="hidden" name="eachList[${status.index}].unqId" id="eachList_${eachVO.unqId}_unqId" value="<c:out value="${eachVO.unqId}"/>" />
				  			<input type="hidden" name="eachList[${status.index}].userId" id="eachList_${eachVO.eachUnqId}_userId" value="<c:out value="${eachVO.userId}"/>" />
				  			<input type="hidden" name="eachList[${status.index}].eachUnqId" id="eachList_${eachVO.eachUnqId}_eachUnqId" value="<c:out value="${eachVO.eachUnqId}"/>" />
					  		<div class="alert alert-success" style="margin-bottom:0px;">
								<strong><span class="glyphicon glyphicon-info-sign"></span> 고용정보</strong>
								<button type="button" class="btn btn-danger" style="float:right;position:relative;top:-6px;" onclick="fn_delDBUser('<c:out value="${eachVO.eachUnqId}"/>');return false;"><i class="glyphicon glyphicon-minus">삭제</i></button>
							</div>
							<table class="table table-striped table_lh" summary="" style="border:1px solid #ddd;">
								<caption>고용정보</caption>
								<colgroup>
									<col style="width:15%;" />
									<col style="width:auto;" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="reqBg"><label for="eachList[${status.index}].userNm">취업자 이름</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="eachList[${status.index}].userNm" id="eachList_${eachVO.eachUnqId}_userNm" class="form-control" style="display:inline-block; width:20%;" value="<c:out value="${eachVO.userNm}"/>" readonly />
										</td>
									</tr>
									<tr>
										<th scope="row" class="reqBg"><label for="eachList[${status.index}].userJumin">주민등록번호</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="eachList[${status.index}].userJumin" id="eachList_${eachVO.eachUnqId}_userJumin" class="form-control" value="<c:out value="${eachVO.userJumin}"/>" readonly />
										</td>
									</tr>
									<tr>
										<th scope="row" class="reqBg"><label for="eachList[${status.index}].incentive">지원금액</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<input type="text" name="eachList[${status.index}].incentive" id="eachList_${eachVO.eachUnqId}_incentive" class="form-control" value="<c:out value="${eachVO.incentive}"/>" readonly />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						</c:forEach>
					</div>
				</div>

				<div id="deleteEachDiv" class="panel panel-danger" style="display:none;">
				  	<div class="panel-heading">
				  		<h3 class="panel-title"><span class="glyphicon glyphicon-tag"></span> 삭제된 고용정보</h3>
				  	</div>
				  	<div class="panel-body">
				  		<ul class="list-inline">
				        </ul>
				  	</div>
				</div>

				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-tag"></span> 지원금액</h3>
					</div>
		  			<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table_lh" summary="">
								<caption class="hidden"><c:out value="${curSysMenuNm}"/> 등록</caption>
								<colgroup>
									<col style="width:15%;" />
									<col style="width:auto;" />
								</colgroup>
								<tbody>
									<!-- 지원금액 -->
									<tr class="form-inline">
										<th scope="row"><label for="incentiveTot">지원금액(합산)</label> <span class="glyphicon glyphicon-ok red-color"></span></th>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${resultVO.incentiveTot}" /> 원
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>


		  		<div id="buttonFieldSet">
		  			<a class="btn btn-default" href="#fn_list" role="button">
		  				<span class="glyphicon glyphicon-th-list"></span>
		                <span><spring:message code="button.list" /></span>
					</a>
		  			<button type="submit" class="btn btn-info">
			  			<i class="glyphicon glyphicon-ok-circle"></i>
		                <span><spring:message code="button.save" /></span>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
