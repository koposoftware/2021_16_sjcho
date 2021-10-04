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
				  height : 500,
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
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="writerRegister_container">
					<div class="main_title">
						<p>공지 등록</p>
					</div>
					<form action="${pageContext.request.contextPath}/manage/noticeRegister" method="post" enctype="multipart/form-data">
						<table>
							<tr>
								<th >제목</th>
								<td><input type="text" name="title" class="notice-title-input"></td>
							</tr>
							<tr>
								<th>구분</th>
								<td>
									<select name="type">
										<option value="1">공지</option>
										<option value="2">이벤트</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea class="summernote" name="content"></textarea></td>
							</tr>
							
						</table>
						<div class="div_center">
							<input type="submit" value="등록">
						</div>
					</form>
				</div>
			</div>
		</section>
		
	</div>
</body>
</html>