<%@page import="member.MemberVO"%>
<%@page import="java.sql.*"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 안깨지게 utf인코딩
	request.setCharacterEncoding("utf-8");
	//사용할 변수들 만들어주기
	int memno = Integer.parseInt(request.getParameter("memno"));
	String pass = request.getParameter("pass");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String gender = request.getParameter("gender");
	String job = request.getParameter("job");
	String city = request.getParameter("city");
	//다오 instance 만들어 활용 
	MemberDAO instance = MemberDAO.getInstance();
	//다오에 updatesql쿼리문 작성함
	/* Connection conn = instance.getConnection(); */
	/* String updateSql = "UPDATE MEMBER_TBL SET PASS=?, BIRTH=?, GENDER=?, JOB=?, CITY=? WHERE MEMNO=?";
	int cnt = 0;
	String msg = null;
	PreparedStatement pstmt = conn.prepareStatement(updateSql);
	pstmt.setString(1, pass);
	pstmt.setInt(2, birth);
	pstmt.setString(3, gender);
	pstmt.setString(4, job);
	pstmt.setString(5, city);
	pstmt.setInt(6, memno); */
	//vo 활용해 set해준다
	MemberVO member = new MemberVO();
	member.setMemno(memno);
	member.setPass(pass);
	member.setBirth(birth);
	member.setGender(gender);
	member.setJob(job);
	member.setCity(city);
	
	//정보 수정 성공 여부
	int cnt = 0; 
	//msg로 성공여부 알려줌
	String msg = null;
	
	cnt = instance.updateMember(member);
	if(cnt > 0) {
		msg = "회원 정보 수정 성공";
	} else {
		msg = "회원 정보 수정 실패";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 수정</title>
</head>
<body>
	<script type="text/javascript">
		//alert으로 수정된건지 띄어줌
		alert('<%= msg%>');
		location.href = 'selectMember.jsp';
	</script>
</body>
</html>