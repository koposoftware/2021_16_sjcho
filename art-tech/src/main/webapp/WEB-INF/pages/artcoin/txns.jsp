<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			const fontSizeMax = 10;
			//tx data 가져오기
    		$.ajax({
    			type: "GET",
    			url : "http://localhost:18080/transactions",
    			dataType : 'json',
    			success : function(result) {
    				console.log(result)
    				
    				//tran data
    				for(let i = 0; i < result.data.length ; ++i) {
    					//let tx = result.data[result.data.length - i - 1]
    					let tx = result.data[i]
    					console.log(tx)
    					let txRowData = `
	    					<tr onclick="location.href='${pageContext.request.contextPath}/artscan/txnDetail/` + tx.transactionId + `'">
		                        <td>` + (tx.transactionId.length >=fontSizeMax ?tx.transactionId.substring(0,fontSizeMax) + "..." : tx.transactionId  ) + `</td>
		                        <td><span>` + (tx.sender.length >= fontSizeMax ? tx.sender.substring(0,fontSizeMax) + "..." : tx.sender) + `</span></td>
		                        <td><span>` + (tx.reciepient.length >=fontSizeMax ? tx.reciepient.substring(0,fontSizeMax) + "..." : tx.reciepient) + `</span></td>
		                        <td><span> ` + tx.artId + ` </span></td>
		                        <td><span> ` + tx.value + ` </span></td>
		                        <td><span>`+ (tx.blockHash.length >=fontSizeMax ?  tx.blockHash.substring(0,fontSizeMax) + "..." : tx.blockHash) +`</span></td>
		                        <td><span>`+ tx.blockHeight +`</span></td>
		                    </tr>
    					`
					    $('#tranListTbody').prepend(txRowData)           		
    				} //tran for문
    				
    		        
    			},
    			error: function (request, status, error){
    				var msg = "ERROR : " + request.status + "<br>"
    				msg += + "내용 : " + request.responseText + "<br>" + error;
    				console.log(msg);
    				
    			}
    		}) //tran ajax
			
		}) //document
	</script>
</head>
<body>
   <div class="page-content">
	    <div class="container">
		    <div class="docs-overview py-5">
			    <div class="row justify-content-center">
				    <table class="table mb-0" style="min-width: 845px">
	                    <thead>
	                        <tr>
	                            <th>Txn Hash</th>
	                            <th>From</th>
	                            <th>To</th>
	                            <th>Art Id</th>
	                            <th>Value</th>
	                            <th>Block Hash</th>
	                            <th>Block Height</th>
	                        </tr>
	                    </thead>
	                    <tbody id = "tranListTbody">
	                        
	                        
	                    </tbody>
	                </table>
				    
				    
			    </div><!--//row-->
		    </div><!--//container-->
		</div><!--//container-->
    </div><!--//page-content-->
</body>
</html>