<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
	input{
		 font-family: 'Open Sans', sans-serif;
	}
	.dh-login{
		border: 1px solid #dadada;
		padding: 20px;
		width: 400px;
  		background-color:white;  
		border-radius: 6px;
	}
	.dh-loform{
		display: table;
    	table-layout: fixed;
		border: 1px solid #dadada;
		padding: 14px 17px 13px;
    	box-sizing: border-box;
    	width:100%;
	}
	img#loginicon{
		width:20px;
		height:20px;
		padding-right: 20px;
		position:absolute;
		top:15px;
		left:17px;
		display:none;
	}
	img#passicon{
		width:20px;
		height:20px;
		padding-right: 20px;
		position:absolute;
		top:15px;
		left:17px;
		display:none;
	}
	
	.dh-loform:nth-child(1){
		border-radius: 6px 6px 0 0;
    	box-shadow: none;
    	position:relative;
	}
	.dh-loform:nth-child(2){
		border-radius: 0 0 6px 6px;
    	box-shadow: none;
    	position:relative;
    	margin-bottom: 40px;
	}
	
	.dh-lobutton{
	display: block;
    width: 100%;
    padding: 13px 0 13px;
    border-radius: 6px;
    border: solid 1px rgba(0,0,0,.15);
    background-color: #dadada;
    box-sizing: border-box;
    position:relative;
    z-index:5;
	}
	
	.dh-input_user,
	.dh-input_pass{
	width: 100%;
    font-size: 16px;
    font-weight: 400;
    line-height: 19px;
    letter-spacing: -.5px;
    color: #222;
    box-sizing: border-box;
    display: table-cell;
    padding-right: 30px;
	}
	
	.dh-loginbutton{
		text-decoration: none;
		border: 0px;
		background: 0 0;
		font-family: 'Open Sans', sans-serif;
		font-size: 20px;
    	font-weight: 700;
   	 	line-height: 24px;
    	color: #fff;
    	margin: 0 auto;
    	cursor:pointer;
	}
	.dh-input_pass,
	.dh-input_user{
		border:0px;
		padding:1px;
	}
	.dh-input_pass:focus,
	.dh-input_user:focus{
		outline:none;
	}
	.dh-input_pass:focus + img#passicon,
	.dh-input_user:focus + img#loginicon{
		display:block;
	}
	
</style>
</head>
<body>

<c:if test="${pageContext.request.method == 'GET' }">
<div class="main-img">
			<h2>LOGIN</h2>
		</div>
	<div class="frame center">
		<div class="dh-login center">
			<form method="POST">
				<div class="dh-loform">
					<div class="center">
						<img src="image/login2.png" height="20" width="21" style="padding-right:20px;">
						<input class="dh-input_user" type="text" name="userid" placeholder="아이디" autofocus required>
						<img id="loginicon" src="image/login1.png">
					</div>
				</div>
				<div class="dh-loform">
					<div class="center">
						<img src="image/password2.png" height="20" width="21" style="padding-right:20px;">
						<input class="dh-input_pass" type="password" name="userpw" placeholder="패스워드" required>
						<img id="passicon" src="image/password1.png">
					</div>
				</div>
				<div class="dh-lobutton center"><button class="dh-loginbutton center">로그인</button></div>
			</form>
		</div>
	</div>
</c:if>


<c:if test="${pageContext.request.method == 'POST' }">
	<jsp:useBean id="dto" class="member.MemberDTO" />
	<jsp:setProperty property="*" name="dto" />
	<c:set var="login" value="${memberDAO.login(dto) }" scope="session" />
	<c:if test="${not empty login }">
		<c:redirect url="/" />
	</c:if>
	<script>
		alert('로그인실패!')
		history.go(-1);
	</script>
</c:if>

</body>
</html>