<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
<jsp:include page="header.jsp"/>
	<h2>회원 가입</h2>
	<form method="post" action="insertMemberPro.jsp" name="regForm">
		<table border="1" style="width: 400">
			<tr>
				<td colspan="2" align="center"><b>회원가입 정보 입력</b></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" value="강길동"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id"> <input type="button"
					value="중복확인" onclick="idCheck(this.form.id.value)"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pass" vlaue="1234"></td>
			</tr>
			<tr>
				<th>생년(4자리)</th>
				<td><select name="birth">
						<%
							for (int i = 2001; i <= 2010; i++) {
						%>
						<option value="<%=i%>">
							<%=i%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" name="gender" value="남자" checked>남자
					<input type="radio" name="gender" value="여자">여자</td>
			</tr>
			<tr>
				<th>직업</th>
				<td><input type="text" name="job" value="학생"></td>
			</tr>
			<tr>
				<th>도시</th>
				<td><input type="text" name="city" value="성남"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="가입"><input
					type="reset" value="재작성"></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		function idCheck(id) {
			//id가 공백, 비어있으면 다시 입력해주기 위해
			if (id == "") {
				//alert창 띄워 아이디 경고띄어주고 다시 입력
				alert("아이디를 입력해 주세요.");
				document.regForm.id.focus();
			} else {
				//아이디를 입력했으면 
				url = "idCheck.jsp?id=" + id;
				//window.open으로 입력한 아이디에 해당하는 새창을 띄어준다
				window.open(url, "post", "width=400,height=200");
			}
		}
	</script>
<jsp:include page="footer.jsp"/>
</body>
</html>