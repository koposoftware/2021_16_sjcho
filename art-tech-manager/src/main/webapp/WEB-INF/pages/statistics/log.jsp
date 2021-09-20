<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/myModal.css">
<script src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>

<!-- Bootstrap -->
<link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="${pageContext.request.contextPath}/static/css//font-awesome.min.css" rel="stylesheet">
<!-- NProgress -->
<link href="${pageContext.request.contextPath}/static/css/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="${pageContext.request.contextPath}/static/css/green.css" rel="stylesheet">

<!-- bootstrap-progressbar -->
<link href="${pageContext.request.contextPath}/static/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
<!-- JQVMap -->
<link href="${pageContext.request.contextPath}/static/css/jqvmap.min.css" rel="stylesheet">
<!-- bootstrap-daterangepicker -->
<link href="${pageContext.request.contextPath}/static/css/daterangepicker.css" rel="stylesheet">

<!-- Custom Theme Style -->
<link href="${pageContext.request.contextPath}/static/css/custom.min.css" rel="stylesheet">
<script type="text/javascript">
let customLegend = function (chart) {
    let ul = document.createElement('ul');
    let color = chart.data.datasets[0].backgroundColor;

    chart.data.labels.forEach(function (label, index) {
        ul.innerHTML += `<li><span style="background-color: ` + color[index] + `"></span>` +  label + `</li>`;
    });

    return ul.outerHTML;
};
$(document).ready(function(){
	
	//성비 그래프
	var ctx1 = document.getElementById('genderDoughnut').getContext('2d'); 
        
	var chart1 = new Chart(ctx1, 
		{ 
			type: 'doughnut', // 
			data: { 
				labels: ['남', '여'], 
				datasets: [{ 
					data: [${genderNo.manNo},${genderNo.womanNo}],
					backgroundColor: [ 
						'#5F9EA0',
						'#F08080'], 
					label: '성비', 
				}] 
			},  //data
			options : {
				//maintainAspectRatio: false,
				responsive: false,
				legend : {
					display : false
				},
				pieceLabel: { 
	                  mode:"percentage",
	                  position:"default",
	                  fontSize: 12,
	                  fontColor : 'rgb(2,2,2)',
	                  fontStyle: 'bold'
	               },
				legendCallback: customLegend,
				plugins : {
					datalabels: {
				      align: 'top',
						  formatter: function(context, chart_obj) {
						  	return calculate(chart_obj.dataIndex)
				  	  		}
					    }
				},
				
			}
		})
	document.getElementById('legend-div').innerHTML = chart1.generateLegend();
	//성비 도넛 그래프 끝
	var ctx2 = document.getElementById('genderDoughnut2').getContext('2d'); 
        
	var chart2 = new Chart(ctx2, 
		{ 
			type: 'doughnut', // 
			data: { 
				labels: ['참여', '미참여'], 
				datasets: [{ 
					data: [${cobuyingParticipation.participation},${cobuyingParticipation.nonParticipation}],
					backgroundColor: [ 
						'#BDB76B',
						'#F08080'], 
					label: '공동구매 참여', 
				}] 
			},  //data
			options : {
				//maintainAspectRatio: false,
				responsive: false,
				legend : {
					display : false
				},
				pieceLabel: { 
	                  mode:"percentage",
	                  position:"default",
	                  fontSize: 12,
	                  fontColor : 'rgb(2,2,2)',
	                  fontStyle: 'bold'
	               },
				legendCallback: customLegend,
				plugins : {
					datalabels: {
				      align: 'top',
						  formatter: function(context, chart_obj) {
						  	return calculate(chart_obj.dataIndex)
				  	  }
					    }
				},
				
			}
		})
	document.getElementById('legend-div2').innerHTML = chart2.generateLegend();
	//공동구매 참여비율 시작
	
	//공동구매 참여비율 끝
	
	//작품 당 click 그래프
	$.ajax({
		type : 'GET',
		url : '${pageContext.request.contextPath}/manage/goodsClickGraph',
		success : function(result) {
			let col = []
			let row = []
	        for(let i = 0; i < 4; ++i) {
	        	let data = result.keyList[i]
	        	col.push(result.title[i])
	        	row.push(result.data[data])
	        }
			var ctx = document.getElementById('goodsClickGraph').getContext('2d'); 
			var chart = new Chart(ctx, 
				{ 
					type: 'bar', // 
					data: { 
						labels: col, 
						datasets: [{ 
							label: '색상', 
							backgroundColor: [ 
								'#CD5C5C',
								'#B0C4DE',
								'rgba(255, 206, 86, 1)',
								'#5F9EA0'
										], 
							borderColor: 'rgb(255, 99, 132)', 
							data: row 
						}] 
					},  //data
					options : {
						//maintainAspectRatio: false,
						responsive: false,
						legend : {
							display : false
						},
						scales: {
							yAxes: [{
								ticks : {
									min : 0,
									//max : row[row.length - 1] + 10,
									stepSize : Math.round((row[row.length - 1] + 10) /5) ,
									fontSize : 10,
								},
								gridLines : {
									display : false
								}
							}],
							xAxes : [{
								gridLines : {
									display : false
								}
							}]
						},
						animation: {
   		                  duration: 1,
   		                  onComplete: function () {
   		                     var chartInstance = this.chart,
   		                        ctx = chartInstance.ctx;
   		                     ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
   		                     ctx.fillStyle = '#808080';
   		                     ctx.textAlign = 'center';
   		                     ctx.textBaseline = 'bottom';

   		                     this.data.datasets.forEach(function (dataset, i) {
   		                        var meta = chartInstance.controller.getDatasetMeta(i);
   		                        meta.data.forEach(function (bar, index) {
   		                           //var data = dataset.data[index] + 'KRW';                     
   		                           var data = dataset.data[index] ;                     
   		                           ctx.fillText(data, bar._model.x, bar._model.y - 5);
   		                        });
   		                     });
   		                  }
   		               } //animation
					}
				}
			);

		},
		error: function (request, status, error){
			var msg = "ERROR : " + request.status + "<br>"
			msg += + "내용 : " + request.responseText + "<br>" + error;
			console.log(msg);
			
		}
	}) //ajax end
	
	//로그인 시간 그래프
	$.ajax({
		type : 'GET',
		url : '${pageContext.request.contextPath}/manage/loginTimeGraph',
		success : function(result) {
			let col = []
			let row = []
			let keys = Object.keys(result)
			keys.forEach(key => {
				col.push(key)
				row.push(result[key])
			})
			
			var ctx = document.getElementById('loginTimeGraph').getContext('2d'); 
			var chart = new Chart(ctx, 
				{ 
					type: 'line', // 
					data: { 
						labels: col, 
						datasets: [{ 
							label: '유저 수', 
							backgroundColor: [ 
								'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)'
										], 
							borderColor: "rgba(154, 188, 195, 1)",
							backgroundColor: "rgba(154, 188, 195, 0.5)",
							fill : true,
							data: row ,
							pointRadius : 0
						}] 
					},  //data
					options : {
						//maintainAspectRatio: false,
						responsive: false,
						legend : {
							display : false
						},
						scales: {
							yAxes: [{
								ticks : {
									min : 0,
									stepSize : 1,
									fontSize : 10,
								},
								gridLines : {
									display : true
								}
							}],
							xAxes : [{
								gridLines : {
									display : true
								}
							}]
						}
					}
				}
			);
			

		},
		error: function (request, status, error){
			var msg = "ERROR : " + request.status + "<br>"
			msg += + "내용 : " + request.responseText + "<br>" + error;
			console.log(msg);
			
		}
	}) //ajax end
	
})
</script>
</head>
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="right_col" role="main">
          <!-- top tiles -->
          <div class="row" style="display: inline-block;" >
          <div class="tile_count">
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top">Total Users</span>
              <div class="count">2500</div>
              <span class="count_bottom">From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top">Average Time</span>
              <div class="count">123.50</div>
              <span class="count_bottom"><i class="green">3%</i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top"> Total Males</span>
              <div class="count green">2,500</div>
              <span class="count_bottom"><i class="green">34% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top">Total Females</span>
              <div class="count">4,567</div>
              <span class="count_bottom"><i class="red">12% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top"> Total Collections</span>
              <div class="count">2,315</div>
              <span class="count_bottom"><i class="green">34% </i> From last Week</span>
            </div>
            <div class="col-md-2 col-sm-4  tile_stats_count">
              <span class="count_top"> Total Connections</span>
              <div class="count">7,325</div>
              <span class="count_bottom"><i class="green">34% </i> From last Week</span>
            </div>
          </div>
        </div>
          <!-- /top tiles -->

          <div class="row">
            <div class="col-md-12 col-sm-12 ">
              <div class="dashboard_graph">

                <div class="row x_title">
                  <div class="col-md-6">
                    <h3>시간대별 로그인 횟수</h3>
                  </div>
                  <div class="col-md-6">
                    <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                      <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                      <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
                    </div>
                  </div>
                </div>

                <div class="col-md-9 col-sm-9 ">
                  <div id="chart_plot_01" class="demo-placeholder">
                  	<canvas id="loginTimeGraph" class="flot-base" width="900" height="280" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 515px; height: 280px;"></canvas>
                  </div>
                </div>
                <div class="col-md-3 col-sm-3  bg-white">
                  <div class="x_title">
                    <h2>로그인 많이 한 회원 Top5 </h2>
                    <div class="clearfix"></div>
                  </div>
				  
				  <div class="col-md-12 col-sm-12 loginTopmemberId-div">
				  	<table class="loginTopTable">
				  		<tr>	
				  			<th class="loginTopmemberIdTitle">member Id</th>
				  			<th class="loginTopmemberNameTitle">name</th>
				  			<th class="loginTopmemberFreTitle">frequency</th>
				  		</tr>
				  		<c:forEach items="${loginTopMemberList}" var="member">
				  			<tr>
								<td class="loginTopmemberId">${member.id }</td>
								<td class="loginTopmemberName">${member.name }</td>
								<td class="loginTopmemberFre">${member.frequencyLogin }</td>
				  			</tr>
				  		</c:forEach>
				  	</table>
                  </div>
                </div>

                <div class="clearfix"></div>
              </div>
            </div>

          </div>
          <br />

          <div class="row">
          <!-- 조회 많이 한 작품 -->
            <div class="col-md-4 col-sm-4 ">
              <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                  <h2>조회를 많이 한 작품 Top4</h2>
                  	
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="widget_summary">
                    <canvas id="goodsClickGraph" class="flot-base" width="400" height="230" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 515px; height: 280px;"></canvas>
                  </div>
              </div>
            </div>
            </div>
            <!-- 조회 많이 한 작품 끝-->
            
            <!-- 성비 -->
            <div class="col-md-4 col-sm-4 ">
              <div class="x_panel tile fixed_height_320 overflow_hidden">
                <div class="x_title">
                  <h2>남녀 비율</h2>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                	<canvas class="canvasDoughnut" id="genderDoughnut" height="200" width="250" style="margin: 15px 10px 10px 0"></canvas>
                	<div id="legend-div" class="legend-div"></div>
                </div>
              </div>
            </div>
			<!-- 끝 -->
			
			<!-- 공동구매 참여 미참여 시작 -->
            <div class="col-md-4 col-sm-4 ">
              <div class="x_panel tile fixed_height_320">
                <div class="x_title">
                  <h2>공동구매 참여비율</h2>
                  
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                	<canvas class="canvasDoughnut" id="genderDoughnut2" height="200" width="250" style="margin: 15px 10px 10px 0"></canvas>
                	<div id="legend-div2" class="legend-div"></div>
                </div>
                
              </div>
            </div>
            <!-- 공동구매 참여 미참여 끝 -->

          </div>


          <div class="row">
            <div class="col-md-4 col-sm-4 ">
              <div class="x_panel">
                <div class="x_title">
                  <h2>Recent Activities <small>Sessions</small></h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                          <a class="dropdown-item" href="#">Settings 1</a>
                          <a class="dropdown-item" href="#">Settings 2</a>
                        </div>
                    </li>
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="dashboard-widget-content">

                    <ul class="list-unstyled timeline widget">
                      <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                              <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                          </h2>
                            <div class="byline">
                              <span>13 hours ago</span> by <a>Jane Smith</a>
                            </div>
                            <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                            </p>
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                              <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                          </h2>
                            <div class="byline">
                              <span>13 hours ago</span> by <a>Jane Smith</a>
                            </div>
                            <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                            </p>
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                              <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                          </h2>
                            <div class="byline">
                              <span>13 hours ago</span> by <a>Jane Smith</a>
                            </div>
                            <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                            </p>
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                              <a>Who Needs Sundance When You’ve Got&nbsp;Crowdfunding?</a>
                                          </h2>
                            <div class="byline">
                              <span>13 hours ago</span> by <a>Jane Smith</a>
                            </div>
                            <p class="excerpt">Film festivals used to be do-or-die moments for movie makers. They were where you met the producers that could fund your project, and if the buyers liked your flick, they’d pay to Fast-forward and… <a>Read&nbsp;More</a>
                            </p>
                          </div>
                        </div>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>


            <div class="col-md-8 col-sm-8 ">



              <div class="row">

                <div class="col-md-12 col-sm-12 ">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>Visitors location <small>geo-presentation</small></h2>
                      <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                              <a class="dropdown-item" href="#">Settings 1</a>
                              <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                      </ul>
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                      <div class="dashboard-widget-content">
                        <div class="col-md-4 hidden-small">
                          <h2 class="line_30">125.7k Views from 60 countries</h2>

                          <table class="countries_list">
                            <tbody>
                              <tr>
                                <td>United States</td>
                                <td class="fs15 fw700 text-right">33%</td>
                              </tr>
                              <tr>
                                <td>France</td>
                                <td class="fs15 fw700 text-right">27%</td>
                              </tr>
                              <tr>
                                <td>Germany</td>
                                <td class="fs15 fw700 text-right">16%</td>
                              </tr>
                              <tr>
                                <td>Spain</td>
                                <td class="fs15 fw700 text-right">11%</td>
                              </tr>
                              <tr>
                                <td>Britain</td>
                                <td class="fs15 fw700 text-right">10%</td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        <div id="world-map-gdp" class="col-md-8 col-sm-12 " style="height:230px;"></div>
                      </div>
                    </div>
                  </div>
                </div>

              </div>
              <div class="row">


                <!-- Start to do list -->
                <div class="col-md-6 col-sm-6 ">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>To Do List <small>Sample tasks</small></h2>
                      <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                              <a class="dropdown-item" href="#">Settings 1</a>
                              <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                      </ul>
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                      <div class="">
                        <ul class="to_do">
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Schedule meeting with new client </p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Create email address for new intern</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Have IT fix the network printer</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Copy backups to offsite location</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Food truck fixie locavors mcsweeney</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Food truck fixie locavors mcsweeney</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Create email address for new intern</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Have IT fix the network printer</p>
                          </li>
                          <li>
                            <p>
                              <input type="checkbox" class="flat"> Copy backups to offsite location</p>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End to do list -->
                
                <!-- start of weather widget -->
                <div class="col-md-6 col-sm-6 ">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>Daily active users <small>Sessions</small></h2>
                      <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                              <a class="dropdown-item" href="#">Settings 1</a>
                              <a class="dropdown-item" href="#">Settings 2</a>
                            </div>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                      </ul>
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                      <div class="row">
                        <div class="col-sm-12">
                          <div class="temperature"><b>Monday</b>, 07:30 AM
                            <span>F</span>
                            <span><b>C</b></span>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-4">
                          <div class="weather-icon">
                            <canvas height="84" width="84" id="partly-cloudy-day"></canvas>
                          </div>
                        </div>
                        <div class="col-sm-8">
                          <div class="weather-text">
                            <h2>Texas <br><i>Partly Cloudy Day</i></h2>
                          </div>
                        </div>
                      </div>
                      <div class="col-sm-12">
                        <div class="weather-text pull-right">
                          <h3 class="degrees">23</h3>
                        </div>
                      </div>

                      <div class="clearfix"></div>

                      <div class="row weather-days">
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Mon</h2>
                            <h3 class="degrees">25</h3>
                            <canvas id="clear-day" width="32" height="32"></canvas>
                            <h5>15 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Tue</h2>
                            <h3 class="degrees">25</h3>
                            <canvas height="32" width="32" id="rain"></canvas>
                            <h5>12 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Wed</h2>
                            <h3 class="degrees">27</h3>
                            <canvas height="32" width="32" id="snow"></canvas>
                            <h5>14 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Thu</h2>
                            <h3 class="degrees">28</h3>
                            <canvas height="32" width="32" id="sleet"></canvas>
                            <h5>15 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Fri</h2>
                            <h3 class="degrees">28</h3>
                            <canvas height="32" width="32" id="wind"></canvas>
                            <h5>11 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="col-sm-2">
                          <div class="daily-weather">
                            <h2 class="day">Sat</h2>
                            <h3 class="degrees">26</h3>
                            <canvas height="32" width="32" id="cloudy"></canvas>
                            <h5>10 <i>km/h</i></h5>
                          </div>
                        </div>
                        <div class="clearfix"></div>
                      </div>
                    </div>
                  </div>

                </div>
                <!-- end of weather widget -->
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>
	<!-- jQuery -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.bundle.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="${pageContext.request.contextPath}/static/js/custom.min.js"></script>
    
    
	<!-- FastClick -->
    <script src="${pageContext.request.contextPath}/static/js/fastclick.js"></script>			
	<!-- NProgress -->
    <script src="${pageContext.request.contextPath}/static/js/nprogress.js"></script>	
	<!-- Chart.js -->
    <script src="${pageContext.request.contextPath}/static/js/Chart.min.js"></script>
    
	<!-- gauge.js -->
    <script src="${pageContext.request.contextPath}/static/js/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="${pageContext.request.contextPath}/static/js/bootstrap-progressbar.min.js"></script>
    
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/static/js/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="${pageContext.request.contextPath}/static/js/skycons.js"></script>
    <!-- Flot -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.pie.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.time.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.stack.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.orderBars.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.flot.spline.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="${pageContext.request.contextPath}/static/js/date.js"></script>
    <!-- JQVMap -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.vmap.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.vmap.world.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="${pageContext.request.contextPath}/static/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/daterangepicker.js"></script>

    
	
</body>
</html>