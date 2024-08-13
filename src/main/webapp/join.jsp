<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<style>
input {
	font-family: 'Open Sans', sans-serif;
	color: #dadada;
}

.dh-login {
	border: 1px solid #dadada;
	padding: 20px;
	width: 400px;
	background-color: white;
	border-radius: 6px;
}

.dh-loform {
	display: table;
	table-layout: fixed;
	border: 1px solid #dadada;
	padding: 14px 17px 13px;
	box-sizing: border-box;
	width: 100%;
}

.dh-check {
	border-radius: 6px 6px 0 0;
	box-shadow: none;
	position: relative;
}

.dh-loform:nth-child(6) {
	border-radius: 0 0 6px 6px;
	box-shadow: none;
	position: relative;
	display: flex;
	padding: 0px;
	margin-bottom: 40px;
}

.dh-loginbutton {
	text-decoration: none;
	border: 0px;
	background: 0 0;
	font-family: 'Open Sans', sans-serif;
	font-size: 20px;
	font-weight: 700;
	line-height: 24px;
	color: #fff;
	margin: 0 auto;
	cursor: pointer;
}

.dh-lobutton {
	display: block;
	width: 100%;
	padding: 13px 0 13px;
	border-radius: 6px;
	border: solid 1px rgba(0, 0, 0, .15);
	background-color: #dadada;
	box-sizing: border-box;
	position: relative;
	z-index: 5;
}

.dh-input {
	width: 100%;
	font-size: 16px;
	font-weight: 400;
	line-height: 19px;
	letter-spacing: -.5px;
	color: #222;
	box-sizing: border-box;
	display: table-cell;
	padding-right: 30px;
	border: 0px;
	padding: 1px;
}

.dh-loform input[type=radio] {
	display: none;
}

.dh-loform input[type=file] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

.dh-loform input[type=file]+label {
	padding-left: 57px;
	cursor: pointer;
	font-family: 'Open Sans', sans-serif;
	color: #757575;
}

.dh-loform input[type=radio]+label {
	border: 1px solid #dadada;
	border-top: 0px;
	font-family: 'Open Sans', sans-serif;
	display: flex;
	justify-content: center;
	height: 110%;
	width: 50%;
	background-color: #fff;
	color: #757575;
	padding: 14px 17px 13px;
	overflow: hidden;
	border-radius: 2px;
	cursor: pointer;
}

.dh-loform input[type=radio]:checked+label {
	background-color: #555;
	color: #fff;
}

div#preview {
	border: 1px solid #dadada;
	border-radius: 50%;
	width: 200px;
	height: 200px;
	margin-bottom: 13px;
	background-position: center center;
	background-repeat: no-repeat;
	background-size: auto 100%;
	overflow: hidden;
}
.dh-checkId{
	display:flex;
	align-items:center;
}
.dh-checkbutton {
	text-decoration: none;
	border: 0px;
	background: 0 0;
	width:70px;
	font-family: 'Open Sans', sans-serif;
	font-size: 13px;
	font-weight: 300;
	line-height: 24px;
	color: #757575;
	margin: 0 auto;
	cursor: pointer;
	z-index: 5;
}
.dh-chbutton {
	display: block;
	width:fit-content;
	border-radius: 6px;
	border: solid 1px rgba(0, 0, 0, .15);
	background: 0 0;
	box-sizing: border-box;
	position: relative;
	
}
button#noch{
	color: #dadada;
}
p#yescheck{
	 margin-left:40px; 
	 padding-top:10px;
	 }
p#yescheck,
p#yescheck > span
{
	font-family: 'Open Sans', sans-serif;
}

</style>
</head>
<body>

<c:if test="${empty login }">

	<script>
		var img = document.createElement("img");
		function changeHandler(event) {
			// event.target 은 파일을 첨부하는 input 요소이다
			// preview는 미리보기 그림을 보여줄 div 요소이다
			const preview = document.getElementById('preview')

			if (event.target.files && event.target.files[0]) {
				var reader = new FileReader();
				reader.onload = function(event) {
					img.setAttribute("src", event.target.result);
					img.style.width = '100%'
					img.style.height = '100%'					
// 					img.setAttribute("width", "100%");
// 					img.setAttribute("height", "100%");
					document.querySelector("div#preview").appendChild(img);
				};

				reader.readAsDataURL(event.target.files[0]);
			} else {
				document.querySelector("div#preview").removeChild(img);
			}
		}
	</script>
	
	<c:set var="checkID" value="ttttttttttttttttttttttttt"/>
	<div class="main-img">
		<h2>JOIN</h2>
	</div>
	<div class="frame center">
		<div class="dh-login center">
			<div class="dh-join">
				<div class="dh-check dh-loform">
					<div>
						<form class="dh-checkId" action="check.jsp" method="POST">
							<img src="image/login2.png" height="20" width="21"style="padding-right: 20px;"> 
							<input class="dh-input"	type="text" name="userid" 
							value="${param.userid==checkID ? '': param.userid }"
							placeholder="아이디" autofocus required>
							<div class="dh-chbutton center">
								<button class="dh-checkbutton center">중복확인</button>
							</div>							
						</form>	
					</div>
					<div>
						<c:if test="${not empty param.userid }">
							<p id="yescheck">
							${param.userid==checkID ? '<span style="color:red;">중복된 아이디입니다.</span>' : '사용가능한 아이디입니다.' }
							</P>	
						</c:if>
					</div>
				</div>
				<form action="join-action.jsp" method="POST"
					enctype="multipart/form-data">
					<input type="hidden" name="userid" value="${param.userid }">
					<div class="dh-loform">
						<div class="center">
							<img src="image/password2.png" height="20" width="21"
								style="padding-right: 20px;"> <input class="dh-input"
								type="password" name="userpw" placeholder="패스워드" required>
						</div>
					</div>
					<div class="dh-loform">
						<div id="preview"></div>
						<input type="file" name="profile_image" accept="image/*" id="file">
						<label for="file">프로필 사진</label>
					</div>
					<div class="dh-loform">
						<div class="center">
							<img src="image/login2.png" height="20" width="21"
								style="padding-right: 20px;"> <input class="dh-input"
								type="text" name="username" placeholder="별명">
						</div>
					</div>
					<div class="dh-loform">
						<div class="center">
							<img src="image/email1.png" height="20" width="21"
								style="padding-right: 20px;"> <input class="dh-input"
								type="text" name="email" placeholder="이메일">
						</div>
					</div>
					<div class="dh-loform">
						<input id="dh-gender1" type="radio" name="gender" value="남성"
							required><label for="dh-gender1">남성</label> <input
							id="dh-gender2" type="radio" name="gender" value="여성" required><label
							for="dh-gender2">여성</label>
					</div>
					<div class="dh-lobutton center">
						<button class="dh-loginbutton center"${param.userid==checkID || empty param.userid ? 'id="noch" disabled' : '' }>회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		const input = document.querySelector('input[name="profile_image"]')

		input.addEventListener('change', changeHandler)
	</script>
</c:if>
</body>
</html>