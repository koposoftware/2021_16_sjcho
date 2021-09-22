<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>artscan</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/artcoin/myCss.css">
<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			type : 'GET',
			url : "http://localhost:18080/wallet?address=" + '${address}',
			dataType : 'json',
			success : function(result) {
				console.log(result)
				
				//지갑 조회(art id와 총 개수)
				$.each(result.data, function(key, value){
					
					let artTitle = `
						<div class="address-title-container" id=`+ key +`>
				    		<p class="myWallet-title-p">Art Id : `+ key +` ( total `+ value +`pieces )</p>
				    	</div>
					`
					$('.justify-content-center').append(artTitle)
					//각 art id에 대한 트랜잭션 리스트
					$.ajax({
						type : 'GET',
						url : "http://localhost:18080/optionTransactions?receiveWallet=${address}&artId=" + key,
						dataType : 'json',
						async: false,
						success : function(result) {
							console.log('여기')
							console.log(result)
							$('.justify-content-center').append('<table class="table mb-0" style="min-width: 845px">')
							result.data.forEach(tx => {
								console.log(tx.transactionId)
								let rowData = `
									<tr onclick="location.href='${pageContext.request.contextPath}/artscan/txnDetail/` + tx.transactionId + `'">
							    		<td class="mywalletTranTd">`+tx.transactionId+`</td>
							    	</tr>
								`
								$('.justify-content-center').append(rowData)
							})
							$('.justify-content-center').append('</table>')
					        
						},
						error: function (request, status, error){
							var msg = "ERROR : " + request.status + "<br>"
							msg += + "내용 : " + request.responseText + "<br>" + error;
							console.log(msg);
							
						}
					}) //ajax end
					
				})
		        
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}
		}) //ajax end
	})
</script>
</head>
<body>
	<div class="page-content">
	    <div class="container">
	    	<div class="blockDetail-title-div">
	    		<p>Address</p>
	    	</div>
		    <div>
			    <div class="row justify-content-center">
			    	<!-- 
			    	<div class="address-title-container">
			    		<p>art id : 3pieces</p>
			    	</div>
				    <table class="table mb-0" style="min-width: 845px">
				    	<tr>
				    		<th>Txn Hash</th>
				    		<td>hash값 넣어주세요~</td>
				    	</tr>
	                </table>
	                 -->

				    
			    </div><!--//row-->
		    </div><!--//container-->
		</div><!--//container-->
    </div><!--//page-content-->
</body>
</html>