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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/signup.css">	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/board/myCss.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	
    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->

    <script type="text/javascript">
		$(document).ready(function(){
			
			if('${resultTran}' == 'success') {
				$('#index_content_p').text('예치금 입금이 성공적으로 진행되었습니다.')
    			$('.index_modal').css('display','block')
    			$('body').css("overflow", "hidden");
			}
			
			//모달 다시 숨기기
    		$('.index_modal_cancel').click(function(){
    			$('.index_modal').css('display','none')
    			$('body').css("overflow", "scroll");
    		})
			
			//조회 기간에 현재 시간 넣기
			Date.prototype.toDateInputValue = (function() {
			    var local = new Date(this);
			    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
			    return local.toJSON().slice(0,10);
			});
			$('#start_date').val(new Date().toDateInputValue());
			$('#end_date').val(new Date().toDateInputValue());
			
			
		}) //$(document).ready()
		
		//해당 계좌의 거래내역 가져오기(조건에 따라서)
		let start_date = $('#start_date').val()
		let end_date = $('#end_date').val()
		let inout_type = $('input:radio[name="inout_type"]:checked').val()
		let order = $('input:radio[name="order"]:checked').val() 
		
		function transferInfo() {
				
			$.ajax({
				type: "POST",
				url : "${pageContext.request.contextPath}/openbanking/tranInfo",
				method : 'post',
				data : {
					"startDate" : $('#start_date').val(),
					"endDate" : $('#end_date').val(),
					"selectInOutType" : $('input:radio[name="inout_type"]:checked').val(),
					"orderBy" : $('input:radio[name="order"]:checked').val() ,
					"selectDepositYn" : 'Y'
				},
				success : function(data) {
					let transferList = data
			        $('#transInfo > tbody').empty()
			        
			        for(let i = 0; i < transferList.length; ++i ) {
			        	let info = transferList[i]
			        	$('#transInfo > tbody').append('<tr>')
			        		$('#transInfo > tbody').append('<td>'+ info.bankName +'</td>')
			        		$('#transInfo > tbody').append('<td>'+ info.accountNumber +'</td>')
			        		$('#transInfo > tbody').append('<td>'+ info.tranDate +'</td>')
			        		$('#transInfo > tbody').append('<td>'+ info.tranTime +'</td>')
			        		
			        		if(info.inoutType == 'O') { //출금
			        			$('#transInfo > tbody').append('<td>출금</td>')
			        			
			        		} else if(info.inoutType == 'I') { //입금
			        			$('#transInfo > tbody').append('<td>입금</td>')
				        			
			        		} 
			        		$('#transInfo > tbody').append('<td>'+ info.tranAmt +'</td>')
			        	$('#transInfo > tbody').append('</tr>')
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
    <!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_3">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>예치금 내역</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    
    
	<div class="myDeposit_container">
	
	
		<div class="container">
			
			<div class="row">
				<div class="col-xl-6">
					<div class="deposit_notice_container">
						<div class="deposit_title">
							<p>예치금 안내</p>
							<hr>
						</div>
						<div class="deposit_notice">
							<p>
								- 예치금 계좌는 한 번 발급 후 변경이 불가능 합니다. <br>
								<br>
								- 예치금 입금 후 <b>약 1~10분</b> 사이 충전 반영됩니다.<br>
								(10분 이후에도 반영 안 될 경우 고객센터로 문의 바랍니다.<br>
								<br>
								- 창구 또는 자동화기기(CD/ATM)에서는 예치금 입금이 불가합니다.<br>
								<br>
								- 예치금 출금계좌는 본인명의 계좌만 등록이 가능하며, 가상계좌 및 증권계좌. 등록이 불가합니다.<br>
								<br>
								- 출금 신청 가능 금액은 최소 1원이며, 수수료는 무료입니다.<br>
								<br>
								-예치금출금(실패)시 예치금내역에 다시 입금처리됩니다.<br>
								<br>
								- <b>은행 점검 시간</b>에는 이체 및 출금이 <b>불가</b>합니다.<br>
								<br>
								- 출금완료는 <b>출금신청 후 +1 영업일</b>의 기간이 소요됩니다.<br>
								<br>
								- (단, 23시 이후 출금신청은 최대 <b>+2 영업일</b> 소요됩니다)<br>
							</p>
						</div>
					</div>
				</div>
				<div class="col-xl-6">
					<div class="deposit_account_container">
						<div class="deposit_title">
							<p>예치금 계좌</p>
							<hr>
						</div>
						<div class="deposit_account_content">
							<span>가상 계좌번호</span><span class="text_right_one">하나은행 412-910652-66607</span><br>
							
							<span>예치금</span><span class="text_right_two">${totalDeposit } KRW</span>
						</div>
					</div>	
					<div class="withdraw_request_container">
						<div class="deposit_title">
							<p>출금 신청</p>
							<hr>
						</div>
						<div class="withdraw_request_content">
							<span>출금 계좌번호</span>
							<span class="text_right_one">
								<select>
									<option>하나은행 1232-1411-2412</option>
								</select>
							</span><br>
							<span>출금 가능액</span><span class="text_right_two"></span>${totalDeposit } KRW<br>
							<span>출금 금액</span><span class="text_right_three"><input type="text"></span> <br>
							<div class="deposit_out">
								<button type="button" class="deposit_out_btn">출금신청</button>
							</div>
										
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="container myDeposit_inout_container">
			<p>예치금 입출금 내역</p>
			
			<div class="depositSelectTableContainer">
				<table class="table depositSelectTable" >
					<tbody>
						<tr>
							<th class="text-center" >조회기간</th>
							<td><input type="date" id="start_date">&nbsp;&nbsp; ~ &nbsp;&nbsp;<input type="date" id="end_date"></td>
						</tr>
						<tr>
							<th class="text-center" >조회내용</th>
							<td>
								<input type="radio" name="inout_type" value="all" checked>&nbsp; 전체내역 &nbsp;
								<input type="radio" name="inout_type" value="I"> &nbsp;입금내역 &nbsp;
								<input type="radio" name="inout_type" value="O"> &nbsp;출금내역 &nbsp;
							</td>
						</tr>
						<tr>
							<th class="text-center" >조회결과순서</th>
							<td> 
								<input type="radio" name="order" value="desc" checked>&nbsp; 최근거래순 &nbsp;
								<input type="radio" name="order" value="asc"> &nbsp; 과거거래순 &nbsp;
							</td>
						</tr>
						
					</tbody>
				</table>
				<hr>
				<div class="qna-write-btn">
					<input type="button" class="btn" value="조회" onclick="transferInfo()">
				</div>
			</div>
			<table class="table table-hover myDeposit_inout_table" id="transInfo">
				<thead>
				<tr>
					<th>은행</th>
					<th>계좌</th>
					<th>거래 날짜</th>
					<th>거래 시간</th>
					<th>구분</th>
					<th>거래금액</th>
					
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${tranInfoList}" var='tranInfo'>
						<tr> 
							<td>${tranInfo.bankName }</td>
							<td>${tranInfo.accountNumber }</td>
							<td>${tranInfo.tranDate }</td>
							<td>${tranInfo.tranTime }</td>
							<c:if test="${tranInfo.inoutType == 'I' }">
								<td>입금</td>
							</c:if>
							<c:if test="${tranInfo.inoutType == 'O' }">
								<td>출금</td>
							</c:if>
							<td>${tranInfo.tranAmt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr>
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
	
	
	
</body>
</html>