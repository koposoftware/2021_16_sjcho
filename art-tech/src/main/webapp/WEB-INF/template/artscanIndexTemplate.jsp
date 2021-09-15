<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
    <title>Art Scan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/artcoin/myCss.css">
</head> 
<body>
    <!-- header-start -->
	<tiles:insertAttribute name="artscanHeader"></tiles:insertAttribute>
    <!-- header-end -->

    <tiles:insertAttribute name="artscanContent"></tiles:insertAttribute>

    <!-- footer start -->
    <tiles:insertAttribute name="artscanFooter"></tiles:insertAttribute>
    <!--/ footer end  -->
</body>
</html>