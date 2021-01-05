<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
		<jsp:include page="header.jsp"/>
	<!-- memno값을 가져와서 탈퇴할 회원을 비밀번호를 확인 후 탈퇴시킨다. -->
	<%int memno = Integer.parseInt(request.getParameter("memno")); %>
	<h2>회원 탈퇴</h2>
	<form method="post" action="deleteMemberPro.jsp">
	<input type="hidden" name="memno" value="<%=memno%>">
	<!-- memno를 가져와 -->
	비밀번호 : <input type="password" name="pass">
	 <!-- 비밀번호 확인 -->
	<input type="submit" value="탈퇴">
	<!--버튼 누르면 회원 탈퇴 -->
	</form>
	<jsp:include page="footer.jsp"/>