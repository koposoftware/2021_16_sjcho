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
			$('#index_content_p').text('작가 정보가 등록되었습니다.')
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
				<div class="writerList_container div_center">
					<div class="main_title">
						<p>작가 목록</p>
					</div>
					<table class="table">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>등록날짜</th>
						</tr>
						<c:forEach items="${writerInfoList}" var="writerInfo" varStatus="status">
							<tr onclick="location.href='${pageContext.request.contextPath}/manage/writerDetail?id=${writerInfo.id}'">
								<td>${status.count }</td>
								<td>${writerInfo.writerName }</td>
								<td>${writerInfo.regDate }</td>
							</tr>
						</c:forEach>
						
						
					</table>
					<div class="writerList-registerbtn-div">
						<button type="button" onclick="location.href='${pageContext.request.contextPath}/manage/writerRegister'">등록</button> <br><br><br><br>
					</div>
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
		<!-- 모달끝 -->
	</div>
	
	
</body>
</html>