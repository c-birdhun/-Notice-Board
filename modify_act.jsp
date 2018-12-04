<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.* "%>
<%
    try{
    	String b_name = new String(request.getParameter("b_name").getBytes("8859_1"),"utf-8"); 
    	String b_mail = request.getParameter("b_mail");
    	String b_title= new String(request.getParameter("b_title").getBytes("8859_1"),"utf-8");
    	String b_content= new String(request.getParameter("b_content").getBytes("8859_1"),"utf-8");
    	String b_pwd = request.getParameter("b_pwd"); 
    	int b_id = Integer.parseInt(request.getParameter("b_id")); 
    	//수정을 위해 
    	String b_pwd_db = null; 
    	/* database driver setup  */ 
    	Class.forName("com.mysql.jdbc.Driver"); 
    	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ro", "exam", "12345");
    	Statement stmt = conn.createStatement();
    	ResultSet rs = stmt.executeQuery("select b_pwd from ex_board where b_id=" + b_id + ""); 
    	if(rs.next()){
   			b_pwd_db = rs.getString(1); 
   		}
   	 	if(b_pwd.equals(b_pwd_db)){
	   		String sql = "update ex_board set b_name=' " + b_name + "', b_mail='" + b_mail +"', b_title='" + b_title + "', b_content='" + b_content + "' where b_id=" +b_id;
	   		stmt.execute(sql); 
	   		response.sendRedirect("list.jsp"); 
		}else{
			%> 	
	  		<%
   	 	}
	   	 stmt.close(); 
	   	 conn.close(); 
   	
	} catch(Exception e){
		out.println(e); 
	}
    
   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정 처리 페이지</title>
<script language="javascript"> 
alter("사용자 인증번호가 틀립니다. 다시 정확하게 입력해 주세요"); 
history.back(); 
</script>
</head>
<body>
</body>
</html>