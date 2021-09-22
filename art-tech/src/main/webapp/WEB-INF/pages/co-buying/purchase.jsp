<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Transportion</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
    
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/myJs.js"></script>
	
    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->
	<script type="text/javascript">
	$(document).ready(function(){
		$('#purchasePiece').keyup(function(){
			let purchaseP = ${artworkInfo.targetPiece - artworkInfo.achiePiece }
			let inputP = $('#purchasePiece').val()
			if(purchaseP < inputP) {
				$('#purchaseError').text('구입 가능한 조각의 개수보다 많습니다.')
			}else {
				$('#purchaseError').text('')
				$('#totalPiecePrice').text(numberWithCommas(inputP * 10000))
				$('#platformPrice').text(numberWithCommas(inputP * 10000 * 0.066))
				$('#totalPrice').text(numberWithCommas( inputP * 10000 + inputP * 10000 * 0.066 ))
			}
		})
		
		//모달 다시 숨기기
   		$('.purchas_modal_cancel').click(function(){
   			$('.purchas_modal').css('display','none')
   			$('body').css("overflow", "scroll");
   		})
	})
	
	function check() {
		let easyPwInput = $('#easyPwInput').val()
		let easyPw = ''
		let pieceInput = $('#purchasePiece').val()
		let pieceP = ${artworkInfo.targetPiece - artworkInfo.achiePiece }
		
		//간편 비밀번호 확인
		$.ajax({
			type: "GET",
			url : "${pageContext.request.contextPath}/member/easypassword",
			async : false,
			data : {
				easyPassword : $('#easyPwInput').val()
			},
			success : function(data) {
				easyPw = data;
		        
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}

		})
		
		if(! checkPurchase(easyPw, pieceInput, pieceP)) {
   			$('#purchas_content_p').text('정보 입력을 확인해주세요.')
   			$('.purchas_modal').css('display','block')
   			$('body').css("overflow", "hidden");
   			
		}
		
		return checkPurchase(easyPw, pieceInput, pieceP) ;
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
    <div class="purchase_container">
	    <div class="container">
	    	<div class="purchase_content_container">
	    	
	    	<div class="payment_artwork_info_container" >
	    		<div class="title_container">
	    			<p>결제하기</p>
	    		</div>
	    		<div class="content_container">
	    			<form action="${pageContext.request.contextPath}/co-buying/purchase" onsubmit="return check()" method="post">
	    			<input type="hidden" name="artworkInfoId" value="${artworkInfo.id }" >
	    			<div class="purchase-img-th">
	    				<img class="purchase-img" alt="" src="/artworkImg/${artworkInfo.artworkImg }">
	    			</div>
	    			<table class="artwork_content_info">
	    				<tr>
	    					<td>작가명</td>
	    					<th>${artworkInfo.writerName }</th>
	    				</tr>
	    				<tr>
	    					<td>재료</td>
	    					<th>${artworkInfo.material }</th>
	    				</tr>
	    				<tr>
	    					<td>사이즈</td>
	    					<th>${artworkInfo.sizeWidth } X ${artworkInfo.sizeHeight } cm</th>
	    				</tr>
	    				<tr>
	    					<td>제작연도</td>
	    					<th>${artworkInfo.productionYear }</th>
	    				</tr>
	    			</table>
	    			<hr class="purchase_hr_size">
	    			<div class="artwork_purchase_info_container payment_artwork_available_info">
	    				<table class="artwork_purchase_info">
	    					<tr>
	    						<td>구입 가능</td>
	    						<th>${artworkInfo.targetPiece - artworkInfo.achiePiece }</th>
	    					</tr>
	    					<tr>
	    						<td>구입</td>
	    						<th><input type="text" id="purchasePiece"  name="pieceNo" required>조각 <br>
	    						<b id="purchaseError"></b>
	    						</th>
	    					</tr>
	    				</table>
	    			</div>
	    			<hr class="purchase_hr_size">
	    			<div class="title_container">
	    				<p>예치금 정보</p>
	    			</div>
	    			
	    			<div class="artwork_purchase_info_container">
	    				<table class="artwork_purchase_info">
	    					<tr>
	    						<td>보유 예치금</td>
	    						<th>${deposit}원</th>
	    					</tr>
	    					<tr>
	    						<td>예치금 입금계좌</td>
	    						<th>하나은행 110420340941 왕하나</th>
	    					</tr>
	    				</table>
	    			</div>
	    			
	    			<hr class="purchase_hr_size">
	    			
	    			<div class="purchase_price_info">
	    			
	    				<div class="price_table">
	    					<table>
	    						<tr>
		    						<td>주문금액</td>
		    						<th><p id="totalPiecePrice"></p></th>
		    					</tr>
	    						<tr>
		    						<td>플랫폼 이용료(부가세 포함)</td>
		    						<th id="platformPrice"></th>
		    					</tr>
	    						<tr>
		    						<td>총 결제 금액</td>
		    						<th id="totalPrice"></th>
		    					</tr>
		    					<tr>
		    						<td>간편 비밀번호</td>
		    						<th><input type="password" required id="easyPwInput"><br>
		    							<b id="easypwErr"></b>
		    						</th>
		    					</tr>
	    					</table>
	    				
	    				</div>
	    				
	    				<div class="puschase_agree">
	    					<p class="main_title">약관동의</p>
	    					
	    					<p class="check"><input type="checkbox" required><a href="#">서비스 이용약관(필수)</a></p>
	    					<p class="check"><input type="checkbox" required><a href="#">개인정보 처리방침(필수)</a></p>
	    					
	    				</div>
	    				<div class="puschase_input_container">
	    						<input type="submit" value="결제">
    					</div>
	    			</div>
	    			
	    			
	    			</form>
	    			
					
	    		</div>
	    		<!-- 모달 -->
				<div class="purchas_modal">
					<div class="purchas_body" >  
						
						<div class="content">
							<p id="purchas_content_p"></p>
						</div>
						<hr>
						<div class="select">
							<p class="purchas_modal_cancel">확인</p>
						</div>
					</div>
				</div>
	    	</div>
	    	</div>
	    </div>
    </div>
</body>
</html>