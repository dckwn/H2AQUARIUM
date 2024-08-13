<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:set var="all" value="all"/>
<c:set var="list" value="${reserveDAO.info(all) }"/>

<div class="main-img">
			<h2>RESERVATION</h2>
		</div>

<main class="frame">
<div class="sb">
	<h2>예약현황</h2>
	<a href="${cpath }/show.jsp">예약</a>
</div>
<hr>
<table class="info frame">
		<thead>
			<tr>
				<th>번호</th>
				<th>예약자ID</th>
				<th>날짜</th>
				<th>공연</th>
				<th>예약시간</th>
				<th>예약자리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list }">
				<tr>
					<td>${dto.idx }</td>
					<td>${dto.userid }</td>
					<td>${dto.resDate }</td>
					<td>${dto.show_name }</td>
					<td>${dto.time_part }</td>
					<td>${dto.seat_num }</td>
					<td><button>수정</button><a href="">탈퇴</a></td>
				</tr>
			</c:forEach>
		</tbody>
</table>
</main>


</body>
</html>