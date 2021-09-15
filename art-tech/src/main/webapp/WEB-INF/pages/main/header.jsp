<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
		
    
    
    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="${pageContext.request.contextPath}/static/image/x-icon" >
    <!-- Place favicon.ico in the root directory -->
    <!-- font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
    <!-- CSS here -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font/fontCss.css">
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
	<link rel="preconnect" href="https://fonts.googleapis.com">
	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
    
    

</head>

<body>
    <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

    <!-- header-start -->
    <header>
        <div class="header-area ">
            <div class="header-top_area d-none d-lg-block">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-xl-4 col-lg-4">
                            <div class="logo hana-logo">
                                <a href="${pageContext.request.contextPath}/">
                                    <img src="${pageContext.request.contextPath}/static/img/logo.PNG" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-8 col-md-8">
                            <div class="header_right d-flex align-items-center">
                                <div class="short_contact_list">
                                    <ul>
                                    	<c:if test="${not empty sessionScope.memberId}">
                                    		<li><a href="${pageContext.request.contextPath}/member/signout"> Sign out</a></li>
                                    	</c:if>
                                    	<c:if test="${empty sessionScope.memberId}">
                                    		<li><a href="${pageContext.request.contextPath}/member/signin"> Sign in</a></li>
                                        	<li><a href="${pageContext.request.contextPath}/member/signup"> Sign up</a></li>
                                    	</c:if>
                                        
                                    </ul>
                                </div>
								
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="sticky-header" class="main-header-area">
                <div class="container">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-12 d-block d-lg-none">
                                <div class="logo">
                                    <a href="index.jsp">
                                        <img src="${pageContext.request.contextPath}/static/img/logo.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-12 col-lg-9">
                                <div class="main-menu  d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                     		<li><a  href="${pageContext.request.contextPath}/">home</a></li>	
                                            <li><a  href="service.html">서비스</a></li>
                                            <li><a href="#">예치금 관리<i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="${pageContext.request.contextPath}/deposit/myDeposit">예치금 조회</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/openBanking/myAccountList">계좌 조회</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/deposit/autoTranDeposit">자동이체 설정</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/deposit/transferDeposit">예치금 입금</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">공동구매 <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="${pageContext.request.contextPath}/co-buying/goods">공동구매</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/co-buying/ownership">소유자 현황</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/co-buying/disposal">매각 진행현황</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="${pageContext.request.contextPath}/artscan/" target="_blank">아트스캔</a></li>
                                            <li><a href="#">마이페이지 <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="${pageContext.request.contextPath}/myPage/myInfo">회원정보조회</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/myPage/myGallery">마이 갤러리</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/myPage/myHistory">거래내역</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="mobile_menu d-block d-lg-none"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->


</body>
</html>