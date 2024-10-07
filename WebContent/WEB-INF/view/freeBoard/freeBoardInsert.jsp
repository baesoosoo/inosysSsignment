<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<script type="text/javascript">

$(document).ready(function() {    
    function insertCheck() {   
        var name = $('input[name="name"]').val().trim();
        var title = $('input[name="title"]').val().trim();
        var content = $('textarea[name="content"]').val().trim();
        
        if (name == "") {
            alert("이름을 입력해주세요");
            return false; 
        }
        
        if (title == "") {
            alert("제목을 입력해주세요");
            return false; 
        }
        
        if (content == "") {
            alert("내용을 입력해주세요");
            return false; 
        }
        
        return true; 
    }
    
    $(".submit").click(function(e) {
        e.preventDefault(); 

        if (insertCheck()) {
            var confirmSubmit = confirm('글을 등록하시겠습니까?');
            
            if (confirmSubmit) {
            	
        
	            var params = $("form").serialize(); 
                $.ajax({                
                    url: "/mavenBoard/freeBoardInsertPro.ino",
                    type: "POST",  
                    data: params, 
                    success: function(response) {
                    	
	                    	if(response.success){
	                    		
	                        var confirmMain = confirm('메인으로 돌아가시겠습니까?');
	                        
	                        if (confirmMain) {
	                            window.location.href = "/mavenBoard/main.ino";
	                        } else {
	                            window.location.href = "/mavenBoard/freeBoardDetail.ino?num=" +response.num; 
	                        }
                    	}else{
                    		alert("글 쓰기를 실패하였습니다."+message);
                    	}
                    	
                    },

                    error: function(e) {
                        alert("AJAX 오류."+e.responseText);
                    }                
                });
                
            }
        }
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

	<form action="/freeBoardInsertPro.ino" onsubmit="return insertCheck()">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" class="submit" value="글쓰기">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>