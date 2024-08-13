<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:set var="row" value="${memberDAO.delete(param.idx) }"/>
<c:if test="${row!=0 }">
<c:set var="filedelete" value="${fileutil.deleteImageFile(param.profile_image) }"/>
</c:if>

<c:if test="${login.isAdmin == 1 }">
	<script>
	const row = '${row}'
	if(row != 0) {
		alert('탈퇴시켰습니다')
		location.href = '${cpath}/admin.jsp'
	}
	else {
		alert('오류 발생')
		history.back()
	}
</script>
</c:if>

<c:if test="${login.isAdmin == 0 }">
<script>
	const row = '${row}'
	if(row != 0) {
		alert('탈퇴되었습니다')
		location.href = '${cpath}/logout.jsp'
	}
	else {
		alert('탈퇴 실패')
		history.back()
	}
</script>
</c:if>

</body>
</html>