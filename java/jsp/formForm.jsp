<form:form commandName="searchVO" name="listForm" id="listForm" action="./list.do?mId=${mId}" methodParam="post">
	<form:hidden path="searchTxt"/>
	<form:hidden path="searchType"/>
	<form:hidden path="searchTypeEtc1"/>
	<form:hidden path="page"/>
</form:form>
