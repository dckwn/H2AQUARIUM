<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<jsp:useBean id="dto" class="reply.ReplyDTO" />
<jsp:setProperty property="*" name="dto" />
<jsp:setProperty property="writer" name="dto" value="${login.userid }" />

<c:set var="row" value="${replyDAO.delete(dto) }" />

<c:if test="${row != 0 }">
	<script>
		location.href = '${cpath }/view.jsp?idx=${param.fish_idx }'
	</script>
</c:if>

<c:if test="${row == 0 }">
	<script>
		alert('덧글 삭제 실패')
		history.go(-1)
	</script>
</c:if>
</body>
</html>