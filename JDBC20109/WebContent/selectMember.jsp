<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="header.jsp"/>
	<%
		//하나하나 다 주석 달아주기 (밑에문장)
		MemberDAO instance = MemberDAO.getInstance();
		//오라클 연동
		//con객체 생성
		Connection conn = instance.getConnection();
		//셀렉트 쿼리문 가져오기
		String selectSql = "SELECT * FROM MEMBER_TBL ORDER BY MEMNO";
		//동적할당 pstmt객체 생성
		PreparedStatement pstmt = conn.prepareStatement(selectSql);
		//resultset rs 객체 생성
		ResultSet rs = pstmt.executeQuery();
	%>
	<h2>회원 목록</h2>
	<table border="1">
		<tr align="center">
			<th width="100">회원번호</th>	
			<th width="100">이름</th>
			<th width="100">아이디</th>
			<th width="100">비밀번호</th>
			<th width="100">생년(4자리)</th>
			<th width="50">성별</th>
			<th width="100">직업</th>
			<th width="100">도시</th>
			<th width="100">가입일자</th>
			<th width="50">탈퇴</th>
		</tr>
		<%
			while (rs.next()) {
				/* 저장할 변수타입과 이름(컬럼명)은 일칳시켜준다 */
				int memno = rs.getInt("MEMNO");
				String name = rs.getString("NAME");
				String id = rs.getString("ID");
				String pass = rs.getString("PASS");
				int birth = rs.getInt("BIRTH");
				String gender = rs.getString("GENDER");
				String job = rs.getString("JOB");
				String city = rs.getString("CITY");
				//joindate는 Date로 받아주기
				Date joinDate = rs.getDate("JOINDATE");
		%>
		<tr align="center">
			<!-- -->
			<td width="100"><a href="updateMember.jsp?memno=<%=memno%>"><%=memno%></a></td>
			<td width="100"><%=name%></td>
			<td width="100"><%=id%></td>
			<td width="100"><%=pass%></td>
			<td width="100"><%=birth%></td>
			<td width="50"><%=gender%></td>
			<td width="100"><%=job%></td>
			<td width="100"><%=city%></td>
			<td width="100"><%=joinDate%></td>
			<!--  delete할 memno삭제해줌-->
			<!-- 탈퇴 시켜준디 -->
			<td width="100"><a href="deleteMember.jsp?memno=<%=memno%>">탈퇴</a></td>
		</tr>
		<%
			}
			//객체를 위에서 생성해줬다
			//rs, pstmt, conn객체를 생성한 반대 순서로 close
			//반환해준다
			instance.close(rs, pstmt, conn);
		%>
		</table>
		<jsp:include page="footer.jsp"/>