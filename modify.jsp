<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.* "%>
<%
	String b_name = null, b_mail = null, b_title = null, b_content = null;
	String bid = request.getParameter("bid");
	/* database Driver setup  */
	Class.forName("com.mysql.jdbc.Driver");
	//jdbc드라이버 로드
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
	//드라이버 매니저로 mysql db에 연결
	Statement stmt = conn.createStatement();
	//list.jsp와 동일 db연동, 쿼리를 전송할수 있는 객체를 얻는다.
	String sql = "select b_name, b_mail, b_title, b_content from ex_board where b_id=" + bid;
	//ex테이블에서 bid 값과 동일한 값 선택 쿼리문
	ResultSet rs = stmt.executeQuery(sql);
	//select 쿼리 실행
	if (rs.next()) {
		b_name = rs.getString(1);
		b_mail = rs.getString(2);
		b_title = rs.getString(3);
		b_content = rs.getString(4);
	}//결과값이 있을경우 각 변수에 getString로 각 번째의 값을 초기화시켜줌
	rs.close();
	stmt.close();
	conn.close();
	//데이터사용 닫아줌
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
	function check() {
		if (document.myform.b_name.value.length == 0) {
			alert("작성자를 입력하세요");
			myform.b_name.focus();
			return false;
		}
		if (document.myform.b_title.value.length == 0) {
			alert("제목을 입력하세요");
			myform.b_title.focus();
			return false;
		}
		if (document.myform.b_content.value.length == 0) {
			alert("내용을 입력하세요");
			myform.b_content.focus();
			return false;
		}
		if (document.myform.b_pwd.value.length == 0) {
			alert("수정시 필요한 비밀번호를 입력하세요");
			myform.b_pwd.focus();
			return false;
		}
		document.myform.submit();

	}
</script>
</head>
<body>
	<div>게시글 수정 페이지</div>
	<form name="myform" action="modify_act.jsp" method="post">
		<!-- modify_act로 값을 날려주기 위해 form설정  -->
		<table border="1" cellspacing="0" cellpadding="5">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="b_name" value="<%=b_name%>">
				</td>
			</tr>

			<tr>
				<td>메일</td>
				<td><input type="text" name="b_mail" value="<%=b_mail%>">
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="b_title" value="<%=b_title%>">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="50" name="b_content"><%=b_content%></textarea>
				</td>
			</tr>

			<tr>
				<td>비밀번호(사용자인증처리)</td>
				<td><input type="password" name="b_pwd"></td>
			</tr>

		</table>
		<input type="hidden" name="b_id" value="<%=bid%>"> <input
			type="button" value="수정" onclick="check()"> <input
			type="reset" value="취소"> <a href="list.jsp"> 게시글 목록 </a>
	</form>
</body>
</html>