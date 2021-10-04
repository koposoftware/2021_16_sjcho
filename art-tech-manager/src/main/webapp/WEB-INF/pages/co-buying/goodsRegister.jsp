<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.0/jquery.js"></script>
	
	<link href="${pageContext.request.contextPath}/static/css/myCss.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js" defer></script>
	
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
	

	<script type="text/javascript">
		$(document).ready(function() {
			//summernote
			$('.summernote').summernote({
				  height : 400,
				  lang : 'ko-KR',
				  toolbar: [
					    // [groupName, [list of button]]
					    ['fontname', ['fontname']],
					    ['fontsize', ['fontsize']],
					    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
					    ['color', ['forecolor','color']],
					    ['table', ['table']],
					    ['para', ['ul', 'ol', 'paragraph']],
					    ['height', ['height']],
					    ['insert',['picture','link','video']],
					    ['view', ['fullscreen', 'help']]
					  ],
					fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
					fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			  });
			
			
			$("#file").on("change",function () {
	            var fileInput = document.getElementById("file");
	            var files = fileInput.files;
	            var file;
	            
	            for (var i = 0; i < files.length; i++) {
	                file = files[i];
	                $('#fileTd').append('<p>'+ file.name +'</p>')
	            }
	        });
				
		});	
	</script>
  
	
</head>
<body>
	<div class="contents-wrap1">
		<!-- Start Banner Hero -->
	    <div id="work_banner" class="banner-wrapper bg-light w-100 py-5">
	        <div class="banner-vertical-center-work container text-light d-flex justify-content-center align-items-center py-5 p-0">
	            <div class="banner-content col-lg-8 col-12 m-lg-auto text-center">
	                <h1 class="banner-heading h2 display-3 pb-5 semi-bold-600 ">Our Goods</h1>
	                <h3 class="h4 pb-2 regular-400"></h3>
	                <p class="banner-body pb-2 light-300">
	                </p>
	            </div>
	        </div>
	    </div>
	    <!-- End Banner Hero -->
	    
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="artworkRegister_container">
					<div class="main_title">
						<p>작품 등록</p>
					</div>
					<form action="${pageContext.request.contextPath}/manage/goodsRegister" enctype="multipart/form-data" method="post">
						<table>
							<tr>
								<th>작품명</th>
								<td><input type="text" id="goodsName" name="title"></td>
							</tr>
							<tr>
								<th>작가</th>
								<td>
									<select class="form-control" id="writer" name="writerId">
										<c:forEach items="${writerInfoList}" var="writerInfo">
											<option value="${writerInfo.id }">${writerInfo.writerName }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>재료</th>
								<td><input type="text" id="material" name="material"></td>
							</tr>
							<tr>
								<th>작품 사이즈</th>
								<td><input type="text" id="sizeWidth" name="sizeWidth"> X <input id="sizeHeight" type="text" name="sizeHeight"></td>
							</tr>
							<tr>
								<th>제작 연도</th>
								<td><input type="text" name="productionYear" id="productionYear"></td>
							</tr>
							<tr>
								<th>모집 시작 날짜</th>
								<td><input type="date" name="recruitStartDate" id="recruitStartDate"> <input type="time" name="recruitStartTime" id="recruitStartTime"></td>
							</tr>
							<tr>
								<th>모집 종료 날짜</th>
								<td><input type="date" name="recruitEndDate" id="recruitEndDate"> <input type="time" name="recruitEndTime" id="recruitEndTime"></td>
							</tr>
							<tr>
								<th>공동구매 목표 조각 개수</th>
								<td><input type="text" name="targetPiece" id="targetPiece"></td>
							</tr>
							<tr>
								<th>작품 추정가</th>
								<td><input type="text" name="estimatedPriceMin" id ="estimatedPriceMin"> ~ 
								<input type="text" name="estimatedPriceMax" id="estimatedPriceMax"></td>
							</tr>
							<tr>
								<th>작품 사진(여러 장 선택 가능)</th>
								<td id="fileTd">
									<p><input multiple="multiple" type="file" id="file" name="file" style="width: 317px;"/><p>
								</td>
							</tr>
							
							
						</table>
						<p>작품 정보</p>
						<textarea class="summernote" name="artworkContent"></textarea>  
						<div class="div_center register-div">
							<input type="submit" value="등록하기">
						</div>
					</form>
				</div>
			</div>
		</section>
		<script type="text/javascript">
			//작가 select box 검색 가능하게 하기
			$('#writer').select2();		
		</script>
	</div>
</body>
</html>