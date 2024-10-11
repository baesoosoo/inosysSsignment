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
			contentType: 'application/json; charset=utf-8',
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
	 
 
	 $('#submitComment').on('click',function(){
		 var commentcon = $('#commentForm').serialize();
		 
		 $.ajax({
			 url:"/mavenBoard/add.ino",
			 type:"POST",
			 data:commentcon,
			 success:function(response){
				 if(response.success){
					 alert("댓글을 작성하였습니다!");
					 location.reload(); 
				 }
			 },
			 error:function(e){
				 alert("댓글 작성을 실패했습니다"+e.responseText);
			 }
		 });
	 })
	 
	 $('.commentModify').on('click',function(){
		 event.preventDefault();
		var commentMid = $(this).data('id');
		var commentCon = $("#commentCon"+commentMid);
		var commentModifyCon = commentCon.find(".commentModifyCon").text().trim();
		var commentWriter = commentCon.find(".commentWriter strong").text().trim();
		console.log("commentWriter>>"+commentWriter);
		
		
		 var commentHtml = `
			 	<p>작성자:<input type="text" class="Mwriter" readonly></p>
		        <textarea  rows="4" cols="50" class="Mcont" name="content" id="content"></textarea>
		        <a href="#" class="saveBtn">저장</a>
		        <a href="#" class="cancelBtn">취소</a>
		    `;
		commentCon.html(commentHtml);
		commentCon.find(".Mwriter").val(commentWriter);
		commentCon.find(".Mcont").val(commentModifyCon);
		
	 
		 $(".saveBtn").on("click",function(){
			var newCommentCon=$("#content").val();
			console.log("newCommentCon>>>"+newCommentCon);
			
			$.ajax({
				url:"/mavenBoard/commentModify.ino",
				type:"POST",
				data:{
					content:newCommentCon,
					num:commentMid
					},
				success:function(response){
					
					if(response.success){
					alert("수정을 성공했습니다.");
					location.reload();
					}
				},
				error:function(e){
					alert("댓글 수정을 실패했습니다"+e.responseText);
				}
			})
			 
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
	
	<h3>댓글</h3>
	<div id="commentCon">
	    <c:forEach var="comment" items="${commentList}">
	    <div id="commentCon${comment.num}">
	       <p class="commentWriter"><strong>${comment.writer} </strong></p><p class="commentModifyCon">${comment.content} </p> <a href="#" class="commentModify" data-id="${comment.num} ">수정</a>  
	       <p><small>${comment.regdate}</small></p>
	    </div>
	    </c:forEach>
	</div>
	
	<form id="commentForm">
	<input type="hidden" value="${freeBoardDto.num } " name="ref_group">
		<table>
			<tr>
				<th><label for="writer">작성자:</label></th>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<td><label for="content">내용:</label></td>
				<td><textarea name="content" rows="5" cols="50"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="button" value="댓글작성" id="submitComment">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>