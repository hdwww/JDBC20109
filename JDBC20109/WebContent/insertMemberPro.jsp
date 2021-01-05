<%@page import="member.MemberVO"%>
<%@page import="java.sql.*"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//name, id, pass, birth, gender, job, city 가져와준다
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String gender = request.getParameter("gender");
	String job = request.getParameter("job");
	String city = request.getParameter("city");

	//membervo를 연결해줘서
	MemberVO member = new MemberVO();
	//name, id, pass, birth, gender, job, city 가져와준다
	member.setName(name);
	member.setId(id);
	member.setPass(pass);
	member.setBirth(birth);
	member.setGender(gender);
	member.setJob(job);
	member.setCity(city);

	/* MemberDAO instance = MemberDAO.getInstance();
	Connection conn = instance.getConnection();
	String getNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
	int memno = 0;
	PreparedStatement pstmt = conn.prepareStatement(getNoSql);
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
		memno = rs.getInt(1) + 1;
	}

	String insertSql = "INSERT INTO MEMBER_TBL(memno, name, id, pass, birth, gender, job, city, joindate) "
			+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
	pstmt = conn.prepareStatement(insertSql);
	String msg = null;
	int cnt = 0;
	pstmt.setInt(1, memno);
	pstmt.setString(2, name);
	pstmt.setString(3, id);
	pstmt.setString(4, pass);
	pstmt.setInt(5, birth);
	pstmt.setString(6, gender);
	pstmt.setString(7, job);
	pstmt.setString(8, city); */
	
	MemberDAO instance = MemberDAO.getInstance();
	
	//회원가입 된건지 체크 해주는 cnt
	boolean cnt = false;
	//msg로 회원 가입 성공 실패 여부 알려줌
	String msg = null;
	cnt = instance.insertMember(member);
	if (cnt) {
		msg = "회원 가입 성공";
	} else
		msg = "회원 가입 실패";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<script type="text/javascript">
		//alert창으로 띄워줌
		alert('<%=msg%>');
		location.href = 'selectMember.jsp';
	</script>
</body>
</html>