<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Transportion</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->

    
</head>
<body>
	<!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>작품별 소유자 현황</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    
    <div class="container">
    	<div class="myDeposit_inout_container">
    		<div>
	    		<span>
		    		<select>
		    			<option>전체</option>
		    			<option>모집완료</option>
		    			<option>렌탈중</option>
		    			<option>매각중</option>
		    		</select>
	    		</span>
	    		<span class="ownership_keyword">
	    			<input type="text" placeholder="작가 및 작품명을 입력하세요.">
	    		</span>
    		</div>
    	</div>
    	
    	<div class="ownership_container">
    	
    		<c:forEach items="${ownershipList }" var="ownership">
	    		<div class="div_left">
					<div class="artwork_img">
						<img alt="" src="/artworkImg/${ownership.artworkImg }">
					</div>
					<div class="artwork_title">
						<p class="title">${ownership.title }</p>
						<p class="writer">${ownership.writerName }</p>
					</div>
					<div class="artwork_piece">
						<p class="title">조각 수</p>
						<p class="writer"><b class="p_tag_bold">${ownership.achiePiece }</b> 조각</p>
					</div>	    		
	    		</div>
	    		<div class="div_right">
					<div class="recruit_date">
						<p class="title">모집 날짜</p>
						<p class="content">${ownership.recruitStartDate } ~ ${ownership.recruitEndDate }</p>
					</div>
					<div class="recruit_state">
						<P>${ownership.stateName }</P>
					</div>
					<div class="detail">
						<a href="${pageContext.request.contextPath}/co-buying/ownershipDetail/${ownership.id}"><p>소유자 확인</p></a>
					</div>
	    		</div>
	    		<div class="ownership_container_margin" ></div>
    		</c:forEach>
    		
    	</div>
    	
    	<div class="myDeposit_paging_container">
			<ul	class="pagination">
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
			</ul>
		</div>
	    	
	    	
	    	
	    	
	    	
	    	
    </div>
</body>
</html>