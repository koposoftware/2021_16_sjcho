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
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script> <!-- your piecelabel -->
	
	<script src="${pageContext.request.contextPath}/static/js/palette.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/myJs.js"></script>
    <script type="text/javascript">
	    let myHistoryBuyPieceNo = []
	    let myHistoryBuyArtworkId = []
	    
	    let myHistoryTotalRevenue = []
	    let myHistoryTotalRevenueArtworkId = []
	    
			
    	$(document).ready(function(){
    		<c:forEach items='${myHistoryBuyPieceNo}' var='myInfo'>	
				console.log(${myInfo.pieceNo})
				myHistoryBuyPieceNo.push(${myInfo.pieceNo})
				myHistoryBuyArtworkId.push('${myInfo.artworkInfoId}')
			</c:forEach>
				
				
    		//내가 산 총 조각 수
    		let myChartOne5 = document.getElementById('myChartOne5').getContext('2d');
        	let barChart5 = new Chart(myChartOne5, {
            
	            type : 'doughnut',
	            data: {
	               
	               labels : myHistoryBuyArtworkId,
	               datasets : [{
	                  
	                  data : myHistoryBuyPieceNo,
	                  backgroundColor:
	                	  palette('tol', myHistoryBuyArtworkId.length).map(function(hex) {
	                	        return '#' + hex;
	                	      })
	               
	               }]
	            },
	            options : {
	               title : {
	                  display : true,   
	                  text : '매각된 총 조각 수',
	                  fontSize : 20,
	               },
	               legend : {
	                  position : 'bottom'
	                  
	               },pieceLabel: { 
	                  mode:"percentage",
	                  position:"default",
	                  fontSize: 12,
	                  fontColor : 'rgb(2,2,2)',
	                  fontStyle: 'bold'
	                  }
	            }
	            
	         })
        	//내가 산 총 조각 수 그래프 끝
        	
        	//내가 얻은 총 수익 그래프
        	
        	<c:forEach items='${myHistoryDisposalInfoList}' var='myInfo'>	
				console.log(${myInfo.pieceNo})
				myHistoryTotalRevenue.push(${myInfo.revenue - myInfo.initiaCost})
				myHistoryTotalRevenueArtworkId.push('${myInfo.artworkInfoId}')
			</c:forEach>
				
    		let myChartOne6 = document.getElementById('myChartOne6').getContext('2d');
        	let barChart6 = new Chart(myChartOne6, {
            
	            type : 'doughnut',
	            data: {
	               
	               labels : myHistoryTotalRevenueArtworkId,
	               datasets : [{
	                  
	                  data : myHistoryTotalRevenue,
	                  backgroundColor:
	                	  palette('tol', myHistoryTotalRevenueArtworkId.length).map(function(hex) {
	                	        return '#' + hex;
	                	      })
	               
	               }]
	            },
	            options : {
	               title : {
	                  display : true,   
	                  text : '그림별 수익 비율',
	                  fontSize : 20,
	               },
	               legend : {
	                  position : 'bottom'
	                  
	               },pieceLabel: { 
	                  mode:"percentage",
	                 // position:"default",
	                  position:"bottom",
	                  fontSize: 12,
	                  fontColor : 'rgb(2,2,2)',
	                  fontStyle: 'bold'
	                  }
	            }
	            
	         })        	
        	//내가 얻은 총 수익 그래프 끝
    		
    		
    		<c:forEach items='${myHistoryDisposalInfoList}' var='disposalInfo'>	
	    		//그래프 그리기
	    		var ctx = document.getElementById('${disposalInfo.artworkInfoId}').getContext('2d'); 
	    		var chart = new Chart(ctx, 
	    			{ 
	    				type: 'bar', // 
	    				data: { 
	    					labels: ['${disposalInfo.recruitEndDate}', '${disposalInfo.sellDate}'], 
	    					datasets: [{ 
	    						type : 'bar',
	    						backgroundColor: [ 
	    							'#B0C4DE',
	    							'#778899'
	    							], 
	    						borderColor: 'rgb(255, 99, 132)',
	    						data : [${disposalInfo.initiaCost}, ${disposalInfo.revenue}],
	    						datalabels: {
	    							  display: false,
	    							  align : 'end'
	   							}
	    					}, {
	    						type : 'line',
	    						fill : false,
	    						pointRadius : 0,
	    						backgroundColor: 'rgb(089, 089, 089)',
	    	                    borderColor: 'rgb(089, 089, 089)',
	    	                    borderWidth: 1, // 선 굵기
	    						data : [${disposalInfo.initiaCost}, ${disposalInfo.revenue}],
	    						datalabels: {
	    							  display: false,
	   							}
	    					}] 
	    				},  //data
	    				options : {
	    					title : {
	    						display : true,
	    						text : '매각현황'
	    					},
	    					responsive: false,
	    					legend : {
	    						display : false
	    					},
	    					scales: {
	    						yAxes: [{
	    							ticks : {
	    								min : 0,
	    								stepSize : ${disposalInfo.initiaCost}/5,
	    								fontSize : 10,
	    								display : false
	    							},
	    							gridLines : {
	    								display : false
	    							}
	    						}],
	    						xAxes : [{
	    							barPercentage: 0.3,
	    							gridLines : {
	    								display : false
	    							}
	    						}]
	    					}, 
	    					
	    					pieceLabel : {
	    						display : false
	    					},
	    					
	    					animation: {
	   		                  duration: 1,
	   		                  onComplete: function () {
	   		                     var chartInstance = this.chart,
	   		                        ctx = chartInstance.ctx;
	   		                     ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
	   		                     ctx.fillStyle = '#808080';
	   		                     ctx.textAlign = 'center';
	   		                     ctx.textBaseline = 'bottom';
	
	   		                     this.data.datasets.forEach(function (dataset, i) {
	   		                        var meta = chartInstance.controller.getDatasetMeta(i);
	   		                        meta.data.forEach(function (bar, index) {
	   		                           //var data = dataset.data[index] + 'KRW';                     
	   		                           var data = numberWithCommas(dataset.data[index]) + 'KRW';                     
	   		                           ctx.fillText(data, bar._model.x, bar._model.y - 5);
	   		                        });
	   		                     });
	   		                  }
	   		               } //animation
	    				} //option
	    			}
	    		); //그래프 그리기 끝 
    		</c:forEach>	
	    		
	    		
    		if('${resultPurchase}' == 'success') {
    			$('#index_content_p').text('구매되었습니다.')
    			$('.index_modal').css('display','block')
    			$('body').css("overflow", "hidden");
    			
        		
    		} //if end
    		
    		//모달 다시 숨기기
    		$('.index_modal_cancel').click(function(){
    			$('.index_modal').css('display','none')
    			$('body').css("overflow", "scroll");
    		})
    		
    		
    		$('.myHistory_menu_select').click(function(){
    			let option = '';
    			//버튼
				$(this).addClass('myHistory_menu_active');
				$('.myHistory_menu_select').not(this).removeClass('myHistory_menu_active') 
				
				if($(this).text() =='매각작품') {
					$('#myHistory_disposal_contain').removeClass('myHistory_disposal_contain_hidden')
					$('#myHistory_all_table_container').addClass('myHistory_disposal_contain_hidden')
				}else { //매각작품이 아닐 경우 
					$('#myHistory_disposal_contain').addClass('myHistory_disposal_contain_hidden')
					$('#myHistory_all_table_container').removeClass('myHistory_disposal_contain_hidden')
					
					switch($(this).text()) {
					case '전체' :
						option = 'all'
						break;
					case '모집중' :
						option = 'ing'
						break;
					case '모집완료' :
						option = 'end'
						break;
					}
				
					getDataList();
				}
				
				//list 가져오기
				function getDataList() {
					$.ajax({
						type: "GET",
						url : "${pageContext.request.contextPath}/member/myHistoryOption",
						data : {
							'option' : option
						},
						async: false,
						success : function(result) {
					        $('#myHistoryTbodyTwo').empty()
					        result.forEach(myHistory => {
					        	$('#myHistoryTbodyTwo').append('<tr>')
					        	$('#myHistoryTbodyTwo').append('<td>' + myHistory.regDate + '</td>')
					        	$('#myHistoryTbodyTwo').append('<td>' + myHistory.title + '</td>')
					        	$('#myHistoryTbodyTwo').append('<td>' + myHistory.writerName + '</td>')
					        	$('#myHistoryTbodyTwo').append('<td>' + myHistory.pieceNo + '</td>')
					        	if(myHistory.type == '1') {
					        		$('#myHistoryTbodyTwo').append('<td>구매</td>')
					        	}else if(myHistory.type == '2') {
					        		$('#myHistoryTbodyTwo').append('<td>판매</td>')
					        	}else if(myHistory.type == '3') {
					        		$('#myHistoryTbodyTwo').append('<td>판매</td>')
					        	}
					        	$('#myHistoryTbodyTwo').append('<td>' + myHistory.totalPrice + '</td>')
					        	if(myHistory.state == '1') {
					        		$('#myHistoryTbodyTwo').append('<td>취소가능</td>')
					        	}else {
					        		$('#myHistoryTbodyTwo').append('<td>취소불가</td>')
					        	}
					        	$('#myHistoryTbodyTwo').append('<tr>')
					        	
					        })
					        
					        
						},
						error: function (request, status, error){
							var msg = "ERROR : " + request.status + "<br>"
							msg += + "내용 : " + request.responseText + "<br>" + error;
							console.log(msg);
							
						}

					})
				} //getDataList()
				
    		})
    		
    	}) //document.ready
    </script>
</head>
<body>
	<!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_4">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>거래내역</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->

	<div class="container myDeposit_inout_container ">
		<div class="myHistory_menu_select_container">
			<span class="myHistory_menu_select myHistory_menu_active">전체</span>
			<span class="myHistory_menu_select">모집중</span>
			<span class="myHistory_menu_select">모집완료</span>
			<span class="myHistory_menu_select">매각작품</span>
		</div>
		
		<!-- 매각작품에서만 보여줘야 하는 것 -->
		<div id="myHistory_disposal_contain" class="myHistory_disposal_contain_hidden">
			<div class="row">
		    	<div class="col-xl-6">
		    		<div class="total_cobuying_summary">
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">매각 수익률</span>
		    				<span class="content_middle">44%</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">매각 작품 수</span>
		    				<span class="content_middle">6건</span>
		    			</div>
		    			<div class="total_cobuying_summary_one">
		    				<span class="title">총 구입 금액</span>
		    				<span class="content_middle">42,241,660원</span>
		    			</div>
		    			
		    		</div>
		    	</div>
		    	
		    	<div class="col-xl-6">
		    		<div class="total_cobuying_summary">
		    			<div class="total_cobuying_summary_one2">
		    				<span class="title">총 매각 금액</span>
		    				<span class="content_middle1">87,231,750원</span>
		    			</div>
		    			<div class="total_cobuying_summary_one2">
		    				<span class="title">총 플랫폼 이용료</span>
		    				<span class="content_long">583,421원</span>
		    			</div>
		    			<div class="total_cobuying_summary_one2">
		    				<span class="title">총 부가세</span>
		    				<span class="content">154,660원</span>
		    			</div>
		    			<div class="total_cobuying_summary_one2">
		    				<span class="title">총 실 지급액</span>
		    				<span class="content_middle1">2,034,150원</span>
		    			</div>
		    		</div>
		    	</div>
	    	</div>
	    	
	    	<!-- 그래프 그리기 -->
	    	<div class="row">
		    	<div class="col-xl-6">
		    		<div class="myHistoryTotalChart">
		    			<canvas id="myChartOne5"></canvas>
		    		</div>
		    	</div>
		    	<div class="col-xl-6">
		    		<div class="myHistoryTotalChart">
		    			<canvas id="myChartOne6"></canvas>
		    		</div>
		    	</div>
	    	</div>
	    	<!-- 그래프 그리기 끝 -->
	    	
	    	
	    	<div class="myHistory-disposal-card">
		    	<div class="container">
			        <div class="row">
			        	<c:forEach items="${myHistoryDisposalInfoList}" var="disposalInfo">
				            <!-- 하나  -->
				            <div class="col-md-6 col-lg-4">
				                <div class="single_service">
				                    <div class="item front">
				                    	<p class="item-artworkId-p">${disposalInfo.artworkInfoId }</p>	
				                    	<img class="myHistory-card-img" src="/artworkImg/${disposalInfo.artworkImg }" alt="img front"/>
			                    	</div>
		       						<div class="item back">
		       							<canvas id="${disposalInfo.artworkInfoId }"></canvas> 
		       							<p id="yield">수익률 : ${disposalInfo.yield }%</p>
		       							<p id="title">작품명 : ${disposalInfo.title }</p>
		       							<p id="writer">작가 : ${disposalInfo.writerName }</p>
		       						</div>
				                </div>
				            </div>
				            <!-- 하나 끝  -->
			            </c:forEach>
			        </div>
			    </div>
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
		<!-- 매각작품에서만 보여줘야 하는 것 끝 -->
		
		<div id="myHistory_all_table_container">
			<table class="table table-hover myDeposit_inout_table">
				<thead id="myHistory_thead">
				<tr>
					<th>구매일시</th>
					<th>작품명</th>
					<th>작가명</th>
					<th>조각</th>
					<th>상태</th>
					<th>결제금액</th>
					<th>취소</th>
					
				</tr>
				</thead>
				<tbody id="myHistoryTbodyTwo">
					
					<c:forEach items="${myHistoryListAll }" var="myHistory">
						<tr> 
							<td>${myHistory.regDate }</td>
							<td>${myHistory.title }</td>
							<td>${myHistory.writerName }</td>
							<td>${myHistory.pieceNo }</td>
							<c:choose>
								<c:when test="${myHistory.type == 1 }">
									<td>구매</td>
								</c:when>
								<c:when test="${myHistory.type == 2 }">
									<td>판매</td>
								</c:when>
								<c:when test="${myHistory.type == 3 }">
									<td>판매</td>
								</c:when>
							</c:choose>
							<td>${myHistory.totalPrice }</td>
							<c:choose>
								<c:when test="${myHistory.state == 1 }">
									<td>취소가능</td>
								</c:when>
								<c:otherwise>
									<td>취소불가</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
			<hr>
			<div class="myDeposit_paging_container">
				<ul	class="pagination">
					<li><a href="#">1</a></li>
					
				</ul>
			</div>
		</div>
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
		<!-- 모달끝 -->
	</div>
</body>
</html>