<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>artscan</title>
<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			type : 'GET',
			url : "http://localhost:18080/transaction?transactionHash=" + '${transactionId}',
			dataType : 'json',
			success : function(result) {
				console.log(result)
				//transaction data
				let transactionRowData = `
					<tr>
	                	<th>Transaction Hash</th>
	                	<td>` + result.data.transactionId + `</td>
	                </tr>
	                <tr>
	                	<th>Block Height</th>
	                	<td>` + result.data.blockHeight + `</td>
	                </tr>
	                <tr>
	                	<th>Block Hash</th>
	                	<td>` + result.data.blockHash + `</td>
	                </tr>
	                <tr>
	                	<th>From</th>
	                	<td>` + result.data.sender + `</td>
	                </tr>
	                <tr>
	                	<th>To</th>
	                	<td>` + result.data.reciepient + `</td>
	                </tr>
	                <tr>
	                	<th>Art Id</th>
	                	<td>`+ result.data.artId +`</td>
	                </tr>
	                <tr>
	                	<th>Value</th>
	                	<td>` + result.data.value + `</td>
	                </tr>
	                
				`
				$('#blockDetailTbody').append(transactionRowData)
		        
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}
		}) //block ajax
	})
</script>
</head>
<body>
	<div class="page-content">
	    <div class="container">
	    	<div class="blockDetail-title-div">
	    		<p>Transaction Details</p>
	    	</div>
		    <div class="docs-overview py-5">
			    <div class="row justify-content-center">
				    <table class="table mb-0" style="min-width: 845px">
				    	<tbody id="blockDetailTbody">
					    	
	                    </tbody>
	                    
	                </table>

				    
			    </div><!--//row-->
		    </div><!--//container-->
		</div><!--//container-->
    </div><!--//page-content-->
</body>
</html>