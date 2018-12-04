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
		String bid = request.getParameter("bid");
		//bid 값을 받아와서 bid라는 변수에 값 저장
		Class.forName("com.mysql.jdbc.Driver");
		//jdbc드라이버 로드
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
		//드라이버 매니저로 mysql db에 연결
		Statement stmt = conn.createStatement();
		//list.jsp와 동일 db연동, 쿼리를 전송할수 있는 객체를 얻는다.
		String sql = "delete from ex_board where b_id=" + bid;
		//b_id값이 불러온 bid의 값과 동일한 결과물을 제거
		stmt.execute(sql);
		//쿼리 실행
		stmt.close();
		conn.close();
		//닫아줌
		response.sendRedirect("list.jsp");
		//list.jsp로 돌아감
	%>
</body>
</html>