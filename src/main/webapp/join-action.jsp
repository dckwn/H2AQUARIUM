<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<body>

	<c:set var="dto" value="${fileutil.getDTO(pageContext.request) }" />
	<c:set var="row" value="${memberDAO.insert(dto) }"/>
	<c:if test="${row != 0 }">
		<c:redirect url="index.jsp"/>
	</c:if>
	<script>
		alert('회원 가입 실패')
		history.go(-1)
	</script>
	
</body>
</html>