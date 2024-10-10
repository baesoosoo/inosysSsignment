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
            alert("�̸��� �Է����ּ���");
            return false; 
        }
        
        if (title == "") {
            alert("������ �Է����ּ���");
            return false; 
        }
        
        if (content == "") {
            alert("������ �Է����ּ���");
            return false; 
        }
        
        return true; 
    }
    
    $(".submit").click(function(e) {
        e.preventDefault(); 

        if (insertCheck()) {
            var confirmSubmit = confirm('���� ����Ͻðڽ��ϱ�?');
            
            if (confirmSubmit) {
            	
        
	            var params = $("form").serialize(); 
                $.ajax({                
                    url: "/mavenBoard/freeBoardInsertPro.ino",
                    type: "POST",  
                    data: params, 
                    success: function(response) {
                    	
	                    	if(response.success){
	                    		
	                        var confirmMain = confirm('�������� ���ư��ðڽ��ϱ�?');
	                        
	                        if (confirmMain) {
	                            window.location.href = "/mavenBoard/main.ino";
	                        } else {
	                            window.location.href = "/mavenBoard/freeBoardDetail.ino?num=" +response.num; 
	                        }
                    	}else{
                    		alert("�� ���⸦ �����Ͽ����ϴ�."+message);
                    	}
                    	
                    },

                    error: function(e) {
                        alert("AJAX ����."+e.responseText);
                    }                
                });
                
            }
        }
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

	<form action="/freeBoardInsertPro.ino" onsubmit="return insertCheck()">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" class="submit" value="�۾���">
					<input type="button" value="�ٽþ���" onclick="reset()">
					<input type="button" value="���" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>