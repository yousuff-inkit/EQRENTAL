<%@ taglib prefix="s" uri="/struts-tags"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="includesdashboard.jsp"></jsp:include>
<link href='http://fonts.googleapis.com/css?family=Mr+Dafoe' rel='stylesheet' type='text/css'> 
<link rel="stylesheet" href="../../vendors/bootstrap-v3/bootstrap.min.css">
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> --%>
<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script> --%>
<script src="../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<link href="../../vendors/select2/select2.min.css" rel="stylesheet" />
<script src="../../vendors/select2/select2.min.js"></script>
<link rel="stylesheet" href="../../vendors/font-awesome-v5/all.css">
<link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
<link rel="stylesheet" href="../../vendors/animate/animate.min.css">
<link href="../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/util.css">
<link rel="stylesheet" href="../../vendors/datatables/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="../../vendors/daterangepicker/daterangepicker.css" />
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#F7F7F7;
		font-family: Poppins-Regular, sans-serif;
	}
	html {
	    font-family: sans-serif;
	    line-height: 1.15;
	    -webkit-text-size-adjust: 100%;
	    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	}
	body {
	    margin: 0;
	    font-family: "Poppins";
	    font-size: 1.3rem;
	    font-weight: 400;
	    line-height: 1.5;
	    color: #212529;
	    text-align: left;
	    background-color: #F7F7F7;
	    width:100%;
	    overflow:auto;
		height:100%;
		background-color: #F7F7F7;
	}
	.sidebar{
		position:absolute;
		z-index:999999;
		width:100px;
		min-height:100%;
		background-color:#fff;
	}
	
	.admin-cover .panel-body,.chart-panel .panel-body{
		border:none;
	}
		
	.page-loader{
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		z-index:9999999;
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.9);
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: #5867dd;
    	border-color: #5867dd;
		color:#fff;
		margin:0 auto;
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
	}
	.btn-chartfleetsales.active{
		background-color:#5867dd;
		border-color:#5867dd;
		color:#fff;
	}
	.knob:focus,.knob{
        border: 0;
        outline:0;
    }
    .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
        border-radius: 8px;
        margin-bottom: 15px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    }
        
    .chart-gauge {
        width: 200px;
        margin: 10px auto;
    }

    .chart-color1 {
        fill: #43da14;
    }

    .chart-color2 {
        fill: #e0ff00;
    }

    .chart-color3 {
        fill: #e97209;
    }

    .chart-color4 {
        fill: #ff001a;
    }

    .needle,
    .needle-center {
        fill: #464A4F;
    }
    .custom-badge1.badge{
   		margin-left: 10px;
    	border-radius: 3px;
    	background-color: darkblue;
    }
    table tr.active td{
    	background-color:blue;
    	color:#000;
    }
    .btn-table-dropdown,.btn-table-dropdown:focus,.btn-table-dropdown:active,.btn-table-dropdown:hover{
    	margin: 0;
	    padding: 0;
	    outline: 0;
	    border: 0;
	    background-color: transparent;
	    box-shadow: none;
    }
    .panel-heading .dropdown-menu li a[data-target="#"]{
    	cursor:pointer;
    }
    .panel-loader{
   		position: absolute;
    	width: 100%;
    	height: 100%;
    	z-index: 99;
    	background-color: rgba(0,0,0,0.5);
    	margin: 0;
    	padding: 0;
    	overflow: hidden;
    }
    .panel-loader i{
    	color:#fff;
    }
    .no-padding {
   		padding: 0;
   		margin: 0 !important;
	}
	.p-15{
		padding:15px;
	}
</style>
<script type="text/javascript">
	
	
	
</script>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<!-- <div class="sidebar animated slideOutLeft">
		
	</div> -->
	<div class="container-fluid">
		<div class="panel panel-default admin-cover animated fadeInDown m-t-10">
	  		<div class="panel-body">
	  			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
	  				<p style="margin-bottom:0;" class="fs-12"><strong>Hi <span style="text-transform:capitalize;">Admin</span></strong>, Your Analytics are all set</p>	
	  			</div>
	    		<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
	    			<p style="margin-bottom:0;" class="fs-12 pull-right last-updated">Last Updated on 29-08-2019 14:03</p>	
	    		</div>
	  		</div>
		</div>
		
		<div class="row">
	        <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
	            <div class="card-container">
	                <div class="card-body text-center">
	                    <div id="gauge1" class='chart-gauge'></div>
	                </div>
	                <div class="card-footer">
	                    <ul class="list-group">
	                        <li class="list-group-item">Occupancy on Total<span class="badge"><span class="counter">815</span> %</span></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	        <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
	            <div class="card-container">
	                <div class="card-body text-center">
	                    <div id="gauge2" class='chart-gauge'></div>
	                </div>
	                <div class="card-footer">
	                    <ul class="list-group">
	                        <li class="list-group-item">Occupancy on Available<span class="badge"><span class="counter">815</span> %</span></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	        <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
	            <div class="card-container">
	                <div class="card-body text-center">
	                    <div id="gauge3" class='chart-gauge'></div>
	                </div>
	                <div class="card-footer">
	                    <ul class="list-group">
	                        <li class="list-group-item">In Garage<span class="badge"><span class="counter">815</span> %</span></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	        <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
	            <div class="card-container">
	                <div class="card-body text-center">
	                    <div id="gauge4" class='chart-gauge'></div>
	                </div>
	                <div class="card-footer">
	                    <ul class="list-group">
	                        <li class="list-group-item">In Unrentable<span class="badge"><span class="counter">815</span> %</span></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </div>
		<!--<div class="row">
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <div class="card-container">
                    <div class="card-body">
                        <div class="card-chart-container">
                            <input type="text" class="knob" data-width="60%" data-displayInput="true" data-linecap="round" data-angleOffset="90" data-bgColor="#d8d7d0" data-fgColor="#007bff" data-readOnly="true" value="45">
                        </div>
                        <div class="card-detail-container">
                            <span>On Hire</span>
                            <h4>895</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <div class="card-container">
                    <div class="card-body">
                        <div class="card-chart-container">
                            <input type="text" class="knob" data-width="60%" data-displayInput="true" data-linecap="round" data-angleOffset="90" data-bgColor="#d8d7d0" data-fgColor="#007bff" data-readOnly="true" value="10">
                        </div>
                        <div class="card-detail-container">
                            <span>Garrage</span>
                            <h4>250</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <div class="card-container">
                    <div class="card-body">
                        <div class="card-chart-container">
                            <input type="text" class="knob" data-width="60%" data-displayInput="true" data-linecap="round" data-angleOffset="90" data-bgColor="#d8d7d0" data-fgColor="#007bff" data-readOnly="true" value="75">
                        </div>
                        <div class="card-detail-container">
                            <span>Available</span>
                            <h4>152</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <div class="card-container">
                    <div class="card-body">
                        <div class="card-chart-container">
                            <input type="text" class="knob" data-width="60%" data-displayInput="true" data-linecap="round" data-angleOffset="90" data-bgColor="#d8d7d0" data-fgColor="#007bff" data-readOnly="true" value="20">
                        </div>
                        <div class="card-detail-container">
                            <span>Internal Operations</span>
                            <h4>12</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            
            <div class="col-xs-12 col-sm-6 col-md-5 col-lg-5">
                    <div class="card-container revenue">
                    <div class="card-body">
                        <div class="card-icon-container"  style="width: 20%;">
                            <img src="../../icons/dashboard-icons/cash.png"/>
                        </div>
                        <div class="card-detail-container">
                            <div>
                                <p>Daily</p>
                                <h5><span class="counter">12458.52</span></h5>
                            </div>
                            <div>
                                <p>Weekly</p>
                                <h5><span class="counter">12458.52</span></h5>
                            </div>
                            <div>
                                <p>Monthly</p>
                                <h5><span class="counter">12458.52</span></h5>
                            </div>
                            <div>
                                <p>Lease</p>
                                <h5><span class="counter">12458.52</span></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>-->
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-5">
				<div class="panel-group" id="chartfleetsalesparent" role="tablist" aria-multiselectable="true">
					<div class="panel panel-default chart-panel">
						<div class="panel-heading">
							<strong>Fleet Induction & Sales 2019</strong>
						</div>
		  				<div class="panel-body">
		  					<canvas id="chartfleetsales"></canvas>
		  					<div class="text-center">
		  						<a href="#fleetsalesbrandwise" class="btn btn-default btn-chartfleetsales" style="width:45%;" data-toggle="collapse" data-parent="#chartfleetsalesparent">View Brandwise Details</a>
		  						<a href="#fleetsalesmodelwise" class="btn btn-default btn-chartfleetsales" style="width:45%;" data-toggle="collapse" data-parent="#chartfleetsalesparent">View Modelwise Details</a>
		  					</div>
		  					<div id="fleetsalesbrandwise" class="panel-collapse collapse p-t-5" role="tabpanel">
		  						<select class="cmbfleetsalesbrand form-control" name="cmbfleetsalesbrand" id="cmbfleetsalesbrand" style="width:100%;"></select>
		  						<div class="table-responsive" style="max-height:200px;overflow:auto;">
		  							<table class="table table-brandwise">
		  								<thead>
		  									<tr>
		  										<th>Sr.No</th>
		  										<th>Brand</th>
		  										<th>Induction</th>
		  										<th>Sales</th>
		  									</tr>
		  								</thead>
		  								<tbody>
		  									<tr>
		  										<td>1</td>
		  										<td>Toyota</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  									<tr>
		  										<td>1</td>
		  										<td>Mercedes</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  									<tr>
		  										<td>1</td>
		  										<td>Audi</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  								</tbody>
		  							</table>
		  						</div>
		  						
		  					</div>
		  					<div id="fleetsalesmodelwise" class="panel-collapse collapse p-t-5" role="tabpanel" >
								<select class="cmbfleetsalesmodel form-control" name="cmbfleetsalesmodel" id="cmbfleetsalesmodel" style="width:100%;"></select>
								<div class="table-responsive"  style="max-height:200px;overflow:auto;">
		  							<table class="table table-modelwise">
		  								<thead>
		  									<tr>
		  										<th>Sr.No</th>
		  										<th>Model</th>
		  										<th>Induction</th>
		  										<th>Sales</th>
		  									</tr>
		  								</thead>
		  								<tbody>
		  									<tr>
		  										<td>1</td>
		  										<td>Toyota Supra</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  									<tr>
		  										<td>1</td>
		  										<td>Mercedes E</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  									<tr>
		  										<td>1</td>
		  										<td>Audi A4</td>
		  										<td>12</td>
		  										<td>15</td>
		  									</tr>
		  								</tbody>
		  							</table>
		  						</div>
							</div>
		  				</div>
					</div>
				</div>		
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
				<div class="panel panel-default chart-panel widget-fleetdistchart">
					<div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right" style="margin-top:-7px;margin-right:-7px;">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filter="brandname">Brand wise</a></li>
	                                <li><a data-target="#" data-filter="modelname">Model wise</a></li>
	                                <li><a data-target="#" data-filter="groupname">Group wise</a></li>
	                                <li><a data-target="#" data-filter="yom">YoM wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Fleet Distribution</strong></span>
	                    </h4>
	                </div>
					<div class="panel-body" style="height:310px;overflow-y:auto;border:none;">
						<div class="chart-container">
							<canvas id="chartfleetdist"></canvas>
						</div>
						<div class="chartfleetdist-legend-container"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
				<div class="panel panel-default chart-panel widget-livefleet">
	  				<div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right" style="margin-top:-7px;margin-right:-7px;">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filter="brandname">Brand wise</a></li>
	                                <li><a data-target="#" data-filter="modelname">Model wise</a></li>
	                                <li><a data-target="#" data-filter="groupname">Group wise</a></li>
	                                <li><a data-target="#" data-filter="yom">YoM wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Live Fleets</strong><span class="custom-badge1 badge"></span></span>
	                    </h4>
	                </div>
	  				<div class="panel-body" style="height:310px;overflow:auto;border:none;">
	  					<div class="widget fleetlist">
	  						<ul class="list-group">
  								<li class="list-group-item">Mercedes <span class="badge">12</span></li>
  								<li class="list-group-item">BMW <span class="badge">5</span></li> 
  								<li class="list-group-item">Audi <span class="badge">3</span></li> 
							</ul>
	  					</div>
	  				</div>
				</div>		
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                <div class="card-container agmt-count">
                    <div class="card-body">
                        <div class="card-icon-container">
                            <img src="../../icons/dashboard-car.png"/>
                        </div>
                        <div class="card-detail-container">
                            <div>
                                <p>Daily</p>
                                <h4><span class="counter">845</span></h4>
                            </div>
                            <div>
                                <p>Weekly</p>
                                <h4><span class="counter">845</span></h4>
                            </div>
                            <div>
                                <p>Monthly</p>
                                <h4><span class="counter">845</span></h4>
                            </div>
                            <div>
                                <p>Lease</p>
                                <h4><span class="counter">845</span></h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<div class="row">
	        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	            <div class="panel panel-default widget-clientlist ">
	                <div class="panel-heading p-t-18 p-b-18">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right" style="margin-top:-8px;">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filtertype="salesman">Salesman wise</a></li>
	                                <li><a data-target="#" data-filtertype="category">Client Category wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Clients</strong></span>
	                    </h4>
	                </div>
	                <div class="panel-body table-responsive pos-relative no-padding" style="height:310px;overflow:auto;border:none;">
	                	<div class="panel-loader dis-none">
	                		<i class="fa fa-circle-o-notch fa-spin fa-fw ab-c-m fa-2x"></i>
	                	</div>
	                	<div class="p-15">
		                    <table class="table" style="width:100%" id="tblclients">
		                        <thead>
		                            <tr>
		                                <th style="width: 50%;">Name</th>
		                                <th>New</th>
		                                <th>Old</th>
		                                <th>Active</th>
		                                <th>Inactive</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td>Michael Jordan</td>
		                                <td>5</td>
		                                <td>60</td>
		                                <td>40</td>
		                                <td>25</td>
		                            </tr>
		                        </tbody>
		                    </table>
						</div>
	                </div>
	            </div>
	        </div>
	        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	        	<div class="panel panel-default widget-fleetutillist">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filtertype="brand">Brand</a></li>
	                                <li><a data-target="#" data-filtertype="model">Model</a></li>
	                                <li><a data-target="#" data-filtertype="group">Group</a></li>
	                                <li><a data-target="#" data-filtertype="yom">YoM</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Fleet Utilisation</strong></span>
	                        <input type="text" name="daterangefleetutil" value="" id="daterangefleetutil" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
	                    </h4>
	                </div>
	                <div class="panel-body table-responsive pos-relative no-padding" style="height:310px;overflow:auto;border:none;">
	                	<div class="panel-loader dis-none">
	                		<i class="fa fa-circle-o-notch fa-spin fa-fw ab-c-m fa-2x"></i>
	                	</div>
	                	<div class="p-15">
		                    <table class="table" style="width:100%" id="tblfleetutilisation">
		                        <thead>
		                            <tr>
		                                <th style="width: 40%;">Name</th>
		                                <th class="text-right">Rental</th>
		                                <th class="text-right">Staff</th>
		                                <th class="text-right">Garage</th>
		                                <th class="text-right">For Sale</th>
		                                <th class="text-right">Other</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td>Michael Jordan</td>
		                                <td>5</td>
		                                <td>60</td>
		                                <td>40</td>
		                                <td>25</td>
		                                <td>25</td>
		                            </tr>
		                        </tbody>
		                    </table>
		            	</div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="row">
	        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	            <div class="panel panel-default widget-revenuelist">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filtertype="salesman">Salesman wise</a></li>
	                                <li><a data-target="#" data-filtertype="category">Client Category wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Revenue</strong></span>
	                        <input type="text" name="daterangerevenue" value="" id="daterangerevenue" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
	                    </h4>
	                </div>
	                <div class="panel-body table-responsive pos-relative no-padding" style="height:310px;overflow:auto;border:none;">
	                	<div class="panel-loader dis-none">
	                		<i class="fa fa-circle-o-notch fa-spin fa-fw ab-c-m fa-2x"></i>
	                	</div>
	                	<div class="p-15">
		                    <table class="table" style="width:100%" id="tblrevenue">
		                        <thead>
		                            <tr>
		                                <th style="width: 50%;">Name</th>
		                                <th class="text-right">Rental</th>
		                                <th class="text-right">Lease</th>
		                                <th class="text-center">&nbsp;</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td>Michael Jordan</td>
		                                <td>5</td>
		                                <td>60</td>
		                            </tr>
		                        </tbody>
		                    </table>
						</div>
	                </div>
	            </div>
	        </div>
	        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	        	<div class="panel panel-default widget-collectlist">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filtertype="salesman">Salesman wise</a></li>
	                                <li><a data-target="#" data-filtertype="category">Client Category wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Collection</strong></span>
	                        <input type="text" name="daterangecollection" value="" id="daterangecollection" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
	                    </h4>
	                </div>
	                <div class="panel-body table-responsive pos-relative no-padding" style="height:310px;overflow:auto;border:none;">
	                	<div class="panel-loader dis-none">
	                		<i class="fa fa-circle-o-notch fa-spin fa-fw ab-c-m fa-2x"></i>
	                	</div>
	                	<div class="p-15">
		                    <table class="table" style="width:100%" id="tblcollect">
		                        <thead>
		                            <tr>
		                                <th style="width: 50%;">Name</th>
		                                <th class="text-right">Card</th>
		                                <th class="text-right">Cash</th>
		                                <th class="text-right">Cheque</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td>Michael Jordan</td>
		                                <td>5</td>
		                                <td>10</td>
		                                <td>10</td>
		                            </tr>
		                        </tbody>
		                    </table>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="row">
	    	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	    		<div class="panel panel-default widget-revenuecomplist">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        <div class="btn-group pull-right">
	                            <button class="btn dropdown-toggle" data-toggle="dropdown">
	                                <span class="filter-text p-r-5"></span><i class="caret"></i>
	                            </button>
	                            <ul class="dropdown-menu dropdown-menu-right">
	                                <li><a data-target="#" data-filtertype="salesman">Salesman wise</a></li>
	                                <li><a data-target="#" data-filtertype="category">Client Category wise</a></li>
	                            </ul>
	                        </div>
	                        <span class="panel-title-text fs-12"><strong>Revenue Comparison</strong></span>
	                        <div>
	                        	<input type="text" name="daterangerevenuecomp1" value="" id="daterangerevenuecomp1" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
	                        <input type="text" name="daterangerevenuecomp2" value="" id="daterangerevenuecomp2" style="font-size: 12px;padding:7px;width: 180px;display: inline-block;" class="form-control"/>
	                        </div>
	                        
	                    </h4>
	                </div>
	                <div class="panel-body table-responsive pos-relative no-padding" style="height:310px;overflow:auto;border:none;">
	                	<div class="panel-loader dis-none">
	                		<i class="fa fa-circle-o-notch fa-spin fa-fw ab-c-m fa-2x"></i>
	                	</div>
	                	<div class="p-15">
	                		<table class="table" style="width:100%" id="tblrevenuecomp">
		                        <thead>
		                        	<tr>
		                        		<th style="width: 50%;">Name</th>
		                        		<th colspan="2" class="text-center">Previous Period</th>
		                        		<th>&nbsp;</th>
		                        		<th colspan="2"  class="text-center">Current Period</th>
		                        		<th>&nbsp;</th>
		                        	</tr>
		                            <tr>
		                                <th style="width: 50%;">&nbsp;</th>
		                                <th class="text-right">Rental</th>
		                                <th class="text-right">Lease</th>
		                                <th class="text-center">&nbsp;</th>
		                                <th class="text-right">Rental</th>
		                                <th class="text-right">Lease</th>
		                                <th class="text-center">&nbsp;</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                           
		                        </tbody>
		                    </table>
	                	</div>
	                </div>
	            </div>
	    	</div>
	    </div>
	</div>
	<script src="../../vendors/dashboard/Chart.min.js"></script>
	<script type="text/javascript" src="../../vendors/dashboard/chartjs-plugin-colorschemes.min.js"></script>
	<script src="../../vendors/dashboard/d3.min.js" charset="utf-8"></script>
	<%-- <script src="../../js/chartutils.js"></script> --%>
	<%-- <script src="../../js/dashboard/jquery.knob.min.js"></script> --%>
	
	<script src="../../vendors/waypoints/waypoints.min.js"></script>
	<script src="../../vendors/dashboard/jquery.counterup.min.js"></script>
	<script src="../../vendors/underscore/underscore.js"></script>
	<script src="../../vendors/datatables/jquery.dataTables.min.js"></script>
	<script src="../../vendors/datatables/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript" src="../../vendors/daterangepicker/moment.min.js"></script>
    <script type="text/javascript" src="../../vendors/daterangepicker/daterangepicker.min.js"></script>
	<script type="text/javascript">
		var rawdata={};
		document.getElementById("chartfleetdist").onclick = function(evt){
            var activePoints = window.chartfleetdist.getElementsAtEvent(evt);
            var firstPoint = activePoints[0];
            var grouptype=document.querySelector(".widget-fleetdistchart .panel-heading .panel-title .btn-group .dropdown-toggle span.filter-text").getAttribute("data-filtertype");
            if(grouptype=="undefined" || grouptype=="" || grouptype==null){
            	grouptype="brandname";
            }
            var label = window.chartfleetdist.data.datasets[firstPoint._datasetIndex].labels[firstPoint._index];
            var value = window.chartfleetdist.data.datasets[firstPoint._datasetIndex].data[firstPoint._index];
        	window.chartfleetdist.data.datasets[1].data=funSetRawData(rawdata.fleetdistdata,label,"count",grouptype);
			window.chartfleetdist.data.datasets[1].labels=funSetRawData(rawdata.fleetdistdata,label,"group",grouptype);
			window.chartfleetdist.update();
			var legendhtml='<ul class="list-group">';
			for(var i=0;i<window.chartfleetdist.data.datasets[1].data.length;i++){
				legendhtml+='<li class="list-group-item">'+window.chartfleetdist.data.datasets[1].labels[i]+' <span class="badge">'+window.chartfleetdist.data.datasets[1].data[i]+'</span></li>';
			}
			legendhtml+='</ul>';
			$('.chartfleetdist-legend-container').html($.parseHTML(legendhtml));
        };
        
		function generateGauge(el, percent,chartOrder) {
            var Needle, arc, arcEndRad, arcStartRad, barWidth, chart, chartInset, degToRad, el, endPadRad, height, i, margin, needle, numSections, padRad, percToDeg, percToRad, percent, radius, ref, sectionIndx, sectionPerc, startPadRad, svg, totalPercent, width,sectionReverseIndex;

            barWidth = 50;
            numSections = 4;
            sectionPerc = 1 / numSections / 2;
            padRad = 0;
            chartInset = 5;
            totalPercent = 0.75;
            sectionReverseIndex=numSections;
            margin = {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            };
            width = el[0][0].offsetWidth - margin.left - margin.right;
            height = width;
            radius = Math.min(width, height) / 2;
            percToDeg = function (perc) {
                return perc * 360;
            };
            percToRad = function (perc) {
                return degToRad(percToDeg(perc));
            };
            degToRad = function (deg) {
                return deg * Math.PI / 180;
            };
            svg = el.append('svg').attr('width', width + margin.left + margin.right).attr('height', (height-80) + margin.top + margin.bottom);
            chart = svg.append('g').attr('transform', 'translate(' + (width + margin.left) / 2 + ', ' + (height + margin.top) / 2 + ')');
            for (sectionIndx = i = 1, ref = numSections; 1 <= ref ? i <= ref : i >= ref; sectionIndx = 1 <= ref ? ++i : --i) {
                /*if (window.CP.shouldStopExecution(1)) {
                    break;
                }*/
                arcStartRad = percToRad(totalPercent);
                arcEndRad = arcStartRad + percToRad(sectionPerc);
                totalPercent += sectionPerc;
                startPadRad = sectionIndx === 0 ? 0 : padRad / 2;
                endPadRad = sectionIndx === numSections ? 0 : padRad / 2;
                arc = d3.svg.arc().outerRadius(radius - chartInset).innerRadius(radius - chartInset - barWidth).startAngle(arcStartRad + startPadRad).endAngle(arcEndRad - endPadRad);
                if(chartOrder=="desc"){
                    chart.append('path').attr('class', 'arc chart-color' + sectionReverseIndex).attr('d', arc);
                    sectionReverseIndex--;
                }
                else{
                    chart.append('path').attr('class', 'arc chart-color' + sectionIndx).attr('d', arc);
                }
                
            }
            /*window.CP.exitedLoop(1);*/
            Needle = function () {
                function Needle(len, radius1) {
                    this.len = len;
                    this.radius = radius1;
                }
                Needle.prototype.drawOn = function (el, perc) {
                    el.append('circle').attr('class', 'needle-center').attr('cx', 0).attr('cy', 0).attr('r', this.radius);
                    return el.append('path').attr('class', 'needle').attr('d', this.mkCmd(perc));
                };
                Needle.prototype.animateOn = function (el, perc) {
                    var self;
                    self = this;
                    return el.transition().delay(500).ease('elastic').duration(3000).selectAll('.needle').tween('progress', function () {
                        return function (percentOfPercent) {
                            var progress;
                            progress = percentOfPercent * perc;
                            return d3.select(this).attr('d', self.mkCmd(progress));
                        };
                    });
                };
                Needle.prototype.mkCmd = function (perc) {
                    var centerX, centerY, leftX, leftY, rightX, rightY, thetaRad, topX, topY;
                    thetaRad = percToRad(perc / 2);
                    centerX = 0;
                    centerY = 0;
                    topX = centerX - this.len * Math.cos(thetaRad);
                    topY = centerY - this.len * Math.sin(thetaRad);
                    leftX = centerX - this.radius * Math.cos(thetaRad - Math.PI / 2);
                    leftY = centerY - this.radius * Math.sin(thetaRad - Math.PI / 2);
                    rightX = centerX - this.radius * Math.cos(thetaRad + Math.PI / 2);
                    rightY = centerY - this.radius * Math.sin(thetaRad + Math.PI / 2);
                    return 'M ' + leftX + ' ' + leftY + ' L ' + topX + ' ' + topY + ' L ' + rightX + ' ' + rightY;
                };
                return Needle;
            }();
            needle = new Needle(90, 15);
            needle.drawOn(chart, 0);
            needle.animateOn(chart, percent);
            
        }
		var dt = new Date();

		// ensure date comes as 01, 09 etc
		var DD = ("0" + dt.getDate()).slice(-2);
		
		// getMonth returns month from 0
		var MM = ("0" + (dt.getMonth() + 1)).slice(-2);
		
		var YYYY = dt.getFullYear();
		
		var hh = ("0" + dt.getHours()).slice(-2);
		
		var mm = ("0" + dt.getMinutes()).slice(-2);
		
		var ss = ("0" + dt.getSeconds()).slice(-2);
		
		var date_string = DD + "-" + MM + "-" + YYYY + " " + hh + ":" + mm;
		$('.last-updated').text('Last Updated On '+date_string);
		window.chartColorsOrg = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
		};
		window.chartColors=['#00876c','#379469','#58a066','#78ab63','#98b561','#b8bf62','#dac767','#deb256','#e09d4b','#e18745','#e06f45','#dc574a','#d43d51'];
		var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		var fleetdistconfig = {
			type: 'doughnut',
			data: {
				datasets: [{
					data: [
						5,
						10,
						15,
						20,
						30,
					],
					labels: [
					'Red',
					'Orange',
					'Yellow',
					'Green',
					'Blue'
				]
				},
				{
					data: [],
					labels:[]
				}]
			},
			options: {
				plugins: {
      				colorschemes: {
        				scheme: 'tableau.ClassicGreenOrange12'
      				}
    			},
				responsive: true,
				legend:{
					position:'right',
					display:false
				},
				tooltips: {
		            callbacks: {
		                label: function(tooltipItem, data) {
		                    var dataset = data.datasets[tooltipItem.datasetIndex];
		                    var index = tooltipItem.index;
		                    return dataset.labels[index] + ': ' + dataset.data[index];
		                }
		            }
		        }
			}
		};
		var fleetsalesconfig = {
			type: 'line',
			data: {
				labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July','August'],
				datasets: [{
					label: 'Addition',
					backgroundColor: window.chartColorsOrg.blue,
					borderColor: window.chartColorsOrg.blue,
					data: [
						5,
						10,
						15,
						6,
						25,
						10,
						2
					],
					fill: false,
				}, {
					label: 'Sales',
					fill: false,
					backgroundColor: window.chartColorsOrg.red,
					borderColor: window.chartColorsOrg.red,
					data: [
						5,
						20,
						35,
						6,
						25,
						10,
						50
					],
				}]
			},
			options: {
				responsive: true,
				maintainAspectRatio:true,
				title: {
					display: false,
					text: 'Fleet Induction & Sales 2019'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
					displayColors:false
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}]
				}
			}
		};
		
		$(document).ready(function(){
			$('#daterangefleetutil,#daterangerevenue,#daterangecollection,#daterangerevenuecomp1,#daterangerevenuecomp2').daterangepicker({
                showCalendars:true,
                locale: {
            		format: 'DD/MM/YYYY'
        		}
            });
            $('#daterangefleetutil').data('daterangepicker').setStartDate(moment().subtract(10, 'days'));
			$('#daterangefleetutil').data('daterangepicker').setEndDate(moment());
			$('#daterangerevenue').data('daterangepicker').setStartDate(moment().subtract(10, 'days'));
			$('#daterangerevenue').data('daterangepicker').setEndDate(moment());
			$('#daterangecollection').data('daterangepicker').setStartDate(moment().subtract(10, 'days'));
			$('#daterangecollection').data('daterangepicker').setEndDate(moment());
			$('#daterangerevenuecomp1').data('daterangepicker').setStartDate(moment().subtract(6, 'month').startOf('month'));
			$('#daterangerevenuecomp1').data('daterangepicker').setEndDate(moment().subtract(4, 'month').endOf('month'));
			$('#daterangerevenuecomp2').data('daterangepicker').setStartDate(moment().subtract(3, 'month').startOf('month'));
			$('#daterangerevenuecomp2').data('daterangepicker').setEndDate(moment());
			$('#daterangerevenuecomp1,#daterangerevenuecomp2').on('apply.daterangepicker', function(ev, picker) {
  				var fromdate=picker.startDate.format('DD.MM.YYYY');
  				var todate=picker.endDate.format('DD.MM.YYYY');
  				var filtertype=$('.widget-revenuecomplist').find('.panel-heading').find('.filter-text').attr('data-filtertype');
				funGetFilterData(fromdate,todate,filtertype,'revenuecomplist');
			});
			$('#daterangerevenue').on('apply.daterangepicker', function(ev, picker) {
  				var fromdate=picker.startDate.format('DD.MM.YYYY');
  				var todate=picker.endDate.format('DD.MM.YYYY');
  				var filtertype=$('.widget-revenuelist').find('.panel-heading').find('.filter-text').attr('data-filtertype');
				funGetFilterData(fromdate,todate,filtertype,'revenuelist');
			});
			$('#daterangecollection').on('apply.daterangepicker', function(ev, picker) {
  				var fromdate=picker.startDate.format('DD.MM.YYYY');
  				var todate=picker.endDate.format('DD.MM.YYYY');
  				var filtertype=$('.widget-collectlist').find('.panel-heading').find('.filter-text').attr('data-filtertype');
				funGetFilterData(fromdate,todate,filtertype,'collectlist');
			});
			$('#daterangefleetutil').on('apply.daterangepicker', function(ev, picker) {
  				var fromdate=picker.startDate.format('DD.MM.YYYY');
  				var todate=picker.endDate.format('DD.MM.YYYY');
  				var filtertype=$('.widget-fleetutillist').find('.panel-heading').find('.filter-text').attr('data-filtertype');
				funGetFilterData(fromdate,todate,filtertype,'fleetutillist');
			});
			$('.widget-fleetdistchart .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filter');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				$('.chartfleetdist-legend-container').html('');
				window.chartfleetdist.data.datasets[1].data=[];
				window.chartfleetdist.data.datasets[1].labels=[];
				window.chartfleetdist.update();
			});
			$('.widget-fleetutillist .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filtertype');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var fromdate = $('#daterangefleetutil').data('daterangepicker').startDate.format('DD.MM.YYYY');
				var todate = $('#daterangefleetutil').data('daterangepicker').endDate.format('DD.MM.YYYY');
				funGetFilterData(fromdate,todate,filtertype,'fleetutillist');
			});
			$('.widget-revenuecomplist .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filtertype');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var fromdate = $('#daterangerevenuecomp1').data('daterangepicker').startDate.format('DD.MM.YYYY');
				var todate = $('#daterangerevenuecomp1').data('daterangepicker').endDate.format('DD.MM.YYYY');
				funGetFilterData(fromdate,todate,filtertype,'revenuecomplist');
			});
			$('.widget-revenuelist .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filtertype');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var fromdate = $('#daterangerevenue').data('daterangepicker').startDate.format('DD.MM.YYYY');
				var todate = $('#daterangerevenue').data('daterangepicker').endDate.format('DD.MM.YYYY');
				funGetFilterData(fromdate,todate,filtertype,'revenuelist');
			});
			
			$('.widget-collectlist .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filtertype');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var fromdate = $('#daterangecollection').data('daterangepicker').startDate.format('DD.MM.YYYY');
				var todate = $('#daterangecollection').data('daterangepicker').endDate.format('DD.MM.YYYY');
				funGetFilterData(fromdate,todate,filtertype,'collectlist');
			});
			$('.widget-clientlist .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filtertype');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var clienthtml='';
				if(filtertype=="salesman"){
					$.each(rawdata.clientdatasalesmanwise,function(key,value){
						clienthtml+='<tr>';
						clienthtml+='<td>'+value.salesman+'</td>';
						clienthtml+='<td>'+value.newstatus+'</td>';
						clienthtml+='<td>'+value.oldstatus+'</td>';
						clienthtml+='<td>'+value.active+'</td>';
						clienthtml+='<td>'+value.inactive+'</td>';
						clienthtml+='</tr>';
					});
				}
				else if(filtertype=="category"){
					$.each(rawdata.clientdatacategorywise,function(key,value){
						clienthtml+='<tr>';
						clienthtml+='<td>'+value.category+'</td>';
						clienthtml+='<td>'+value.newstatus+'</td>';
						clienthtml+='<td>'+value.oldstatus+'</td>';
						clienthtml+='<td>'+value.active+'</td>';
						clienthtml+='<td>'+value.inactive+'</td>';
						clienthtml+='</tr>';
					});
				}
				$('#tblclients tbody').html($.parseHTML(clienthtml));
			});
			$('.widget-livefleet .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filter');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var livefleetcountdata=_.countBy(rawdata.livefleetdata, function(num) {
  					return num[filtertype];
  					//return num % 2 == 0 ? 'even': 'odd';
				});
				
				$('.widget-livefleet .panel-body div').html('');
				var sum=0;
				var fleetlisthtml='<ul class="list-group">';
				_.map(livefleetcountdata, function(value, key){
					sum+=value;
					fleetlisthtml+='<li class="list-group-item">'+key+'<span class="badge">'+value+'</span></li>';
			    	/*return {
			        	name: key,
			        	y: value
			    	};*/
				});
				fleetlisthtml+='</ul>';
				$('.widget-livefleet .panel-body div').html($.parseHTML(fleetlisthtml));
				$('.widget-livefleet').find('.panel-title-text').find('.custom-badge1').text(sum);
			});
		    $('.cmbfleetsalesbrand,.cmbfleetsalesmodel').select2();
			$('.cmbfleetsalesbrand').change(function(){
				getBrandwiseFleetSales($(this).val(),"Brand");
			});
			$('.cmbfleetsalesmodel').change(function(){
				getBrandwiseFleetSales($(this).val(),"Model");
			});
			
			$('#chartfleetsalesparent .panel-collapse').on('shown.bs.collapse', function () {
	   			var collapseid=$(this).attr('id');
	   			$('a[href="#'+collapseid+'"]').addClass('active');
			});
			
			$('#chartfleetsalesparent .panel-collapse').on('hidden.bs.collapse', function () {
	   			var collapseid=$(this).attr('id');
	   			$('a[href="#'+collapseid+'"]').removeClass('active');
			});
		});
		
		function funGetFilterData(fromdate,todate,filtertype,widgetname){
			var fromdate2,todate2;
			if(widgetname=='revenuecomplist'){
				fromdate = $('#daterangerevenuecomp1').data('daterangepicker').startDate.format('DD.MM.YYYY');
				todate = $('#daterangerevenuecomp1').data('daterangepicker').endDate.format('DD.MM.YYYY');
				fromdate2 = $('#daterangerevenuecomp2').data('daterangepicker').startDate.format('DD.MM.YYYY');
				todate2 = $('#daterangerevenuecomp2').data('daterangepicker').endDate.format('DD.MM.YYYY');
			}
			$('.widget-'+widgetname).find('.panel-loader').removeClass('dis-none');
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					var objdata=JSON.parse(items);
					if(widgetname=='fleetutillist'){
						rawdata.fleetutildata=objdata.fleetutilizedata;
						var fleetutilhtml='';
						$.each(rawdata.fleetutildata,function(key,value){
							fleetutilhtml+='<tr>';
							fleetutilhtml+='<td>'+value.description+'</td>';
							fleetutilhtml+='<td align="right">'+value.rental+'</td>';
							fleetutilhtml+='<td align="right">'+value.garage+'</td>';
							fleetutilhtml+='<td align="right">'+value.staff+'</td>';
							fleetutilhtml+='<td align="right">'+value.forsale+'</td>';
							fleetutilhtml+='<td align="right">'+value.other+'</td>';
							fleetutilhtml+='</tr>';
						});
						$('#tblfleetutilisation tbody').html($.parseHTML(fleetutilhtml));	
					}
					else if(widgetname=="revenuelist"){
						rawdata.revenuelistdata=objdata.revenuelistdata;
						var revenuehtml='';
						$.each(rawdata.revenuelistdata,function(key,value){
							revenuehtml+='<tr>';
							revenuehtml+='<td>'+value.description+'</td>';
							var rentaltotal=parseFloat(value.daily)+parseFloat(value.weekly)+parseFloat(value.monthly);
							rentaltotal=rentaltotal.toFixed(2);
							revenuehtml+='<td align="right">'+rentaltotal+'</td>';
							revenuehtml+='<td align="right">'+value.lease+'</td>';
							revenuehtml+='<td align="center" width="10%" >';
							revenuehtml+='<div class="btn-group">';
	  						revenuehtml+='<button type="button" class="btn btn-default dropdown-toggle btn-table-dropdown" data-toggle="dropdown">';
	    					revenuehtml+='<span class="caret"></span>';
	    					revenuehtml+='<span class="sr-only">Toggle Dropdown</span>';
	  						revenuehtml+='</button>';
	  						revenuehtml+='<ul class="dropdown-menu dropdown-menu-right" role="menu" style="width:250px;">';
	    					revenuehtml+='<li><a href="#">Daily<span class="pull-right"><strong>'+value.daily+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Weekly<span class="pull-right"><strong>'+value.weekly+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Monthly<span class="pull-right"><strong>'+value.monthly+'</strong></span></a></li>';
	    					revenuehtml+='<li class="divider"></li>';
	    					revenuehtml+='<li><a href="#">Lease<span class="pull-right"><strong>'+value.lease+'</strong></span></a></li>';
	  						revenuehtml+='</ul>';
							revenuehtml+='</div>';
							revenuehtml+='</td>';
							revenuehtml+='</tr>';
						});
						$('#tblrevenue tbody').html($.parseHTML(revenuehtml));
					}
					else if(widgetname=="revenuecomplist"){
						rawdata.revenuecomplistdata=objdata.revenuecomplistdata;
						var revenuehtml='';
						var customdata={};
						$.each(rawdata.revenuecomplistdata,function(key,value){
							revenuehtml+='<tr data-toggle="collapse" data-target="#revenuecompcollapse'+key+'">';
							revenuehtml+='<td>'+value.description+'</td>';
							var prevrentaltotal=parseFloat(value.prevdaily)+parseFloat(value.prevweekly)+parseFloat(value.prevmonthly);
							var currentrentaltotal=parseFloat(value.currentdaily)+parseFloat(value.currentweekly)+parseFloat(value.currentmonthly);
							prevrentaltotal=prevrentaltotal.toFixed(2);
							currentrentaltotal=currentrentaltotal.toFixed(2);
							revenuehtml+='<td align="right">'+prevrentaltotal+'</td>';
							revenuehtml+='<td align="right">'+value.prevlease+'</td>';
							revenuehtml+='<td align="center" width="10%" >';
							revenuehtml+='<div class="btn-group">';
	  						revenuehtml+='<button type="button" class="btn btn-default dropdown-toggle btn-table-dropdown" data-toggle="dropdown">';
	    					revenuehtml+='<span class="caret"></span>';
	    					revenuehtml+='<span class="sr-only">Toggle Dropdown</span>';
	  						revenuehtml+='</button>';
	  						revenuehtml+='<ul class="dropdown-menu dropdown-menu-right" role="menu" style="width:250px;">';
	    					revenuehtml+='<li><a href="#">Daily<span class="pull-right"><strong>'+value.prevdaily+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Weekly<span class="pull-right"><strong>'+value.prevweekly+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Monthly<span class="pull-right"><strong>'+value.prevmonthly+'</strong></span></a></li>';
	    					revenuehtml+='<li class="divider"></li>';
	    					revenuehtml+='<li><a href="#">Lease<span class="pull-right"><strong>'+value.prevlease+'</strong></span></a></li>';
	  						revenuehtml+='</ul>';
							revenuehtml+='</div>';
							revenuehtml+='</td>';
							revenuehtml+='<td align="right">'+currentrentaltotal+'</td>';
							revenuehtml+='<td align="right">'+value.currentlease+'</td>';
							revenuehtml+='<td align="center" width="10%" >';
							revenuehtml+='<div class="btn-group">';
	  						revenuehtml+='<button type="button" class="btn btn-default dropdown-toggle btn-table-dropdown" data-toggle="dropdown">';
	    					revenuehtml+='<span class="caret"></span>';
	    					revenuehtml+='<span class="sr-only">Toggle Dropdown</span>';
	  						revenuehtml+='</button>';
	  						revenuehtml+='<ul class="dropdown-menu dropdown-menu-right" role="menu" style="width:250px;">';
	    					revenuehtml+='<li><a href="#">Daily<span class="pull-right"><strong>'+value.currentdaily+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Weekly<span class="pull-right"><strong>'+value.currentweekly+'</strong></span></a></li>';
	    					revenuehtml+='<li><a href="#">Monthly<span class="pull-right"><strong>'+value.currentmonthly+'</strong></span></a></li>';
	    					revenuehtml+='<li class="divider"></li>';
	    					revenuehtml+='<li><a href="#">Lease<span class="pull-right"><strong>'+value.currentlease+'</strong></span></a></li>';
	  						revenuehtml+='</ul>';
							revenuehtml+='</div>';
							revenuehtml+='</td>';
							revenuehtml+='</tr>';
							revenuehtml+='<tr><td colspan="7"><div class="collapse revenuecompchart-container" id="revenuecompcollapse'+key+'" style="height:350px;"></div></td></tr>';
						});
						$('#tblrevenuecomp tbody').html($.parseHTML(revenuehtml));
						//"#2ecc71","#3498db","#95a5a6","#9b59b6","#f1c40f","#e74c3c","#34495e"
						$('.revenuecompchart-container').each(function(key){
							//console.log(rawdata.revenuecomplistdata[key].currentdaily);
							$('<canvas id="revenuecompChart'+key+'"></canvas>').appendTo($(this));
              					var data1={};
              					data1.labels=["Daily", "Weekly", "Monthly", "Lease"];
              					data1.datasets=[
                 					{label:'Previous',backgroundColor:["#2ecc71","#3498db","#95a5a6","#9b59b6"],data: [rawdata.revenuecomplistdata[key].prevdaily, rawdata.revenuecomplistdata[key].prevweekly,rawdata.revenuecomplistdata[key].prevmonthly,rawdata.revenuecomplistdata[key].prevlease]},
                 					{label:'Current',backgroundColor:["#2ecc71","#3498db","#95a5a6","#9b59b6"],data: [rawdata.revenuecomplistdata[key].currentdaily, rawdata.revenuecomplistdata[key].currentweekly,rawdata.revenuecomplistdata[key].currentmonthly,rawdata.revenuecomplistdata[key].currentlease]}
              					];
								console.log(data1);
             					var ctx = $("#revenuecompChart"+key).get(0).getContext("2d");
                				var myChart = new Chart(ctx, {
                  					type: 'pie',
                  					data: data1,
                  					options:{
                  						responsive: true,
										maintainAspectRatio:true,
										tooltips: {
		            						callbacks: {
		                						label: function(tooltipItem, data) {
		                    						var dataset = data.datasets[tooltipItem.datasetIndex];
		                    						var index = tooltipItem.index;
		                    						return dataset.label+' '+data.labels[index] + ': ' + dataset.data[index];
		                						}
		            						}
		        						}
                  					}
                 				});
                 			$(this).closest('tr').css('cursor','pointer').find('td').css('padding-top',0).css('padding-bottom',0);
						});
					}
					else if(widgetname=="collectlist"){
						rawdata.collectlistdata=objdata.collectlistdata;
						var collecthtml='';
						$.each(rawdata.collectlistdata,function(key,value){
							collecthtml+='<tr>';
							collecthtml+='<td>'+value.description+'</td>';
							collecthtml+='<td align="right">'+value.card+'</td>';
							collecthtml+='<td align="right">'+value.cash+'</td>';
							collecthtml+='<td align="right">'+value.cheque+'</td>';
							collecthtml+='</tr>';
						});
						$('#tblcollect tbody').html($.parseHTML(collecthtml));
					}
					$('.widget-'+widgetname).find('.panel-loader').addClass('dis-none');
				}
				else{
				}
			}
			x.open("GET","getFilterData.jsp?fromdate="+fromdate+"&todate="+todate+"&grouptype="+filtertype+"&widgetname="+widgetname+"&fromdate2="+fromdate2+"&todate2="+todate2,true);
			x.send();
		}
		
		function getInitChartData(chart,config,fleetdistchart,fleetdistconfig){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items.split("***")[2]);
				generateGauge(d3.select("#gauge1"), parseFloat(guagedata.occtotal/100).toFixed(2),"desc");
            	generateGauge(d3.select("#gauge2"), parseFloat(guagedata.occavail/100).toFixed(2),"desc");
            	generateGauge(d3.select("#gauge3"), parseFloat(guagedata.occgarage/100).toFixed(2),"asc");
            	generateGauge(d3.select("#gauge4"), parseFloat(guagedata.occunrentable/100).toFixed(2),"asc");
            	$("#gauge1").closest('.card-container').find('.card-footer').find('.counter').text(guagedata.occtotal);
            	$("#gauge2").closest('.card-container').find('.card-footer').find('.counter').text(guagedata.occavail);
            	$("#gauge3").closest('.card-container').find('.card-footer').find('.counter').text(guagedata.occgarage);
            	$("#gauge4").closest('.card-container').find('.card-footer').find('.counter').text(guagedata.occunrentable);
	            
		        
				$('.agmt-count .card-detail-container div:nth-child(1)').find('.counter').text(guagedata.agmtdailycount);
				$('.agmt-count .card-detail-container div:nth-child(2)').find('.counter').text(guagedata.agmtweeklycount);
				$('.agmt-count .card-detail-container div:nth-child(3)').find('.counter').text(guagedata.agmtmonthlycount);
				$('.agmt-count .card-detail-container div:nth-child(4)').find('.counter').text(guagedata.agmtleasecount);
				$('.counter').counterUp({
		            delay: 10,
		            time: 1000
		        });
				rawdata.fleetdistdata=JSON.parse(items.split("***")[0]);
				rawdata.livefleetdata=JSON.parse(items.split("***")[1]);
				rawdata.fleetsalesdata=JSON.parse(items.split("***")[1]);
				rawdata.fleetsalescombo=rawdata.livefleetdata.labelsvalues;
				rawdata.livefleetdata=rawdata.livefleetdata.livefleets;
				$('.widget-livefleet .panel-heading .dropdown-menu li:first-child a').trigger('click');
				window.chartfleetdist.data.datasets[0].data=funSetRawData(rawdata.fleetdistdata,"","count","trancode");
				window.chartfleetdist.data.datasets[0].labels=funSetRawData(rawdata.fleetdistdata,"","group","trancode");
				window.chartfleetdist.update();
				chart.data.labels=rawdata.fleetsalesdata.labels;
				chart.data.datasets[0].data=rawdata.fleetsalesdata.purchasemonthcount;
				chart.data.datasets[1].data=rawdata.fleetsalesdata.salesmonthcount;
				chart.options.title.text=rawdata.fleetsalesdata.fleetstatustitle;
				chart.update();
				
				/*$('.widget.fleetlist').html($.parseHTML(fleetlisthtml));*/
				var fleetsalescombohtml='';
				$.each(rawdata.fleetsalesdata.labelsvalues,function(key,value){
					if(key==rawdata.fleetsalesdata.labels.length-1){
						fleetsalescombohtml+='<option value='+rawdata.fleetsalesdata.labelsvalues[key]+' selected>'+rawdata.fleetsalesdata.labels[key]+'</option>';	
					}
					else{
						fleetsalescombohtml+='<option value='+rawdata.fleetsalesdata.labelsvalues[key]+'>'+rawdata.fleetsalesdata.labels[key]+'</option>';
					}
				});
				$('.cmbfleetsalesbrand,.cmbfleetsalesmodel').html(fleetsalescombohtml);
				getBrandwiseFleetSales($('.cmbfleetsalesbrand').val(),"Brand");
				getBrandwiseFleetSales($('.cmbfleetsalesmodel').val(),"Model");
				var objdata=JSON.parse(items.split("***")[2]);
				rawdata.clientdatasalesmanwise=objdata.clientdataarraysalesmanwise;
				rawdata.clientdatacategorywise=objdata.clientdataarraycategorywise;
				
				$('.widget-fleetdistchart .panel-heading .dropdown-menu li:first-child a').trigger('click');
				$('.widget-clientlist .panel-heading .dropdown-menu li:first-child a').trigger('click');
				$('.widget-collectlist .panel-heading .dropdown-menu li:first-child a').trigger('click');
				$('.widget-revenuelist .panel-heading .dropdown-menu li:first-child a').trigger('click');
				$('.widget-fleetutillist .panel-heading .dropdown-menu li:first-child a').trigger('click');
				$('.widget-revenuecomplist .panel-heading .dropdown-menu li:first-child a').trigger('click');
				/*$('#tblclients').DataTable({
                	"paging":   false,
                	"info":false
            	});*/
				$('.page-loader').hide();
				
			}
			else{
			}
		}
		x.open("GET","getInitChartData.jsp",true);
		x.send();
	}
	
	function funSetRawData(rawdata,filtername,grouptype,groupname){
		var result;
		if(grouptype=="count"){
			if(filtername!=""){
				result=_.chain(rawdata.fleetdistdata)
					.filter(function(stooge){
						return stooge.trancode==filtername;
					})
					.countBy(function(stooge){return stooge[groupname]})
					.map(function(stooge){return stooge})
					.value();
			}
			else{
				result=_.chain(rawdata.fleetdistdata)
					.countBy(function(stooge){return stooge[groupname]})
					.map(function(stooge){return stooge})
					.value();	
			}
			
		}
		else if(grouptype=="group"){
			if(filtername!=""){
				result=_.chain(rawdata.fleetdistdata)
					.filter(function(stooge){
						return stooge.trancode==filtername;
					})
					.groupBy(function(obj){
						return obj[groupname];
					})
					.map(function(obj,y){
						return y;
					})
					.value();	
			}
			else{
				result=_.chain(rawdata.fleetdistdata)
					.groupBy(function(obj){
						return obj[groupname];
					})
					.map(function(obj,y){
						return y;
					})
					.value();	
			}
			
		}
		return result;
	}
	function getBrandwiseFleetSales(basedate,detailtype){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				items=JSON.parse(items);
				
				if(detailtype=="Brand"){
					var brandwisetabledata='';
					$.each(items.brandwisedata,function(key,value){
						brandwisetabledata+='<tr>';
						brandwisetabledata+='<td>'+value.split("::")[0]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[1]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[2]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[3]+'</td>';
						brandwisetabledata+='</tr>';
					});
					$('.table-brandwise tbody').html($.parseHTML(brandwisetabledata));	
				}
				else if(detailtype=="Model"){
					var brandwisetabledata='';
					$.each(items.modelwisedata,function(key,value){
						brandwisetabledata+='<tr>';
						brandwisetabledata+='<td>'+value.split("::")[0]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[1]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[2]+'</td>';
						brandwisetabledata+='<td>'+value.split("::")[3]+'</td>';
						brandwisetabledata+='</tr>';
					});
					$('.table-modelwise tbody').html($.parseHTML(brandwisetabledata));	
				}
				
			}
			else{
			}
		}
		x.open("GET","getBrandwiseFleetSales.jsp?basedate="+basedate+"&detailtype="+detailtype,true);
		x.send();
	}
		window.onload = function() {
			var ctxchartfleetsales = document.getElementById('chartfleetsales').getContext('2d');
			window.chartfleetsales = new Chart(ctxchartfleetsales, fleetsalesconfig);
			var ctxchartfleetdist = document.getElementById('chartfleetdist').getContext('2d');
			window.chartfleetdist = new Chart(ctxchartfleetdist, fleetdistconfig);
			getInitChartData(window.chartfleetsales,fleetsalesconfig,window.chartfleetdist,fleetdistconfig);
			
		};
	</script>
</body>
</html>