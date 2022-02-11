/*	
  function fn_selectData(){
		window.open("/selectData.do", "데이터 선택","width=1500, height=600, left=200, top=300");
	}

	HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = rmndtrvlMngService.getSelectBoxData(searchVO);
		if (resultMap != null){
			model.addAttribute("Dvsn1", resultMap.get("Dvsn1"));
			model.addAttribute("Dvsn2", resultMap.get("Dvsn2"));
			model.addAttribute("sggList", resultMap.get("sggList"));
	}
*/

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/storyCms/common/jsp/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">

	function goPage(curPage) {
	    var frm = document.getElementById('listForm');
	    frm.page.value = curPage;
	    frm.action = './selectData.do?mId=${mId}';
	    frm.submit();
	}
	
	function fn_search() {
	    var frm = document.getElementById('listForm');
	    frm.page.value = 1;
	    frm.action = './selectData.do?mId=${mId}';
	    frm.submit();
	}
	
	function fn_select(pstgDvsn, pstgUnqId, title){
		opener.setInfo(pstgDvsn, pstgUnqId, title);
		self.close();
	}
	
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
			url  		: './searchDvsn1.do' ,
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
					
					if(key == 'sggList'){
						
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
		
	$(function() {
		
		
	});

</script>
<div id="container">
	<div id="contentarea">
		<form id="listForm" name="listForm" action="./selectData.do?mId=${mId}" method="post">
		<input type="hidden" name="page" id="page" value="${page}" />

			<div class="contents">
				<div class="panel panel-default">
					<div class="panel-body">
						<fieldset class="board_search">
							<legend class="hidden">검색</legend>
								<div class="form-group form-inline">
									<select name="searchDvsn1" id="searchDvsn1" class="form-control" onchange="fn_selectBox(this.value)" style="width: 150px">
										<option value=""		<c:if test="${searchVO.searchDvsn1 eq ''}"> selected="selected"			</c:if>>선택</option>
										<option value="A"		<c:if test="${searchVO.searchDvsn1 eq 'A'}"> selected="selected"		</c:if>>A</option>
										<option value="B"		<c:if test="${searchVO.searchDvsn1 eq 'B'}"> selected="selected"		</c:if>>B</option>
										<option value="C"		<c:if test="${searchVO.searchDvsn1 eq 'C'}"> selected="selected"		</c:if>>C</option>
										<option value="D"		<c:if test="${searchVO.searchDvsn1 eq 'D'}"> selected="selected"		</c:if>>D</option>
										<option value="E"		<c:if test="${searchVO.searchDvsn1 eq 'E'}"> selected="selected"		</c:if>>E</option>
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
										<c:forEach items="${sggList}" var="sggList" varStatus="status">
											<option value="${sggList.code}"	<c:if test="${searchVO.searchType3 eq sggList.code }"> selected="selected"	</c:if>>${sggList.codeNm}</option>
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
					<div class="table-responsive">
							<div>총 게시글 수 : ${totalCnt}</div>
							<table class="table table-striped table-hover" summary="">
								<caption class="hidden"><c:out value="${curSysMenuNm}"/> 목록</caption>
								<thead>
									<tr>
										<th>선택 </th>
										<th>게시판 ID</th>
										<th>구분1</th>
										<th>구분2</th>
									    <th>시군구</th>
									    <th>제목</th>
									</tr>
								</thead>
								<tfoot>
 									<tr>
										<td colspan="9">
											<div class="pageingDiv">
												<c:if test="${not empty resultList}">
													<ui:pagination paginationInfo="${paginationInfo}" type="sys" jsFunction="goPage" />
												</c:if>
											</div>
										</td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${resultList }" var="list" varStatus="status">
									<tr>
										<td>
										<button type="button" class="btn btn-xs btn-primary" onclick="fn_select('<c:out value="${list.pstgDvsn}"/>','<c:out value="${list.pstgUnqId}"/>','<c:out value="${list.title}"/>');">
								  			<i class="glyphicon glyphicon-edit"></i>
						    				<span><spring:message code="button.confirm" /></span> 
										</button>
										</td>
										<td>${list.pstgDvsn}</td>
										<td>${list.dvsn1nm}</td>
										<td>${list.dvsn2nm}</td>
										<td>${list.sggNm}</td>
										<td>${list.title}</td>
									</tr>
									</c:forEach>
									<c:if test="${empty resultList}">
										<tr>
										<td colspan="9"><spring:message code="info.nodata.msg" /></td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div><!-- <div class="table-responsive"> -->
					</div><!-- <div class="panel-body" -->
				</div><!-- <div class="panel panel-default"> -->
			</div><!-- <div class="contents"> -->
		</form>
	</div><!-- <div id="contentarea"> -->
</div><!-- <div id="container"> -->
