<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Transportion</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myCss.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
	<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script>
    <!-- <link rel="manifest" href="site.webmanifest"> -->
	
	<script type="text/javascript">
		var arr = new Array(${fn:length("myGalleryList")})
		var option = '';
		$(document).ready(function(){
			<c:forEach items="${myGalleryList}" var="myGallery" varStatus="index">
				arr[${index.index}] = new Array(6);
				arr[${index.index}][0] = ${myGallery.totalPieceNo}
				arr[${index.index}][1] = '${myGallery.firstRegDate}'
				arr[${index.index}][2] = '${myGallery.title}'
				arr[${index.index}][3] = '${myGallery.writerName}'
				arr[${index.index}][4] = '${myGallery.artworkImg}'
				arr[${index.index}][5] = '${myGallery.artworkInfoId}'
				
			</c:forEach>
			
			//메뉴 클릭
			$('.select_menu').click(function(){
				$(this).addClass('myGallery_menu_select_menu_active');
				$('.select_menu').not(this).removeClass('myGallery_menu_select_menu_active')
				
				
				//모집중, 모집완료, 매각완료(disposal)
				switch($(this).text()) {
				case '전체' :
					option = 'all'
					break;
				case '모집중' :
					option = 'ing'
					break;
				case '모집완료' :
					option = 'end'
					break;
				case '매각완료' : 
					option = 'disposal'
				}
				getDataList();
				
			})
			
			//모달 다시 숨기기
    		$('.myGallery-modal-cancel').click(function(){
    			$('.myGallery-modal').css('display','none')
    			$('body').css("overflow", "scroll");
    		})
		})//document
		
		//모달 
		function certificate(idx) {
			let img = '/artworkImg/' + arr[idx][4]
			$("#img_form_url").attr("src", img);
			$('#index_content_p').text(arr[idx][2])
			$('#modalWriterName').text(arr[idx][3])
			$('#firstRegDate').text('최초 구입일 : ' + arr[idx][1])
			$('#totalPieceNo').text('현재 보유 : ' + arr[idx][0])
			$('#artId').text('Art id : ' + arr[idx][5])
			
			$('.myGallery-modal').css('display','block')
			$('body').css("overflow", "hidden");
		}
		
		//리스트 가져오기
		function getDataList() {
			$.ajax({
				type: "GET",
				url : "${pageContext.request.contextPath}/member/myGalleryOption",
				data : {
					'option' : option
				},
				async: false,
				success : function(result) {
			        
			        arr = new Array(result.length)
			        
			        $('#myGalleryListDiv').empty()
			        
			        let rowData = '';
			        
			        for(let i=0 ; i<result.length; ++i) {
			        	let myGallery = result[i]
			        	arr[i] = new Array(5);
			        	arr[i][0] = myGallery.totalPieceNo
						arr[i][1] = myGallery.firstRegDate
						arr[i][2] = myGallery.title
						arr[i][3] = myGallery.writerName
						arr[i][4] = myGallery.artworkImg
						arr[i][5] = myGallery.artworkInfoId
						
						let totalPieceNo = myGallery.totalPieceNo.trim()
			        	rowData += `
			        		<div class="col-xl-6 ">
			        			<div class="myGallery_main_container">
			        				<div class="div_left_img">
			        					<img alt="" src="/artworkImg/` + myGallery.artworkImg + `">
		        					</div>
		        					<div class="div_center_artworkInfo">
		        						<p class="title">`+ myGallery.title +`</p>
		        						<p class="writer">` + myGallery.writerName + `</p>`
		        						if(totalPieceNo == 0) {
		        							rowData += `<p class="piece">매각 완료</p>`
		        						}else {
		        							rowData += `<p class="piece">보유조각 : ` + totalPieceNo + `</p>`
		        						}
										rowData += `<p class="piece">Art id : ` + myGallery.artworkInfoId + `</p>
									</div>
									<div class="div_right_certificate">`
									if(totalPieceNo == 0) {
										rowData += `<div class="certificate-non" >
											<p class="certificateP">온라인 권리증</p>
											</div>
											`
									}else {
										rowData += `
											<div class="certificate" onclick="certificate(`+ i +`)">
												<p class="certificateP">온라인 권리증</p>
											</div>
										`
									}
									rowData += `
									</div>
								</div>
							</div>
				        `
			        }
			       
			        $('#myGalleryListDiv').append(rowData)
			        
				},
				error: function (request, status, error){
					var msg = "ERROR : " + request.status + "<br>"
					msg += + "내용 : " + request.responseText + "<br>" + error;
					console.log(msg);
					
				}

			})
		} //getDataList()
	</script>
    
</head>
<body>

	<!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_4">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text text-center">
                        <p>마이갤러리</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ bradcam_area  -->

	<div class="myGallery_contain">
		<div class="container">
			
			<!-- 메뉴 -->
			<div class="myGallery_menu_top">
				<div class="row">
					<div class="myGallery_menu">
						<div class="myGallery_menu_one">
							<p class="select_menu myGallery_menu_select_menu_active" id="select_menu">전체</p>
						</div>
						<div class="myGallery_menu_one">
							<p class="select_menu" id="select_menu" value="ing">모집중</p>
						</div>
						<div class="myGallery_menu_one">
							<p class="select_menu" id="select_menu">모집완료</p>
						</div>
						<div class="myGallery_menu_one">
							<p class="select_menu" id="select_menu">매각완료</p>
						</div>
					</div>
					
				</div>
			</div>
			<!-- 메뉴 끝 -->
			
			<!-- 마이갤러리 -->
			<div class="row" id="myGalleryListDiv">
				<c:forEach items="${myGalleryList }" var="myGallery" varStatus="index">
					<!-- 하나 -->
					<div class="col-xl-6 ">
						<div class="myGallery_main_container">
							<div class="div_left_img">
								<img alt="" src="/artworkImg/${myGallery.artworkImg }">
							</div>
							<div class="div_center_artworkInfo">
								<p class="title">${myGallery.title }</p>
								<p class="writer">${myGallery.writerName }</p>
								<c:choose>
									<c:when test="${fn:trim(myGallery.totalPieceNo) eq '0' }">
										<p class="piece">매각 완료</p>
									</c:when>
									<c:otherwise>
										<p class="piece">보유조각 : ${myGallery.totalPieceNo }</p>
									</c:otherwise>
								</c:choose>
								<p class="piece">Art id : ${myGallery.artworkInfoId }</p>
							</div>
							<div class="div_right_certificate">
								<c:choose>
									<c:when test="${fn:trim(myGallery.totalPieceNo) eq '0' }">
										<div class="certificate-non" onclick="certificate(${index.index})">
											<p class="certificateP">온라인 권리증</p>
										</div>
									</c:when>
									<c:otherwise>
										<div class="certificate" onclick="certificate(${index.index})">
											<p class="certificateP">온라인 권리증</p>
										</div>
									</c:otherwise>
								</c:choose>
								
							</div>
						</div>
					</div>
					<!-- 하나 끝 -->
				</c:forEach>
			</div>
			
			<div class="myDeposit_paging_container myGallery_paging">
				<ul	class="pagination">
					<li><a href="#">1</a></li>
				</ul>
			</div>
			
		</div>
		
	</div>
	<!-- 모달 -->
	<div class="myGallery-modal">
		<div class="myGallery-body" >  
			
			<div class="content">
				<p class="certificateImg"><img alt="" src="${pageContext.request.contextPath}/static/img/23.PNG" id="img_form_url"> </p>
				<p id="index_content_p">작품명적는공간입니다.</p>
				<p id="modalWriterName">작가명적는공간입니다.</p>
				<p id="firstRegDate">구입일적는공간입니다.</p>
				<p id="totalPieceNo">현재보유 : 3개</p>
				<p id="artId">Art id : artwork1</p>
			</div>
			<hr>
			<div class="select">
				<p class="myGallery-modal-cancel">확인</p>
			</div>
		</div>
	</div>	
	<!-- 모달 끝 -->
</body>
</html>