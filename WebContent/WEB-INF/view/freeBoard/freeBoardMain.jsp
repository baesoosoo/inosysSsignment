<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<script type="text/javascript">

	 $(document).ready(function(){
			$('#deleteButton').on('click',function(){
			
			var checked = $('input[type=checkbox]:checked');
			
			console.log(checked.length);
			
			if(checked.length < 1){
				alert("삭제할 데이터를 선택해주세요.");
				return false;
			}
			
			var idList=[];
			
			$.each(checked,function(k,v){
				idList.push($(this).val());
			});
			console.log(idList);
			
			
			$.ajax({
				type: "POST",
				url : "/mavenBoard/freeBoardDeleteAll.ino",
				contentType: 'application/json; charset=utf-8',
				data: JSON.stringify(idList),
				success : function(response){
					
					if(response.success){
						alert("선택한 글을 삭제하였습니다.");
						window.location.href = "/mavenBoard/main.ino";
					}
					
				},
				error: function(e){
					 alert("선택한 글 삭제를 실패하였습니다."+e.responseText);
					 window.location.href="/mavenBoard/main.ino"
				 }
				
			});
			
		});
		
	 });
		
	 
		var row;
		$(document).on('change','#selectOp',function(){
			selectedOption = $(this).val();
			$('.here').empty();
			if(selectedOption == "1"){
				row = 
					`
		        	<select id="stype">
						<option value="01">자유</option>
						<option value="02">익명</option>
						<option value="03">QnA</option>
					</select>
			    `
			}else if(selectedOption == "2"){
				row = `
					<input type="text" id="snumber" name="snumber">
				`
				
			}else if(selectedOption == "3"){
				row = `
					<input type="text" id="scont" name="scont">
				`
			}else if(selectedOption == "4"){
				row = `
					<input type="text" id="ctitle" name="ctitle">
				`
			}else if(selectedOption == "5"){
				row = `
					<input type="text" id="cwriter" name="cwriter">
				`
			}else if(selectedOption == "6"){
				row = `
					<input type="text" id="cdate1"> - <input type="text" id="cdate2">
				`
			}else if(selectedOption == "0"){
				row = ``
			}
			  $(".here").append(row);
		})
		
		
		$(document).on('click', '#search', function() {
		    var selectOne = $('#selectOp').val();
		    var inputCont = "";
		    var currentPage = 1; 
		
		    if (selectOne == "1") {
		        inputCont = $('#stype').val();
		        
		    } else if (selectOne == "2") {
		        inputCont = $('#snumber').val();
		        if (!Number(inputCont)) {
		            alert("숫자만 입력해주세요");
		            return;
		        }
		        
		    } else if (selectOne == "3") {
		        inputCont = $('#scont').val();
		        
		    } else if (selectOne == "4") {
		        inputCont = $('#ctitle').val();
		        
		    } else if (selectOne == "5") {
		        inputCont = $('#cwriter').val();
		        
		    } else if (selectOne == "6") {
		        var cdate1 = $('#cdate1').val();
		        var cdate2 = $('#cdate2').val();
		        if (!Number(cdate1) || !Number(cdate2)) {
		            alert("날짜는 숫자로만 입력해주세요.");
		            return;
		        }
		        inputCont = cdate1 + '-' + cdate2;  
		    }
		
		    console.log(inputCont);
		
		    loadSearchResults(currentPage); 

	   
	    $(document).on('click', '.page-link', function(e) {
	        e.preventDefault();
	        var page = $(this).data('page'); 
	        loadSearchResults(page);
	    });
	
	   
	    function loadSearchResults(page) {
	        $.ajax({
	            url: "/mavenBoard/mainSearch.ino",
	            type: "POST",
	            dataType: 'json',
	            contentType: "application/json; charset=utf-8",
	            data: JSON.stringify({
	                inputCont: inputCont, 
	                selectedOption: selectOne,
	                page: page,
	                pageSize: 5
	            }),
	            success: function(response) {
	                var tableRows = '';
	                if (response.success) {
	                    for (var i = 0; i < response.searchList.length; i++) {
	                        tableRows += '<tr>';
	                        tableRows += '<td><input type="checkbox" value="' + response.searchList[i].num + '"></td>';
	                        tableRows += '<td>' + response.searchList[i].codeType + '</td>';
	                        tableRows += '<td>' + response.searchList[i].num + '</td>';
	                        tableRows += '<td><a href="/mavenBoard/freeBoardDetail.ino?num=' + response.searchList[i].num + '">' + response.searchList[i].title + '</a></td>';
	                        tableRows += '<td>' + response.searchList[i].name + '</td>';
	                        tableRows += '<td>' + response.searchList[i].regdate + '</td>';
	                        tableRows += '</tr>';
	                    }
	                    $('#tb').html(tableRows);
	                } else {
	                    $('#tb').empty();
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("AJAX 오류: " + xhr.status + xhr.statusText + xhr.responseText);
	            }
	        });
	    }
	});

	
		

</script>

<body>

		<div class="box-body">
			<h1>자유게시판</h1>
		</div>
		
		<div>
			<select id="selectOp" name="selectOp">
				 <option value="0">전체</option>
				 <option value="1">타입</option> <!-- selectbox -->
				 <option value="2">번호</option> <!-- input type text 검색버튼 클릭시 숫자인지 확인. -->
				 <option value="3">내용</option> <!-- input type text -->
				 <option value="4">제목</option> <!-- input type text --> 
				 <option value="5">작성자</option> <!-- input type text -->
				 <option value="6">기간</option> <!-- input type text input type text 검색버튼 클릭시 숫자인지 확인 20240924 -->
			</select>
			<span class="here"></span>
			<button id="search">검색</button>
		</div>
		<div style="width:650px;" align="right">
			<a href="./freeBoardInsert.ino">글쓰기</a>
		</div>
		
		<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
	    <table border="1" id="tab">
	        <thead>
	            <tr>
	                <td><input type="checkbox" id="allCheck" name="allCheck"></td>
	                <td style="width: 55px; padding-left: 30px;" align="center">타입</td>
	                <td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
	                <td style="width: 125px;" align="center">글제목</td>
	                <td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
	                <td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
	            </tr>
	        </thead>
	        <tbody id="tb" name="tb">
	            <c:forEach var="dto" items="${list}">
	                <tr>
	                    <td><input type="checkbox" name="RowCheck" value="${dto.num}"></td>
	                    <td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType}</td>
	                    <td style="width: 50px; padding-left: 10px;" align="center">${dto.num}</td>
	                    <td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=${dto.num}">${dto.title}</a></td>
	                    <td style="width: 48px; padding-left: 50px;" align="center">${dto.name}</td>
	                    <td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</div>
	<hr style="width: 600px;">



	<!-- 페이징 처리 -->
	<ul style="display: flex; list-style: none; padding: 0; justify-content: center;">
	    <li style="margin-right: 5px;">
	        <a href="/mavenBoard/main.ino?page=1&pageSize=${pageSize}" data-page="1" class="page-link">◀</a>
	    </li>
	    
	    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
	        <li style="margin-right: 5px;">
	            <a href="/mavenBoard/main.ino?page=${i}&pageSize=${pageSize}" data-page="${i}" class="page-link">${i}</a>
	        </li>
	    </c:forEach>
	
	    <li style="margin-right: 5px;">
	        <a href="/mavenBoard/main.ino?page=${pagination.totalPage}&pageSize=${pageSize}" data-page="${pagination.totalPage}" class="page-link">▶</a>
	    </li>
	</ul>


<br>
	<button id="deleteButton" >삭제</button>
</body>
</html>