<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>계좌 조회</title>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/board/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/account/openBanking.css">
	
	
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/myJs.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/board/bootstrap.js"></script>
</head>
<body>
	
	<div class="container qna-board-container">
		<c:forEach items="${accountInfoList}" var="accountInfo" varStatus="status">
			<c:choose>
				<c:when test="${status.index == 0 }"> <!-- 맨 처음 -->
					<div class="openBanking-block">
						<h2>${accountInfo.bankName } 계좌 조회</h2>
						
						<table class="table table-hover">
							<thead>
							<tr>
								<th>계좌번호</th>
								<th>신규일</th>
								<th>잔액</th>
								<th>업무</th>
							</tr>
							</thead>
							<tbody>
								<tr> 
									<td>${accountInfo.accountNumber} </td>
									<td>${accountInfo.regDate} </td>
									<td>${accountInfo.balance}</td>
									<td><a class="qna-board-btn btn-default" href="${pageContext.request.contextPath}/openBanking/myAccountDetail?accountNumber=${accountInfo.accountNumber}&bankCode=${accountInfo.bankCode}">조회</a>
									</td>
								</tr>
								
							
				</c:when>
				
				<c:when test="${accountInfoList[status.index - 1].bankName ==  accountInfo.bankName}"> <!-- 이전과 은행명이 같을 때 -->
					<tr> 
						<td>${accountInfo.accountNumber} </td>
						<td>${accountInfo.regDate} </td>
						<td>${accountInfo.balance}</td>
						<td><a class="qna-board-btn btn-default" href="${pageContext.request.contextPath}/openBanking/myAccountDetail?accountNumber=${accountInfo.accountNumber}&bankCode=${accountInfo.bankCode}">조회</a>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					</tbody>
						</table>
						<hr>
					</div>
					<div class="openBanking-block">
						<h2>${accountInfo.bankName } 계좌 조회</h2>
						
						<table class="table table-hover">
							<thead>
							<tr>
								<th>계좌번호</th>
								<th>신규일</th>
								<th>잔액</th>
								<th>업무</th>
							</tr>
							</thead>
							<tbody>
								<tr> 
									<td>${accountInfo.accountNumber} </td>
									<td>${accountInfo.regDate} </td>
									<td>${accountInfo.balance}</td>
									<td><a class="qna-board-btn btn-default" href="${pageContext.request.contextPath}/openBanking/myAccountDetail?accountNumber=${accountInfo.accountNumber}&bankCode=${accountInfo.bankCode}">조회</a>
									</td>
								</tr>
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
		</tbody>
			</table>
			<hr>
		</div>
		
	</div>
	
	
</body>
</html>