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
.dh_index > h2{
	padding-top: 15%;
	text-align:center;
	opacity:0.9;
}
</style>

<div class="dh_index">
	<h2><img src="image/now.png"></h2>
</div>

<c:if test="${not empty login }">
<c:set var="fish_idx" value="${memberDAO.alarm(login.userid) }"/>

<c:if test="${fish_idx != 0 }">
	<script>
		const flag = confirm('${login.userid}님에 대한 알림이 있습니다. 확인하시겠습니까?')	//사용자에게 확인/취소 묻기
		if(flag){						//만약 확인을 클릭했다면
			location.href = '${cpath}/view.jsp?idx=${fish_idx}&alarm=1#reply'			
		}
	</script>
</c:if>
</c:if>
</body>
</html>