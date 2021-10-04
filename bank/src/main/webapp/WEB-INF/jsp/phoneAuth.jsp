<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>핸드폰 인증</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.auth-container {
	margin-left: 0;
	margin-right: 0;
	border: 3px solid black;
	margin-top: 15px;
	padding-bottom: 15px;
}
.auth-content .main-title {
	text-align: center;
}
.sub-title {
	text-align: center;
}
.auth-content .main-title p {
	font-size: 25px;
	font-weight: bold;
	margin-top: 30px;
}
table {
	width: 80%;
	margin: auto;
}
table .imgTd {
	width: 50%;
	style: "word-break:break-all";
	border: 1px solid black;
}
table .imgTd img {
	
}
table td {
	text-align: center;
}
.auth-btn-container {
	text-align: center;
	margin-top: 20px;
}
.auth-btn-container p {
	width: 150px;
	height: 30px;
	font-weight: bold;
	margin: auto;
	padding-top: 10px;
	background-color: #4682B4;
	border-radius: 10px;
	color: white;
}
#phoneBtn {
	background-color: #4682B4;
    border-radius: 10px;
}
.agreeText {
	font-size: 13px;
	font-weight: bold;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#authCheckBtn').click(function(){
			$.ajax({
				type: "post",
				url : "${pageContext.request.contextPath}/phoneAuthCheck",
				data : {
					ranNo : ranNo	,
					inputRanNo : $('#inputRanNo').val(),
					phone : $('#phone').val()	
				},
				method : 'post',
				success : function(data) {
					if(data == 'success') {
						window.close();
					}
				},
				error: function (request, status, error){
					var msg = "ERROR : " + request.status + "<br>"
					msg += + "내용 : " + request.responseText + "<br>" + error;
					console.log(msg);
				}
			})
		})
	})
	
	let ranNo = '';
	function sendSms() {
		$.ajax({
			type: "post",
			url : "${pageContext.request.contextPath}/phoneAuth",
			data : {
				phone : $('#phone').val()	
			},
			method : 'post',
			success : function(data) {
				ranNo = data
				
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
<body onresize="parent.resizeTo(400,610)" onload="parent.resizeTo(400,610)">
	<div class="auth-container">
		<div class="auth-content">
			<div class="main-title">
				<p>PASS</p>
			</div>
            <div class="sub-title">
            	<p>이용 중인 통신사를 선택하세요.</p>
            </div>
			<table>
				<tr>
					<td class="imgTd" >
						<img alt="" src="https://m.corp.kt.com/images/kt_ci.png" width="100" height="100"> 
					</td>
					<td class="imgTd">
						<img  alt="" src="https://keepcoing.com/wp-content/uploads/2018/09/SKT.png" width="100" height="100"> 
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>
						<input type="checkbox">
					</td>
				</tr>
				<tr>
					<td class="imgTd">
						<img alt="" src="https://t1.daumcdn.net/cfile/tistory/207BB6164CEA631518" width="100" height="100"> 
					</td>
					<td class="imgTd">
						<img alt="" src="https://blog.kakaocdn.net/dn/b0jxjq/btq8jdX4i7O/zppGNd3f7JXIN0h5SCQVj1/img.png" width="100" height="100"> 
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>
						<input type="checkbox">
					</td>
				</tr>
				<tr>
                	<td>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" name="phone" id="phone"> <button onclick="sendSms()" id="phoneBtn">인증번호전송</button>
					</td>
				</tr>
				<tr>
					<td colspan="2">인증번호  : <input type="text" name="inputRanNo" id="inputRanNo"></td>
				</tr>
			</table>
            <div>
            	<p class="agreeText">&nbsp;&nbsp;&nbsp;<input type="checkbox">&nbsp;<a href="#">본인확인을 하기 위한 필수사항에 전체 동의합니다.</a></p>
            </div>
			<div class="auth-btn-container">
				<p id="authCheckBtn">인증하기</p>
			</div>
		</div>
	</div>
</body>
</html>