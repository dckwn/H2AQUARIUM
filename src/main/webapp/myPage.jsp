<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:set var="list" value="${reserveDAO.selectOne(login.userid) }"/>


<div class="main-img">
			<h2>MyPage</h2>
		</div>
	<div class="frame">
		<div class="dh-profile">
			<h2>나의 정보</h2>
			<table>
				<tr>
					<td>프로필사진</td>
					<td><img src="profile/${login.profile_image }" height="150" width="150"></td>
				</tr>
				<tr>
					<td>별명</td>
					<td>${login.username }</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${login.email }</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>${login.gender }</td>
				</tr>
			</table>
			<a href="${cpath }/member-modify.jsp">수정</a>
			<a href="${cpath }/member-delete.jsp?idx=${login.idx}&profile_image=${login.profile_image}">탈퇴</a>
		</div>
		<br><br>
		<div class="dh-reserv">
			<h2>나의 예약</h2>
			<c:forEach var="dto" items="${list }">
			${dto.resDate }
			${dto.time_part }
			${dto.show_name }
			${dto.seat_num }
			<a href="${cpath}/reserve-delete.jsp?idx=${dto.idx }">예약취소</a>
			<br><br>
			</c:forEach>
		</div>
</div>	
</body>
</html>