<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                        <p>소유자현황</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    
    <div class="goodsDetail_container">
	<div class="container">
		
		<div class="row">
			<div class="col-xl-6">
				<div class="ownershipDetail_content_container">
						<!--가로--> 
					<img class="ownershipDetail_img_size" src="/artworkImg/${artworkInfo.artworkImg }" alt="First slide"> 

			</div>
			</div>
			<div class="col-xl-6">
				<div class="ownershipDetail_content_container">
					<div class="goods_info_container">
						<p class="goods_info_title">${artworkInfo.title }</p>
						<p class="goods_info_writer">${artworkInfo.writerName }</p>
						
						<hr>
						<div class="buyingDetail_state">
							<span class="detail_title">추정가</span>
							<span class="detail_state">${artworkInfo.estimatedPriceMin } ~ ${artworkInfo.estimatedPriceMax }KRW</span>
						</div>
						<div class="buyingDetail_state">
							<span class="detail_title">모집기간</span>
							<span class="detail_state">${artworkInfo.recruitStartDate } ~ ${artworkInfo.recruitEndDate }</span>
						</div>
						<div class="buyingDetail_state">
							<span class="detail_title">조각 수</span>
							<span class="detail_state">${artworkInfo.achiePiece }조각</span>
						</div>
						<hr>
						<div class="buyingDetail_state">
							<span class="detail_title">조각거래 현재가</span>
							<span class="detail_state_long">11,000KRW</span>
						</div>
						<div class="buyingDetail_state">
							<span class="detail_title">총 소유</span>
							<span class="detail_state">${fn:length(totalOwnerList)} 명</span>
						</div>
							
					</div>
						
				</div>
			</div>
		</div>
		<div class="artworkInfo_title">
			<p>소유자 현황</p>
		</div>
		<div class="ownership_table_container">
			<table class="table table-hover ownership_inout_table">
			
				<c:forEach items="${totalOwnerList}" var="owner" varStatus="index">
					<c:choose>
						<c:when test="${index.index == 0 || index.index + 1 % 5 == 0}">
							<tr>
								<td><b>${owner.name }</b>님 / <b>${owner.totalPieceNo }</b>조각</td>
						</c:when>
						<c:when test="${index.index % 4 == 0 || index.last} ">
								<td><b>${owner.name }</b>님 / <b>${owner.totalPieceNo }</b>조각</td>
							</tr>
						</c:when>
						<c:otherwise>
							<td><b>${owner.name }</b>님 / <b>${owner.totalPieceNo }</b>조각</td>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
				
			</table>
		</div>
	</div>
	</div>
	
</body>
</html>