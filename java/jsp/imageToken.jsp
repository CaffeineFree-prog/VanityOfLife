<c:forEach var="fileVO" items="${fileList}" varStatus="fileStatus">
	<c:set var="filename" value="${fileVO.orignlFileNm}" />
	<c:set var="fileNm" value="${fn:toLowerCase(filename)}" />
	<c:forTokens var="token" items="${fileNm}" delims="." varStatus="status">
		<c:if test="${status.last}">
			<c:choose>
				<c:when test="${token eq 'png' || token eq 'gif' || token eq 'jpg' || token eq 'jpeg' || token eq 'bmp'}">
					<img src="/getImage.do?atchFileId=<c:out value='${fileVO.atchFileId}'/>&amp;fileSn=<c:out value='${fileVO.fileSn}'/>" alt="<c:out value='${fileVO.orignlFileNm}'/>" onerror='this.src="${pageContext.request.contextPath}/icon_file.gif"' style="width:100%;">
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forTokens>
</c:forEach>
