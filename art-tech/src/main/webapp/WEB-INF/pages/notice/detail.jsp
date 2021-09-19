<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
    <div class="container notice-detail-container">
    	<div class="notice-detail-title-container">
    		<div class="title-name1">
    			<c:if test="${notice.type ==1 }">
	    			<p>공지</p>
    			</c:if>
    			<c:if test="${notice.type ==2 }">
	    			<p>이벤트</p>
    			</c:if>
    		</div>
    		<div class="title-name2">
    			<p>${notice.title }</p>
    		</div>
    		<div class="title-date">
    			<p>${notice.regDate }</p>
    		</div>
    	</div>
    	<div class="notice-detail-content-container">
    		<p>
    			${notice.content }
    		</p>
    	</div>
    </div>
</body>
</html>