<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>

	.btw {
		 display: flex;
		 justify-content: space-between;
	}
	
	.end {
		display: flex;
		justify-content: flex-end;
	}
	
	.font20 {
		font-size: 20px;
	}
	
	.view_main {
		width: 1200px;
		height: fit-content;
		background-color: white;
		border: 1px solid gray;
	}
	
	.view_image {
		width: 700px;
		height: fit-content;
		display: flex;
	}

	.view_text {
		width: 500px;
	}
	
	.view_text2 {
		padding: 10px 80px;
		padding-bottom: 40px;
		display: flex;
		justify-content: space-between;
	}
	
	.view_text > div:nth-child(1) {
		padding: 20px;
		padding-bottom: 0px;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 40px;
		font-weight: bold;
	}
	
	.view_text > div:nth-child(3) {
		padding: 20px;
		font-size: 20px;
	}
	
	.view_button {
		margin-bottom: 30px;
	}
	
	.reply_flex {
		width:1200px;
		border: 1px solid grey;
		display:flex;
	}
	
	.reply_flex > form{
	display:flex;
	}
	
	.reply_flex > form>textarea {
		resize: none;
		width: 1026px;
		height:114px;
		padding: 10px;
		border: 0px;
	}
	
	.reply_flex > form> input {
		width: 100px;
		border: 0px;
		border-left: 1px solid gray;
	}
	
	.reply_main {
		width: 1200px;
		height: fit-content;
		background-color: white;
		border: 1px solid gray;
		border-bottom: 0px;
		display:flex;
	}
	
	.padding_lr {
		padding: 5px;
	}
	
	.move_right {
		display: flex;
		justify-content: flex-end;
		padding-bottom:12px;
	}
	.pro{
		background-color:white;
		padding: 10px 2px 10px 10px;
	}
	.pro>img{
		width: 40px;
		height: 40px;
		border: 1px solid #dadada;
		border-radius: 50px;
	}
	.reply-con{
		padding-left:10px;
	}
	span#alarmUser{
		color: blue;
		font-weight: 600;
	}
</style>

<c:set var="dto" value="${boardDAO.selectOne(param.idx) }" />
<c:if test="${param.alarm==1 }">
	${memberDAO.deleteAlarm(login.userid, param.idx)}
</c:if>

<div class="main-img">
	<h2>FISHLIST 상세보기</h2>
</div>

<div class="frame col-center">
	<div class="view_main btw">
		<div class="view_image">
			<img src="${cpath }/fish/${dto.image }" width="700px">
		</div>
		<div class="view_text">
			<div>${dto.name }</div>
			<div class="view_text2">
				<div>카테고리 : ${dto.category }</div>
				<div>위치 : ${dto.place }</div>
			</div>
			<div>${dto.content }</div>
		</div>
	</div>
</div>
	<div id="reply" class="frame view_button end" style="width:1200px;">
		<a href="${cpath }/fish_list.jsp"><img src="image/back_to_the_list.png" width="50px" style="margin-top: 10px;"></a>
	</div>

<div class="frame col-center" >
	<c:forEach var="reply" items="${replyDAO.selectList(param.idx) }">
		<c:set var="user" value="${replyDAO.changeUser(reply.content) }"/>
		<c:set var="userProfile" value="${memberDAO.selectProfile(reply.writer) }"/>
		<div class="reply_main">
			<div class="pro"><img src="profile/${userProfile }"></div>
				<div style="width:100%;">
				<div class="btw">
					<div class="padding_lr font20" style="padding-top:15px; font-weight:600;">@${reply.writer }</div>
					<div class="padding_lr font20">
						<fmt:formatDate value="${reply.writeDate }" pattern="yyyy-MM-dd a hh:mm:ss" />
					</div>
				</div>
				<div class="padding_lr font20"><pre class="reply-con">${user}</pre></div>
				
				<div class="move_right padding_lr" style="height:22px;">
	 				<c:if test="${reply.writer == login.userid }"> 
						<a class="font20" href="${cpath }/reply-modify.jsp?idx=${reply.idx }&fish_idx=${dto.idx }">수정 |</a>
						<a class="font20" href="${cpath }/reply-delete.jsp?idx=${reply.idx }&fish_idx=${dto.idx }">&nbsp;삭제</a>
	 				</c:if>
				</div>
			</div>
		</div>
	</c:forEach>
	<div class="reply_flex">
	<div class="pro" ${empty login ? 'style="opacity:0.27;"' : '' }><img src="profile/${login.profile_image }" ${empty login ? 'style="opacity:0;"' : '' }></div>
	<form method="POST" action="reply-write.jsp">
		<input type="hidden" name="fish_idx" value="${param.idx }">
		<input type="hidden" name="writer" value="${login.userid }">
		
			<textarea class="font20" name="content" rows="5" cols="150" placeholder="의견을 남겨 보세요" ${empty login ? 'disabled' : ''}></textarea>
			<input class="font20" type="submit" value="덧글 작성" ${empty login ? 'disabled' : '' }>
		
	</form>
	</div>
</div>

</body>
</html>