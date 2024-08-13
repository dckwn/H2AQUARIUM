<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="member.*,datey.*,seat.*,showtable.*,time.*,reservation.*, board.*,reply.*,alarm.*,like.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<c:set var="fileutil" value="${FileUtil.getInstance() }" />
<c:set var="fishfile" value="${FileUtilList.getInstance() }" />
<c:set var="memberDAO" value="${MemberDAO.getInstance() }" />
<c:set var="showDAO" value="${ShowDAO.getInstance() }" />
<c:set var="dateDAO" value="${DateDAO.getInstance() }" />
<c:set var="seatDAO" value="${SeatDAO.getInstance() }" />
<c:set var="timeDAO" value="${TimeDAO.getInstance() }" />
<c:set var="replyDAO" value="${ReplyDAO.getInstance() }" />
<c:set var="alarmDAO" value="${AlarmDAO.getInstance() }" />
<c:set var="likeDAO" value="${LikeDAO.getInstance() }" />
<c:set var="boardDAO" value="${BoardDAO.getInstance() }" />
<c:set var="reserveDAO" value="${ReserveDAO.getInstance() }" />
<%	request.setCharacterEncoding("UTF-8"); %>
<%	response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>케이지 아쿠아리움</title>
<style>
@font-face {
	font-family: 'Indie Flower';
	font-style: normal;
	font-weight: normal;
	src: url('fonts/IndieFlower-Regular.ttf');
/* 	src: url(https://fonts.gstatic.com/s/indieflower/v21/m8JVjfNVeKWVnh3QMuKkFcZVaUuH.woff2) format('woff2'); */
	unicode-range: U+0041-005A, U+0061-007A;
}

@font-face {
	font-family: 'Hi Melody';
	font-style: normal;
	font-weight: normal;
	src: url('fonts/HiMelody-Regular.ttf');
	unicode-range: U+AC00-D7A3, U+0030-0039, U+003A-0040, U+005B-0060, U+007B-007E;
}


* {
	margin: 0;
	padding: 0;
	font-family: 'Indie Flower', 'Hi Melody';
}
html{
	scroll-behavior: smooth;
}
body{
	height:fit-content;
	background-image: url(image/bg_test1.png); 
	background-position: 40% 0;
    background-repeat: no-repeat;
    background-attachment: fixed;
    padding-bottom: 320px;
    background-color: #054964;
}
a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: grey;
}

.sb {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.center{
	display: flex;
	justify-content: center;
	align-items: center;
}

.info {
	border-collapse: collapse;
}

.info>tbody>tr {
	text-align: center;
}

.info th, .info td {
	padding: 10px;
}

.logo {
	padding-left: 40px;
	width:auto;
	height:80px;
	}
	
.profile {
	padding-right: 40px;
	text-align: center;
}

.profile>img {
	border: 1px solid #dadada;
	border-radius: 50px;
	cursor:pointer;
	z-index:5;
}

header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 120px;
	margin: 0;
	position: fixed;
	width:100%;
	left: 0;
	top: 0;
	z-index: 1000;
}
.mypage {
	display:none;
	height: fit-content;
	width: 100px;
	background-color: #dadada;
	position: absolute;
	top: 80px;
	right: 12px;
}

.frame {
	width: 1300px;
	margin: 0 auto;
}

.nav > ul{
	display: flex;
	justify-content: space-between;
	align-items: center;
	list-style:none;
}
.nav> ul >li{
	padding-left: 40px;
}
.nav> ul >li > a > img{
}
.dh-head{
	width: 100%;
	align-items: center;
}
.main-img{
	height:fit-content;
/* 	background-image: url(image/bg2.jpg);  */
	background-position: center center;
	background-size:cover;
	width:100%;
/*     background-color: #054964; */
/*     opacity: 0.8; */
    z-index: -20;
}
.main-img>h2{
	padding-top:15%;
	padding-bottom:40px;
	font-size: 2.2rem;
	text-align: center;
	font-weight: 400;
	letter-spacing: 2px;
    margin-bottom: 0;
/*     font-family: "Times New Roman",serif; */
    color:#fff;
}

.col-center{
	display:flex;
	flex-direction: column;
	align-items:center;
}
</style>
</head>
<body>
<script>
    window.addEventListener('scroll', function(){
	  const aa = document.getElementById('aa')
    	console.log(window.scrollY)
	  if(window.scrollY > 130){
		  aa.style.background='rgba(0,0,0,0.2)'
	  }
	  else{
		  aa.style.background='inherit'
	  }
	});
</script>
<%@ include file="back.jsp" %>
	<header id="aa">
		<div class="dh-head sb">
			<div>
				<a href="${cpath }"><img class="logo" src="image/logo1.png"></a>
			</div>
			<div class="nav">
				<ul>
					<li><a href="${cpath }/fish_list.jsp"><img src="image/fish1_icon.png" height="60px" width="60px"></a></li>
					<li><a href="${cpath }/show.jsp"><img src="image/show_icon.png" height="50px" width="60px"></a></li>					
					<c:if test="${empty login }">
						<li class="profile">
							<img id="my" src="profile/default.png"
								height="50px" width="50px"><br><span></span>
							<div class="mypage" id="test">
								<div>
									<a href="join.jsp">회원가입</a><br><a href="#" id="headlogin">로그인</a>
								</div>
							</div> 
						</li>
					</c:if>
					<c:if test="${not empty login }">
						<li class="profile">
							<img id="my" src="profile/${login.profile_image }"
								height="50px" width="50px">
							<div class="mypage" id="test">
								<div>
									<span>${login.username } 님</span><br>
									<c:if test="${login.isAdmin == 1 }">
										<a href="admin.jsp">관리자페이지</a>
									</c:if>
									<c:if test="${login.isAdmin == 0 }">
										<a href="myPage.jsp">마이페이지</a>
									</c:if>
									<br><a href="logout.jsp">로그아웃</a>
								</div>
							</div> 
						</li>
					</c:if>
				</ul>
			</div>
		</div>
<%-- 		<c:if test="${empty login }"> --%>
<!-- 			<div class="profile"> -->
<!-- 				<img onclick="test()" src="profile/default.png" -->
<!-- 					height="50px" width="50px"><br><span></span> -->
<!-- 				<div class="mypage" id="test"> -->
<!-- 					<div> -->
<!-- 						<a href="join.jsp">회원가입</a><br><a href="#" onclick="login()">로그인</a> -->
<!-- 					</div> -->
<!-- 				</div>  -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
<%-- 		<c:if test="${not empty login }"> --%>
<!-- 			<div class="profile"> -->
<%-- 				<img onclick="test()" src="profile/${login.profile_image }" --%>
<!-- 					height="50px" width="50px"> -->
<!-- 				<div class="mypage" id="test"> -->
<!-- 					<div> -->
<%-- 						<span>${login.username } 님</span><br> --%>
<%-- 						<c:if test="${login.isAdmin == 1 }"> --%>
<!-- 							<a href="admin.jsp">관리자페이지</a> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test="${login.isAdmin == 0 }"> --%>
<!-- 							<a href="myPage.jsp">마이페이지</a> -->
<%-- 						</c:if> --%>
<!-- 						<br><a href="logout.jsp">로그아웃</a> -->
<!-- 					</div> -->
<!-- 				</div>  -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
	</header>
	
	<script>
// 		function test(){
// 			var t = document.getElementById("test");
			
// 			if(t.style.display !=='block'){
// 				t.style.display = 'block';
// 			}
// 			else{
// 				t.style.display = 'none';
// 			}
// 		}

// 		function login(){
// 			const url = 'login-mini.jsp'
// 				let options = ''
// 				options += 'menubar=no,'
// 				options += 'toolbar=no,'
// 				options += 'width=600,'
// 				options += 'height=600,'
// 				options += 'status=no,'
// 				options += 'left=500,'
// 				options += 'top=180'
// 				window.open(url, '', options)			
// 		}
			const url = 'login-mini.jsp'
			let options = ''
			options += 'menubar=no,'
			options += 'toolbar=no,'
			options += 'width=600,'
			options += 'height=600,'
			options += 'status=no,'
			options += 'left=500,'
			options += 'top=180'
			
			const my = document.getElementById("my");
			const t = document.getElementById("test");
			
			const myHandler = function(event){
				if(t.style.display !=='block'){
					t.style.display = 'block';
				}
				else{
					t.style.display = 'none';
				}
			}
			my.onclick = myHandler
		
		const loginBtn = document.getElementById('headlogin')
		//이벤트 함수를 정의한다
		const loginHandler = function(event){
				window.open(url, '', options)
		}
		loginBtn.onclick = loginHandler
		
		
		
		
		
		
		
		
		
		
		
	</script>