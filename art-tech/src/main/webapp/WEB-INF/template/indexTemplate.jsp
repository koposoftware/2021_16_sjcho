<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>하나 Art</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/statice/css/myCss.css">
    
</head>

<body>
    <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

    <!-- header-start -->
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
    <!-- header-end -->

    <tiles:insertAttribute name="content"></tiles:insertAttribute>

    <!-- footer start -->
    <tiles:insertAttribute name="footer"></tiles:insertAttribute>
    <!--/ footer end  -->
    


</body>

</html>