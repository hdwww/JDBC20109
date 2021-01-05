<%@page import="member.MemberVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한글 안깨지게 인코딩설정
	request.setCharacterEncoding("utf-8");
	//memno값 인트로 가져오기
	int memno = Integer.parseInt(request.getParameter("memno"));
	//pass값 스트링 가져오기
	String pass = request.getParameter("pass");
	
	MemberDAO instance = MemberDAO.getInstance();
	/* //연결객체
	Connection conn = instance.getConnection();

	//셀렉트 실행하는 쿼리문
	String selectSql = "SELECT ID, PASS FROM MEMBER_TBL WHERE MEMNO = ?";
	//딜리트 실행하는 쿼리문
	String deleteSql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?";
	int cnt = 0;
	//회원 탈퇴 성공여부 알려주는 메세지
	String msg = null;
	//동적할당 pstmt객체
	PreparedStatement pstmt = conn.prepareStatement(selectSql);
	pstmt.setInt(1, memno);
	ResultSet rs = pstmt.executeQuery();

	if (rs.next()) {
		String dbPass = rs.getString("pass");
		//저장된 비밀번호와 입력한 비밀번호가 다른지 체크
		if (pass.equals(dbPass)) {
			//딜리트쿼리문 실행
			pstmt = conn.prepareStatement(deleteSql);
			pstmt.setInt(1, memno);
			cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				msg = "회원 탈퇴 완료";
			}
		} else {
			msg = "비밀번호 오류";
		}
	} */
	MemberVO member = new MemberVO();
	member.setMemno(memno);
	member.setPass(pass);
	//cnt초기화해줌
	int cnt = 0;
	//회원탈퇴 된건지 확인해주는 msg 만들어준다
	String msg = null;
	//cnt로 회원이 탈퇴 , member에 있는지 확인
	cnt = instance.deleteMember(member);
	
	if (cnt > 0) {
		msg = "회원 탈퇴 완료";
	} else {
		msg = "비밀번호 오류";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<script type="text/javascript">
		//메세지띄워 회원탈퇴 성공 알려줌
		alert('<%=msg%>');
		//history.go(-1);
		location.href = 'selectMember.jsp';
	</script>

</body>
</html>