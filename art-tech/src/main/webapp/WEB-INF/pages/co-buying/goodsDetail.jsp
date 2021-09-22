<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>하나 Art</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
    
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->
	
	<script type="text/javascript">
		$(document).ready(function(){
			Kakao.init('d1823ddd57768c060556deb5cad1d563');
	    	Kakao.isInitialized();
		})
		function kakaoShare() {
			Kakao.Link.sendDefault({
			  objectType: 'feed',
			  content: { 
			    title: '하나아트 공동구매 작품 공유',
			    description: '[${artworkInfo.writerName }] 화백의 작품 [${artworkInfo.title }]',
			    imageUrl:
			      'https://postfiles.pstatic.net/MjAyMTA5MTdfMSAg/MDAxNjMxODUzMzg1NTY0.v9lqKYFHvWN1FpTh0jWkMZaLlvPCGsb5Vli8sFKCeCQg.TX-Yjv6Ktgck5AuKNlVyAQAQnMVQVNpnaOphQm3o2HQg.JPEG.whtpwls777/%EC%82%AC%EC%9E%A5%EB%8B%98.jpg?type=w773',
			    link: {
			      mobileWebUrl: 'http://localhost:8080/arttech/co-buying/goodsDetail/${artworkInfo.id}',
			      androidExecutionParams: 'test',
			    },
			  },
			  social: {
			    likeCount: 10,
			    commentCount: 20,
			    sharedCount: 30,
			  },
			  buttons: [
			    {
			      title: '웹으로 이동',
			      link: {
			        mobileWebUrl: 'http://192.168.43.55:8080/arttech/co-buying/goodsDetail/${artworkInfo.id}',
			      },
			    }
			  ]
			});
			
		}
	</script>
    
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
    
    <div class="goodsDetail_container">
	<div class="container">
		
		<div class="row">
			<div class="col-xl-6">
				<div class="goodsDetail_content_container">
				<div id="demo" class="carousel slide" data-ride="carousel">

					<div class="carousel-inner"> 
					
						<!-- 슬라이드 쇼 --> 
						<c:forEach items="${artworkInfoImg}" var="img" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 0 }">
									<div class="carousel-item active"> 
										<img class="d-block w-100 goodsDetail_img_size" src="/artworkImg/${img.fileChanName }" alt="First slide"> 
									</div> 
								</c:when>
								<c:otherwise>
									<div class="carousel-item"> 
										<img class="d-block w-100 goodsDetail_img_size" src="/artworkImg/${img.fileChanName }" alt="Second slide"> 
									</div> 
								</c:otherwise>
							</c:choose>
							
						</c:forEach>
						<!-- / 슬라이드 쇼 끝 --> 
						
						
						<!-- 왼쪽 오른쪽 화살표 버튼 --> 
						<a class="carousel-control-prev" href="#demo" data-slide="prev"> 
						<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
						<!-- <span>Previous</span> --> </a> 
						<a class="carousel-control-next" href="#demo" data-slide="next"> 
						<span class="carousel-control-next-icon" aria-hidden="true"></span> 
						<!-- <span>Next</span> --> </a> 
						<!-- / 화살표 버튼 끝 --> 
						
						<!-- 인디케이터 --> 
						<ul class="carousel-indicators"> 
							<c:forEach items="${artworkInfoImg}" var="img" varStatus="status">
								<c:choose>
									<c:when test="${status.index == 0 }">
										<li data-target="#demo" data-slide-to="${status.index }" class="active"></li> 
									</c:when>
									<c:otherwise>
										<li data-target="#demo" data-slide-to="${status.index }"></li> 
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
						</ul> 
						<!-- 인디케이터 끝 --> 
					</div>

				</div>
			</div>
			</div>
			<div class="col-xl-6">
				<div class="goodsDetail_content_container">
					<div class="goods_info_container">
						<p class="goods_info_title">${artworkInfo.title }</p>
						<p class="goods_info_writer">${artworkInfo.writerName }</p>
						<div class="progress">
						  <div class="progress-bar" role="progressbar" style="width: ${(artworkInfo.achiePiece / artworkInfo.targetPiece ) * 100}%; background-color: #008485" aria-valuenow="${artworkInfo.achiePiece }" aria-valuemin="0" aria-valuemax="${artworkInfo.targetPiece }"></div>
						</div>
						<p> ${artworkInfo.achiePiece } / ${artworkInfo.targetPiece } 조각 </p>
						<div class="buying_state_container">
							<hr>
							<div class="buying_state">
								<span class="title">모집금액</span>
								<span class="state">${artworkInfo.achiePrice }/${artworkInfo.targetPrice }KRW</span>
							</div>
							<div class="buying_state">
								<span class="title">모집기간</span>
								<span class="state">${artworkInfo.recruitStartDate } ~ 
								${artworkInfo.recruitEndDate }</span>
							</div>
							<div class="buying_state">
								<span class="title">1조각 당 금액</span>
								<span class="state_two">10,000KRW</span>
							</div>
							<hr>
						</div>
						<div class="buying_btn_center">
							<c:choose>
								<c:when test="${artworkInfo.state == 0 }">
									<span><button class="buying_btn" disabled="disabled">모집예정</button></span>
								</c:when>
                        		<c:when test="${artworkInfo.state == 1 }">
                        			<button class="buying_btn">구입</button>
                        		</c:when>
                        		<c:otherwise>
                        			<button class="buying_btn" disabled="disabled">모집완료</button>
                        		</c:otherwise>
                        	</c:choose>
							
						</div>
						<div class="kakaoShare-btn-container">
							카카오톡으로 공유하기  <img alt="" src="https://t1.daumcdn.net/cfile/tistory/99F7DC3359E9878E0F" width="40px;" height="40px;" onclick="javascript:kakaoShare()">
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div>
			<div class="artworkInfo_title">
				<p>작품정보</p>
			</div>
			<div class="artworkInfo_subheading">
				<p>작품</p>
			</div>
			<table class="table-boarder">
				<tbody>
					<tr>
						<th class="artwork-info-table-th">제목</th>
						<td>${artworkInfo.title }</td>
					</tr>
					<tr>
						<th class="artwork-info-table-th">작가</th>
						<td>${artworkInfo.writerName }</td>
					</tr>
					<tr>
						<th class="artwork-info-table-th" >재료</th>
						<td>${artworkInfo.material }</td>
					</tr>
					<tr>
						<th class="artwork-info-table-th" >사이즈</th>
						<td>${artworkInfo.sizeWidth } x ${artworkInfo.sizeHeight }</td>
					</tr>
					<tr>
						<th class="artwork-info-table-th" >제작연도</th>
						<td>${artworkInfo.productionYear }</td>
					</tr>
					
					
				</tbody>
				
			</table>
			<p>
				${artworkInfo.artworkContent }
								
			</p>
			<div class="artworkInfo_subheading">
				<p>작가 소개</p>
			</div>
			<div class="writer_info_container">
				<img alt="" src="/writerImg/${artworkInfo.fileChanName }">
				<div class="writer_info_subheading">
					<p>${artworkInfo.writerName }</p>
				</div>
				<p>
					${artworkInfo.writerInfo }
				</p>
				<div class="writer_info_subheading">
					<p>주요 전시이력</p>
				</div>
				<p>
					${artworkInfo.career }
				</p>
				<div class="writer_info_subheading">
					<p>추가정보</p>
				</div>
				<p>
					${artworkInfo.awardHistory }
				</p>
			</div>
			
		</div>
		</div>	 <!-- /container -->
	</div>
	
	<!-- 모달 -->
	<div class="buy_modal">
		<div class="buy_modal_body" >  
			<div class="title">
				<p class="main">상품안내</p>
				<p class="sub">구매하기 전 안내사항입니다.</p>
				<hr>
			</div>
			<div class="content">
				<div class="content_block">
					<b>위 상품은 '일반형' 상품입니다.</b>
					<p>
						위 상품은 '일반형' 상품으로 100% 모집되지 않을 시,<br>
						구매기간이 연장될 수 있습니다.
					</p>
				</div>
				<div class="content_block">
					<b>위탁작품의 입고절차</b>
					<p>
						xxxxx의 작품은 철거한 입,출고 절차를 거쳐 <br>
						완벽한 컨디션의 상태로 배송 및 보관됩니다.
					</p>
				</div>
				<div class="content_block">
					<b>모집 종료 후에는 구매를 취소할 수 없습니다.</b>
					<p>
						각 상품에 대한 모집이 종료된 후에는, 구매를 취소할 수 없습니다. <br>
						조각의 구매취소는 모집이 완료되기 전까지만 가능합니다.
					</p>
				</div>
				<div class="content_block">
					<b>작품을 매각하여 수익이 발생할 경우, <br>세금을 납부할 수 있습니다.</b>
					<p>
						소득세법 제 41조 제 1항 25호에 의거하여 양도가액이 6천만원을 초과한<br> 물품의 경우
						매각가의 80% 금액과 위탁가격을 비교하여 큰 금액을 매각<br>가에서 차감하고, 차감액의
						20%(부가가치세 별도)를 소유자에게 부과합니다. 단, 양도일 현재 생존해 있는 국내 원
						작자의 물음은 제외합니다.
					</p>
				</div>
				<div class="content_block">
					<b>공동구매 모집상품에 대한 <br>플랫폼 이용료가 있습니다.</b>
					<p>
						공동구매 모집상품에 대한 플랫폼 이용료가 부과됩니다.
					</p>
				</div>
			</div>
			<hr>
			<div class="select">
				<div class="div_left">
					<p onclick="location.href='${pageContext.request.contextPath}/co-buying/purchase/${artworkInfo.id }'">구매</p>
				</div>
				<div class="div_right">
					<p class="modal_cancel">취소</p>
				</div>
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		const modal = document.querySelector('.buy_modal');
		const btnOpenPopup = document.querySelector('.buying_btn');
		const btnModalCancel = document.querySelector('.modal_cancel');
		
		
		btnOpenPopup.addEventListener('click', () => {
			$('html, body').addClass('hidden');
			modal.style.display = 'block'; 
		});
		
		btnModalCancel.addEventListener('click', () => {
			$('html, body').removeClass('hidden');
			modal.style.display = 'none'; 
		});
				
	</script>
	<!-- 모달 끝 -->	
	
</body>
</html>