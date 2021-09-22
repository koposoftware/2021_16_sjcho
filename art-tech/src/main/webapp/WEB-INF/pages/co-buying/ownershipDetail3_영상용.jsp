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
							<span class="detail_title">최초 조각거래가</span>
							<span class="detail_state_long">10,000KRW</span>
						</div>
						<div class="buyingDetail_state">
							<span class="detail_title">총 소유</span>
							<span class="detail_state">250명</span>
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
				<tr>
					<td><b>하금티</b>님 / <b>200</b>조각</td>
					<td><b>인사팀</b>님 / <b>50</b>조각</td>
					<td><b>총무팀</b>님 / <b>50</b>조각</td>
					<td><b>별돌이</b>님 / <b>30</b>조각</td>
					
				</tr>
				<tr>
					<td><b>법무팀</b>님 / <b>10</b>조각</td>
					<td><b>청라시민</b>님 / <b>10</b>조각</td>
					<td><b>안성재</b>님 / <b>10</b>조각</td>
					<td><b>조세진</b>님 / <b>10</b>조각</td>
				</tr>
				<tr>
					<td><b>윤소영</b>님 / <b>10</b>조각</td>
					<td><b>안재훈</b>님 / <b>10</b>조각</td>
					<td><b>구본성</b>님 / <b>10</b>조각</td>
					<td><b>이기찬</b>님 / <b>10</b>조각</td>
				</tr>
				<tr>
					<td><b>최민기</b>님 / <b>10</b>조각</td>
					<td><b>윤정환</b>님 / <b>10</b>조각</td>
					<td><b>정해명</b>님 / <b>10</b>조각</td>
					<td><b>황준호</b>님 / <b>10</b>조각</td>
				</tr>
				<tr>
					<td><b>김충만</b>님 / <b>10</b>조각</td>
					<td><b>데니얼</b>님 / <b>1</b>조각</td>
					<td><b>홍길동</b>님 / <b>1</b>조각</td>
					<td><b>김길동</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>김재민</b>님 / <b>1</b>조각</td>
					<td><b>임가영</b>님 / <b>1</b>조각</td>
					<td><b>임기은</b>님 / <b>1</b>조각</td>
					<td><b>양소진</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>조혜란</b>님 / <b>1</b>조각</td>
					<td><b>서유현</b>님 / <b>1</b>조각</td>
					<td><b>김슬기</b>님 / <b>1</b>조각</td>
					<td><b>조윤진</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				<tr>
					<td><b>양현석</b>님 / <b>1</b>조각</td>
					<td><b>전지철</b>님 / <b>1</b>조각</td>
					<td><b>이현우</b>님 / <b>1</b>조각</td>
					<td><b>김병웅</b>님 / <b>1</b>조각</td>
				</tr>
				
					
				<!-- 
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
				 -->
			</table>
		</div>
	</div>
	</div>
	
</body>
</html>