<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Writing page</title>
<script language ="JavaScript">
 function check(){
   if(document.myform.b_name.value.length==0){
      alert("작성자를 입력하세요.");
      myform.b_name.focus();
      return false;
   }
   if(document.myform.b_title.value.length==0){
      alert("제목을 입력하세요.");
      myform.b_title.focus();
      return false;
   }
   if(document.myform.b_content.value.length==0){
      alert("내용을 입력하세요.");
      myform.b_content.focus();
      return false;
   }
   if(document.myform.b_pwd.value.length==0){
      alert("수정시 필요한 비밀번호를 입력하세요.");
      myform.b_pwd.focus();
      return false;
   }
   document.myform.submit();//front end
}

</script>
</head>
<body>
<div> <h2>게시글 작성</h2></div>
<form name ="myform" action ="write_act.jsp" method="post" enctype="multipart/form-data">

<table border="1" cellspacing ="0" cellpadding="5">

 <tr>
  <td>작성자 </td>
  <td><input type="text" name="b_name" value=""></td>
 </tr>
  <tr>
  <td>이메일 </td>
  <td><input type="text" name="b_mail" value=""></td>
 </tr>
  <tr>
  <td>제목 </td>
  <td><input type="text" name="b_title" value=""></td>
 </tr>
 
 

  <tr>
  <td>첨부파일 </td>
  <td><input type="file" name="filename1"></td>
 </tr>

 
  <tr>
  <td>내용 </td>
  <td> <textarea rows="10" cols="50" name="b_content"></textarea></td>
 </tr>
  <tr>
  <td>비밀번호 </td>
  <td><input type="password" name="b_pwd" value=""></td>
 </tr>
  <tr>
  <td align="center" colspan ="2">
  <input type="button" value ="저장" onclick="check()">
  <input type="reset" value ="취소" onclick="list.jsp"></td>
 </tr>

</table>
</form>
</body>
</html>