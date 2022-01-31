<script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<script>

  function fn_selectBox(searchDvsn1){

		$('#searchType1').find("option").remove();
		$('#searchType2').find("option").remove();
		$('#searchType3').find("option").remove();
    
		var str1 = '';
		str1 += '<option value="">선택</option>' ;
		$('#searchType1').append(str1);
		$('#searchType2').append(str1);
		$('#searchType3').append(str1);

		$.ajax({
			type 		: 'POST',
			url  		: '/searchDvsn1.do' ,
			data		:  {
				searchDvsn1 : searchDvsn1
			},
			success : function(result){
				var resultMap = JSON.parse(result);
				$.each(resultMap, function (key, value){
					if(key == 'Dvsn1'){
						var str2 = '';
						for (var i = 0 ; i < value.length ; i ++){
							str2 += '<option value="'+ value[i].code +'" <c:if test="${searchVO.searchType1 eq '+ value[i].code +'}"> selected="selected"	</c:if>>'+ value[i].codeNm +'</option>' ; 
						}
						$('#searchType1').append(str2);

					}					

					if(key == 'Dvsn2'){
						var str2 = '';
						for (var i = 0 ; i < value.length ; i ++){
							str2 += '<option value="'+ value[i].code +'" <c:if test="${searchVO.searchType2 eq '+ value[i].code +'}"> selected="selected"	</c:if>>'+ value[i].codeNm +'</option>' ; 
						}
						$('#searchType2').append(str2);

					}

					if(key == 'sList'){
            var str2 = '';
						for (var i = 0 ; i < value.length ; i ++){
							str2 += '<option value="'+ value[i].code +'" <c:if test="${searchVO.searchType3 eq '+ value[i].code +'}"> selected="selected"	</c:if> >'+ value[i].codeNm +'</option>' ; 
						}
						$('#searchType3').append(str2);

					}

				})
			}
		});
    
	}
  
  $(document).ready(function(){

  });
  
</script>

<fieldset class="board_search">

<legend class="hidden">검색</legend>

  <div class="form-group form-inline">

    <select name="searchDvsn1" id="searchDvsn1" class="form-control" onchange="fn_selectBox(this.value)" style="width: 150px">

      <option value=""		<c:if test="${searchVO.searchDvsn1 eq ''}"> selected="selected"			</c:if>>선택</option>

      <option value="A"	<c:if test="${searchVO.searchDvsn1 eq 'A'}"> selected="selected"	</c:if>>A</option>

      <option value="B"	<c:if test="${searchVO.searchDvsn1 eq 'B'}"> selected="selected"	</c:if>>B</option>

      <option value="C"	<c:if test="${searchVO.searchDvsn1 eq 'C'}"> selected="selected"		</c:if>>C</option>

      <option value="D"	<c:if test="${searchVO.searchDvsn1 eq 'D'}"> selected="selected"	</c:if>>D</option>

      <option value="E"<c:if test="${searchVO.searchDvsn1 eq 'E'}"> selected="selected"	</c:if>>E</option>

    </select>

    <select name="searchType1" id="searchType1" class="form-control" style="width: 180px">

      <option value=""> 선택 </option>

      <c:forEach items="${Dvsn1}" var="Dvsn1" varStatus="status">

        <option value="${Dvsn1.code}"	<c:if test="${searchVO.searchType1 eq Dvsn1.code }"> selected="selected"	</c:if>>${Dvsn1.codeNm}</option>

      </c:forEach>

    </select>

    <select name="searchType2" id="searchType2" class="form-control" style="width: 150px">

      <option value=""> 선택 </option>

      <c:forEach items="${Dvsn2}" var="Dvsn2" varStatus="status">

        <option value="${Dvsn2.code}"	<c:if test="${searchVO.searchType2 eq Dvsn2.code }"> selected="selected"	</c:if>>${Dvsn2.codeNm}</option>

      </c:forEach>

    </select>

    <select name="searchType3" id="searchType3" class="form-control" style="width: 150px">

      <option value=""> 선택 </option>

      <c:forEach items="${sList}" var="sList" varStatus="status">

        <option value="${sList.code}"	<c:if test="${searchVO.searchType3 eq sList.code }"> selected="selected"	</c:if>>${sList.codeNm}</option>

      </c:forEach>

    </select>

  <select name="searchType" id="searchType" title="검색조건선택" class="form-control">

    <option value="TITLE"<c:if test="${searchVO.searchType eq 'TITLE'}"> selected="selected"</c:if>>제목</option>

  </select>

    <input type="text" id="searchTxt" name="searchTxt" value="<c:out value="${searchVO.searchTxt}" />" class="form-control" />

    <button type="submit" onclick="fn_search();return false;" class="btn btn-default">

      <i class="glyphicon glyphicon-search"></i>

      <span><spring:message code="button.inquire" /></span>

  </button>

</div>

</fieldset>
