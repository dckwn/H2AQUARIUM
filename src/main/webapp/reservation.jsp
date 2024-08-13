<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<jsp:useBean id="dto" class="reservation.ReserveDTO"/>
<jsp:setProperty property="*" name="dto"/>

<c:set var="row" value="${reserveDAO.insert2(dto) }"/>
<c:if test="${row != 0 }">
			<script>
				alert('예약이 완료되었습니다.')
				location.href = '${cpath }/index.jsp'
			</script>
		</c:if>
		<c:if test="${row == 0 }">
			<script>
				alert('예약 실패')
				history.go(-1)
			</script>
		</c:if>

</body>
</html>