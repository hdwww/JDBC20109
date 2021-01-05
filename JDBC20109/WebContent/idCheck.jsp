<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="member.MemberDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	//한글 안깨지도록 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	//아이디 활용해야 하기 때문에 아이디 가져와주기
	String id = request.getParameter("id");
	//다오활용
	MemberDAO instance = MemberDAO.getInstance();
	/* 다오에 selectsql로 코드를 옮겨 select를 실행시킨다*/
	/* Connection conn = instance.getConnection();
	//셀렉트 쿼리문 가져오기
	String checkSql = "SELECT * FROM MEMBER_TBL WHERE id = ?";
	boolean result = false;
	PreparedStatement pstmt = conn.prepareStatement(checkSql);
	pstmt.setString(1, id);

	ResultSet rs = pstmt.executeQuery();
	if (!rs.next())
		result = true; */
	
	boolean result = false;
	//result : 아이디 중복되는지 확인해줌
	result = instance.idAvailableChk(id);
%>
<title>중복 아이디 확인</title>
</head>
<body bgcolor="yellow">
	<div align="center">
		<b><%=id%></b>는
		<!-- 아이디가 겹치는지 확인 -->
		<!-- result, 안겹치면 사용가능 띄워주기-->
		<!-- result가 true일때-->
		<%
			if (result) {
		%><font color="blue">사용 가능</font> 합니다.
		<!-- 아이디 겹쳐 사용불가능-->
		<!-- result = false-->
		<%
			} else {
		%><font color="red">사용 불가능</font> 합니다.
		<%
			}
		%>
		<hr>
		<!--javascript:self.close()"를 사용해서 창을 닫아준다  -->
		<!--self.close()를 사용하면 메세지 없이 브라우저를 닫을 수 있다-->
		<a href="javascript:self.close()">창 닫기</a>
	</div>
</body>
</html>