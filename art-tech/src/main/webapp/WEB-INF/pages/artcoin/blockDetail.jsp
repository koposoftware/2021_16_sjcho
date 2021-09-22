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
			url : "http://localhost:18080/block?hash=" + '${hash}',
			dataType : 'json',
			success : function(result) {
				let date = new Date(result.data.timeStamp)
				//block data
				let blockRowData = `
					<tr>
	                	<th>Hash</th>
	                	<td>` + result.data.hash + `</td>
	                </tr>
	                <tr>
	                	<th>Block Height</th>
	                	<td>` + result.data.blockHeight + `</td>
	                </tr>
	                <tr>
	                	<th>Timestamp</th>
	                	<td>` + date + `</td>
	                </tr>
	                <tr>
	                	<th>Transactions</th>
	                	<td>`+result.data.transactions.length+` Transactions in this block</td>
	                </tr>
	                <tr>
	                	<th>Previous Hash</th>
	                	<td>`+result.data.previousHash+`</td>
	                </tr>
				`
				$('#blockDetailTbody').append(blockRowData)
		        
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
	    		<p>Block Details</p>
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