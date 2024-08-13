<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<style>
/* body{ */
/* 	height:fit-content; */
/* 	background-image: url(image/bg4.jpg);  */
/* 	background-position: 50% 0; */
/*     background-repeat: no-repeat; */
/*     background-attachment: fixed; */
/*     padding-bottom: 320px; */
/*     background-color: #054964; */
/* } */
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
	padding-bottom:10px;
	font-size: 2.2rem;
	text-align: center;
	font-weight: 400;
	letter-spacing: 2px;
    margin-bottom: 0;
    color:#fff;
}

.show{
	width:1000px;
	height: 400px;
	margin:0 auto;
}
.showNow{
	width:960px;
	height:80px;
	margin:0px auto;
	margin-bottom:10px; 
}
.showNow>h1{
	font-size:30px;
	font-style: normal;
    font-weight: 700;
    line-height: 150%;
    display: flex;
    justify-content:center;
    align-items: center;
}
.showImg{
	height:500px; 
	background-position: center;
	background-size:cover;
	width:100%;
	position:relative;
	border-radius:20px;
}
.showInfo{
	position:absolute;
	bottom:30px;
	left:0px;
	display:flex;
	align-items:center;
	justify-content: space-between;
	padding:20px 20px;
	width: 90%; 
	background-color: rgba(255,255,255,.7);
	border-radius: 0px 20px 20px 0px;
}

.showInfo div:nth-child(1){
	text-align: left;
	color: #212529;
	width: 800px;
	height: 150px;
}
.showInfo div:nth-child(2){
	width: 200px;
}
.showInfo > div> h3{
	letter-spacing: .1rem;
    font-weight: 600;
    font-size:1.6rem;
    margin-bottom: 0;
    padding-bottom:10px;
}
.showInfo > div > p{
	
}
.showInfo > div > a{
	border: 1px solid black;
	padding: 20px;
	margin-left: 25px;
}
.showNow > div{
	margin-top: 10px;
	display: flex;
	align-items: center;
	justify-content:center;
}
.cate > ul{
	display: flex;
	justify-content: space-between;
	align-items: center;
	list-style:none;
	width: 400px;
}
.cate > ul > li{
	padding-right: 30px;
	border: 1px solid white;
	background-color:inherit;
	border-radius: 50px;
	width:30px;
	height:30px;
	cursor:pointer;
}



</style>
</head>
<body>

<c:set var="month" value="${dateDAO.sysMonth() }"/>
	<main>
		<div class="main-img">
			<h2>PERFORMANCE</h2>
		</div>
				<div class="showNow">
<!-- 						<h1>이달의 공연!</h1>	 -->
						<div class="cate">
							<ul>
								<li id="sh1" style="background-color:white;"></li>
								<li id="sh2" ></li>
								<li id="sh3" ></li>
								<li></li>
							</ul>
						</div>				
				</div>
				<c:set var="list" value="${showDAO.select() }" />
				<div class="show">
					<div>
						<c:forEach var="dto" items="${list }" >
								<div class="showImg" id="show${dto.show_id }" 
								style="background-image: url(image/${dto.show_img }); ${dto.show_id == 1 ? ' ' : 'display:none;'}" >
									<div class="showInfo">
										<div>
											<h3>${dto.show_name }</h3>
											<p>${dto.show_content }</p>
										</div>
										<div>
											<a href="${cpath }/date.jsp?show_id=${dto.show_id}&month=${month}" id="target${dto.show_id }">RESERVE -></a>
										</div>
									</div>
								
							</div>
						</c:forEach>
					</div>
				</div>
	</main>

</body>

<script>
		var t1 = document.getElementById('target1');
		var t2 = document.getElementById('target2');
		var t3 = document.getElementById('target3');
		var user = "<c:out value='${login.userid}'/>";
		
		function btn_listener(event){
			event.preventDefault();
			if(user == ''){
		    	alert('로그인이 필요합니다.');
		    	window.open(url, '', options)
			}
			else{
				location.href=event.target.href
			}
        }
		t1.addEventListener('click', btn_listener);
		t2.addEventListener('click', btn_listener);
		t3.addEventListener('click', btn_listener);
		
// 		ttt.addEventListener('click', function(event){
// 			event.preventDefault();
// 			if(user == ''){
// 		    	alert('null');
// 			}
// 			else{
// 				alert('fuck');
// 			}
// 		});
		
// 		var ttt = document.getElementById('id');
// 		const lll = ${login.userid}
		
// 	    ttt.addEventListener('click', function(event){
// 	    	event.preventDefault()
// 	    	if(lll == null){
// 	    		alert('로그인이 필요합니다.')
// 	    		window.open(url, '', options)
// 	    	}
// 	    	else{
// 	    		location.href=event.target.href
// 	    	}
// 	    });
		
// 		function shower1(){
// 			var sh1 = document.getElementById("sh1");
// 			var sh2 = document.getElementById("sh2");
// 			var sh3 = document.getElementById("sh3");
// 			if(sh1.style.backgroundColor !=='white'){
// 				sh1.style.backgroundColor ='white';
// 				sh2.style.backgroundColor ='inherit';
// 				sh3.style.backgroundColor ='inherit';
// 			}
			
// 			var show1 = document.getElementById("show1");
// 			var show2 = document.getElementById("show2");
// 			var show3 = document.getElementById("show3");
// 			if(show1.style.display !=='block'){
// 				show1.style.display = 'block';
// 				show2.style.display = 'none';
// 				show3.style.display = 'none';
// 			}
// 		}
// 		function shower2(){
// 			var sh1 = document.getElementById("sh1");
// 			var sh2 = document.getElementById("sh2");
// 			var sh3 = document.getElementById("sh3");
// 			if(sh2.style.backgroundColor !=='white'){
// 				sh2.style.backgroundColor ='white';
// 				sh1.style.backgroundColor ='inherit';
// 				sh3.style.backgroundColor ='inherit';
// 			}
			
// 			var show1 = document.getElementById("show1");
// 			var show2 = document.getElementById("show2");
// 			var show3 = document.getElementById("show3");
// 			if(show2.style.display !=='block'){
// 				show2.style.display = 'block';
// 				show1.style.display = 'none';
// 				show3.style.display = 'none';
// 			}
// 		}
// 		function shower3(){
// 			var sh1 = document.getElementById("sh1");
// 			var sh2 = document.getElementById("sh2");
// 			var sh3 = document.getElementById("sh3");
// 			if(sh3.style.backgroundColor !=='white'){
// 				sh3.style.backgroundColor ='white';
// 				sh1.style.backgroundColor ='inherit';
// 				sh2.style.backgroundColor ='inherit';
// 			}
			
// 			var show1 = document.getElementById("show1");
// 			var show2 = document.getElementById("show2");
// 			var show3 = document.getElementById("show3");
// 			if(show3.style.display !=='block'){
// 				show3.style.display = 'block';
// 				show2.style.display = 'none';
// 				show1.style.display = 'none';
// 			}
// 		}

		const shList = document.querySelectorAll('div.cate > ul > li')
		const showImgList = document.querySelectorAll('div.show .showImg')
		
		shList.forEach((element, index) => {
			element.onclick = function(event) {
				shList.forEach(e => e.style.backgroundColor = '')
				element.style.backgroundColor = 'white'
				
				showImgList.forEach(e => e.style.display = 'none')
				showImgList[index].style.display = 'block'
			}
		})


	</script>

</html>