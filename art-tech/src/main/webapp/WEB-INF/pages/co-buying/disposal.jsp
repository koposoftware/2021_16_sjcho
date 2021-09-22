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
                        <p>매각 진행현황</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 요약정보 시작 -->
    <div class="disposal_summary_container">
    	<div class="container">
    		<div class="container_main_title">
    			<span>하나아트의 공동구매 작품매각 진행현황을 한 눈에 확인하실 수 있습니다.</span>
    		</div>
	    	<div class="row">
		    	<div class="col-xl-6">
		    		<div class="total_cobuying_summary">
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">총 공동구매 작품 수</span>
		    				<span class="content">21작품</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">총 공동구매 구매금액</span>
		    				<span class="content">3,607,520,000 KRW</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">총 매각 작품 수</span>
		    				<span class="content_middle">12작품</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">총 매각예정 작품 수</span>
		    				<span class="content">2작품</span>
		    			</div>
		    		</div>
		    	</div>
		    	
		    	<div class="col-xl-6">
		    		<div class="total_cobuying_summary">
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">평균 수익률</span>
		    				<span class="content_short">45.16%</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">평균 기간환산 수익률(연)</span>
		    				<span class="content_long">60.27%</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">평균 보유기간</span>
		    				<span class="content_middle">124일</span>
		    			</div>
		    		</div>
		    	</div>
	    	</div>
    	</div>
    </div>
    <!-- 요약정보 끝 -->
    
    <!-- 진행현황 리스트 시작 -->
    <div class="container">
    	<div class="myDeposit_inout_container">
    		<div>
	    		<span>
		    		<select>
		    			<option>전체</option>
		    			<option>매각중</option>
		    			<option>수익분배</option>
		    			<option>매각종료</option>
		    		</select>
	    		</span>
	    		<span class="ownership_keyword">
	    			<input type="text" placeholder="작가 및 작품명을 입력하세요.">
	    		</span>
    		</div>
    	</div>
    	
    	<div class="disposal_container">
    	
    		<!-- 하나 -->
    		<c:forEach items="${disposalList}" var="disposal">
	    		<div class="div_left">
					<div class="disposal_artwork_img">
						<img alt="" src="/artworkImg/${disposal.artworkImg }">
						<p class="title">${disposal.title}</p>
						<p class="writer">${disposal.writerName }</p>
					</div>
					
					<div class="recruit_info">
						<div>
							<span class="title">모집완료일</span>
							<span class="content">${disposal.recruitEndDate }</span>
						</div>
						<div>
							<span class="title">모집금액</span>
							<span class="content_middle">${disposal.achiePrice}KRW</span>
						</div>
						<div>
							<span class="title">매각금액</span>
							<span class="content_middle">${disposal.sellPrice }</span>
						</div>
						<div>
							<span class="title">매각일</span>
							<span class="content_short">${disposal.sellDate }</span>
						</div>
						<div>
							<span class="title">매각처</span>
							<span class="content_short">${disposal.sellPlace }</span>
						</div>
					</div>
					<div class="disposal_state">
						<p class="state_title">진행현황</p>
						<p class="state_detail">${disposal.stateName }</p>
					</div>	    		
	    		</div>
	    		<c:choose>
	    			<c:when test="${disposal.state == 3 || disposal.state == 4 }">
			    		<div class="div_right">
							<div class="disposal_revenue">
								<p class="title">수익률</p>
								<p class="content">-</p>
							</div>
							<div class="disposal_revenue">
								<p class="title">보유기간</p>
								<p class="content">-</p>
							</div>
							<!-- 
							<div class="disposal_revenue">
								<p class="title">기간환산 수익률(연)</p>
								<p class="content">-</p>
							</div>
							 -->
			    		</div>
		    		</c:when>
		    		<c:otherwise>
		    			<div class="div_right">
							<div class="disposal_revenue">
								<p class="title">수익률</p>
								<p class="content">${disposal.yield }%</p>
							</div>
							<div class="disposal_revenue">
								<p class="title">보유기간</p>
								<p class="content">${ disposal.retentionPeriod}일</p>
							</div>
							<!-- 
							<div class="disposal_revenue">
								<p class="title">기간환산 수익률(연)</p>
								<p class="content">11.25%</p>
							</div>
							 -->
			    		</div>
		    		</c:otherwise>
	    		</c:choose>
	    		<div class="ownership_container_margin" ></div>
    		</c:forEach>
    		<!-- 하나 끝 -->
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
    <!-- 진행현황 리스트 끝 -->
    
</body>
</html>