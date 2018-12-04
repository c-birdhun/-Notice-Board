<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!-- upload될수 있도록 환경을 만들어주는 전처리 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- upload될수 있도록 환경을 만들어주는 전처리 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String uploadPath = request.getRealPath("/down"); //파일의 저장 경로 지정
	int size=10*1024*1024; //받을 수 있는 최대 파일의 사이즈
	String name="";
	String title="";
	String filename1="";
		try{
	  	MultipartRequest multi= new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
  		//method 생성 (중간에 "utf-8"은 파일의 이름을 한글 형태로 표현해 주기 위한 것.)
  		name= multi.getParameter("name");
    	System.out.println(name);
    	title= multi.getParameter("title");
    	Enumeration files = multi.getFileNames();
    	String file1= (String)files.nextElement();
    	filename1= multi.getFilesystemName(file1);
	  		
		int b_id=0;
		String b_name= multi.getParameter("b_name");
		String b_mail= multi.getParameter("b_mail");
		String b_title= multi.getParameter("b_title");
		String b_content= multi.getParameter("b_content");
		String b_pwd=  multi.getParameter("b_pwd");
		String b_file = filename1;
		  
	    Class.forName("com.mysql.jdbc.Driver");
  	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
  	    Statement stmt = conn.createStatement();
  	    ResultSet rs = stmt.executeQuery("select max(b_id) from ex_board");
  	    if(rs.next()){
		    b_id = rs.getInt(1);
		    b_id = b_id + 1;
		    rs.close();
		    stmt.close();	   
  	    }else{
  		    b_id = 1;
  	    }
  	    if(b_file == null){
  		   b_file = " ";
  	    } 
	  	PreparedStatement pstmt = conn.prepareStatement("insert into ex_board (b_id, b_name, b_mail, b_title, b_content, b_date, b_view, b_pwd, b_file) values(?,?,?,?,?, now(), 0, ?,?)");
	  	pstmt.setInt(1, b_id);
		pstmt.setString(2, b_name);
		pstmt.setString(3, b_mail);
		pstmt.setString(4, b_title);
		pstmt.setString(5, b_content);
		pstmt.setString(6, b_pwd);
		pstmt.setString(7, b_file);
	  
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("list.jsp");
  		}catch( Exception e){
	  		out.println(e);
		}
	%>
</body>
</html>