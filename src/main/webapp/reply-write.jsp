<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:if test="${empty login }">
	<script>
		alert('로그인 후 덧글 작성이 가능합니다')
		location.href = "${cpath }/view.jsp?idx=(param.idx)"
	</script>
</c:if>


<%
	String str = request.getParameter("content");
	String userid = "";
	int cnt = 0;
	for(int i = 0; i < str.length(); i++){
		char ch = str.charAt(i);
		if(cnt == 1 && ch != ' '){
			userid += ch;
		}else if(cnt == 1 && ch == ' '){
			break;
		}
		
		if(ch == '@'){
			cnt++;
		}
	}
	
%>

<c:set var="alarm" value="<%=userid %>"/>

<h1>${alarm }</h1>

<c:if test="${not empty alarm  }">
<c:set var="row" value="${alarmDAO.insert(alarm, param.fish_idx) }"/>
</c:if>
<jsp:useBean id="dto" class="reply.ReplyDTO" />
<jsp:setProperty property="*" name="dto" />

<c:set var="row" value="${replyDAO.insert(dto) }" />

<c:if test = "${row != 0 }">
	<c:redirect url="view.jsp?idx=${dto.fish_idx }#reply" />
</c:if>

<c:if test = "${row == 0  }">
	<script>
		alert('덧글 작성에 실패 하였습니다')
		history.back()
	</script>
</c:if>
</body>
</html>