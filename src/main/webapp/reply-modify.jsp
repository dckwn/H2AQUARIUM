<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>

	.reply_flex {
		width:1200px;
		border: 1px solid grey;
	}
	
	.reply_flex > form{
	display:flex;
	}
	
	.reply_flex > form>textarea {
		resize: none;
		width: 1080px;
		height:120px;
		padding: 10px;
		border: 0px;
	}
	
	.reply_flex > form> input {
		width: 100px;
		border: 0px;
		border-left: 1px solid gray;
	}
</style>

<c:set var="dto" value="${replyDAO.selectOne(param.fish_idx, param.idx) }" />

<c:if test="${login.userid != dto.writer}">
	<script>
		alert('자신이 쓴 덧글만 수정이 가능합니다')
		history.go(-1)	
	</script>
</c:if>

<c:if test="${login.userid == dto.writer}">
	<c:if test="${pageContext.request.method == 'GET' }">
		<div class="main-img">
			<h2>덧글 수정 하기</h2>
		</div>
		
		<div class="reply_flex frame">
			<form method="POST" action="">
				<input type="hidden" name="idx" value="${param.idx }">
				<input type="hidden" name="fish_idx" value="${param.fish_idx }">
				<input type="hidden" name="writer" value="${login.userid }">
				<textarea name="content" rows="5" cols="150" placeholder="의견을 남겨 보세요">${dto.content }</textarea>
				<input type="submit" value="덧글 수정">
			</form>
		</div>
	</c:if>
	
	<c:if test="${pageContext.request.method == 'POST' }">
		<jsp:useBean id="dto1" class="reply.ReplyDTO" />
		<jsp:setProperty property="*" name="dto1" />
		
		<c:set var="row" value="${replyDAO.modify(dto1) }" />
		
		<c:if test="${row != 0 }">
			<script>
				alert('덧글 수정 성공')
				location.href = '${cpath }/view.jsp?idx=${dto1.fish_idx}#reply'
			</script>
		</c:if>
		<c:if test="${row == 0 }">
			<script>
				alert('덧글 수정 실패')
				history.go(-1)
			</script>
		</c:if>
	</c:if>
</c:if>

</body>
</html>