<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Sign in</title>
    
    
    <!-- 파비콘 -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->
	<!-- CUSTOM CSS -->
	<link href="${pageContext.request.contextPath}/static/css/signin/style.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
	
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/myJs.js"></script>
    <script type="text/javascript">
	    $(document).ready(function(){
			if('${resultSignin}' == '0') {
				$('#index_content_p').text('아이디가 존재하지 않습니다.')
				$('.index_modal').css('display','block')
				$('body').css("overflow", "hidden");
			}else if('${resultSignin}' == '1') {
				$('#index_content_p').text('아이디와 비밀번호가 일치하지 않습니다.')
				$('.index_modal').css('display','block')
				$('body').css("overflow", "hidden");
			}
			
			//모달 다시 숨기기
			$('.index_modal_cancel').click(function(){
				$('.index_modal').css('display','none')
				$('body').css("overflow", "scroll");
			})
			
			
			//아이디 기억하기
			var userInputId = getCookie("userInputId");
			var setCookieYN = getCookie("setCookieYN");
			
			if(setCookieYN == 'Y') {
		        $("#idSaveCheck").prop("checked", true);
		    } else {
		        $("#idSaveCheck").prop("checked", false);
		    }
			
			$("#userId").val(userInputId);
			
			//로그인 버튼 클릭
			$('#loginBtn').click(function() {
				if($("#idSaveCheck").is(":checked")){ 
		            var userInputId = $("#userId").val();
		            setCookie("userInputId", userInputId, 60); 
		            setCookie("setCookieYN", "Y", 60);
		        } else {
		            deleteCookie("userInputId");
		            deleteCookie("setCookieYN");
		        }
		        
		        document.signinForm.submit();

			})


		})
    </script>
</head>
<body class="body-wrapper" data-spy="scroll" data-target=".privacy-nav">


<section class="user-login section">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="block">
					<!-- Image -->
					<div class="image align-self-center"><img class="img-fluid" src="${pageContext.request.contextPath}/static/img/front-desk-sign-in.jpg"
							alt="desk-image"></div>
					<!-- Content -->
					<div class="content text-center">
						<div class="logo">
							<a href="index.html"><img src="images/logo.png" alt=""></a>
						</div>
						<div class="title-text">
							<h3>Sign in to To Your Account</h3>
						</div>
						<form action="${pageContext.request.contextPath}/member/signin" method="post" name="signinForm">
							<!-- Username -->
							<input class="form-control main" type="text" placeholder="UserID" name="userId" id="userId" required>
							<!-- Password -->
							<input class="form-control main" type="password" placeholder="Password" name="password" required>
							<div>
								<input type="checkbox" id="idSaveCheck"><span>아이디 기억하기</span>
							</div>
							<!-- Submit Button -->
							<button class="btn btn-main-sm" id="loginBtn">sign in</button>
						</form>
						<div class="new-acount">
							<a class="forget_pw" href="contact.html">Forget your password?</a>
							<p>Don't Have an account? <a href="${pageContext.request.contextPath}/member/signup" > SIGN UP</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 -->
	<div class="index_modal">
		<div class="index_body" >  
			
			<div class="content">
				<p id="index_content_p"></p>
			</div>
			<hr>
			<div class="select">
				<p class="index_modal_cancel">확인</p>
			</div>
		</div>
	</div>
</section>


  <!-- To Top -->
  <div class="scroll-top-to">
    <i class="ti-angle-up"></i>
  </div>

</body>
</html>