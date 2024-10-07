<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<script type="text/javascript">

 $(document).ready(function() {
	 
	 $(".modify").click(function(e){
		 e.preventDefault();
		 
		 var params = $("form").serialize();
		 
		 $.ajax({
			 url: "/mavenBoard/freeBoardModify.ino",
			 type: "POST",
			 data: params,
			 success: function(response){
				 
				 if(response.success){
				 alert("수정이 완료되었습니다.");
				 window.location.href = "/mavenBoard/main.ino";
				 }
			 },
			 error: function(e){
				 alert("글 수정을 실패하였습니다."+e.responseText);
			 }
		 });
	 }); 
	 
	 
	 $(".delect").click(function(e){
		
		var num = $('input[name="num"]').val().trim();
		
		$.ajax({
			url:"/mavenBoard/freeBoardDelete.ino",
			type:"GET",
			data:{
				"num":num
				},
			success:function(response){
				
				if(response.success){
				alert("삭제가 완료되었습니다");
				window.location.href = "/mavenBoard/main.ino";
			 }
			},
			error: function(e){
				alert("글 삭제를 실패하였습니다"+e.responseText);
			}
			
		});
		 
	 });
	 
 });

</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01" <c:if test="${freeBoardDto.codeType eq '01'}">selected</c:if>>자유</option>
							<option value="02" <c:if test="${freeBoardDto.codeType eq '02'}">selected</c:if>>익명</option>
							<option value="03" <c:if test="${freeBoardDto.codeType eq '03'}">selected</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" class="modify" value="수정" >
					<input type="button" class="delect" value="삭제" >
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>

</body>
</html>