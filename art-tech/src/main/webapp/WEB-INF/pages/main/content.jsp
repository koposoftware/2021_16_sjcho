<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>하나 Art</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
	
    
    <!-- <link rel="manifest" href="site.webmanifest"> -->
    
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/board/bootstrap.css">
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" /> <!-- 토스터 -->
	<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script> <!-- 토스터 -->
	

    <script type="text/javascript">
		
    	$(document).ready(function(){
    		if('${resultJoin}' == 'success') {
    			$('#index_content_p').text('회원가입에 성공하셨습니다.')
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
    <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

    <!-- slider_area_start -->
    <div class="slider_area">
        <div class="single_slider  d-flex align-items-center slider_bg_1">
            <div class="container">
                <div class="row align-items-center justify-content-center">
                    <div class="col-xl-8">
                        <div class="slider_text text-center justify-content-center">
                            <p></p>
                            <h3></h3>
                                <!-- <a class="boxed-btn3" href="service.html">Our Services</a>
                       				 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- slider_area_end -->
    
    

	<c:if test="${not empty recommendArtworkInfoList }">
		<!-- recommend_goods -->
		<div class="recommend_goods_contain">
			<div class="recommendGoods_main">
		  		<p class="recommendGoods_main_title">이런 작품은 어떤가요?</p>
		  		<p>나와 비슷한 투자성향을 가진 사용자들이 고른 작품</p>
		  	</div>
			<div class="container">
		        <div class="row">
		        	<!-- 하나  -->
		        	<c:forEach items="${recommendArtworkInfoList }" var="artwork">
			            <div class="col-md-6 col-lg-4">
			                <div class="single_service">
			                    <div class="thumb recommend-img-div">
			                        <img src="/artworkImg/${artwork.artworkImg }" alt="">
			                    </div>
			                    <div class="service_info">
			                        <h3><a href="${pageContext.request.contextPath}/co-buying/goodsDetail/${artwork.id}">${artwork.title }</a></h3>
                                	<p>${artwork.writerName }</p>
			                        <div class="progress">
									  <div class="progress-bar" role="progressbar" style="width: ${artwork.achiePiece}%; background-color: #008485" aria-valuenow="${artwork.achiePiece}" aria-valuemin="0" aria-valuemax="${artwork.targetPiece }"></div>
									</div>
		                            <p> ${artwork.achiePiece } / ${artwork.targetPiece } 조각 </p>
			                   	</div>
			                </div>
			            </div>
		            </c:forEach>
		            <!-- 하나 끝  -->
		            
		        </div>
		    </div>
	    </div>
		<!-- recommend_goods end -->
   </c:if>

    <!-- counter_area  -->
    <div class="counter_area ">
      	<div class="main-counter-title mb-50 text-center ">
             <h4>
                1051일 동안 <br> 누적 거래현황
             </h4>
             <p>2021.09.16 기준</p>
         </div>
        <div class="container">
            <div>
                <div class="row">
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter main-text-right">
                            <h3> <span class="single_counter_text">4,360,170,100 </span> <span>KRW+</span> </h3>
                            <p>총 판매금액</p>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter text-center">
                            <h3> <span class="single_counter_text">90</span> <span>+</span> </h3>
                            <p>총 모집 작품 수</p>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter main-text-left">
                            <h3> <span class="single_counter_text" >451,164조각</span></h3>
                            <p>총 판매 조각 수</p>
                        </div>
                    </div>
                    
                </div>
                
                <div class="row">
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter main-text-right">
                            <h3> <span class="single_counter_text">17</span> <span>+</span> </h3>
                            <p>총 매각 작품 수</p>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter text-center">
                            <h3> <span class="single_counter_text">52.36%</span> <span>+</span> </h3>
                            <p>매각 평균 수익률</p>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-3">
                        <div class="single_counter main-text-left">
                            <h3> <span class="single_counter_text">277.07</span>%</h3>
                            <p>연환산 평균 수익률</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- /counter_area  -->
    
	<!-- testimonial_area  -->
    <div class="testimonial_area">
        <div class="container">
            <div class="row">
                <div class="col-xl-7">
                    <div class="testmonial_active owl-carousel">
                        <div class="single_carousel">
                            <div class="single_testmonial text-center">
                            	<div>
                            		<img alt="" src="${pageContext.request.contextPath}/static/img/notice1.PNG">
                            	</div>
                            </div>
                        </div>
                        
                        <div class="single_carousel">
                            <div class="single_testmonial text-center">
                            	<div>
                            		<img alt="" src="${pageContext.request.contextPath}/static/img/notice2.PNG">
                            	</div>
                            </div>
                        </div>
                        
                        <div class="single_carousel">
                            <div class="single_testmonial text-center">
                            	<div>
                            		<img alt="" src="${pageContext.request.contextPath}/static/img/notice3.PNG">
                            	</div>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div class="col-xl-5">
		                <div class="single_carousel">
		                	<div class="single_testmonial text-center">
			                	<table class="table">
									<thead >
								    <tr>
								    	<th >공지사항 </th>
								    	<td class="testimonial_area_td"><a href="${pageContext.request.contextPath }/notice/list" >전체보기</a></td>
								    </tr>
								    </thead>
								    <tbody>
								    	<c:forEach items="${noticeList}" var="notice" begin="0" end="4">
								    		<tr class="alert" role="alert" onclick="location.href='${pageContext.request.contextPath}/notice/detail/${notice.id}'">
										        <td id="indexNoticeTd" colspan="2">${notice.title }</td>
										    </tr>
								    	</c:forEach>
									    
								  </tbody>
								</table>
		                	</div>
	                </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /testimonial_area  -->

	<!-- service_area  -->
    <div class="service_area arttechnew-container">
    	<div class="section_title mb-50 text-center">
             <h3>
                 A.T 미디어
             </h3>
         </div>
        <div class="container">
            <div class="row">
            	<!-- 하나 -->
                <div class="col-md-6 col-lg-4">
                    <div class="single_service">
                        <div class="thumb">
                            <img src="${pageContext.request.contextPath }/static/img/KakaoTalk_20210726_160711678.png" alt="">
                        </div>
                        <div class="service_info">
                            <p><a href="${news.newsLink }" target="_blank">kopo 정현석 작가, 하금티 정규직 되면서 작품 가격 상승!</a></p>
                        </div>
                    </div>
                </div>
                <!-- 하나 끝 -->
            	<c:forEach items="${newsList}" var="news" begin="0" end="4">
	            	<!-- 하나 -->
	                <div class="col-md-6 col-lg-4">
	                    <div class="single_service">
	                        <div class="thumb">
	                            <img src="${news.imgLink }" alt="">
	                        </div>
	                        <div class="service_info">
	                            <p><a href="${news.newsLink }" target="_blank">${news.title}</a></p>
	                        </div>
	                    </div>
	                </div>
	                <!-- 하나 끝 -->
                </c:forEach>
                
            </div>
            
        </div>
        
    </div>
    <!--/ service_area  -->
    
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



</body>

</html>