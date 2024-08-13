<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<c:set var="month" value="${param.month}" />
<c:set var="sysday" value="${dateDAO.sysDay()}"/>
<c:set var="sysmonth" value="${dateDAO.sysMonth()}"/>
<c:set var="cal" value="${Cal.newInstance(month) }" />
<style>
.dh-dayItem {
	display: flex;
	flex-wrap: wrap;
}

.dh-day {
	width: 55px;
	height: 50px;
	padding: 2px 18px;
}

.dh-day input[type=radio] {
	display: none;
}

.dh-day input[type=radio]+label {
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 25px;
	cursor: pointer;
	color: #dadada;
	font-size: 20px;
}

.dh-day input[type=radio]:checked+label {
	margin-left: 12px;
	width: 30px;
	height: 30px;
	text-align: center;
	background-color: #dadada;
}

span#date {
	display: table-cell;
	vertical-align: middle;
	padding-left: 33px;
	width: 57px;
	height: 50px;
	color: #dadada;
	font-weight: 400;
	font-size: 22px;
}
h3#month{
	vertical-align: middle;
	color: #dadada;
	font-weight: 500;
	font-size: 30px;
}

.dh-leftright {
	margin-top:40px;
	display:flex;
	flex-flow:column;
	align-items:center;
	position:relative;
}

.dh-time select {
	padding: 10px 100px;
	background-color: rgb(255,255,255,0);
	border:0;
	border-radius:5px;
	font-size: 30px;
	width: 350px;
	-webkit-appearance:none;	
	color: #dadada;
}

.dh-time>select option {
	background: #0074A6;
	color: #dadada;
	font-size: 30px;
}
.dh-time {
	width: 50%;
	padding-top: 172px;
}
#dh-go{
	height:67px;
	background-color: rgb(255,255,255,0);
	border : 0px;
	border-radius:0 5px 5px 0;
	cursor:pointer;
	font-family: 'Open Sans', sans-serif;
	font-size: 20px;
    font-weight: 700;
    color: #fff;
    padding-right:20px;
}
.prev{
	position:absolute;
	width:100px;
	height:100px;
	top: 135px;
	left: 250px;
}
.next{
	position:absolute;
	width:100px;
	height:100px;
	top: 135px;
	right: 210px;
}
a#prevM{
	vertical-align: middle;
	color: #dadada;
	font-weight: 400;
	font-size: 100px;
}
a#nextM{
	vertical-align: middle;
	color: #dadada;
	font-weight: 400;
	font-size: 100px;
}
</style>
</head>
<body>
	<c:if test="${not empty month }">
		${cal.setMonth(month)}
	</c:if>
	<c:set var="datelist" value="${dateDAO.select() }" />
	<c:set var="timelist" value="${timeDAO.select() }" />

	<c:if test="${empty param.show_id }">
		<script>
			alert('공연이 선택되지 않았습니다')
			location.href = "show.jsp"
		</script>
	</c:if>

	<c:if test="${not empty param.show_id }">
		<div class="main-img">
			<h2>PERFORMANCE</h2>
		</div>
		<div class="frame">
			<hr>
			<form action="seat.jsp">
				<input type="hidden" name="show_id" value="${param.show_id }">
				<input type="hidden" name="month" value="${param.month }">
				<div class="dh-leftright">
					<div style="width: 50%;">
						<div class="dateItem">
							<div><h3 id="month">${cal.getYoil(month) }</h3></div>
							<span id="date">Sun</span> <span id="date">MON</span><span
								id="date">TUE</span><span id="date">WED</span> <span id="date">THU</span><span
								id="date">FRI</span><span id="date">SAT</span>
						</div>

						<div class="dh-dayItem">
							<c:forEach var="i" begin="1" end="${cal.startDayOfWeek-1 }">
							<div class="dh-day">
								<input type="radio" id="day" disabled /> <label
									style="color: grey;" for="day"></label>
							</div>
						</c:forEach>
						<c:forEach var="i" begin="1" end="${cal.lastDay }">
							<c:set var="day" value="${dateDAO.selectDay(cal.month, i) }" />
							
							<c:if test="${day != 0}">
								<div class="dh-day">
									<input type="radio" name="date_id" id="day${i}" value="${day }" />
									<label for="day${i}">${i }</label>
								</div>
							</c:if>
							<c:if test="${day == 0}">
								<div class="dh-day">
									<input type="radio" id="day" disabled /> <label
										style="color: grey;" for="day">${i }</label>
								</div>
							</c:if>
						</c:forEach>
						</div>
						<c:if test="${month > 1 }">
							<div class="prev"><a id="nextM" href="date.jsp?show_id=${param.show_id }&month=${month-1 }">&lt;</a></div>
						</c:if>
						<c:if test="${month < 12}">
							<div class="next"><a id="nextM" href="date.jsp?show_id=${param.show_id }&month=${month+1 }">&gt;</a></div>
						</c:if>
					</div>
					<div class="dh-time center">
						<div style="display:flex; align-items:center; border: 1px solid #dadada; border-radius:5px; width:60%;">
						<select name="time_id">
							<c:forEach var="timeDTO" items="${timelist }">
								<option value="${timeDTO.time_id }">${timeDTO.time_part }</option>
							</c:forEach>
						</select> 
						<input id="dh-go" type="submit" value="선택">
						</div>
					</div>
				</div>
			</form>
		</div>
	</c:if>


</body>
</html>