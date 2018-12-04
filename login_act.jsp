<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page session="true"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<%
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	//login에서 id와 password값을 받아옴.
	id = new String(id.getBytes("8859_1"), "utf-8");
	pw = new String(pw.getBytes("8859_1"), "utf-8");
	//한글깨짐 방지
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	Boolean isLogin = false;
	//mysql 연동과 로그인 여부 위해 변수선언
	try{
		Class.forName("com.mysql.jdbc.Driver");
		//jdbc드라이버 로드
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam","12345");
		//드라이버 매니저로 mysql db에 연결
		stmt = (Statement) conn.createStatement();
		//list.jsp와 동일 db연동, 쿼리를 전송할수 있는 객체를 얻는다.
		rs = stmt.executeQuery("select * from rop where id='" + id + "' and password='" + pw + "'" );
		//rop테이블에서 id와 password 일치하는 값을 선택해서 얻어옴
		while( rs.next() ){//출력할 값이 있으면
			session.setMaxInactiveInterval(3600);
		    session.setAttribute( "id", "true" );
		    //interval 값 설정 후, id세션과 값을 출력해줌
		    out.print( id );
		    out.print( " 로그인 완료." );
		    //세션에 저장된 id값과 print출력
		    isLogin = true; //로그인 성공
		    %>
			<br />
			<a href="list.jsp">초기화면으로</a>
			<%
		}
		if( !isLogin ){
			//islogin이 false유지된다면. 즉 login 실패
	    	out.print( "회원정보가 없습니다. " );
  			 %>
			<br>
			<a href="login.jsp"><input type="button" name="input" value="뒤로가기" /></a>
			<br>
			<a href="list.jsp"><input type="button" name="input" value="목록" /></a>
			<%
   		}
	}catch (Exception e) {
		out.println(e);
	} //예외처리
%>
</body>
</html>