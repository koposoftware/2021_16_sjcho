<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Transportion</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Place favicon.ico in the root directory -->
	
	
    <!-- CSS here -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/nice-select.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/gijgo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/slick.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/slicknav.css">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
	
    <link rel="stylesheet" href="css/style.css">
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
    <script type="text/javascript">
    	let ws;
	    function openSocket(){
	        if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
	            writeResponse("WebSocket is already opened.");
	            return;
	        }
	        //웹소켓 객체 만드는 코드
	        ws=new WebSocket("ws://localhost:8080/arttech/echo");
	        
	        ws.onopen=function(event){
	            if(event.data===undefined) return;
	            
	            console.log("onopen : " + event.data)
	            //writeResponse(event.data);
	        };
	        ws.onmessage=function(event){
	        	console.log("onmessage : " + event.data)
	            writeResponse(event.data);
	        };
	        ws.onclose=function(event){
	        	console.log("onclose : " + event.data)
	            //writeResponse("Connection closed");
	        }
	    }
	    
        
        function closeSocket(){
            ws.close();
        }
        
        /*
        function writeResponse(text){
            toastr.options.escapeHtml = true;
			toastr.options.closeButton = true;
			toastr.options.newestOnTop = false;
			toastr.options.progressBar = false;
			toastr.info(text,'[하나Art] 알림', {timeOut: 7000});
        }
        */
        function writeResponse(text){
            toastr.options = {
           		"closeButton": false,	
           		"positionClass": "toast-top-right",
           		"showDuration": "300",
           	    "hideDuration": "1000",
           		"timeOut": "7000",
           		"onclick": function (){ location.href ="${ pageContext.request.contextPath }/" },
           		"hideMethod": "fadeOut"
            }
			toastr.info(text,'[하나Art] 알림');
        }
    	openSocket()  
    
    </script>
</head>

<body>
	
    <!-- footer start -->
    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget">
                            <h3 class="footer_title">
                                Services
                            </h3>
                            <ul>
                                <li><a href="#">아트하나 소개</a></li>
                                <li><a href="#">서비스 이용약관</a></li>
                                <li><a href="#">개인정보처리방침</a></li>
                                <li><a href="#">공지사항</a></li>
                            </ul>

                        </div>
                    </div>
                    <div class="col-xl-2 col-md-6 col-lg-2">
                        <div class="footer_widget">
                            <h3 class="footer_title">
                                Company
                            </h3>
                            <ul>
                                <li><a href="#">세진은행</a></li>
                                <li><a href="#">세진개발</a></li>
                                <li><a href="#">세진저축은행</a></li>
                                <li><a href="#">세진도서관</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget">
                            
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">
                                Subscribe
                            </h3>
                            <form action="#" class="newsletter_form">
                                <input type="text" placeholder="Enter your mail">
                                <button type="submit">Subscribe</button>
                            </form>
                            <p class="newsletter_text">Esteem spirit temper too say adieus who direct esteem esteems
                                luckily.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="copy-right_text">
            <div class="container">
                <div class="footer_border"></div>
                <div class="row">
                    <div class="col-xl-12">
                        <p class="copy_right text-center">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!--/ footer end  -->
    <!-- JS here -->
    <script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/isotope.pkgd.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/ajax-form.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/imagesloaded.pkgd.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/scrollIt.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.scrollUp.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.slicknav.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/plugins.js"></script>
    <!-- <script src="js/gijgo.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/static/js/slick.min.js"></script>



    <!--contact js-->
    <script src="${pageContext.request.contextPath}/static/js/contact.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.ajaxchimp.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/mail-script.js"></script>


    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
	


</body>



</html>