<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:if test="${login.userid != 'admin'}">
	<script>
		alert('잘못된 접근 입니다')
		location.href='index.jsp'	
	</script>
</c:if>

<c:if test="${login.userid == 'admin'}">
	<c:set var="row" value="${boardDAO.delete(param.idx) }" />
	<c:if test=${row!=0 }>
	<c:set var="filedelete" value="${fishfile.deleteImageFile(param.image) }"/>
	</c:if>
	
	<c:if test="${row != 0 }">
	<script>
		alert('삭제되었습니다.')
		location.href = '${cpath }/admin.jsp'
	</script>
</c:if>
<c:if test="${row == 0 }">
	<script>
		alert('삭제 실패')
		history.back()
	</script>
</c:if>
</c:if>

</body>
</html>