<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
.select {
    padding: 15px 10px;
    margin: 0 auto;
}
.select input[type=checkbox]{
    display: none;
}
.select input[type=checkbox]+label{
    display: inline-block;
    cursor: pointer;
    height: 50px;
    width: 50px;
    border-radius: 20px 20px 0 0;
    border: 1px solid #dadada;
    line-height: 24px;
    text-align: center;
    font-weight:bold;
    color: #333;
}
.select input[type=checkbox]+label{
    background-color: #fff;
    color: #333;
}
.select input[type=checkbox]:checked+label{
    background-color: #333;
    color: #fff;
}
#sold{
	background-color: #333;
	color:white;
}
.seatItems{
	width: 750px;
	display:flex;
	flex-flow:wrap;
}
.seatItems > div:nth-child(3n){
	padding-right:50px;
}

.item{
	margin-right:15px;
	padding-bottom:10px;
	width:50px;
}
.select{
	display:flex;
	flex-flow:column;
	align-items:center;
}
.stage {
	margin-bottom: 20px;
	border: 2px solid #dadada;
	height: 320px;
	width: 600px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.stage >div>h1{
	color:#dadada;
}
.dh-seat{
	padding-left:80px;
}
.gogo{
	width:150px;
	background-color:inherit;
	color:#dadada;
	font-size:30px;
	text-align:left;
	border:0px;
	cursor:pointer;
}

    </style>
</head>
<body>
<jsp:useBean id="reserveDTO" class="reservation.ReserveDTO" />
<jsp:setProperty property="*" name="reserveDTO"/>

<c:set var="seatlist" value="${seatDAO.select() }"/>
<c:if test="${not empty param.date_id && not empty param.time_id }">

<div class="main-img">
			<h2>PERFORMANCE</h2>
</div>
<div class="frame">
<hr>
	<div class="select">
		<h3 style="width:fit-content; color:white;">원하시는 자리를 골라주세요 (✔는 이미 예약된 자리입니다)</h3>
		<div class="stage">
				<div>
					<h1>STAGE</h1>
				</div>
		</div>
		
		<div class="dh-seat">
		<form action="reservation.jsp">
			<input type="hidden" name="show_id" value="${param.show_id }">
			<input type="hidden" name="time_id" value="${param.time_id }">
			<input type="hidden" name="date_id" value="${param.date_id }">
			<input type="hidden" name="user_id" value="${login.idx }">
			<div class="seatItems">
				<c:forEach var="seatDTO" items="${seatlist }">
					<div class="item">
						<c:if test="${reserveDAO.check(reserveDTO, seatDTO.seat_id) == false }">
		        			<input type="checkbox" id="select${seatDTO.seat_id }" name="seat" value="${seatDTO.seat_id}" >
		        			<label for="select${seatDTO.seat_id }" >${seatDTO.seat_num }</label>
		        		</c:if>
		        		
		        		<c:if test="${reserveDAO.check(reserveDTO, seatDTO.seat_id) == true }">
		        			<input type="checkbox" id="select${seatDTO.seat_id }" disabled >
		        			<label id="sold" for="select${seatDTO.seat_id }" >✔</label>
		        		</c:if>
	        		</div>
	        	</c:forEach>
        	</div>
        	
        	<button class="gogo">선택</button>
        </form>
        </div>
   </div>
   
</div>


</c:if>
  
  <c:if test="${empty param.date_id || empty param.time_id }">
	<script>
		alert('날짜 및 시간이 선택되지 않았습니다')
		location.href="${cpath}/date.jsp?show_id=${param.show_id}&month=${param.month}"
	</script>
</c:if>
  
</body>
</html>