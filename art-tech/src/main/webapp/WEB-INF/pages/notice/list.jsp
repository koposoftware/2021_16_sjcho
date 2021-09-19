<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
</head>
<body>
	<!-- bradcam_area  -->
    <div class="bradcam_area notice_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>공지사항</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<div class="container notice-container">
		<div class="notice-table-div">
			<table class="table">
				<thead>
					<tr>
						<th>구분</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList}" var="notice">
						<tr onclick="location.href='${pageContext.request.contextPath}/notice/detail/${notice.id}'"> 
							<c:if test="${notice.type == 1 }">
								<td class="text-center">공지 </td>
							</c:if>
							<c:if test="${notice.type == 2 }">
								<td class="text-center">이벤트 </td>
							</c:if>
							<td class="title">${notice.title }</td>
							<td class="text-center">${notice.regDate }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</div>
	</div>
</body>
</html>