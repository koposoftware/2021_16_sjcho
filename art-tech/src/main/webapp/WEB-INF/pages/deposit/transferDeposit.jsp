<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>예치금 이체</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
	
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		let accountList;
		$(document).ready(function(){
			
			//전체 계좌 리스트 가져오기
			$.ajax ({
				type: 'POST',
				url : 'http://localhost:18081/accountList',
				data : JSON.stringify({
					token : '${token}'
				}),
				contentType: "application/json",
				async : false,
				success : function(result){
					accountList = result.data;
					
					//은행 select box 옵션추가
					$('#bankSelectTd').append('<select id="bankNameList" name="bankCode">')
					$('#bankNameList').append('<option value="all">전체</option>')
					
					//계좌 list 
					$('#accountSelectTd').append('<select id="accountList" name="accountNumber">')
					
					let bankArr = []
					
					result.data.forEach(accountInfo => {
						
						if(bankArr.length == 0) {
							bankArr.push(accountInfo.bankCode)
							//은행 select
							$('#bankNameList').append('<option value="' + accountInfo.bankCode + '">'+ accountInfo.bankName +'</option>')
						} else {
							for(let i=0; i < bankArr.length ; ++i) {
								let arrInfo = bankArr[i]
								if(arrInfo != accountInfo.bankCode && i == (bankArr.length-1)) {
									bankArr.push(accountInfo.bankCode)
									//은행 select
									$('#bankNameList').append('<option value="' + accountInfo.bankCode + '">'+ accountInfo.bankName +'</option>')
								}
							}
						}
						
						
						//계좌 select option
						$('#accountList').append('<option value="' + accountInfo.accountNumber + '">'+ accountInfo.accountNumber +'</option>')
						
						
						
					})
					
					$('#bankSelectTd').append('</select>');
					$('#accountSelectTd').append('</select>')
					
					
					
				},
				error: function (request, status, error){
					var msg = "ERROR : " + request.status + "<br>"
					msg += + "내용 : " + request.responseText + "<br>" + error;
					console.log(msg);
					
				}
			}) //ajax 
			
			
			//선택된 계좌의 잔액 가져오기
			function getBalance(selectAccount) {
				let result = '';
				accountList.forEach(account => {
					if(account.accountNumber === selectAccount) {
						result = account.balance
					}
				})
				return result;
			}
			
			//선택된 계좌 읽기
			let selectAcc = $("#accountList option:selected").val();
			//잔액 가져오기
			let selectBal = getBalance(selectAcc)
			$('#balance').text(selectBal)
			
			//여기 위에가 처음 페이지 로딩했을 때
			
			
			//은행 select box chang
			$('#bankNameList').change(function(){
				let option = $("#bankNameList option:selected").val();
				$('#accountList').empty()
				if(option == 'all') {
					accountList.forEach(account => {
						$('#accountList').append('<option value="' + account.accountNumber + '">'+ account.accountNumber +'</option>')
					})
				}else {
					accountList.forEach(account => {
						if(option == account.bankCode){
							$('#accountList').append('<option value="' + account.accountNumber + '">'+ account.accountNumber +'</option>')
						}
					})
				}
				
				selectAcc = $("#accountList option:selected").val();
				selectBal = getBalance(selectAcc)
				$('#balance').text(selectBal)
			})
			
			//계좌 selectbox change
			$('#accountList').change(function(){
				let option = $("#accountList option:selected").val();
				accountList.forEach(account => {
					if(option == account.accountNumber) {
						selectBal = getBalance(account.accountNumber)
						$('#balance').text(selectBal)
					}					
				})
			})
			
		}) //document.ready
		
		
		
	</script>
</head>
<body>
	<!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_3">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>예치금 입금</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    
	<div class="transferDeposit_container">
		<div class="container">
			<h4>출금정보</h4>
			<form action="${pageContext.request.contextPath}/deposit/transferDeposit" method="post" >	
				<input type="hidden" name="token" value="${token }">
				<table class="table">
					<tbody>
						<tr>
							<th class="text-center">은행</th>
							<td id="bankSelectTd">
								
							</td>
						</tr>
						<tr>
							<th class="text-center">조회계좌번호</th>
							<td id="accountSelectTd">
								
							</td>
						</tr>
						
						<tr>
							<th class="text-center" >계좌잔액</th>
							<td id="balance" ></td>
						</tr>
						<tr>
							<th class="text-center" >간편비밀번호</th>
							<td><input type="password"  id="account_password" class="input-text-box" required>
							<span class="account_password_check" id="account_password_check"></span></td>
						</tr>
						
					</tbody>
				</table>
			<br><br>
			<!-- 선택된 계좌의 상세 정보 -->
			<h4>입금정보</h4>
				<table class="table">
					<tbody>
						<tr>
							<th class="text-center">입금은행</th>
							<td>하나은행</td>
						</tr>
						<tr>
							<th class="text-center" >입금 계좌번호</th>
							<td>412-910652-66607</td>
						</tr>
						<tr>
							<th class="text-center">이체금액</th>
							<td><input type="text" name="tranAmt" class="input-text-box" required></td>
						</tr>
						
					</tbody>
				</table>
				
				<hr>
				<div class="transferDeposit_submit_btn">
					<input type="submit" value="이체하기" >
				</div>
			</form>
			
		</div>
	</div>
</body>
</html>