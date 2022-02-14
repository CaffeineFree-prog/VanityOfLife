<c:set var="categoryChoiceStyle" value=" style=\"display:none;\""/>
<c:choose>
	<c:when test="${!empty smartMatchingVO.sort}">
		<c:set var="categoryChoiceStyle" value=""/>
	</c:when>
</c:choose>
<div class="category_choice" ${categoryChoiceStyle}>
	<ul id="selectValue">
		<c:if test="${!empty smartMatchingVO.sort}" >
		<c:set var="sortSplitList" value="${fn:split(smartMatchingVO.sort, '|')}" />
			<c:forEach var="tmpVO" items="${sortSplitList}" varStatus="searchStatus">
				<c:set var="loop_flag" value="false" />
				<c:forEach var="jobList" items="${jobList}" varStatus="status">
					<c:if test="${tmpVO eq jobList.occupationId  and not loop_flag }">
						<li><input type="hidden" value="${tmpVO}" name="searchSortList" /><span><c:out value="${jobList.occupationNm}"/></span><a class="sel_delete" style="cursor:pointer;">삭제</a></li>
						<c:set var="loop_flag" value="true" />
					</c:if>
				</c:forEach>
			</c:forEach>
		</c:if>
	</ul>
</div>
