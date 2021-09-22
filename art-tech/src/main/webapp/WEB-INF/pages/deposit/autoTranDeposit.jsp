<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		Kakao.init('d1823ddd57768c060556deb5cad1d563');
    	Kakao.isInitialized();
    	
    	$('#modal1_cancel').click(function(){
			$('#modal1').css('display','none')
			$('body').css("overflow", "scroll");
			updateAuto()
		})
		
		$('#modal2_cancel').click(function(){
			$('#modal2').css('display','none')
			$('body').css("overflow", "scroll");
		})
    	
	})
	//변수 설정
	var accountArr = []
	var bankNameArr = [];
	var bankCodeArr = [];
	var autoAmtArr = [];
	var type = '' //auto or nonAuto
	
	//자동이체 설정 버튼
	function auto_tran() {
		accountArr = []
		bankNameArr = [];
		bankCodeArr = [];
		autoAmtArr = [];
		type = '' 
		let length = $('input:checkbox[name=chkList1]:checked').length //선택된 체크박스 개수
		if(length == 0) {
			alert('자동이체 설정할 계좌를 선택하셔야죠??')
		} else {
			$(this).prop("checked", false)
        	type='auto'
	        
			$('input:checkbox[name=chkList1]:checked').each(function (index) {
		        accountArr.push($(this).parent().parent().children('#accountNumber_non').text())
		        bankNameArr.push($(this).parent().parent().children('#bankName_non').text())
		        bankCodeArr.push($(this).val())
		        autoAmtArr.push( $(this).parent().parent().children().children('#setAutoAmt').val() )
		        
	     		$('#modal1').css('display','block')
	    		$('body').css("overflow", "hidden");
		    });
			
		}
	}
	
	//자동이체 취소 버튼
	function auto_tran_cancle() {
		accountArr = []
		bankNameArr = [];
		bankCodeArr = [];
		autoAmtArr = [];
		type = '' 
		let length = $('input:checkbox[name=chkList2]:checked').length //선택된 체크박스 개수
		if(length == 0) {
			alert('자동이체 취소할 계좌를 선택해야죠?')
		} else {
			type='nonAuto'
			$('input:checkbox[name=chkList2]:checked').each(function (index) {
				accountArr.push($(this).parent().parent().children('#accountNumber_auto').text())
		        bankNameArr.push($(this).parent().parent().children('#bankName_auto').text())
		        bankCodeArr.push($(this).val())
		        
		        $('#modal1').css('display','block')
	    		$('body').css("overflow", "hidden");
		        
		    });
		}
	}
	
	//자동이체 취소 or 설정
	function updateAuto() {
		
		
		var objParams = {
		"accountArr" : accountArr,
		"bankNameArr" : bankNameArr,
		"bankCodeArr" : bankCodeArr,
		"autoAmtArr" : autoAmtArr,
		"type" : type
		}
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/openbanking/autoSetting",
			method : 'post',
			data : objParams,
			success : function(data) {
				getAutoAccountList()
		        getNonAutoAccountList()
		        
		        let kakaoTitle = ''
		        let kakaoDescription = ''
		        
		        if(type == 'nonAuto') { //자동이체 취소
		        	kakaoTitle = '예치금 자동이체 설정 취소'
		        	for(let i=0; i < bankNameArr.length ; ++i) {
	        			kakaoDescription += bankNameArr[i] + ' ' + accountArr[i] + '\n '
		        	}
		        }else if(type == 'auto') { //자동이체 설정
		        	kakaoTitle = '예치금 자동이체 설정'
	        		for(let i=0; i < bankNameArr.length ; ++i) {
	        			kakaoDescription += bankNameArr[i] + ' ' + accountArr[i] + ' : ' + autoAmtArr[i] + '원 \n'
		        	}
		        }
				
				$('#modal2').css('display','block')
	    		$('body').css("overflow", "hidden");
				
				//카카오 메시지
				Kakao.API.request({
				  url: '/v2/api/talk/memo/default/send',
				  data: {
				    template_object: {
				      object_type: 'feed',
				      content: {
				        title: kakaoTitle,
				        description: kakaoDescription,
				        image_url:
				          'https://pbs.twimg.com/profile_images/1223128080727691265/yp_bP9cU.jpg',
				        link: {
				          web_url: 'https://developers.kakao.com',
				          mobile_web_url: 'https://developers.kakao.com',
				        },
				      },
				      social: {
				        like_count: 100,
				        comment_count: 200,
				      },
				      button_title: '바로 확인',
				    },
				  },
				  success: function(response) {
				    console.log(response);
				  },
				  fail: function(error) {
				    console.log(error);
				  },
				});
				//카카오 메시지 끝
				
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}

		})
	}
	
	function getAutoAccountList() {
		//자동이체 설정한 계좌 가져오기
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/openbanking/autoAccountInfoList",
			method : 'post',
			async: false,
			success : function(data) {
				$('#autoAccountTable > tbody').empty()
				for(var i=0 in data) {
					let info = data[i]
					$('#autoAccountTable > tbody').append('<tr>')
		        		$('#autoAccountTable > tbody').append('<td><input type="checkbox"  id="check_auto"  value="'+ info.bankCode+'" name="chkList2"> </td>')
		        		$('#autoAccountTable > tbody').append('<td id="bankName_auto">'+ info.bankName +'</td>')
		        		$('#autoAccountTable > tbody').append('<td id="accountNumber_auto">'+ info.accountNumber +'</td>')
		        		$('#autoAccountTable > tbody').append('<td>'+ info.autoAmt +'</td>')
		        	$('#autoAccountTable > tbody').append('</tr>')
				}
		        
			},
			error: function (request, status, error){
				var msg = "ERROR : " + request.status + "<br>"
				msg += + "내용 : " + request.responseText + "<br>" + error;
				console.log(msg);
				
			}

		})
	}
	
	//자동이체 설정 안 한 계좌 리스트 가져오기
	function getNonAutoAccountList() {
		$.ajax({
			type: "POST",
			url : "${pageContext.request.contextPath}/openbanking/nonAutoAccountInfoList",
			method : 'post',
			async: false,
			success : function(data) {
				
				$('#nonAutoAccountTable > tbody').empty()
				for(var i=0 in data) {
					let info = data[i]
					$('#nonAutoAccountTable > tbody').append('<tr>')
		        		$('#nonAutoAccountTable > tbody').append('<td><input type="checkbox" id="check_non" name="chkList1" value="' + info.bankCode + '"> </td>')
		        		$('#nonAutoAccountTable > tbody').append('<td id="bankName_non">' + info.bankName + '</td>')
		        		$('#nonAutoAccountTable > tbody').append('<td id="accountNumber_non" >' + info.accountNumber + '</td>')
		        		$('#nonAutoAccountTable > tbody').append('<td ><input type="text" id="setAutoAmt">원</td>')
		        	$('#nonAutoAccountTable > tbody').append('</tr>')
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
                        <p>예치금 자동이체 설정</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->
    
	<div class="autoTranDeposit_container">
		<div class="container">
			<div class="main_title">
				<p>매일 오후 1시에 설정된 금액이 자동으로 이체됩니다.</p>
			</div>
			<div class="unselect_container">
				<div class="sub_title">
					<p>전체 계좌</p>
				</div>
				<!-- 자동이체 설정 안한 테이블 -->
				<table class="table table-hover" id="nonAutoAccountTable">
					<thead>
					<tr>
						<th>선택</th>
						<th>&emsp;은행</th>
						<th>&emsp;계좌번호</th>
						<th>&emsp;&emsp;&emsp;&emsp;&emsp;금액설정</th>
					</tr>
					</thead>
					<tbody>
						<c:forEach items="${nonAccountInfoList}" var="nonAuto" varStatus="i">
							<tr> 
								<td><input type="checkbox" id="check_non" name="chkList1" value="${nonAuto.bankCode }"> </td>
								<td id="bankName_non">${nonAuto.bankName }</td>
								<td id="accountNumber_non" >${nonAuto.accountNumber }</td>
								<td ><input type="text" id="setAutoAmt">원</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
			</div>
			<!-- 자동이체 설정 안한 테이블 끝-->
			<div class="updown_btn">
				<span><a onclick="auto_tran_cancle()">▲</a></span> <span><a onclick="auto_tran()">▼</a></span>		
			</div>
			
			<div class="select_container">
				<!-- 자동이체 설정한 테이블 -->
				<div class="sub_title">
					<p>자동이체 설정한 계좌</p>
				</div>
				
				<table class="table table-hover" id="autoAccountTable">
					<thead>
					<tr>
						<th>선택</th>
						<th>&emsp;은행</th>
						<th>&emsp;계좌번호</th>
						<th>자동이체 금액</th>
					</tr>
					</thead>
					<tbody>
						<c:forEach items="${autoAccountInfoList}" var="auto">
							<tr> 
								<td><input type="checkbox"  id="check_auto"  value="${auto.bankCode}" name="chkList2"> </td>
								<td id="bankName_auto">${auto.bankName }</td>
								<td id="accountNumber_auto">${auto.accountNumber }</td>
								<td >${auto.autoAmt }</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				<!-- 자동이체 설정한 테이블 끝-->
			</div>
		</div>
	</div>
	
	<!-- 간편 비밀번호 모달 -->
	<div class="index_modal" id="modal1">
		<div class="index_body" >  
			
			<div class="content">
				<p id="index_content_p" class="easypw-title">간편 비밀번호를 입력해주세요.</p>
				<input type="password" id="inputEasyPw">
			</div>
			<hr>
			<div class="select">
				<p class="index_modal_cancel" id="modal1_cancel">확인</p>
			</div>
		</div>
	</div>
	
	<div class="index_modal" id="modal2">
		<div class="index_body" >  
			
			<div class="content">
				<p id="index_content_p" class="easypw-title">설정이 완료되었습니다.</p>
			</div>
			<hr>
			<div class="select">
				<p class="index_modal_cancel"id="modal2_cancel" >확인</p>
			</div>
		</div>
	</div>
</body>
</html>