<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.net.URLEncoder" %>
<%@ include file="header.jsp" %>

<c:set var="check" value="${memberDAO.check(param.userid) }"/>

<c:if test="${check == true }">
	<c:redirect url="join.jsp?userid=${URLEncoder.encode(param.userid, 'UTF-8') }" />
</c:if>

<c:if test="${check == false }">
	<c:redirect url="join.jsp?userid=ttttttttttttttttttttttttt"/>
</c:if>