 



	String years = request.getParameter("year")==null?"":request.getParameter("year");

	String month = request.getParameter("month")==null?"":request.getParameter("month");

	

	Calendar cal = Calendar.getInstance();

	

	int mon = cal.get(Calendar.MONTH) + 1;

	if(!month.equals("")){ mon = Integer.parseInt(month); }

	

	int year = cal.get(Calendar.YEAR);

	if(!years.equals("")){ year = Integer.parseInt(years); }

	

	int day = cal.get(Calendar.DAY_OF_MONTH);



	int nextMont = mon + 1;

	int nextYear = year;

	if(nextMont > 12){ nextMont=1; nextYear=year+1; }

	

	int prevMont = mon - 1;

	int prevYear = year;

	if(prevMont < 1){ prevMont=12; prevYear=year-1; }

	

	// 해당월 마지막 일수

	Calendar todayMonthCal = Calendar.getInstance();

	todayMonthCal.set(year, (mon-1), 1);

	int daysOfMonth = todayMonthCal.getActualMaximum(Calendar.DAY_OF_MONTH);

	

	// 해당월 이전 달의 마지막 일수

	Calendar preMonthCal = Calendar.getInstance();

	preMonthCal.set(year, (mon-2), 1);

	int prevDaysOfMonth = preMonthCal.getActualMaximum(Calendar.DAY_OF_MONTH);

	

	// 해당월 1일 요일 구하기

	Calendar fweek = Calendar.getInstance();

	fweek.set(Calendar.YEAR, year);

	fweek.set(Calendar.MONTH, mon-1);

	fweek.set(Calendar.DATE, 1);

	int firstDay = fweek.get(Calendar.DAY_OF_WEEK)-1;

	

	long nDate = 0;

	long cDate = 0;

	long bDate = 0;



---------------------------------------------------------------------------------



<%

	ServletContext servletContext = getServletContext();

	WebApplicationContext waContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);

	Service service = (Service) waContext.getBean("Service");

	

	// 당월 달력에서 이전달의 일자가 시작하는 수

	int start_previousDate = (prevDaysOfMonth - firstDay) + 1;

	

	// 첫번째 공란 날짜

	for(int w=0; w<firstDay; w++) { 

		out.println("<td><span class=\"no_day\"><b>" + start_previousDate + "</b></span></td>");

		start_previousDate++;

	} 

	

	SimpleDateFormat dfhm = new SimpleDateFormat("yyyyMMdd");	 

	

	Calendar AfterDate = Calendar.getInstance();

	Calendar BeforeDate = Calendar.getInstance();

	

	int sy = AfterDate.get(Calendar.YEAR);

	int sm = AfterDate.get(Calendar.MONTH);

	int sd = AfterDate.get(Calendar.DAY_OF_MONTH);

	int year2, month2, day2 = 0;

	

	// 오늘 날짜에서 1년뒤를 구하기 위함

	AfterDate.set(sy +1 , sm , sd);

	BeforeDate.set(sy, sm , sd);

	

	Calendar chkDate = Calendar.getInstance();	

	

	// 1년 뒤 날짜

	nDate = dfhm.parse(dfhm.format(AfterDate.getTime())).getTime();

	

	// 오늘 날짜 이전

	bDate = dfhm.parse(dfhm.format(BeforeDate.getTime())).getTime();

	

	for(int i=1; i<=daysOfMonth; i++){

		String isDate = "";

		isDate = Integer.toString(year);

		

		if(mon < 10){ isDate += "0"+Integer.toString(mon); }

		else{ isDate += Integer.toString(mon); }

		if(i<10){ isDate += "0"+Integer.toString(i); }

		else{ isDate += Integer.toString(i); }

		

		year2 = Integer.parseInt(isDate.substring(0, 4));

		month2 = Integer.parseInt(isDate.substring(4, 6));

		day2 = Integer.parseInt(isDate.substring(6, 8));

		

		chkDate.set(year2, month2 -1, day2);

		

		// SdateLink 변환

		cDate = dfhm.parse(dfhm.format(chkDate.getTime())).getTime();

		pageContext.setAttribute("isDate", isDate);

		

		VO O = new VO();

		O.setDesigDate(isDate);

		List<VO> List = service.isDateList(O);

		pageContext.setAttribute("List", List);

		

	%>

<td>

	<b><%=i%></b>

	<div class="day_schedule_box">

		<c:if test="${not empty List}">

			<ul>						

				<c:forEach items="${unitClteList}" var="unitClteList" varStatus="status">	

				</c:forEach>

			</ul>

		</c:if>

		

	</div>

</td>						

	<%

		if(firstDay != 6) ++firstDay;

		else firstDay = 0;

	

		if(firstDay == 0) {

			out.println("</tr>");

			if(i <= daysOfMonth) out.println("<tr>");

			firstDay=0;

		}

	}

	

	// 마지막 공란 날짜

	if (firstDay != 0) {

		int lastDay = 1;

		for(int w=firstDay;w<7;w++) { 

			out.println("<td><span class=\"no_day\"><b>" + lastDay + "</b></span></td>");

			lastDay++;

		} 

	}

	%>

	
