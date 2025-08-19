<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Customer Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="../gatelogo.ico">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../reportincludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	:root {
  		/*--main-bg-color:#5867dd;
  			rgba(88,103,221,1)
  		*/
  		--main-bg-color:#0c447f;
  		--main-sec-color:#fff;
	}
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
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		position:relative;
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: var(--main-bg-color);
    	border-color: var(--main-bg-color);
		color:#fff;
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:var(--main-bg-color);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:var(--main-bg-color);
	}
	
	.custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	height:54px;
    	padding-top:20px;
    }
    .stmtpanel{
    	height:54px;
    	padding-top:15px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.admin-cover .panel-body{
	border:none;
}

.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-top: 10px;
	}
	.card-container .card-icon-wrapper{
		width: 30%;
		display: inline-block;
		clear: both;
		float: left;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	.card-container .card-detail-wrapper{
		width: 70%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-detail-wrapper{
		width: 50%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-expand-wrapper{
		width: 18%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container .card-detail-wrapper p:nth-child(1){
		margin-top: 5px;
		margin-bottom: 2px;
	}
	.centered{
	    margin: 0 auto;
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: var(--main-bg-color);
	}
	.contact-container{
		width:100%;
		background-color:#fff;
	}
	.contact-header{
		background-image:url("images/bg-02.jpg");
		background-size:cover;
		background-repeat:no-repeat;
		background-position:center top;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	#tblexenq tbody tr.active td,#tblexend tbody tr.active td{
		color: #fff;
	    background-color: var(--main-bg-color);
	}
	#tblexend tbody tr.active td span.badge{
		background-color:#fff;
		color:var(--main-bg-color);
	}
	#tblexenq tbody tr{
		cursor:pointer;
	}
	.btn-outline-primary{
	    color: var(--main-bg-color);
	    background-color: transparent;
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	.btn-outline-primary:hover,.btn-outline-primary:focus,.btn-outline-primary:active{
	    color: #fff;
	    background-color: var(--main-bg-color);
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	
	#tblcontracts .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tblcontracts .table-responsive {
	  overflow-y: visible !important;
	}
	.custom-navbar{
		background-color:var(--main-bg-color);
		color:var(--main-sec-color);
	}
	.custom-navbar .navbar-brand,.custom-navbar .navbar-brand:hover,.custom-navbar .navbar-brand:active,.custom-navbar .navbar-brand:focus{
		color:var(--main-sec-color);
	}
	.custom-navbar .user-dropdown-text,#myNavbar .fa-user,#myNavbar .caret{
		color:var(--main-sec-color);
	}
	.contact-header-img .img-thumbnail{
		background-color:var(--main-bg-color);
		border-color:var(--main-bg-color);
	}
	.custom-navbar .dropdown.open .user-dropdown-text,#myNavbar .dropdown.open .fa-user,#myNavbar .dropdown.open .caret{
		color:var(--main-bg-color);
	}
	:not(#feeddate) .jqx-datetimeinput .jqx-icon{
		top: 20%;
    	left: 10%;
	}
	.tblfeed tbody tr.active td{
		background-color:var(--main-bg-color);
		color:var(--main-sec-color);
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#" style="padding-top: 2px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;">
      					<img alt="" src="images/comp-logo.jpg" style="width:auto; height: 100%;">
      				</span>
      				CRM Dashboard
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><i class="fa fa-user"></i> <span class="user-dropdown-text">User</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<%
          					String redirect=request.getParameter("redirect")==null?"":request.getParameter("redirect");
          					if(redirect.equalsIgnoreCase("1")){%>
          					<li><a href="#" onclick="location.replace('https://alhabtoor.fly7c.com');">Sign Out</a></li>
          					<%}else{%>
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
							<%}%>
          					<!-- <li><a href="#">Change Password</a></li> -->
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60">
    		<li class="active"><a data-toggle="pill" href="#menu-dashboard"><i class="fa fa-home p-r-5"></i>Dashboard</a></li>
    		<li><a data-toggle="pill" href="#menu1"><i class="fa fa-credit-card p-r-5"></i>Account Statement</a></li>
    		<li><a data-toggle="pill" href="#menu2"><i class="fa fa-file-text p-r-5"></i>Agreement List</a></li>
    		<li><a data-toggle="pill" href="#menutrafficinv"><i class="fa fa-car p-r-5"></i>Traffic Invoices</a></li>
    		<li><a data-toggle="pill" href="#menufeedback"><i class="fa fa-comments p-r-5"></i>Customer Queries</a></li>
    		<li><a data-toggle="pill" href="#menu4"><i class="fa fa-users p-r-5"></i>Customer Helpdesk</a></li>
  		</ul>

  		<div class="tab-content">
  			<div id="menufeedback" class="tab-pane fade">
  				<div class="container-fluid">
  					<div class="row m-t-10">
  						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  							<div class="panel panel-default">
  								<div class="panel-heading">
  									<strong class="panel-title" style="font-size:14px;">Existing Queries</strong>
  								</div>
  								<div class="panel-body">
  									<div class="form-horizontal form-feed">
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="cmbfeedregno">Reg No:</label>
		    								<div class="col-sm-9">
		      									<select class="form-control" name="cmbfeedregno" id="cmbfeedregno" style="width:100%;">
		      										<option value="">--Select--</option>
		      									</select>
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedcalledby">Called By:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedcalledby" id="feedcalledby" class="form-control" placeholder="Called By">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedmobile">Mobile:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedmobile" id="feedmobile" class="form-control" placeholder="Mobile No">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="cmbfeedtype">Type:</label>
		    								<div class="col-sm-9">
		      									<select class="form-control" name="cmbfeedtype" id="cmbfeedtype" style="width:100%;">
		      										<option value="">--Select--</option>
		      									</select>
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedplace">Place:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedplace" id="feedplace" class="form-control" placeholder="Place">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedremarks">Remarks:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedremarks" id="feedremarks" class="form-control" placeholder="Remarks">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feeddate">Date &amp; Time:</label>
		    								<div class="col-sm-9">
		      									<div id="feeddate"></div>
		    								</div>
		  								</div>
		  							</div>		
  								</div>
  								<div class="panel-footer text-right">
  									<button type="button" class="btn btn-default" id="btnfeedclear">Clear</button>
      								<button type="button" class="btn btn-default btn-primary" id="btnfeedsave">Save Changes</button>
  								</div>
  							</div>
  							
  						</div>
  						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  							<div class="panel panel-default">
  								<div class="panel-heading">
  									<strong class="panel-title" style="font-size:14px;">Existing Queries</strong>
  								</div>
  								<div class="panel-body table-responsive" style="height:400px;overflow-y:auto;">
  									<table class="table table-hover tblfeed">
  										<thead>
  											<tr>
  												<th>Reg.No</th>
  												<th>Date</th>
  												<th>Called By</th>
  												<th>Type</th>
  												<th>Status</th>
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
    		<div id="menutrafficinv" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btntrafficsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btntrafficexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="trafficfromdate"></div>
				  				<div id="traffictodate"></div>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="trafficlistdiv"><jsp:include page="trafficListGrid.jsp"></jsp:include></div> 
						</div>
					</div>
				</div>
    		</div>
    		<div id="menu-dashboard" class="tab-pane fade in active">
    			<div class="container-fluid m-t-20">
    				<div class="panel panel-default admin-cover animated fadeInDown" id="admin-cover">
	  					<div class="panel-body">
	    					<p style="margin-bottom:0;display:inline-block;" class="fs-12"><strong>Hi User</strong>, Your Analytics are all set</p>
	    					<button type="button" class="close" data-target="#admin-cover" data-dismiss="alert"  style="display:inline-block;">
	    						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        	</button>
	  					</div>
					</div>
    				<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn advance">
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/advance.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Advance</p>
									<p><strong>AED <span class="value">0.00</span></strong></p>
								</div>
							</div>
						</div>
						<!--<div class="col-xs-12 col-sm-6 col-md-3 col-lg-2">
							<div class="card-container img-rounded m-b-10 animated zoomIn pdcinhand">
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/pdcinhand.png">
								</div>
								<div class="card-detail-wrapper">
									<p>PDC In Hand</p>
									<p><strong>AED <span class="value">15245.56</span></strong></p>
								</div>
							</div>
						</div>-->
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn total">
								<div class="card-icon-wrapper text-center">
									<!-- <img src="https://img.icons8.com/color/48/000000/total-sales-1.png"> -->
									<img src="images/icons/total.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Total</p>
									<p><strong>AED <span class="value">0.00</span></strong></p>
								</div>
							</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn unapplied">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/unapplied.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Un Applied</p>
								<p><strong>AED <span class="value">0.00</span></strong></p>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn balance">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/balance.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Balance</p>
								<p><strong>AED <span class="value">0.00</span></strong></p>
							</div>
						</div>
					</div>
				</div>
				<div class="row m-t-10">
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
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
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
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
			                        <span class="panel-title-text fs-12"><strong>Live Fleets</strong><span class="custom-badge1 badge" style="margin-left: 10px;border-radius: 4px;margin-top: -3px;"></span></span>
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
    		</div>
    		
    	</div>
    		<div id="menu1" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="fromdate"></div>
				  				<div id="todate"></div>
				        	</div>
				        	<div class="primarypanel custompanel">
				        		<button class="btn btn-default" id="btnacstmt">Statement Print</button>
				        		<button class="btn btn-default" id="btnoutstanding">Outstanding Statement</button>
				        		<button class="btn btn-default" id="btnstmtprint"><i class="fa fa-print"></i></button>
				        		<button class="btn btn-default hidden" id="btnstmtattach"><i class="fa fa-paperclip"></i></button>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="accountsStatementDiv"><jsp:include page="accountsStatementTypeGrid.jsp"></jsp:include></div> 
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<table width="100%">
								<tr>
									<td width="85%" align="right" style="font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
			        				<td width="15%" align="left"><input type="text" class="textbox form-control" id="txtnetamount" name="txtnetamount" style="width:90%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
    		</div>
    		<div id="menu2" class="tab-pane fade">
    			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btninvsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btninvexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninvinfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				        		<label class="checkbox-inline" style="margin-top: -10px;"><input type="checkbox" value="" id="chkbetweendates">Use Between Dates</label>
				  				<div id="invfromdate"></div>
				  				<div id="invtodate"></div>
				  				<select id="cmbstatus" name="cmbstatus" class="form-control" style="width:150px;margin-top: -20px;">
				  					<option value="">--Select--</option>
				  					<option value="0" selected>Open</option>
				  					<option value="1">Closed</option>
				  				</select>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="agmtListDiv"><jsp:include page="agmtListGrid.jsp"></jsp:include></div>
						</div>
					</div>
				</div>
    		</div>
  			<div id="menu4" class="tab-pane fade">
  				<div class="container m-t-10">
  					<div class="contact-container img-rounded boxshadow1">
  						<div class="contact-header">
  							<div class="row">
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-img p-t-15 p-l-15 p-r-15 p-b-15">
		  								<a href="http://www.epicrentacar.com" target="_blank">
		  									<img alt="Company Logo" src="images/comp-logo.jpg" style="width:auto;height:150px;" class="img-responsive img-thumbnail img-responsive boxshadow1"></a>
		  							</div>		
  								</div>
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-detail pull-right p-r-20 p-t-25">
  										<h4>Epic &amp;Rent-A-Car</h4>
  										<p>Let's start exploring the world together with us</p>
  									</div>		
  								</div>
  							</div>
  						</div>
  						<div class="contact-body">
  							<div class="container-fluid">
  								<div class="panel panel-default m-t-15">
  									<table class="table tblhelpdesk">
		  								<thead>
		  									<tr>
		  										<th>Sr No</th>
		  										<th>Employee</th>
		  										<th>Department</th>
		  										<th>Email</th>
		  										<th>Mobile</th>
		  									</tr>
		  								</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Earl Harmon</td>
												<td>Management</td>
												<td>earl@trust.com</td>
												<td>+9199895098950</td>
											</tr>
											<tr>
												<td>2</td>
												<td>Jeremy Gardener</td>
												<td>Finance</td>
												<td>jeremy_255@trust.com</td>
												<td>+9199895098950</td>
											</tr>
											<tr>
												<td>3</td>
												<td>Della Cunningham</td>
												<td>Customer Relation</td>
												<td>dells@trust.com</td>
												<td>+9199895098950</td>
											</tr>
										</tbody>
		  							</table>
  								</div>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  		</div>
	</div>
	
	<input type="hidden" name="clientacno" id="clientacno">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="../js/sweetalert2.all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script src="../js/Chart.min.js"></script>
	<script type="text/javascript" src="../js/dashboard/chartjs-plugin-colorschemes.min.js"></script>
	<%-- <script src="../../js/dashboard/d3.min.js" charset="utf-8"></script> --%>
	<%-- <script src="../../js/chartutils.js"></script> --%>
	<%-- <script src="../../js/dashboard/jquery.knob.min.js"></script> --%>
	
	<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script> --%>
	<script src="../js/dashboard/jquery.counterup.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.10.2/underscore.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script>
    	var rawdata={};
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
    	window.chartColors = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
			color1:'rgb(255, 15, 0)',
			color2:'rgb(255, 102, 0)',
			color3:'rgb(255, 158, 1)',
			color4:'rgb(252, 210, 2)',
			color5:'rgb(248, 255, 1)',
			color6:'rgb(176, 222, 9)',
			color7:'rgb(4, 210, 21)',
			color8:'rgb(13, 142, 207)',
			color9:'rgb(13, 82, 209)',
			color10:'rgb(42, 12, 208)',
			color11:'rgb(138, 12, 207)',
			color12:'rgb(205, 13, 116)',
			color13:'rgb(117, 77, 235)',
			color14:'rgb(221, 221, 221)',
			color15:'rgb(153, 153, 153)',
			color16:'rgb(51, 51, 51)'
		};
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
				legendhtml+='<li class="list-group-item">'+window.chartfleetdist.data.datasets[1].labels[i]+' <span class="badge" style="border-radius:4px;">'+window.chartfleetdist.data.datasets[1].data[i]+'</span></li>';
			}
			legendhtml+='</ul>';
			$('.chartfleetdist-legend-container').html($.parseHTML(legendhtml));
        };
        
		window.onload = function() {
			var ctxchartfleetdist = document.getElementById('chartfleetdist').getContext('2d');
			window.chartfleetdist = new Chart(ctxchartfleetdist, fleetdistconfig);
		};
    	$(document).ready(function(){
    		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#todate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#invfromdate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#invtodate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#trafficfromdate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#traffictodate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#feeddate").jqxDateTimeInput({ width: '150px', height: '20px', formatString:"dd.MM.yyyy HH:mm",value:new Date()});
    		
    		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     		$('#fromdate,#invfromdate,#trafficfromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
			$('#cmbstatus').select2({
				placeholder:"Select Status",
				allowClear:true
			});
			$('#cmbfeedregno').select2({
				placeholder:"Select Reg No",
				allowClear:true
			});
			$('#cmbfeedtype').select2({
				placeholder:"Select Type",
				allowClear:true
			});
			$('#btnfeedclear').click(function(){
				$('.tblfeed tbody tr').removeClass('active');
				$('.form-feed input').val('');
				$('.form-feed select').val(null).trigger('change');
				$('#feeddate').jqxDateTimeInput('setDate',new Date());
			});
			$('#btnfeedsave').click(function(){
				if($('.tblfeed tbody tr.active').length>0){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please clear the document before proceeding'
					});
					return false;
				}
				var invalid=0;
				$('#cmbfeedregno,#feedcalledby,#feedmobile,#cmbfeedtype,#feeddate').each(function(){
					
					if(($(this).val()=='' && $(this).attr('id')!='feeddate') || ($(this).attr('id')=='feeddate' && $(this).jqxDateTimeInput('getDate')==null)){
						$(this).closest('.form-group').find('span.help-block').remove();
						$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Mandatory</span>'));
						invalid=1;
						return false;
					}
					else{
						$(this).closest('.form-group').find('span.help-block').remove();
						$(this).closest('.form-group').removeClass('has-error');
					}
					if($(this).attr('id')=='feedmobile'){
						var mobileno=$(this).val();
						let isnum = /^\d+$/.test(mobileno);
						if(mobileno.length>12){
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Max 12 Digits Allowed</span>'));
							invalid=1;
							return false;
						}
						else if(!isnum){
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Only Digits Allowed</span>'));
							invalid=1;
							return false;
						}
						else{
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').removeClass('has-error');
						}
					}
				});
				if(invalid==1){
					return false;
				}
				
				Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Save Changes'
				}).then((result) => {
						if(result.isConfirmed) {
					   		$('.page-loader button').show();
					   		$.post('saveClientQueries.jsp',{
					   			'regno':$('#cmbfeedregno').val(),
					   			'calledby':$('#feedcalledby').val(),
					   			'mobile':$('#feedmobile').val(),
					   			'type':$('#cmbfeedtype').val(),
					   			'place':$('#feedplace').val(),
					   			'remarks':$('#feedremarks').val(),
					   			'date':$('#feeddate').jqxDateTimeInput('val')},
					   			function(data,status){
					   				console.log('RAW:'+data);
					   				data=JSON.parse(data.trim());
					   				console.log('JSON:'+data);
					   				$('.page-loader button').hide();
					   				if(data.errorstatus=="0"){
					   					Swal.fire({
											type: 'success',
											title: 'Success',
											text: 'Saved Successfully'
										});
					   					$('.form-feed input').val('');
					   					$('.form-feed select').val(null).trigger('change');
					   					$('#feeddate').jqxDateTimeInput('setDate',new Date());
					   					getInitData();
					   				}
					   				else{
					   					Swal.fire({
											type: 'error',
											title: 'Warning',
											text: 'Not Saved'
										});
					   					return false;
					   				}
					   			});
					  	}
					});
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
			
			$('#btnacstmt').click(function(){
				var gridrows=$('#accountsStatement').jqxGrid('getrows');
				if(gridrows.length>0){
					var fromdate=$('#fromdate').jqxDateTimeInput('val');
					var todate=$('#todate').jqxDateTimeInput('val');
					var clientacno=document.getElementById("clientacno").value;
					var netamount=document.getElementById("txtnetamount").value;
			        var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
				}
			});
			$('#btnoutstanding').click(function(){
				var gridrows=$('#accountsStatement').jqxGrid('getrows');
				if(gridrows.length>0){
					var fromdate=$('#fromdate').jqxDateTimeInput('val');
					var todate=$('#todate').jqxDateTimeInput('val');
					var clientacno=document.getElementById("clientacno").value;
					var netamount=document.getElementById("txtnetamount").value;
					var win= window.open("<%=contextPath%>/com/dashboard/accounts/ageingstatement/printAgeingOutstandingsStatementNew?&acno="+clientacno+"&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch=a&uptoDate="+todate+"&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        //var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
				}
			});
			$('#btnstmtprint').click(function(){
				var rowindex=$('#stmtrowindex').val();
				var dtype=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transtype");
           		var docno=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transno");
           		var brhid=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"brhid");
           		if(dtype=="TINV"){
           			var win= window.open("<%=contextPath%>/com/operations/commtransactions/travelinvoice/printtravelinvoice?docno="+docno+"&branch="+brhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();
           		}
           		else if(dtype=="INS" || dtype=="INV" || dtype=="INT"){
           			var win= window.open("<%=contextPath%>/com/operations/commtransactions/invoice/printManualInvoice?tono="+docno+"&fromno="+docno+"&branch="+brhid+"&printdocno=&hidheader=1&chkdeletedinvprint=0&bankdocno=","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();
           		}
           		else if(dtype=="CRV"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/cashreceipt/printCashReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="BRV"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/bankreceipt/printBankReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="CNO"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/creditnote/printCreditNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="DNO"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/debitnote/printDebitNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		
			});
			$('#btnstmtattach').click(function(){
				var rowBoundIndex=$('#stmtrowindex').val();
				var brhid=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'brhid');  
				var docno="";
				docno=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'docno');
    			if(docno!="" && docno!="0"){             
					var frmdet=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'transtype');
					var fname="";
					var x = new XMLHttpRequest();
 					x.onreadystatechange = function() {
 						if (x.readyState == 4 && x.status == 200) {
 							var items = x.responseText.trim();
 							fname=items;
	   						var myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		  					myWindow.focus();
 						}
 					}
 					x.open("GET", "getFormname.jsp?formtype="+frmdet, true);
 					x.send();
 					
				}
				else{  
					Swal.fire({
						type: 'error',
						title: 'Empty Document',
						text: 'Please select a document'
					});
					return false;
    			}
			});
    		$('#btnsubmit').click(function(){
    			var acno=$('#clientacno').val();
    			var fromdate=$('#fromdate').jqxDateTimeInput('val');
    			var todate=$('#todate').jqxDateTimeInput('val');
    			$('#txtnetamount').val('');
    			$('.page-loader button').show();
    			$('#accountsStatementDiv').load('accountsStatementTypeGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&accdocno='+acno+'&check=1&branchval=a');
    		});
    		$('#btnexcel').click(function(){
    			var excelname="Account Statement of "+$('.user-dropdown-text').text()+" dated from "+$('#fromdate').jqxDateTimeInput('val')+" to "+$('#todate').jqxDateTimeInput('val');
    			$("#accountsStatementDiv").excelexportjs({
					containerid: "accountsStatementDiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "accountsStatement", 
					columns: getColumns("accountsStatement") , 
					worksheetName:excelname
				});	
    		});
			$('#btninvsubmit').click(function(){
				var fromdate=$('#invfromdate').jqxDateTimeInput('val');
				var todate=$('#invtodate').jqxDateTimeInput('val');
				var acno=$('#clientacno').val();
				$('.page-loader button').show();
				var status=$('#cmbstatus').val();
				var chkbetweendates=$("#chkbetweendates:checked" ).length;
				$('#agmtListDiv').load('agmtListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&acno='+acno+'&id=1&branch=a&status='+status+'&chkbetweendates='+chkbetweendates);
			}); 
			$('#btntrafficsubmit').click(function(){
				var fromdate=$('#trafficfromdate').jqxDateTimeInput('val');
				var todate=$('#traffictodate').jqxDateTimeInput('val');
				var acno=$('#clientacno').val();
				$('.page-loader button').show();
				//alert('trafficListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&acno='+acno+'&id=1&branch=a');
				$('#trafficlistdiv').load('trafficListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&acno='+acno+'&id=1&branchval=a');
			}); 
			$('#btntrafficexcel').click(function(){
				var excelname="Invoiced Traffics of "+$('.user-dropdown-text').text()+" dated from "+$('#trafficfromdate').jqxDateTimeInput('val')+" to "+$('#traffictodate').jqxDateTimeInput('val');
    			$("#jqxInvoiced").excelexportjs({
					containerid: "jqxInvoiced",
					datatype: 'json', 
					dataset: null, 
					gridId: "jqxInvoiced", 
					columns: getColumns("jqxInvoiced") , 
					worksheetName:excelname
				});	
    		});
			$('#btninvexcel').click(function(){
				var chkbetweendates=$("#chkbetweendates:checked" ).length;
				var excelname="";
				if(chkbetweendates==0){
					excelname="Agreement List of "+$('.user-dropdown-text').text()+" dated till "+$('#invtodate').jqxDateTimeInput('val');
				}
				else{
					excelname="Agreement List of "+$('.user-dropdown-text').text()+" dated from "+$('#invfromdate').jqxDateTimeInput('val')+" to "+$('#invtodate').jqxDateTimeInput('val');
				}
    			$("#detailsgrid").excelexportjs({
					containerid: "detailsgrid",
					datatype: 'json', 
					dataset: null, 
					gridId: "detailsgrid", 
					columns: getColumns("detailsgrid") , 
					worksheetName:excelname
				});	
    		});

    	});
    	$(window).ready(function(){
    		getInitData();
		});
		
		
		function getInitData(){
			$('.page-loader,.page-loader button').show();
			$('body').css('overflow','hidden');
			
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.user-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				$('#clientacno').val(items.split("::")[3].trim());
	  				$('.pdcinhand .card-detail-wrapper .value').text(items.split("::")[4].trim());
	  				$('.subreceipt .card-detail-wrapper .value').text(items.split("::")[5].trim());
	  				$('.advance .card-detail-wrapper .value').text(items.split("::")[6].trim());
	  				$('.balance .card-detail-wrapper .value').text(items.split("::")[7].trim());
	  				$('.unapplied .card-detail-wrapper .value').text(items.split("::")[8].trim());
	  				$('.total .card-detail-wrapper .value').text(items.split("::")[9].trim());
	  				var policynodata=JSON.parse(items.split("::")[13].trim());
					var helpdeskdata='';
					$.each(policynodata.helpdeskdata, function( index, value ) {
	  					helpdeskdata+='<tr data-docno="'+value.split("***")[1]+'">';
	  					helpdeskdata+='<td>'+value.split("***")[0]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[2]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[3]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[4]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[5]+'</td>';
	  					helpdeskdata+='</tr>';
					});
					$('.tblhelpdesk tbody').html($.parseHTML(helpdeskdata));
					helpdeskdata='<option value="">--Select--</option>';
					$.each(policynodata.feedvehdata,function(index,value){
						helpdeskdata+='<option value="'+value.fleetno+'">'+value.refname+'</option>';
					});
					$('#cmbfeedregno').html($.parseHTML(helpdeskdata));
					$('#cmbfeedregno').select2({
						placeholder:"Select Reg No",
						allowClear:true
					});
					helpdeskdata='<option value="">--Select--</option>';
					$.each(policynodata.feedtypedata,function(index,value){
						helpdeskdata+='<option value="'+value.docno+'">'+value.refname+'</option>';
					});
					$('#cmbfeedtype').html($.parseHTML(helpdeskdata));
					$('#cmbfeedtype').select2({
						placeholder:"Select Type",
						allowClear:true
					});
					helpdeskdata='';
					$.each(policynodata.feeddata,function(index,value){
						helpdeskdata+='<tr data-fleetno="'+value.fleetno+'" data-datetime="'+value.datetime+'" data-mobile="'+value.mobile+'" data-type="'+value.type+'" data-place="'+value.place+'" data-remarks="'+value.remarks+'">';
						helpdeskdata+='<td>'+value.regno+'</td>';
						helpdeskdata+='<td>'+value.date+'</td>';
						helpdeskdata+='<td>'+value.calledby+'</td>';
						helpdeskdata+='<td>'+value.typename+'</td>';
						helpdeskdata+='<td>'+value.statusname+'</td>';
						helpdeskdata+='</tr>';
					});
					$('.tblfeed tbody').html($.parseHTML(helpdeskdata));
					
					$('.tblfeed tbody tr').on('click',function(){
						$('.tblfeed tbody tr').removeClass('active');
						$(this).addClass('active');
						$('#cmbfeedregno').val($(this).attr('data-fleetno')).trigger('change');
						$('#feedcalledby').val($(this).find('td').eq(2).text());
						$('#feedmobile').val($(this).attr('data-mobile'));
						$('#cmbfeedtype').val($(this).attr('data-type')).trigger('change');
						$('#feedplace').val($(this).attr('data-place'));
						$('#feedremarks').val($(this).attr('data-remarks'));
						$('#feeddate').jqxDateTimeInput('val',$(this).attr('data-datetime'));
						return false;
					})
					rawdata.fleetdistdata=JSON.parse(items.split("::")[14]);
					rawdata.livefleetdata=JSON.parse(items.split("::")[15]);
					rawdata.fleetsalesdata=JSON.parse(items.split("::")[15]);
					rawdata.fleetsalescombo=rawdata.livefleetdata.labelsvalues;
					rawdata.livefleetdata=rawdata.livefleetdata.livefleets;
					$('.widget-livefleet .panel-heading .dropdown-menu li:nth-child(2) a').trigger('click');
					window.chartfleetdist.data.datasets[0].data=funSetRawData(rawdata.fleetdistdata,"","count","trancode");
					window.chartfleetdist.data.datasets[0].labels=funSetRawData(rawdata.fleetdistdata,"","group","trancode");
					window.chartfleetdist.update();

					$('.widget-fleetdistchart .panel-heading .dropdown-menu li:nth-child(2) a').trigger('click');
					/* chart.data.labels=rawdata.fleetsalesdata.labels;
					chart.data.datasets[0].data=rawdata.fleetsalesdata.purchasemonthcount;
					chart.data.datasets[1].data=rawdata.fleetsalesdata.salesmonthcount;
					chart.options.title.text=rawdata.fleetsalesdata.fleetstatustitle;
					chart.update(); */
	  				$('.page-loader,.page-loader .btn').hide();
	  				$('body').css('overflow','auto');
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp", true);
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
		function SaveToDisk(fileURL, fileName) {
	   		var host = window.location.origin;
	   		var splt = fileURL.split("webapps"); 
	   		var repl = splt[1].replace( /;/g, "/");
	   		fileURL=host+repl;
	    	
	    	if (!window.ActiveXObject) {
	        	var save = document.createElement('a');
	        	save.href = fileURL;
	        	save.target = '_blank';
	        	save.download = fileName || 'unknown';
	        	window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	    	}

	    	// for IE
	    	else if ( !! window.ActiveXObject && document.execCommand){
	        	var _window = window.open(fileURL, '_blank');
	        	_window.document.close();
	        	_window.document.execCommand('SaveAs', true, fileName || fileURL)
	       	 	_window.close();
	    	}
		}
    	function funRoundAmt(value,id){
    		var res=parseFloat(value).toFixed(2);
    		var res1=(res=='NaN'?"0":res);
    		document.getElementById(id).value=res1;  
   		}
   		
    </script>    
</body>
</html>