<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:set var="row" value="${reserveDAO.delete(param.idx) }"/>



<c:if test="${login.isAdmin == 1 }">
<script>
	const row = '${row}'
	if(row != 0) {
		alert('취소되었습니다')
		location.href='${cpath}/admin.jsp'
	}
	else {
		alert('취소 실패')
		history.back()
	}
</script>
</c:if>

<c:if test="${login.isAdmin == 0 }">
<script>
	const row = '${row}'
	if(row != 0) {
		alert('취소되었습니다')
		location.href='${cpath}/myPage.jsp'
	}
	else {
		alert('취소 실패')
		history.back()
	}
</script>
</c:if>

</body>
</html>