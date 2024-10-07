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
				 alert("������ �Ϸ�Ǿ����ϴ�.");
				 window.location.href = "/mavenBoard/main.ino";
				 }
			 },
			 error: function(e){
				 alert("�� ������ �����Ͽ����ϴ�."+e.responseText);
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
				alert("������ �Ϸ�Ǿ����ϴ�");
				window.location.href = "/mavenBoard/main.ino";
			 }
			},
			error: function(e){
				alert("�� ������ �����Ͽ����ϴ�"+e.responseText);
			}
			
		});
		 
	 });
	 
 });

</script>
<body>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01" <c:if test="${freeBoardDto.codeType eq '01'}">selected</c:if>>����</option>
							<option value="02" <c:if test="${freeBoardDto.codeType eq '02'}">selected</c:if>>�͸�</option>
							<option value="03" <c:if test="${freeBoardDto.codeType eq '03'}">selected</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" class="modify" value="����" >
					<input type="button" class="delect" value="����" >
					<input type="button" value="���" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>

</body>
</html>