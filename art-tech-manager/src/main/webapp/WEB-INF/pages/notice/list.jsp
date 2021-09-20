<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		if('${register}' == 'success') {
			$('#index_content_p').text()
			$('#index_content_p').text('공지가 등록되었습니다.')
			$('.index_modal').css('display','block')
			$('body').css("overflow", "hidden");
		}
		//모달 다시 숨기기
		$('.index_modal_cancel').click(function(){
			$('.index_modal').css('display','none')
			$('body').css("overflow", "scroll");
		})
	})
	
</script>
</head>
<body>
	<div class="contents-wrap1">
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="writerList_container div_center">
					<div class="main_title">
						<p>공지</p>
					</div>
					<table class="table">
						<tr>
							<th>구분</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
						<c:forEach items="${noticeList}" var="notice" varStatus="status">
							<tr>
								<c:if test="${notice.type == 1 }">
									<td>공지</td>
								</c:if>
								<c:if test="${notice.type == 2 }">
									<td>이벤트</td>
								</c:if>
								<td><a href="${pageContext.request.contextPath}/manage/noticeDetail/${notice.id}">${notice.title }</a></td>
								<td>${notice.regDate }</td>
							</tr>
						</c:forEach>
						
						
					</table>
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/manage/noticeRegister'">등록</button> <br><br><br><br>
					<div class="row">
			            <div class="btn-toolbar justify-content-center pb-4" role="toolbar" aria-label="Toolbar with button groups">
			                <div class="btn-group me-2" role="group" aria-label="First group">
			                    <button type="button" class="btn btn-secondary text-white">Previous</button>
			                </div>
			                <div class="btn-group me-2" role="group" aria-label="Second group">
			                    <button type="button" class="btn btn-light">1</button>
			                </div>
			                <div class="btn-group me-2" role="group" aria-label="Second group">
			                    <button type="button" class="btn btn-secondary text-white">2</button>
			                </div>
			                <div class="btn-group" role="group" aria-label="Third group">
			                    <button type="button" class="btn btn-secondary text-white">Next</button>
			                </div>
			            </div>
			        </div>
				</div>
			</div>
			
		</section>
		
		<!-- 모달 -->
		<div class="index_modal">
			<div class="index_body" >  
				
				<div class="content">
					<p id="index_content_p"></p>
				</div>
				<hr>
				<div class="select">
					<p class="index_modal_cancel">확인</p>
				</div>
			</div>
		</div>
		
		
	</div>
	
	
</body>
</html>