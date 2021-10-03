<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
	<meta charset="utf-8">
	<title>Q&A</title>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/board/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/signup.css">	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/board/myCss.css">
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap.js"></script>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
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
					"accountNumber" : '${accountInfo[0].accountNumber}',
					"startDate" : $('#start_date').val(),
					"endDate" : $('#end_date').val(),
					"selectInOutType" : $('input:radio[name="inout_type"]:checked').val(),
					"orderBy" : $('input:radio[name="order"]:checked').val() ,
					"bankCode" :  '${accountInfo[0].bankCode}',
					"selectDepositYn" : 'N'
				},
				success : function(data) {
					let transferList = data
			        $('#transInfo > tbody').empty()
			        
			        for(let i = 0; i < transferList.length; ++i ) {
			        	let info = transferList[i]
			        	
			        	$('#transInfo > tbody').append('<tr>')
			        		$('#transInfo > tbody').append('<td>'+ info.tranDate +'</td>')
			        		$('#transInfo > tbody').append('<td>'+ info.tranTime +'</td>')
			        		
			        		if(info.inoutType == 'O') { //출금
			        			$('#transInfo > tbody').append('<td>'+ info.tranAmt +'</td>')
			        			$('#transInfo > tbody').append('<td></td>')
			        			
			        		} else if(info.inoutType == 'I') { //입금
			        			$('#transInfo > tbody').append('<td></td>')
			        			$('#transInfo > tbody').append('<td>'+ info.tranAmt +'</td>')
				        			
			        		} 
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
                        <p>계좌조회</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->


	<div class="qna-write-container">
		<h4>계좌조회</h4>
		<br>	
		<table class="table ">
			<tbody>
				<tr>
					<th class="text-center">은행</th>
					<td>${accountInfo[0].bankName} </td>
				</tr>
				<tr>
					<th class="text-center">조회계좌번호</th>
					<td>${accountInfo[0].accountNumber}</td>
				</tr>
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
		<br><br>
		
		
		<!-- 선택된 계좌의 상세 정보 -->
		<h4>계좌정보</h4>
		<br>	
		<table class="table">
			<tbody>
				<tr>
					<th class="text-center" >계좌번호</th>
					<td id="info_account_number">${accountInfo[0].bankName}</td>
				</tr>
				<tr>
					<th class="text-center" >계좌잔액</th>
					<td id="info_balance">${accountInfo[0].balance}</td>
				</tr>
				<tr>
					<th class="text-center" >신규일자</th>
					<td id="info_reg_date">${accountInfo[0].regDate}</td>
				</tr>
				
			</tbody>
		</table>
		<br><br>
		
		<!-- 거래내역 조회 -->
		<h4>거래내역</h4>
		<table class="table table-hover" id="transInfo">
			<thead>
			<tr>
				<th>거래일자</th>
				<th>거래시간</th>
				<th>출금(원)</th>
				<th>입금(원)</th>
			</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>

	<script src="${pageContext.request.contextPath}/static/js/account/account.js"></script>
</body>
</html>