<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>artscan</title>
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		const fontSizeMax = 30;
		//block data 가져오기 
		$.ajax({
			type: "GET",
			url : "http://localhost:18080/blocks",
			dataType : 'json',
			success : function(result) {
				console.log('block' + result)
				console.log(result)
				
				
				//block data
				for(let i = 0; i < result.data.totalBlockSize ; ++i) {
					let block = result.data.blocks[result.data.totalBlockSize - i - 1]
					//block data
					let blockRowData = `
				    				<tr onclick="location.href='${pageContext.request.contextPath}/artscan/blockDetail/` + block.hash + `'">
					                    <td>` + block.blockHeight + `</td>
					                    <td>` + block.hash + `</td>
		                                <td><span>` + block.transactions.length + ` </span></td>
		                                <td><span> in ` + Math.round(((new Date().getTime() - block.timeStamp)/1000))  + ` secs </span></td>
					                </tr>
				               		` 
					
					$('#blockListTbody').append(blockRowData)
				               		
				} //block for문
				
				
		        
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}
		}) //block ajax
		
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
	                            <th>Block</th>
	                            <th>Hash</th>
	                            <th>Txn</th>
	                            <th>Age</th>
	                        </tr>
	                    </thead>
	                    <tbody id="blockListTbody">
	                        
	                    </tbody>
	                    
	                </table>

				    
			    </div><!--//row-->
		    </div><!--//container-->
		</div><!--//container-->
    </div><!--//page-content-->
</body>
</html>