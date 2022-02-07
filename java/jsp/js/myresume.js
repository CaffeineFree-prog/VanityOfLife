
	function fn_readImage(input, expression){
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(expression).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	function fn_deleteDBresume(obj, UnqId , esntlId){
		
		$.ajax({
			url : '',
			type : 'POST',
			data : { dvsnUnqId : UnqId  , esntlId : esntlId }, 
			success : function(){
				$(obj).parent().parent().parent().parent().parent().remove();
			},
			error		: function(xhr){
				alert(xhr.status + "," + xhr.statusTest);
			}
		});
		
	}



	function fn_deleteAdbgStatus(idx){
		
		if(idx == edbgIndex){
			$("input[name='acbgVOList[" + idx + "].acbgInstNm']").parent().parent().parent().parent().remove();
			edbgIndex--;
		}else{
			alert("마지막으로 추가된 신규 학력부터 삭제해야 합니다.");
		}

	}
	
	function fn_addWorkExpStatus(){
		workExIndex++;
		
		var addWorkStr = "";
		
		addWorkStr += "		<ul class=\"sp3d_inner\"> " ;
		addWorkStr += "		<li>" ;
		addWorkStr += "			<dl> " ;
		addWorkStr += "				<dt><label for=\"workexpVOList[" + workExIndex + "].companyNm\">회사명</label></dt>" ;
		addWorkStr += "				<dd>" ;
		addWorkStr += "					<input type=\"text\" name=\"workexpVOList[" + workExIndex + "].companyNm\" id=\"workexpVOList[" + workExIndex + "].companyNm\" class=\"sp3d_bsize1\"  />" ;
		addWorkStr += "				</dd>";
		addWorkStr += "			</dl>" ;
		addWorkStr += "		</li>" ;
		addWorkStr += "		<li>" ;
		addWorkStr += "			<dl>" ;
		addWorkStr += "				<dt class=\"thbtn_dt\">근무기간</dt>" ;
		addWorkStr += "				<dd>" ;
		addWorkStr += "					<label for=\"workexpVOList[" + workExIndex + "].workStartDt\" class=\"blind\">시작일</label>" ;
		addWorkStr += "					<input type=\"text\" name=\"workexpVOList[" + workExIndex + "].workStartDt\" id=\"workexpVOList[" + workExIndex + "].workStartDt\" class=\"sp3d_bsize2 datepicker\" maxlength=\"10\" placeholder=\"YYYY-MM-DD\" readonly />" ;
		addWorkStr += "					~" ;
		addWorkStr += "					<label for=\"workexpVOList[" + workExIndex + "].workEndDt\" class=\"blind\">퇴사일</label>" ;
		addWorkStr += "					<input type=\"text\" name=\"workexpVOList[" + workExIndex + "].workEndDt\" id=\"workexpVOList[" + workExIndex + "].workEndDt\" class=\"sp3d_bsize2 datepicker\" maxlength=\"10\" placeholder=\"YYYY-MM-DD\" readonly  />" ;
		addWorkStr += "				</dd>" ;
		addWorkStr += "			</dl>" ;
		addWorkStr += "		</li>" ;
		addWorkStr += "		<li>" ;
		addWorkStr += "			<dl>" ;
		addWorkStr += "				<dt><label for=\"workexpVOList[" + workExIndex + "].deptJbgdNm\">부서/직급</label></dt>" ;
		addWorkStr += "				<dd>" ;
		addWorkStr += "					<input type=\"text\" name=\"workexpVOList[" + workExIndex + "].deptJbgdNm\" id=\"workexpVOList[" + workExIndex + "].deptJbgdNm\" class=\"sp3d_bsize1\" />" ;
		addWorkStr += "				</dd>" ;
		addWorkStr += "			</dl>" ;
		addWorkStr += "		</li>" ;
		addWorkStr += "		<li>" ;
		addWorkStr += "			<dl>" ;
		addWorkStr += "				<dt><label for=\"workexpVOList[" + workExIndex + "].workCn\">담당업무</label></dt>" ;
		addWorkStr += "				<dd>" ;
		addWorkStr += "					<input type=\"text\" name=\"workexpVOList[" + workExIndex + "].workCn\" id=\"workexpVOList[" + workExIndex + "].workCn\" class=\"sp3d_bsize1\"  />" ;
		addWorkStr += "				</dd>"; 
		addWorkStr += "			</dl>";
		addWorkStr += "		</li>";
		addWorkStr += "		<li>";
		addWorkStr += "			<dl>";
		addWorkStr += "				<dt class=\"thbtn_dt del_btn\">관리</dt>";
		addWorkStr += "				<dd>";
		addWorkStr += "					<button type=\"button\" onclick=\"fn_deleteWorkExpStatus('" + workExIndex + "');\" class=\"bd_btn\"><span>삭제</span></button>" ;
		addWorkStr += "				</dd>";
		addWorkStr += "			</dl>";
		addWorkStr += "		</li>";
		addWorkStr += "	</ul>";
		
		$('#addWorkExpStatus').append(addWorkStr);
		
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
	
	function fn_deleteWorkExpStatus(idx){
		
		if(idx == workExIndex){
			$("input[name='workexpVOList[" + idx + "].companyNm']").parent().parent().parent().parent().remove();
			workExIndex--;
		}else{
			alert("마지막으로 추가된 신규 경력부터 삭제해야 합니다.");
		}
		
	}
	
	function fn_addCertificate(){
		certIndex++;
		
		var addCertStr = "";
		
		addCertStr += "<ul class=\"sp4d_inner\">";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt><label for=\"certificateVOList[" + certIndex + "].certType\">구분</label></dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<select name=\"certificateVOList[" + certIndex + "].searchTypeEtc1\" id=\"certificateVOList[" + certIndex + "].searchTypeEtc1\" onchange=\"fn_selectBox( this.value ,'"+ certIndex + "');\" >";
		addCertStr += "						<option value=\"\"	>선택</option>";
		addCertStr += "						<option value=\"어학\"	>어학</option>";
		addCertStr += "						<option value=\"자격증\">자격증</option>";
		addCertStr += "						<option value=\"면허\"	>면허</option>";
		addCertStr += "						<option value=\"수료증\">수료증</option>";
		addCertStr += "					</select>";
		addCertStr += "					<select name=\"certificateVOList[" + certIndex + "].certType\" id=\"certificateVOList[" + certIndex + "].certType\"  >";
		addCertStr += "					</select>";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt><label for=\"certificateVOList[" + certIndex + "].certNm\">자격증명/면허명/교육이수명</label></dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<input type=\"text\" name=\"certificateVOList[" + certIndex + "].certNm\" id=\"certificateVOList[" + certIndex + "].certNm\" class=\"sp4d_bsize1\" />";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt><label for=\"certificateVOList[" + certIndex + "].certScore\">급수/어학점수</label></dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<input type=\"text\" name=\"certificateVOList[" + certIndex + "].certScore\" id=\"certificateVOList[" + certIndex + "].certScore\" class=\"sp4d_bsize1\"  />";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt><label for=\"certificateVOList[" + certIndex + "].issuInstNm\">발급기관</label></dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<input type=\"text\" name=\"certificateVOList[" + certIndex + "].issuInstNm\" id=\"certificateVOList[" + certIndex + "].issuInstNm\" class=\"sp4d_bsize1\"  />";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt><label for=\"certificateVOList[" + certIndex + "].issuDt\">취득일</label></dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<input type=\"text\" name=\"certificateVOList[" + certIndex + "].issuDt\" id=\"certificateVOList[" + certIndex + "].issuDt\" class=\"sp4d_bsize1 datepicker\"  maxlength=\"10\" placeholder=\"YYYY-MM-DD\" readonly />";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "		<li>";
		addCertStr += "			<dl>";
		addCertStr += "				<dt class=\"thbtn_dt del_btn\">관리</dt>";
		addCertStr += "				<dd>";
		addCertStr += "					<button type=\"button\" onclick=\"fn_deleteCertificate('" + certIndex + "');\" class=\"bd_btn\"><span>삭제</span></button>";
		addCertStr += "				</dd>";
		addCertStr += "			</dl>";
		addCertStr += "		</li>";
		addCertStr += "	</ul>";
		
		$('#addCertificate').append(addCertStr);
		
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
	
	function fn_deleteCertificate(index){
		
		if(index == certIndex){
			$("input[name='certificateVOList[" + index + "].certNm']").parent().parent().parent().parent().remove();
			certIndex--;
		}else{
			alert("마지막으로 추가된 신규 자격증부터 삭제해야 합니다.");
		}
		
	}
	
	function fn_addEca(){
		ecaIndex++;
		
		var addEcaStr = "";
		
		addEcaStr += "	<ul class=\"sp5d_inner\">";
		addEcaStr += "		<li>";
		addEcaStr += "			<dl>";
		addEcaStr += "				<dt><label for=\"ecaVOList[" + ecaIndex + "].ecaInstNm\">기관/장소</label></dt>";
		addEcaStr += "				<dd>";
		addEcaStr += "					<input type=\"text\" name=\"ecaVOList[" + ecaIndex + "].ecaInstNm\" id=\"ecaVOList[" + ecaIndex + "].ecaInstNm\" class=\"sp5d_bsize1\" />";
		addEcaStr += "				</dd>";
		addEcaStr += "			</dl>";
		addEcaStr += "		</li>";
		addEcaStr += "		<li>";
		addEcaStr += "			<dl>";
		addEcaStr += "				<dt class=\"thbtn_dt\">기간</dt>";
		addEcaStr += "				<dd>";
		addEcaStr += "					<label for=\"ecaVOList[" + ecaIndex + "].ecaStartDt\" class=\"blind\">시작일</label>";
		addEcaStr += "					<input type=\"text\" name=\"ecaVOList[" + ecaIndex + "].ecaStartDt\" id=\"ecaVOList[" + ecaIndex + "].ecaStartDt\" class=\"sp5d_bsize2 datepicker\" maxlength=\"10\" placeholder=\"YYYY-MM-DD\"  readonly />";
		addEcaStr += "					~";
		addEcaStr += "					<label for=\"ecaVOList[" + ecaIndex + "].ecaEndDt\" class=\"blind\">마감일</label>";
		addEcaStr += "					<input type=\"text\" name=\"ecaVOList[" + ecaIndex + "].ecaEndDt\" id=\"ecaVOList[" + ecaIndex + "].ecaEndDt\" class=\"sp5d_bsize2 datepicker\"  maxlength=\"10\" placeholder=\"YYYY-MM-DD\"   readonly />";
		addEcaStr += "				</dd>";
		addEcaStr += "			</dl>";
		addEcaStr += "		</li>";
		addEcaStr += "		<li>";
		addEcaStr += "			<dl>";
		addEcaStr += "				<dt><label for=\"ecaVOList[" + ecaIndex + "].ecaCn\">내용</label></dt>";
		addEcaStr += "				<dd>";
		addEcaStr += "					<input type=\"text\" name=\"ecaVOList[" + ecaIndex + "].ecaCn\" id=\"ecaVOList[" + ecaIndex + "].ecaCn\" class=\"sp5d_bsize1\" />";
		addEcaStr += "				</dd>";
		addEcaStr += "			</dl>";
		addEcaStr += "		</li>";
		addEcaStr += "		<li>";
		addEcaStr += "			<dl>";
		addEcaStr += "				<dt class=\"thbtn_dt del_btn\">관리</dt>";
		addEcaStr += "				<dd>";
		addEcaStr += "					<button type=\"button\" onclick=\"fn_deleteEca('" + ecaIndex + "');\" class=\"bd_btn\"><span>삭제</span></button>";
		addEcaStr += "				</dd>";
		addEcaStr += "			</dl>";
		addEcaStr += "		</li>";
		addEcaStr += "	</ul>";
		
		$('#addEca').append(addEcaStr);
		
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
	
	function fn_deleteEca(index){
		
		if(index == ecaIndex){
			$("input[name='ecaVOList[" + index + "].ecaInstNm']").parent().parent().parent().parent().remove();
			ecaIndex--;
		}else{
			alert("마지막으로 추가된 신규 대외활동부터 삭제해야 합니다.");
		}
		
	}
	
	/*항목추가랑 삭제 버튼 끝 */
	
	/*보유자격증 구분값*/
	function fn_selectBox(certType1, index){
			
		$("select[name='certificateVOList["+ index+"].certType']").empty();
		
		if(certType1 == '어학'){
			var languageStr = "";
			for(var i=0;i<language.length;i++){
				var vo = language[i];
				languageStr += "<option value=\"" + vo.code + "\">" + vo.codeNm + "</option>";
			}
			
			$("select[name='certificateVOList["+ index+"].certType']").append(languageStr);
			
		} else if (certType1 == '자격증'){
			var certStr = "";
			for(var i=0;i<certificate.length;i++){
				var vo = certificate[i];
				certStr += "<option value=\"" + vo.code + "\">" + vo.codeNm + "</option>";
			}
			
			$("select[name='certificateVOList["+ index+"].certType']").append(certStr);
			
		} else if (certType1 == '면허'){
			var driverStr = "";
			for(var i=0;i<driver.length;i++){
				var vo = driver[i];
				driverStr += "<option value=\"" + vo.code + "\">" + vo.codeNm + "</option>";
			}
			
			$("select[name='certificateVOList["+ index+"].certType']").append(driverStr);
			
		} else if (certType1 == '수료증'){
			var suryo = "<option value=\"01\">수료증</option>";
			
			$("select[name='certificateVOList["+ index+"].certType']").append(suryo);
		}
		
	}
	
	function fn_occupationInit(){
		$("#firstOccupation option").remove();
		var htmlStr = "<option value=\"\">1차직종</option>";
		for(var i=0;i<jobListJson.length;i++){
			var vo = jobListJson[i];
			if(vo.occupationLevel == 1){
				htmlStr += "<option value=\"" + vo.occupationId + "\">" + vo.occupationNm + "</option>";
			}
		}
		$("#firstOccupation").append(htmlStr);

		$("#secondOccupation option").remove();
		var htmlStr2 = "<option value=\"\">2차직종</option>";
		$("#secondOccupation option").append(htmlStr2);

		$("#thirdOccupation option").remove();
		var htmlStr3 = "<option value=\"\">3차직종</option>";
		$("#thirdOccupation option").append(htmlStr3);
	}

	function fn_occupationSecondList(){
		if($("#firstOccupation").val()){
			$("#secondOccupation option").remove();
			$("#thirdOccupation option").remove();

			var htmlStr = "<option value=\"\">2차직종</option>";
			for(var i=0;i<jobListJson.length;i++){
				var vo = jobListJson[i];
				if(vo.occupationLevel == 2 && vo.occupationParentId == $("#firstOccupation").val()){
					htmlStr += "<option value=\"" + vo.occupationId + "\">" + vo.occupationNm + "</option>";
				}
			}
			$("#secondOccupation").append(htmlStr);
		}
	}

	function fn_occupationThirdList(){
		if($("#secondOccupation").val()){
			$("#thirdOccupation option").remove();

			var htmlStr = "<option value=\"\">3차직종</option>";
			for(var i=0;i<jobListJson.length;i++){
				var vo = jobListJson[i];
				if(vo.occupationLevel == 3 && vo.occupationParentId == $("#secondOccupation").val()){
					htmlStr += "<option value=\"" + vo.occupationId + "\">" + vo.occupationNm + "</option>";
				}
			}
			$("#thirdOccupation").append(htmlStr);
		}
	}
    
	function fn_handleOnChange() {
		if($("#selectValue li").length < 5) {
			var select = $("select[name=thirdOccupation]").val();
			var selList = $("input[name=searchSortList]");
			var str = "";
			for(var i=0;i<jobListJson.length;i++){
				var vo = jobListJson[i];
				if(vo.occupationLevel == 3 && vo.occupationId == select){
					// 중복체크
					if(selList.length > 0) {
						for(var j=0;j<=selList.length;j++) {
							if(select != $("input[name=searchSortList]").eq(j).val()) {
								str = "<li><input type=\"hidden\" name=\"searchSortList\" value='" + select + "' /><span>" + vo.occupationNm + "</span><a class=\"sel_delete\" style=\"cursor:pointer;\">삭제</a></li>";
							} else {
								return false;
							}
						}
					} else {
						str = "<li><input type=\"hidden\" name=\"searchSortList\" value='" + select + "' /><span>" + vo.occupationNm + "</span><a class=\"sel_delete\" style=\"cursor:pointer;\">삭제</a></li>";
					}
				}
			}
			$("#selectValue").append(str);
		} else {
			alert("직종은 최대 5개까지 선택하실 수 있습니다.");
			return false;
		}
	}
	
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo) {
		var addr = roadAddrPart1 + " " + roadAddrPart2 + " " + addrDetail ;
		$('#roadNmAddr').val(roadAddrPart1 + " " + roadAddrPart2 + " " + addrDetail);
	}
	
	$(function() {
		
	});
	
	
