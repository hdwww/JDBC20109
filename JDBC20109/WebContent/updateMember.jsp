<%@page import="member.MemberVO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>

<jsp:include page="header.jsp"/>
	<%
		//한글 안깨지게 utf 인코딩
		request.setCharacterEncoding("utf-8");
		//memno 가져와줌 
		int memno = Integer.parseInt(request.getParameter("memno"));
		MemberDAO instance = MemberDAO.getInstance();
		/* Connection conn = instance.getConnection();
		String selectSql = "SELECT * FROM MEMBER_TBL WHERE memno = ?";
		PreparedStatement pstmt = conn.prepareStatement(selectSql);
		pstmt.setInt(1, memno);
		ResultSet rs = pstmt.executeQuery();

		if (rs.next()) { */
		MemberVO member = instance.getAMember(memno);
	%>
	<form action="updateMemberPro.jsp" method="post">
	<table borde="1" style="width:400">
	<tr><td colspan="2" align="center"><b>회원 수정 정보 입력</b></td></tr>
	<!-- 회원번호는 수정할 수 없게 readonly 로 넘겨준다 -->
	<tr><th>회원번호</th><td><input type="text" name="memno" value="<%= member.getMemno()%>" readonly></td></tr>
	<!-- 화면에 블럭처리 disabled  -->
	<tr><th>이름</th><td><input type="text" name="name" value="<%= member.getName()%>" disabled></td></tr>
	<!-- 화면에 블럭처리 disabled  -->
	<tr><th>아이디</th><td><input type="text" name="id" value="<%= member.getId()%>" disabled></td></tr>
	<tr><th>비밀번호</th><td><input type="password" name="pass" value="<%= member.getPass()%>"></td></tr>
	<tr><th>생년(4자리)</th>
	<td><select name ="birth">
	<!-- 2001년부터 2010년까지 고를 수 있게 만들어준다-->
<%for (int i = 2001; i <= 2010; i++) {
		//선택한 년도로 값 넣어줌
		if(member.getBirth() == i) {
%>			<option value = "<%= i %>" selected><%= i %></option>
<% 		} else {
%>			<option value = "<%= i%>"> <%= i %></option>
<%		}
	}
%>		</select></td>
	</tr>
	<tr><th>성별</th>
		<td>
			<!--gender를 확인해준다 -->
<%		if(member.getGender().equals("남자")) {
			//gender가 남자면 남자에 check
%>			<input type="radio" name="gender" value="남자" checked>남자
			<input type="radio" name="gender" value="여자">여자	
<% 		} else {
			//gender가 여자면 여자에 check
%>			<input type="radio" name="gender" value="남자">남자
			<input type="radio" name="gender" value="여자" checked>여자	
<%		}
%>		</td>	
	</tr>
	<tr><th>직업</th>		<td><input type="text" name="job" value="<%= member.getJob()%>"></td></tr>
	<tr><th>도시</th>		<td><input type="text" name="city" value="<%= member.getCity()%>"></td></tr>
	<tr>
		<td colspan ="2" align ="center">
			<!-- hidden으로 화면에 안띄우고 파라미터로 넘겨준다 -->
			<input type="submit" value="수정">	<input type="hidden" value="취소">
			</td>
			</tr>
			</table>
			</form>
			<!-- dao에서updatesql 구현하면서 객체반환 -->
<%-- 	<% } instance.close(null, pstmt, conn); %> --%>

<jsp:include page="footer.jsp"/>
</body>

