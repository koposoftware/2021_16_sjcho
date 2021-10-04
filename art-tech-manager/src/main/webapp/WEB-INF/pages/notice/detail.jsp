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

  
	
</head>
<body>
	<div class="contents-wrap2">
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="writerRegister_container">
					<div class="main_title">
						<p>공지</p>
					</div>
					<form action="">
						<table id="writerDetailTable">
							<tr>
								<th>구분</th>
								<c:if test="${notice.type ==1 }">
									<td>공지</td>
								</c:if>
								<c:if test="${notice.type ==2 }">
									<td>이벤트</td>
								</c:if>
							</tr>
							<tr>
								<th>제목</th>
								<td>${notice.title }</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${notice.content }</td>
							</tr>
							<tr>
								<th>작성일</th>
								<td>${notice.regDate }</td>
							</tr>
						</table>
						<div class="div_center">
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/manage/noticeList'">목록</button>
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