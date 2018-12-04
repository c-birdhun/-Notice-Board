<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>


<!-- 쿼리문을 작성할수 있게 만듬 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>공지사항 게시판</title>
</head>

<div style="margin-left:320px;"> <h1>공지사항</h1> </div>
<body>
	<%
		String filename1 = request.getParameter("filename1");
	    String fullpath = request.getParameter("fullpath");
		String id = (String) session.getAttribute("id");
		//로그인했을때 저장된 값들이 존재하는지 id의 값을 불러옴
		if (id != null) {
	%>
		<div style="margin-left:630px;"><a href="logout.jsp"> 로그아웃 </a></div>
	<%
		} else {
	%>
			<div style="margin-left:650px;"><a href="login.jsp"> 로그인 </a></div>
	<%
		}
	%>
	<table>
		<tr>
			<td>
				<table border="1" width="700">
					<tr>
						<th>번호</th>
						<th>이미지</th>
						<th>제목</th>
						<th>이름</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<%
						try {
							String b_name, b_mail, b_title, b_content, b_date, b_pwd, mailtoyou, b_file;
							int b_id, b_view;
							int datacount = 0;
							int pagecount;
							//db와 연동되었을때 부를수 있는 필드명들과 페이지의값, 게시글 수 데이터 변수선언
							Class.forName("com.mysql.jdbc.Driver");
							//jdbc드라이버 로드
							Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
							//드라이버 매니저로 mysql db에 연결
							Statement stmt = conn.createStatement();
							//list.jsp와 동일 db연동, 쿼리를 전송할수 있는 객체를 얻는다.
							ResultSet rs0 = stmt.executeQuery("select count(b_id) from ex_board");
							//rs0에 ex_board 테이블에서 b_id의 갯수의 결과를 얻는다.
							int pagesize = 10;
							//게시글 갯수
							int mypage = 1;
							//현재 페이지
							int abpage = 1;
							//다음 페이지
							if (rs0.next()) {
								//순차적으로 출력
								datacount = rs0.getInt(1);
								rs0.close();
								//첫번째 결과값을 datacount에 초기화
							}
							pagecount = datacount / (pagesize + 1) + 1;
							if ((pagesize % 10) == 0) {
								pagecount = datacount / (pagesize + 1) + 1;
							} else {
								pagecount = datacount / pagesize + 1;
							}
							//pagecount 초기화 해줌. dataCount에 들어간 숫자를 나눠서 페이지 분할
							if (request.getParameter("mypage") != null) {
								//mypage 파라메터가 null 이아니면
								mypage = Integer.parseInt(request.getParameter("mypage"));
								//mypage의 값이 null이 아닐때
								abpage = (mypage - 1) * pagesize + 1;
								if (abpage <= 0)
									abpage = 1;
								//abpage값  최소 1로 초기화시켜줌
							}
							ResultSet rs = stmt.executeQuery(
									"select b_id, b_name, b_mail, b_title, b_content, date_format(b_date, '%Y-%m-%d'), b_view, b_pwd, b_file from ex_board order by b_id desc");
							////데이터추출메서드 resultset ,쿼리를 DB에 전송하여 결과를 얻는다.
							if (!rs.next()) {
								pagesize = 0;
								//값 다음이 없으면 페이지사이즈 0으로 초기화
							} else {
								rs.absolute(abpage);
							} //결과값이 없다면  abpage의 값을 보여줌
							for (int k = 1; k <= pagesize; k++) {
								b_id = rs.getInt(1);
								b_name = rs.getString(2);
								b_mail = rs.getString(3);
								b_title = rs.getString(4);
								b_content = rs.getString(5);
								b_date = rs.getString(6);
								b_view = rs.getInt(7);
								b_pwd = rs.getString(8);
								b_file = rs.getString(9);
								//각번째 결과 값을 int,String형으로 변수에 집어 넣기
								if (!b_mail.equals("")) {
									mailtoyou = "<a href=mailto:" + b_mail + ">" + b_name + "</a>";
								} else {
									mailtoyou = b_name;
								}
								//이메일에 하이퍼링크 걸기. ""공백이면 그냥 b_name 초기화
					%>
									<tr>
										<td align="center" ><%=b_id%></td>
										<td style="width:180px;height:100px;"> <a href="view.jsp?bid=<%=b_id%>"><img src="down/<%=b_file %>" width=180, height=100 style="margin-right:-100px;"></a><br></td>
										<td  align="center"><a href="view.jsp?bid=<%=b_id%>"><%=b_title%></a></td>
										<td  align="center"><%=mailtoyou%></td>
										<td  align="center"><%=b_date%></td>
										<td  align="center"><%=b_view%></td>
									</tr>
									<!-- 데이터 출력 -->
					<%
								if (rs.getRow() == datacount) {
									//현재 커서가 가르키는 값과 dataCount의 값이 일치하면 for문 나옴
									break;
								} else { //rs의 다음번째로
									rs.next();
									//아니면 다음 결과값 보여줌
								}
							}
							rs.close();
							stmt.close();
							conn.close();
							//데이터 소비를막기위해 닫아줌
					%>
				</table>
			</td>
		</tr>
	</table>
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp; &emsp;
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp; &emsp;
	<%	if (id != null) {%>
			<div style="margin-left:620px;">
				<a href="write.jsp"> 게시글 작성 </a>
			</div>
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp; 
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp;  &emsp; &emsp;
			
			
	<%} int gopage = 1;
		if (mypage != 1) {
			gopage = mypage - 1;
			 out.println("<a href=list.jsp?mypage=" + gopage + "> << 이전</a>");
			// ''<<이전'에 gopage 값을 포함한 하이퍼링크를 걸어준다.
		} else {
			out.println("<<이전");
		} //mypage 즉, mypage의 값이 1이면 <<이전이라고 출력만해준다.
		for (int i = 1; i <= pagecount; i++) {
			if (i == mypage) {
				out.println(i);
			} //현재 페이지를 보여준다.
		}
		if (mypage != pagecount) {
			gopage = mypage + 1;
			out.println("<a href=list.jsp?mypage=" + gopage + ">다음>></a>");
		} else{//현재 페이지랑 pagecount, 위에서 searchCount로 나누고 더한값의 나머지가 mypage랑 같지않으면 (1페이지이상이란 소리) 
			out.println("다음>>");
		} //'다음>>'출력만해준다.
		} catch (Exception e) {
			out.println(e);
		}
	
	%>
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp; 
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; &emsp; 
<p></p>
	<div style= "margin-left:220px;">
		<form action="search_result.jsp" method="post">
			<select name="search" class="search">
				<option value="b_name">작성자</option>
				<option value="b_title">제목</option>
				<option value="b_content">게시글 내용</option>
			</select> <input type="text" name="keyword"> <input type="submit"
				value="검색">
		</form>
	</div>
</body>
</html>
