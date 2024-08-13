<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<script>
		var img = document.createElement("img");
		function changeHandler(event) {
			const preview = document.getElementById('preview')
			var previmg = document.getElementById('preImage')
			if(previmg){
				document.querySelector("div#preview").removeChild(previmg);
			}
			if (event.target.files && event.target.files[0]) {
				var reader = new FileReader();
				reader.onload = function(event) {
					img.setAttribute("src", event.target.result);
					img.setAttribute("width", "150");
					img.setAttribute("height", "150");
					document.querySelector("div#preview").appendChild(img);
				};

				reader.readAsDataURL(event.target.files[0]);
			} else {
				document.querySelector("div#preview").removeChild(img);
			}
		}
	</script>

<c:if test="${login.isAdmin == 1 }">
	<c:set var="dto" value="${memberDAO.selectOne(param.idx) }"/>
</c:if>
<div class="main-img">
	<h2>modify</h2>
</div>

	<div class="frame">
		<div class="dh-profile">
			<h2>회원 정보 수정</h2>
			<form action="member-modifyaction.jsp" method="POST" enctype="multipart/form-data">
					<c:if test="${login.isAdmin==1 }">
							<input type="hidden" name="idx" value="${dto.idx}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							<input type="hidden" name="idx" value="${login.idx}">
						</c:if>
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<c:if test="${login.isAdmin==1 }">
							<input type="text" name="userid" value="${dto.userid}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							${login.userid}
							<input type="hidden" name="userid" value="${login.userid}">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<c:if test="${login.isAdmin==1 }">
							<input type="text" name="userpw" value="${dto.userpw}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							${login.userpw}
							<input type="hidden" name="userpw" value="${login.userpw}">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>프로필사진</td>
					<td>	
							<div id="preview">
								<c:if test="${login.isAdmin==1 }">
									<img id="preImage" src="profile/${dto.profile_image }" height="150" width="150">
								</c:if>
								<c:if test="${login.isAdmin!=1 }">
									<img id="preImage" src="profile/${login.profile_image }" height="150" width="150">
								</c:if>
							</div>
						<input type="file" name="profile_image" accept="image/*">
					</td>
				</tr>
				<tr>
					<td>별명</td>
					<td>
						<c:if test="${login.isAdmin==1 }">
							<input type="text" name="username" value="${dto.username}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							<input type="text" name="username" value="${login.username}">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<c:if test="${login.isAdmin==1 }">
							<input type="text" name="email" value="${dto.email}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							<input type="text" name="email" value="${login.email}">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<c:if test="${login.isAdmin==1 }">
							${dto.gender}
							<input type="hidden" name="gender" value="${dto.gender}">
						</c:if>
						<c:if test="${login.isAdmin!=1 }">
							${login.gender }
							<input type="hidden" name="gender" value="${login.gender}">
						</c:if>
					</td>
				</tr>
			</table>
			<button>수정하기</button>
			</form>
		</div>
	</div>
<script>
		const input = document.querySelector('input[name="profile_image"]')

		input.addEventListener('change', changeHandler)
	</script>
</body>
</html>