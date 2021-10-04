<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.0/jquery.js"></script>
	
	<link href="${pageContext.request.contextPath}/static/css/myCss.css" rel="stylesheet">
	
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
  	<script type="text/javascript">
  		$(document).ready(function(){
  			if(${! empty agree}) {
	  			pieChartDraw();
  			} 
  			
  			//업무 버튼 클릭(투표종료일때는 매각진행 or 매각기각 / 매각중일땐 수익분배하기 버튼, 수익분배일때는 수익분배 완료 버튼, 매각완료)
  			$('#statusBtn').click(function(){
  				
  				$.ajax({
  	  				type : "POST",
  	  				url : "${pageContext.request.contextPath}/manage/goodsDetailTast",
  	  				data : {
  	  					'artworkInfoId' : '${artworkInfo.id}',
  	  					'agreeNo' : ${agree + 0},
  	  					'totalNo' : ${agree + disagree},
  	  					'id' : '${voteInfo.id}',
  	  					'state' : '${artworkInfo.state}',
	  	  				'writerName' : '${artworkInfo.writerName }',
	  					'title' : '${artworkInfo.title }',
	  					'sellPlace' : $('#sellPlace').val(),
	  					'sellPrice' : $('#sellPrice').val(),
	  					'startDate' : '${voteInfo.startDate}',
	  					'endDate' : '${voteInfo.endDate}',
	  					'targetPiece' : '${artworkInfo.targetPiece }'
  	  				},
  	  				async: false,
  	  				success : function(result) {
  	  					if(result == '1') {
  	  						$("input[name='sellPrice']").attr("readonly", true);
  	  						$("input[name='sellPlace']").attr("readonly", true)
  	  						$('#statusBtn').text('수익분배하기')
  	  					}else if(result == '3') {
  	  						$('#statusBtn').text('매각완료하기')
  	  					}else if(result == '4') {
  	  						$('#statusBtn').text('매각완료')
  	  						$('#statusBtn').attr('disabled',true)
  	  						
  	  					}
  	  					
  	  					
  	  				},
  	  				error: function (request, status, error){
  	  					var msg = "ERROR : " + request.status + "<br>"
  	  					msg += + "내용 : " + request.responseText + "<br>" + error;
  	  					console.log(msg);
  	  					
  	  				}
  	  			})
  				
  			})
  		})
  		let pieChartData = {
			labels : ['동의', '반대'],
			datasets : [{
				data : [ ${agree}, ${disagree} ],
				backgroundColor : ['rgb(54, 162, 235)', 'rgb(255, 99, 132)']
				}]
		}
		
		let pieChartDraw = function() {
			let ctx = document.getElementById('pieChartCanvas').getContext('2d');
			
			window.pieChart = new Chart(ctx, {
				type : 'pie',
				data : pieChartData,
				options : {
					responsive: false
				}
			})
		}
  		
  		
  		function vote() {
  			//문자로 투표 링크 보내기, 이메일로 비밀번호 보내기
  			let startDate = $('#startDate').val()
  			let endDate = $('#endDate').val()
  			$.ajax({
  				type : "POST",
  				url : "${pageContext.request.contextPath}/manage/vote",
  				data : {
  					"artworkInfoId" : '${artworkInfo.id}',
  					"startDate" : $('#startDate').val(),
  					"endDate" : $('#endDate').val(),
  					"url" : $('#url').val(),
  					"writerName" : '${artworkInfo.writerName }',
  					"title" : '${artworkInfo.title }',
  					"emailPw" : $('#emailPw').val()
  				},
  				async: false,
  				success : function(result) {
  					if(result == 'success') {
						$('#change').empty();
						$('#change').append('<th>투표결과</th>')
						$('#change').append('<td>투표 중입니다.</td>')
  					}
  				},
  				error: function (request, status, error){
  					var msg = "ERROR : " + request.status + "<br>"
  					msg += + "내용 : " + request.responseText + "<br>" + error;
  					console.log(msg);
  					
  				}
  			})
  		}
  	</script>
	
</head>
<body>
	<div class="contents-wrap2">
		<!-- Start Banner Hero -->
	    <div id="work_banner" class="banner-wrapper bg-light w-100 py-5">
	        <div class="banner-vertical-center-work container text-light d-flex justify-content-center align-items-center py-5 p-0">
	            <div class="banner-content col-lg-8 col-12 m-lg-auto text-center">
	                <h1 class="banner-heading h2 display-3 pb-5 semi-bold-600 ">Our Goods</h1>
	                <h3 class="h4 pb-2 regular-400"></h3>
	                <p class="banner-body pb-2 light-300">
	                    
	                </p>
	            </div>
	        </div>
	    </div>
	    <!-- End Banner Hero -->
	    
		<section class="container py-5">
			<div class="row projects gx-lg-5">
				<div class="writerRegister_container">
					<div class="main_title">
						<p>작품 정보</p>
					</div>
						<table id="writerDetailTable">
							<tr>
								<th>작품명</th>
								<td>${artworkInfo.title }</td>
							</tr>
							<tr>
								<th>작품 사진</th>
								<td><img src="/artworkImg/${artworkInfo.artworkImg }"></td>
							</tr>
							<tr>
								<th>작가명</th>
								<td>${artworkInfo.writerName }</td>
							</tr>
							<tr>
								<th>진행현황</th>
								<td>${artworkInfo.stateName }</td>
							</tr>
							<tr>
								<th>재료</th>
								<td>${artworkInfo.material}</td>
							</tr>
							<tr>
								<th>사이즈</th>
								<td>${artworkInfo.sizeWidth } x ${artworkInfo.sizeHeight }</td>
							</tr>
							<tr>
								<th>제작연도</th>
								<td>${artworkInfo.productionYear }</td>
							</tr>
							<tr>
								<th>작품설명</th>
								<td>${artworkInfo.artworkContent }</td>
							</tr>
							<tr>
								<th>모집 기간</th>
								<td>${artworkInfo.recruitStartDate } ${artworkInfo.recruitStartTime } ~ 
								${artworkInfo.recruitEndDate } ${ artworkInfo.recruitEndTime}</td>
							</tr>
							<tr>
								<th>공동구매 목표 조각 개수</th>
								<td>${artworkInfo.targetPiece }</td>
							</tr>
							<tr>
								<th>공동구매 달성 조각 개수</th>
								<td>${artworkInfo.achiePiece }</td>
							</tr>
							<tr>
								<th>작품 추정가</th>
								<td>${artworkInfo.estimatedPriceMin } ~ ${artworkInfo.estimatedPriceMax }</td>
							</tr>
							<c:choose>
								<c:when test="${artworkInfo.state == 0 || artworkInfo.state == 1 }"></c:when>
								<c:when test="${artworkInfo.state == 2 }">
									<tr>
										<th>투표 기간</th>
										<td><input id="startDate" type="date"> ~ <input id="endDate" type="date"></td>
									</tr>
									<tr id="change">
										<th>설문조사 링크</th>
										<td><input type="text" id="url" placeholder="설문조사 링크를 입력해주세요.">
										<input type="text" id="emailPw" placeholder="설문조사 비밀번호를 입력해주세요.">
										<button onclick="vote()" >투표하기</button></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<th>투표 기간</th>
										<td><input id="startDate" type="date" value="${voteInfo.startDate }"> ~ <input id="endDate" type="date" value="${voteInfo.endDate }"></td>
									</tr>
									<c:choose>
										<c:when test="${artworkInfo.state == 3 }"> <!-- 투표 중 -->
											<tr>
												<th>투표결과</th>
												<td>투표 중입니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<th>투표결과</th> <!-- 투표 종료 다음부터  -->
												<td><canvas id="pieChartCanvas" width="300px" height="300px"></canvas> </td>
											</tr>
											<c:choose>
												<c:when test="${artworkInfo.state == 4 && agree >= disagree }">
													<tr>
														<th>매각처</th>
														<td><input type="text" id="sellPlace" name="sellPlace"></td>
													</tr>
													<tr>
														<th>매각 금액</th>
														<td><input type="text" id="sellPrice" name="sellPrice"></td>
													</tr>
												</c:when>
												<c:when test="${artworkInfo.state == 5 || artworkInfo.state == 6 }">
													<tr>
														<th>매각처</th>
														<td><input type="text" id="sellPlace" name="sellPlace" value="${artworkInfo.sellPlace }" readonly="readonly" ></td>
													</tr>
													<tr>
														<th>매각 금액</th>
														<td><input type="text" id="sellPrice" name="sellPrice" value="${artworkInfo.sellPrice }" readonly="readonly"></td>
													</tr>
												</c:when>
											</c:choose>
											<tr>
												<th>업무</th>
												<c:if test="${artworkInfo.state == 4 && agree >= disagree }">
													<td id="statusTd"><button id="statusBtn">매각진행하기</button> </td>
												</c:if>
												<c:if test="${artworkInfo.state == 4 && agree < disagree }">
													<td id="statusTd"><button id="statusBtn">매각기각</button> </td>
												</c:if>
												<c:if test="${artworkInfo.state == 5 }">
													<td id="statusTd"><button id="statusBtn">수익분배하기</button> </td>
												</c:if>
												<c:if test="${artworkInfo.state == 6 }">
													<td id="statusTd"><button id="statusBtn">매각완료하기</button> </td>
												</c:if>
												<c:if test="${artworkInfo.state == 7 }">
													<td id="statusTd"><button id="statusBtn" disabled="disabled">매각완료</button> </td>
												</c:if>
											</tr>
											
										</c:otherwise>
									</c:choose>
									
								</c:otherwise>
							</c:choose>
							
						</table>
						<div class="div_center goodsDetail-inputbtn-div">
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/manage/goods'">목록</button>
						</div>
				</div>
			</div>
		</section>
		<script type="text/javascript">
			//작가 select box 검색 가능하게 하기
			$('#ee').select2();		
		</script>
	</div>
</body>
</html>