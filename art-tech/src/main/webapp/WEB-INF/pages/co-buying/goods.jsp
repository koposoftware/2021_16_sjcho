<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>하나 Art</title>
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
                        <p>공동구매</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    <!-- service_area  -->
    <div class="service_area">
    	
        <div class="container">
        	<div class="total_items_container">
    			<p>Total ${fn:length(artworkInfoList)} items </p>
    		</div>
            <div class="row">
            	<c:forEach items="${artworkInfoList }" var="artworkInfo" >
	            	<!-- 하나  -->
	                <div class="col-md-6 col-lg-4 goodsItem-div">
	                    <div class="single_service goods-items-div">
	                        <div class="thumb ">
	                            <img class="goodsImg" src="/artworkImg/${artworkInfo.artworkImg }" alt="">
	                        </div>
	                        <div class="service_info goods-items-content-div">
	                        	<c:choose>
	                        		<c:when test="${artworkInfo.state == 0 }">
	                        			<span class="goods-state1">모집 예정</span>
	                        		</c:when>
	                        		<c:when test="${artworkInfo.state == 1 }">
	                        			<span class="goods-state1">모집 중</span>
	                        		</c:when>
	                        		<c:when test="${artworkInfo.state == 2 || artworkInfo.state == 3 || artworkInfo.state == 4 }">
	                        			<span class="goods-state2">모집 완료</span>
	                        		</c:when>
	                        		<c:when test="${artworkInfo.state == 5 }">
	                        			<span class="goods-state2">매각 중</span>
	                        		</c:when>
	                        		<c:otherwise>
	                        			<span class="goods-state2">수익 분배</span>
	                        		</c:otherwise>
	                        	</c:choose>
	                            <p class="goods-title"><a href="${pageContext.request.contextPath}/co-buying/goodsDetail/${artworkInfo.id}">${artworkInfo.title }</a></p>
	                            <p>${artworkInfo.writerName }</p>
	                            
	                            <div class="progress">
								  <div class="progress-bar" role="progressbar" style="width: ${(artworkInfo.achiePiece / artworkInfo.targetPiece ) * 100}%; background-color: #008485" aria-valuenow="${artworkInfo.achiePiece}" aria-valuemin="0" aria-valuemax="${artworkInfo.targetPiece }"></div>
								</div>
	                            <p> ${artworkInfo.achiePiece } / ${artworkInfo.targetPiece } 조각 </p>
	                       	</div>
	                    </div>
	                </div>
	                <!-- 하나 끝  -->
                </c:forEach>
                
                
				
                
                
            </div>
            <div class="myDeposit_paging_container">
				<ul	class="pagination">
					<c:if test="${paging.startPage != 1 }">
						<li><a href="${pageContext.request.contextPath}/co-buying/goods/${paging.startPage - 1 }"> &lt; </a></li>
					</c:if>
					<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
						<c:choose>
							<c:when test="${p == paging.nowPage }">
								<li><a href="#">${p }</a></li>
							</c:when>
							<c:when test="${p != paging.nowPage }">
								<li><a href="${pageContext.request.contextPath}/co-buying/goods/${p }">${p }</a></li>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.endPage != paging.lastPage}">
						<li><a href="${pageContext.request.contextPath}/co-buying/goods/${paging.endPage+1 }"> &gt; </a></li>
					</c:if>
					
					
				</ul>
			</div>
        </div>
    </div>
    <!--/ service_area  -->
</body>
</html>