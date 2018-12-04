<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세보기</title>
</head>
<body>
	<div>
		<h2>글목록 상세보기 페이지</h2>
	</div>
	<%
		String id = (String) session.getAttribute("id");
		try {
			String b_name, b_mail, b_title, b_content, b_date, b_pwd, mailtoyou,b_file;
			int b_id, b_view;
			String bid = request.getParameter("bid");
			//bid값 받아옴
			Class.forName("com.mysql.jdbc.Driver");
			//jdbc드라이버 로드
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
			//드라이버 매니저로 mysql db에 연결
			Statement stmt = conn.createStatement();
			//list.jsp와 동일 db연동, 쿼리를 전송할수 있는 객체를 얻는다.
			String sql = "select b_id, b_name, b_mail, b_title, b_content, date_format(b_date, '%Y/%c/%e'), b_view, b_pwd,b_file from ex_board where b_id="
					+ bid;
			//ex_board에서 b_id ~ b_pwd의 값과 b_id =bid 를 만족하는 값을 선택
			ResultSet rs = stmt.executeQuery(sql);
			//select쿼리문 실행
			if (rs.next()) {
				b_id = rs.getInt(1);
				b_name = rs.getString(2);
				b_mail = rs.getString(3);
				b_title = rs.getString(4);
				b_content = rs.getString(5);
				b_date = rs.getString(6);
				b_view = rs.getInt(7);
				b_pwd = rs.getString(8);
				b_file= rs.getString(9);
				////각번째 결과 값을 int,String형으로 변수에 집어 넣기
				if (!b_mail.equals("")) {
					mailtoyou = "(<a href=mailto:" + b_mail + ">" + b_mail + "</a>)";
				} else {
					mailtoyou = "b_name";
				}//하이퍼링크 걸기. mail존재 할 경우.
	%>
	<div>
		<h2>게시글 상세보기 내용</h2>
	</div>
	<table>
		<tr>
			<td>
				<table cellspacing="0" cellpadding="5" width="780" border="1">
					<tr>
						<th>No</th>
						<th>이미지</th>
						<th>제목</th>
						
						<th>작성자</th>
						<th>이메일</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>글 내용</th>
					</tr>
					<tr>
						<td  align="center"><%=b_id%></td>
						<td  style="width:180px;height:100px;"> <a href="down/<%=b_file %>"><img src="down/<%=b_file %>" width=180, height=100 "> </a>  </td>
						<td  align="center"><%=b_title%></td>
						<td  align="center"><%=b_name%></td>
						<td  align="center"><%=mailtoyou%></td>
						<td  align="center"><%=b_date%></td>
						<td  align="center"><%=b_view%></td>
						<td  align="center"><%=b_content%></td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	<br>
	<div>
		<%
			if (id != null) {%>
		<a href="modify.jsp?bid=<%=b_id%>"> 게시글 수정 </a>   |   <a
			href="delete.jsp?bid=<%=b_id%>"> 게시글 삭제</a>   |   <a href="write.jsp">게시글
			작성   |   </a>
		<%}
		
		%>
		<a href="list.jsp">게시글 목록 페이지 </a>
	</div>
	<%
		}
			rs.close();
			stmt.executeUpdate("update ex_board set b_view= b_view+1 where b_id=" + bid + "");
			stmt.close();
			conn.close();
		} catch (Exception e) {
			out.println(e);
		}
	%>
	<br>
	<div></div>
	<div></div>
</body>
</html>