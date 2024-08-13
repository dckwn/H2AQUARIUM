<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
	table{
		text-align:center;
		width:100%;
	}
	details summary::marker{font-size:0;}
	span#detail{
		font-size:28px;
		font-weight:700;
		cursor:pointer;
	}
</style>
</head>
<body>
<c:set var="memberList" value="${memberDAO.select() }"/>
<c:set var="fishList" value="${boardDAO.selectList() }"/>
<c:set var="reserveList" value="${reserveDAO.info(param.search) }"/>

<c:if test="${login.isAdmin != 1 }">
	<script>
		alert('잘못된 접근방식 입니다.')
		location.href='index.jsp'
	</script>
</c:if>

<div class="main-img">
			<h2>ADMIN</h2>
		</div>
		
		<div class="frame">
		<details class="info">
			<summary><span id="detail">회원</span></summary>
		<table>
			<thead>
				<tr>
					<th>IDX</th>
					<th>USERID</th>
					<th>USERPW</th>
					<th>USERNAME</th>
					<th>PROFILE_IMAGE</th>
					<th>EMAIL</th>
					<th>GENDER</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${memberList }">
					<tr>
						<td>${dto.idx }</td>
						<td>${dto.userid }</td>
						<td>${dto.userpw }</td>
						<td>${dto.username }</td>
						<td>${dto.profile_image }</td>
						<td>${dto.email }</td>
						<td>${dto.gender }</td>
						<td>
							<a href="${cpath }/member-modify.jsp?idx=${dto.idx}">수정</a>
							<a href="${cpath }/member-delete.jsp?idx=${dto.idx}&profile_image=${dto.profile_image}">탈퇴</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</details>
		
		<details class="info" ${not empty param.search ? 'open' : '' }>
			<summary><span id="detail">예약</span></summary>
			<div>
				<form>
					<select name="show_name" id="show">
					<option style="display:none;">공연을 선택하세요.</option>
					<option value="all">전체</option>
					<c:forEach var="showList" items="${showDAO.select() }">
						<option value="${showList.show_name }">${showList.show_name }</option>
					</c:forEach>
					</select>
					
				</form>
			</div>
			<c:if test="${not empty param.search }">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>예약자ID</th>
					<th>날짜</th>
					<th>공연</th>
					<th>예약시간</th>
					<th>예약자리</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${reserveList }">
					<tr>
					<td>${dto.idx }</td>
					<td>${dto.userid }</td>
					<td>${dto.resDate }</td>
					<td>${dto.show_name }</td>
					<td>${dto.time_part }</td>
					<td>${dto.seat_num }</td>
					<td><a href="${cpath}/reserve-delete.jsp?idx=${dto.idx }">예약취소</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		</details>
		
		<details>
			<summary><span id="detail">물고기</span></summary>
			<table>
				<thead>
					<tr>
						<th>IDX</th>
						<th>NAME</th>
						<th>IMAGE</th>
						<th></th>
						<th><a href="${cpath }/write.jsp">추가</a></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${fishList }">
						<tr>
							<td>${dto.idx }</td>
							<td>${dto.name }</td>
							<td><img src="fish/${dto.image }" width="100" height="100"></td>
							<td>
							<a href="${cpath }/modify.jsp?idx=${dto.idx}&preImage=${dto.image}">수정</a>
							<a href="${cpath }/delete.jsp?idx=${dto.idx}&image=${dto.image}">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</details>
		
		</div>

	<script>
		
		function changeHandler(event) {
			var show = document.getElementById('show')
			var test = show.options[show.selectedIndex]
			var value = (show.options[show.selectedIndex].value)
			location.href='${cpath}/admin.jsp?search=' + value
// 			'url(' + e.target.result + ')'
		}
	</script>	
	
	<script>
		const input = document.querySelector('select')
		input.addEventListener('change', changeHandler)
	</script>
		
</body>
</html>