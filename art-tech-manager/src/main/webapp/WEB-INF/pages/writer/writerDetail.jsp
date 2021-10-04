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

  
	
</head>
<body>
	<div class="contents-wrap2">
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
						<p>작가</p>
					</div>
					<form action="">
						<table id="writerDetailTable">
							<tr>
								<th>작가명</th>
								<td>${writerInfo.writerName }</td>
							</tr>
							<tr>
								<th>작가 사진</th>
								<td><img class="writer_img_td" alt="" src="/writerImg/${writerInfo.fileChanName}"></td>
							</tr>
							<tr>
								<th>작가정보</th>
								<td>${writerInfo.writerInfo }</td>
							</tr>
							<tr>
								<th>수상이력</th>
								<td>${writerInfo.awardHistory }</td>
							</tr>
							<tr>
								<th>전시이력</th>
								<td>${writerInfo.career }</td>
							</tr>
							
						</table>
						<div class="div_center">
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/manage/writerList'">목록</button>
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