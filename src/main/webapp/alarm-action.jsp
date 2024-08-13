<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
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

<c:set var="row" value="${alarmDAO.insert(alarm, 1) }"/>
<h2>${row }</h2>


</body>
</html>