<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:if test="${not empty param.idx }">
	${likeDAO.delete(param.idx) }
	<c:redirect url="/fish_list.jsp" />
</c:if>

<c:if test="${empty param.idx }">
	${likeDAO.insert(login.userid, param.fish_idx) }
	<c:redirect url="/fish_list.jsp" />
</c:if>

</body>
</html>