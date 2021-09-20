<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				  height : 200,
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
			
				
		});	
	</script>
  
	
</head>
<body>
	<div class="contents-wrap1">
		<!-- Start Banner Hero -->
	    <div id="work_banner_writer" class="banner-wrapper bg-light w-100 py-5">
	        <div class="banner-vertical-center-work container text-light d-flex justify-content-center align-items-center py-5 p-0">
	            <div class="banner-content col-lg-8 col-12 m-lg-auto text-center">
	                <h1 class="banner-heading h2 display-3 pb-5 semi-bold-600 ">Writer</h1>
	                <h3 class="h4 pb-2 regular-400"></h3>
	                <p class="banner-body pb-2 light-300">
	                </p>
	            </div>
	        </div>
	    </div>
	    <!-- End Banner Hero -->
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="writerRegister_container">
					<div class="main_title">
						<p>작가 등록</p>
					</div>
					<form action="${pageContext.request.contextPath}/manage/writerRegisterPro" enctype="multipart/form-data" method="post">
						<table>
							<tr>
								<th>작가명</th>
								<td><input type="text" name="writerName"></td>
							</tr>
							<tr>
								<th>작가 사진</th>
								<td><input type="file" name="attachfile"></td>
							</tr>
							<tr>
								<th>작가정보</th>
								<td><textarea class="summernote" name="writerInfo"></textarea></td>
							</tr>
							<tr>
								<th>수상이력</th>
								<td><textarea class="summernote" name="awardHistory"></textarea></td>
							</tr>
							<tr>
								<th>전시이력</th>
								<td><textarea class="summernote" name="career"></textarea></td>
							</tr>
							
						</table>
						<div class="div_center">
							<input type="submit" value="등록">
						</div>
					</form>
				</div>
			</div>
		</section>
		<script type="text/javascript">
			//작가 select box 검색 가능하게 하기
			$('#ee').select2();		
		</script>
	</div>
</body>
</html>