<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	session = request.getSession(true);
	//세션값을 불러옴
	if (session.getAttribute("id") != null && ((String) session.getAttribute("id")).equals("true")) {
		out.print("로그인 상태입니다. ");
		%>
		<a href="logout.jsp">로그아웃</a>
		<%
	} else {
		%>
		<form action="login_act.jsp" method="post">
		<!-- form으로 login_act에 값을 날려준다. -->
			<ul>
				<li>아 이 디 : <input name="id" type="text" /></li>
				<li>비밀번호 : <input name="password" type="password" /></li>
			</ul>
			<input type="submit" name="login" value="로그인" />
		</form>
		<%
	}
		%>
</body>
</html>