<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Cooperate Travel Desk</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<link href="../../../../css/util.css" rel="stylesheet" />
<style type="text/css">
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../../../../fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../../../../fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../../../../fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../../../../fonts/montserrat/Montserrat-SemiBold.ttf'); 
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
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:rgba(88,103,221,1);
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: rgba(88,103,221,1);
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.form-group label{
		font-weight:normal;
	}
	
	.travel-navbar.navbar {
	  max-height: 30px;
	}

.travel-navbar .navbar-brand {
  padding: 0 15px;
  height: 30px;
  line-height: 30px;
}

.travel-navbar .navbar-toggle {
  /* (80px - button height 34px) / 2 = 23px */
  margin-top: 23px;
  padding: 9px 10px !important;
}
.boxshadow1{
	box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
}
.panel-body{
	border:none;
}
.border{
				border:1px solid #000;
			}
			.cart-container{
				width: 100%;
				box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
				
			}
			.cart-container .cart-header{
				width: 100%;
				padding-top: 10px;
				padding-bottom: 10px;
				border-bottom: 1px solid #6c757d;
			}
			.cart-container .cart-header a{
				text-transform: capitalize;
			}
			.cart-container .cart-body{
				width: 100%;
				height: auto;
				max-height: 400px;
				overflow: auto;
			}
			.cart-container .cart-body .cart-item{
				margin: 15px;
				background-color: #fff;
				box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
				padding: 5px;
			}
			.cart-container .cart-body .cart-item p,.cart-container .cart-footer p{
				padding: 0;
				margin: 0;
			}
			.cart-container .cart-footer{   
				margin-left: 15px;
				margin-right: 15px;
				border-top: 1px solid #6c757d;
			}
#step2 .input-sm{
	padding-top:2px;
	padding-bottom:2px;           
	height:24px;
}
.input-sm{  
   height:24px;  
}
.topbasepadding{  
   padding-top:8px;  
}
.verticalalignment{  
   vertical-align: bottom !important;       
}
.jqxtoursearch{     
   height:12px;  
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
</style>
</head>
<body onload="getBranch();getGroup();getLocationhl();getPayType();">    
  <form autocomplete="off">  
	 <div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div> 
	<nav class="navbar navbar-default navbar-fixed-top travel-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>   
      			<a class="navbar-brand m-t-6" href="#">Cooperate Travel Desk</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav">
        			<li class="p-r-5 topbasepadding">
        				<select class="cmbbranch form-control input-sm" id="cmbbranch" name="cmbbranch" onchange="getLocation();reloadtravel();" value='<s:property value="cmbbranch"/>' style="width:140px;">
  							<option></option>
						</select>
					</li>
        			<li class="p-r-5 topbasepadding">
        				<select class="cmblocation form-control input-sm" id="cmblocation" name="cmblocation" onchange="reloadtravel();" value='<s:property value="cmblocation"/>' style="width:140px;">
  							<option></option>         
						</select>
					</li>
					<li class="p-r-5 topbasepadding">
        				<div class="form-inline"><div id="todate" style="display:inline-block;" ></div></div>
					</li>  
					<li class="active"><a data-toggle="pill" href="#tabdashboard"><i class="fa fa-home p-r-5" data-toggle="tooltip" title="Dashboard" data-placement="bottom"></i></a></li>
					<li><a href="#reload" class="dashboard-link"><i class="fa fa-refresh p-r-5" data-toggle="tooltip" title="Reload" data-placement="bottom"></i></a></li>
					<li><a href="#excel" class="dashboard-link"><i class="fa fa-file-excel-o p-r-5" data-toggle="tooltip" title="Excel" data-placement="bottom"></i></a></li>
	    			<li><a data-toggle="pill" href="#modalservicerequest"><i class="fa fa-cog p-r-5" data-toggle="tooltip" title="Service Request" data-placement="bottom"></i></a></li>
				  <%--  <li><a data-toggle="pill" href="#modalvisa"><i class="fa fa-cc-visa p-r-5" data-toggle="tooltip" title="VISA" data-placement="bottom"></i></a></li>
				    <li><a data-toggle="pill" href="#modalticket"><i class="fa fa-ticket p-r-5" data-toggle="tooltip" title="Ticket" data-placement="bottom"></i></a></li>
				    <li><a data-toggle="pill" href="#modalhotel" class="dashboard-link"><i class="fa fa-bed p-r-5" data-toggle="tooltip" title="Hotel" data-placement="bottom"></i></a></li>
				    <li><a data-toggle="pill" href="#modaltransfer"><i class="fa fa-exchange p-r-5" data-toggle="tooltip" title="Transfer" data-placement="bottom"></i></a></li>
				   --%> <li><a data-toggle="pill" href="#modaltour" class="dashboard-link"><i class="fa fa-arrow-circle-right p-r-5" data-toggle="tooltip" title="Tour" data-placement="bottom"></i></a></li>
				  <%--    <li><a data-toggle="pill" href=""><i class="fa fa-microchip p-r-5" data-toggle="tooltip" title="Mice" data-placement="bottom"></i></a></li>
				     --%> <li><a data-toggle="pill" href="#modaltaskcreation"><i class="fa fa-plus-square p-r-5" data-toggle="tooltip" title="Task Creation" data-placement="bottom"></i></a></li>
				    <li><a data-toggle="pill" href="#modalpendingtask" class="dashboard-link"><i class="fa fa-newspaper-o p-r-5" data-toggle="tooltip" title="Pending Task" data-placement="bottom"></i></a></li>
					
					<li><a data-toggle="pill" href="#" class="dashboard-link"  onclick="funtoursopen();" >
					<i class="fa fa-text-width" aria-hidden="true"></i> </a></ </li>
     			</ul>
    		</div>
  		</div>
	</nav>  
	<div class="container-fluid m-t-60">
		<div class="tab-content">
			<div id="tabdashboard" class="tab-pane fade in active">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div id="traveldiv"><jsp:include page="travelGrid.jsp"></jsp:include></div>
					</div>	
				</div>
			</div>
			
			<!-- Service Request Content Starts here -->
			
			<div id="modalservicerequest" class="tab-pane fade">
				<div class="container">
					<div class="panel panel-default textclient">
						<div class="panel-body">
							<p class="m-b-0"></p>
						</div>
					</div>
					<div class="newclientinfo">
						<div class="row m-t-10">
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">        
		        				<div class="form-inline">Date<div id="edate"  class="m-l-10" ></div></div>
		        			</div>  
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		        				<label class="radio-inline" for="rsumm"><input type="radio" id="rsumm" name="stkled" onchange="funcheck();" value="rsumm" class="optsrvcreqclienttype">Existing Client</label>
		        				<label class="radio-inline" for="rdet"><input type="radio" id="rdet" name="stkled" onchange="funcheck();" value="rdet"  class="optsrvcreqclienttype">New Client</label>
		        			</div>
		        		</div>
		        		<div class="row m-t-10">
		        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
								<div class="divexistingclient">
									<div id="client" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearch.jsp"></jsp:include></div>
			 						<input type="hidden" name="hidclient" id="hidclient">
								</div>
								<div class="divnewclient">
									<input type="text" id="txtclient" name="txtclient"  placeholder="Enter Client" class="form-control input-sm"/>
								</div>
			 				</div>
			 				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
			 					<input type="text" id="txtmob" name="txtmob"  onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
			 				</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
							</div>
		        		</div>
					</div>
					
	        		<div class="row m-t-10">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	        				<div id="micediv"><jsp:include page="serviceRequestGrid.jsp"></jsp:include></div>
	        			</div>
	        		</div>
	        		<div class="row m-t-10">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
	        				<div class="button-group">
	        					<!-- <button type="button" class="buttonX btn btn-default" id="btncreatexsr" onclick="funCreateXOsr();" data-toggle="tooltip" title="CREATE XO" data-placement="top"><i class="fa fa-pencil-square-o"  aria-hidden="true" ></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnconfirmxsr"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square"  aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnvouchersr" onclick="" data-toggle="tooltip" title="VOUCHER PRINT" data-placement="top"><i class="fa fa-print"  aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default"id="btncreceiptsr" data-toggle="modal" data-target="#modalcommreceipt" ><i class="fa fa-file-text-o"  aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btninvoicesr" onclick="" data-toggle="tooltip" title="INVOICE" data-placement="top"><i class="fa fa-info"  aria-hidden="true" ></i></button>&nbsp;&nbsp;&nbsp;&nbsp;</td> -->  
	            	    		<button type="button" class="buttonXX btn btn-default"  id="btnupdatesr"  onclick="saveValidateSR();"><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>
	        				</div>
	        			</div>
	        		</div>	
				</div>
			</div>
			<!-- Service Request content Ends Here -->
			
			<!-- Visa content Starts Here -->
			<div id="modalvisa" class="tab-pane fade">
				<div class="container">
					<div class="panel panel-default textclient">
						<div class="panel-body">
							<p class="m-b-0"></p>
						</div>
					</div>
					<div class="newclientinfo">
						<div class="row m-t-5">
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">
		        				<div class="form-inline">Date<div id="vadate" style="display:inline-block;" class="m-l-10"></div></div>
		        			</div>
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		        				<label class="radio-inline" for="varsumm"><input type="radio" id="varsumm" name="stkledva" onchange="funcheckvisa();" value="varsumm" class="optvisaclienttype">Existing Client</label>
		        				<label class="radio-inline" for="vardet"><input type="radio" id="vardet" name="stkledva" onchange="funcheckvisa();" value="vardet"  class="optvisaclienttype">New Client</label>
		        			</div>
		        		</div>
		        		<div class="row m-t-5">
		        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<div class="divvisaexistingclient">
									<div id="clientva" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearchVisa.jsp"></jsp:include></div>
			 						<input type="hidden" name="hidclientva" id="hidclientva">
								</div>
								<div class="divvisanewclient">
									<input type="text" id="txtclientva" name="txtclientva"  placeholder="Enter Client" class="form-control input-sm"/>
								</div>
			 				</div>
			 				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
			 					<input type="text" id="txtmobva" name="txtmobva"  onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
			 				</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<input type="text" id="txtemailva" name="txtemailva" placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
							</div>
		        		</div>
					</div>
					
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="vname">Given Name</label>
	        					<input type="text" id="vname" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="vsurname">Surname</label>
	        					<input type="text" id="vsurname" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="jqxVisa">Visa Type</label>
	        					<div id="vtype"><jsp:include page="visa.jsp"></jsp:include></div>
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="vvalidity">Visa Validity</label>
	        					<input type="text" id="vvalidity" class="form-control input-sm">
	        					<input type="hidden" name="vdocno" id="vdocno">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label>Nationality</label>
	        					<div id="nation"><jsp:include page="nation.jsp"></jsp:include></div>
	        					<input type="hidden" name="nationid" id="nationid">
	        				</div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="vpassno">Passport No</label>
	        					<input type="text" id="vpassno" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="vissuedfrom">Issued From</label>
	        					<input type="text" id="vissuedfrom" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="vvalidup">Valid Upto</label>
	        					<div id="vvalidup"></div>
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
	        				<div class="form-group">
	        					<label for="vremarks">Remarks</label>
	        					<input type="text" id="vremarks" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
	        				<div class="form-group">
	        					<label for="btnadd">Add</label><br>
	        					<button type="button" class="buttonX btn btn-default" id="btnadd" onclick="funvisagrid();"  data-toggle="tooltip" title="ADD" data-placement="bottom"><i class="fa fa-plus" aria-hidden="true"></i></button>
	        				</div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	        				<div id="visadiv"><jsp:include page="visaGrid.jsp"></jsp:include></div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
	        				<div class="button-group">
	        					<button type="button" class="buttonX btn btn-default" id="btncreatexva" onclick="funCreateXOva();"  data-toggle="tooltip" title="CREATE XO" data-placement="top"><i class="fa fa-pencil-square-o"  aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnconfirmxva"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square"  aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnvoucherva" onclick=""  data-toggle="tooltip" title="VOUCHER PRINT" data-placement="top"><i class="fa fa-print"  aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btncreceiptva" data-toggle="modal" data-target="#modalcommreceipt" ><i class="fa fa-file-text-o"  aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btninvoiceva" onclick=""  data-toggle="tooltip" title="INVOICE" data-placement="top"><i class="fa fa-info"  aria-hidden="true"></i></button>
		            			<button type="button" name="btnupdateva" id="btnupdateva" onclick="saveValidateVA();" class="buttonXX btn btn-default" ><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>
	        				</div>
	        			</div>
					</div>
				</div>
			</div>
			<!-- Visa Contents Ends Here -->
			
			<!-- Ticket Contents Starts Here -->
			<div id="modalticket" class="tab-pane fade">
				<div class="container">
					<div class="panel panel-default textclient">
						<div class="panel-body">
							<p class="m-b-0"></p>
						</div>
					</div>
					<div class="newclientinfo">
						<div class="row m-t-5">
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">
		        				<div class="form-inline">Date<div id="ttdate" style="display:inline-block;" class="m-l-10"></div></div>
		        			</div>
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		        				<label class="radio-inline" for="ttrsumm"><input type="radio" id="ttrsumm" name="stkledtt" onchange="funcheckticket();" value="ttrsumm" class="optticketclienttype">Existing Client</label>
		        				<label class="radio-inline" for="ttrdet"><input type="radio" id="ttrdet" name="stkledtt" onchange="funcheckticket();" value="ttrdet" class="optticketclienttype">New Client</label>
		        			</div>
		        		</div>
		        		<div class="row m-t-10">
		        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<div class="divticketexistingclient">
									<div id="clienttt" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearchTicket.jsp"></jsp:include></div>
		                     		<input type="hidden" name="hidclienttt" id="hidclienttt">
								</div>
								<div class="divticketnewclient">
									<input type="text" id="txtclienttt" name="txtclienttt"  placeholder="Enter Client" class="form-control input-sm"/>
								</div>
			 				</div>
			 				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
			 					<input type="text" id="txtmobtt" name="txtmobtt"  onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
			 				</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<input type="text" id="txtemailtt" name="txtemailtt" placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
							</div>
		        		</div>
					</div>
					
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="tgivenname">Given Name</label>
	        					<input type="text" id="tgivenname" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="tsurname">Surname</label>
	        					<input type="text" id="tsurname" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="tpassno">Passport No</label>
	        					<input type="text" id="tpassno" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="tissuedfrom">Issued From</label>
	        					<input type="text" id="tissuedfrom" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="validupdate">Valid Upto</label>
	        					<div id="validupdate" ></div>
	        				</div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="ticfdest">From Dest.</label>
	        					<input type="text" id="ticfdest" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="tictdest">To Dest.</label>
	        					<input type="text" id="tictdest" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="ticketdate">Date</label>
	        					<div id="ticketdate"></div>
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">
	        					<label for="ptype">Passenger Type</label>
	        					<select id="ptype" class="form-control input-sm">
									<option value="CHILD">CHILD</option>
									<option value="ADULT">ADULT</option>
									<option value="INFANT">INFANT</option>
								</select>
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="tiremarks">Remarks</label>
	        					<input type="text" id="tiremarks" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
	        				<div class="form-group">
	        					<label for="btnadd">Add</label><br>
	        					<button type="button" class="buttonX btn btn-default" id="btnadd" onclick="funticketgrid();"  data-toggle="tooltip" title="ADD" data-placement="bottom"><i class="fa fa-plus" aria-hidden="true"></i></button>
	        				</div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	        				<div id="ticketdiv"><jsp:include page="ticketGrid.jsp"></jsp:include></div>
	        			</div>
	        		</div>
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
	        				<div class="button-group">
	        					<button type="button" class="buttonX btn btn-default" id="btncreatextt" onclick="funCreateXOtt();" data-toggle="tooltip" title="CREATE XO" data-placement="top" ><i class="fa fa-pencil-square-o"  aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnconfirmxtt"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square"  aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnvouchertt" onclick="" data-toggle="tooltip" title="VOUCHER PRINT" data-placement="top"><i class="fa fa-print"  aria-hidden="true" ></i></button>
								<button type="button" class="buttonX btn btn-default"id="btncreceipttt" data-toggle="modal" data-target="#modalcommreceipt" ><i class="fa fa-file-text-o"  aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btninvoicett" onclick=""  data-toggle="tooltip" title="INVOICE" data-placement="top"><i class="fa fa-info"  aria-hidden="true"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		            			<button type="button" name="btnupdatett" id="btnupdatett" onclick="saveValidateTT();" class="buttonXX btn btn-default" ><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>   
	        				</div>
	        			</div>
	        		</div>
				</div>
			</div>
			<!-- Ticket Content Ends Here -->
			
			<!-- Hotel Content Starts Here -->
			<div id="modalhotel" class="tab-pane fade">
				<div class="container">
					<div class="panel panel-default textclient">  
						<div class="panel-body">
							<p class="m-b-0"></p>
						</div>
					</div>
					<div class="newclientinfo">  
						<div class="row m-t-5">
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">
		        				<div class="form-inline">Date<div id="hldate" style="display:inline-block;" class="m-l-10"></div></div>
		        			</div>
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		        				<label class="radio-inline" for="hlrsumm"><input type="radio" id="hlrsumm" name="stkledhl" onchange="funcheckhotel();" value="hlrsumm" class="opthotelclienttype">Existing Client</label>
		        				<label class="radio-inline" for="hlrdet"><input type="radio" id="hlrdet" name="stkledhl" onchange="funcheckhotel();" value="hlrdet" class="opthotelclienttype">New Client</label>
		        			</div>
		        		</div>
		        		<div class="row m-t-10"> 
		        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<div class="divhotelexistingclient">
									<div id="clienthl" onkeydown="return (event.keyCode!=13);">
										<jsp:include page="clientSearchHotel.jsp"></jsp:include>
									</div>
		                     		<input type="hidden" name="hidclienthl" id="hidclienthl">
								</div>
								<div class="divhotelnewclient">
									<input type="text" id="txtclienthl" name="txtclienthl"  placeholder="Enter Client" class="form-control input-sm"/>
								</div>
			 				</div>
			 				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
			 					<input type="text" id="txtmobhl" name="txtmobhl"  onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
			 				</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<input type="text" id="txtemailhl" name="txtemailhl" placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
							</div>
		        		</div>
					</div>
					
	        		<div class="row m-t-5">   
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">  
	        					<label for="location">Location</label>     
	        					<select id="cmblocationhl" name="cmblocationhl"  value='<s:property value="cmblocationhl"/>' class="form-control input-sm" style="height:26px;"></select>
	        					 <input type="hidden" id="hidcmblocationhl" name="hidcmblocationhl" value='<s:property value="hidcmblocationhl"/>'/>
	        				</div>    
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
	        				<div class="form-group">
	        					<label for="hfdest">Check In</label>
	        					<div id="fromdatehl" ></div>
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group" >  
	        					<label for="htdest">Check Out</label>  
	        					<div id="todatehl" ></div>    
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">   
	        					<label for="area">Area</label>     
	        					<div id="txtloc" onkeydown="return (event.keyCode!=13);"><jsp:include page="locationSearch.jsp" ></jsp:include></div>
	        					<input type="hidden" name="locidhl" id="locidhl">                            
	        				</div>    
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">   
	        					<label for="nationality">Nationality</label>        
	        					<div id="txtnation" onkeydown="return (event.keyCode!=13);"><jsp:include page="nationSearch.jsp"></jsp:include></div>
	        					<input type="hidden" name="nationidhl" id="nationidhl">                               
	        				</div>    
	        			</div>
	        		</div>    
	        		<div class="row m-t-5">  
	        		    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">   
	        					<label for="nationality">Hotel</label>        
	        					<div id="txthotel" onkeydown="return (event.keyCode!=13);"><jsp:include page="hotelSearch.jsp"></jsp:include></div>
	        					<input type="hidden" name="hotelidhl" id="hotelidhl">                            
	        				</div>    
	        			</div>
	        		    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="adult">Adult</label>          
	        					 <input type="text" id="adulthl" name="adulthl" onkeypress="return isNumberKey(event)" class="form-control input-sm"  placeholder="Adult"/>                              
	        				</div>    
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child">Child</label>                     
	        					<input type="text" id="childhl" name="childhl" onkeypress="return isNumberKey(event)" onchange="funchildcheck();" class="form-control input-sm" placeholder="Child"/>                            
	        				</div>    
	        			</div> 
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child" id="age1">Child1</label>                       
	        					<input type="text" id="txtage1" name="txtage1" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                                   
	        				</div>    
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child" id="age2">Child2</label>                     
	        					<input type="text" id="txtage2" name="txtage2" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                            
	        				</div>    
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child" id="age3">Child3</label>                     
	        					 <input type="text" id="txtage3" name="txtage3" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                           
	        				</div>    
	        			</div>      
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child" id="age4">Child4</label>                     
	        					<input type="text" id="txtage4" name="txtage4" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                           
	        				</div>    
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
	        				<div class="form-group">   
	        					<label for="child" id="age5">Child5</label>                     
	        					 <input type="text" id="txtage5" name="txtage5" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                            
	        				</div>    
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">    
	        				<div class="form-group">   
	        					<label for="child" id="age6">Child6</label>                        
	        					<input type="text" id="txtage6" name="txtage6" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Age"/>                         
	        				</div>    
	        			</div>   
	        		</div>
	        	<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">            
	        				<div class="form-group">   
	        					<label for="Room">Room Type</label>                           
	        					<div id="txtrtypehl" onkeydown="return (event.keyCode!=13);"><jsp:include page="roomTypeSearchhl.jsp"></jsp:include></div>                         
	        				    <input type="hidden" name="roomtypeidhl" id="roomtypeidhl">         
	        				</div>    
	        			</div> 
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">               
	        				<div class="form-group">           
	        					<label for="Room">Room</label>                                        
	        					<div id="txtroomhl" onkeydown="return (event.keyCode!=13);"><jsp:include page="roomSearchhl.jsp"></jsp:include></div>                         
	        				    <input type="hidden" name="roomidhl" id="roomidhl">                          
	        				</div>    
	        			</div> 
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
	        				<div class="form-group" style="padding-left:50px;">        
	        					<label for="meal">Extra Bed</label>               
	        					<select id="cmbextrabed" name="cmbextrabed"  value='<s:property value="cmbextrabed"/>' class="form-control input-sm" style="height:26px;width:100px;">
	        					<option value="0">0</option>
	        					<option value="1">1</option>
	        					<option value="2">2</option>
	        					<option value="3">3</option>
	        					<option value="4">4</option></select>                               
	        					<input type="hidden" id="hidcmbextrabed" name="hidcmbextrabed" value='<s:property value="hidcmbextrabed"/>'/>      
	        				</div>        
	        			</div> 
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
	        				<div class="form-group">      
	        					<label for="meal">Meal Plan</label>                 
	        					<select id="cmbmealplan" name="cmbmealplan"  value='<s:property value="cmbmealplan"/>' class="form-control input-sm" style="height:26px;width:100px">
	        					<option value="BB">BB</option>
	        					<option value="HB">HB</option>
	        					<option value="FB">FB</option>
	        					<option value="INC">INC</option></select>              
	        					<input type="hidden" id="hidcmbmealplan" name="hidcmbmealplan" value='<s:property value="hidcmbmealplan"/>'/>      
	        				</div>        
	        			</div>  
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">        
	        				<div class="form-group">   
	        					<label for="Star">Star</label>                        
	        					<select id="txtrating" name="txtrating" value='<s:property value="txtrating"/>' class="form-control input-sm" style="height:26px;width:100px">
						         <option value="">--Select--</option> <option value="1 Star">1 Star</option> <option value="2 Star">2 Star</option>
						         <option value="3 Star">3 Star</option> <option value="4 Star">4 Star</option> <option value="5 Star">5 Star</option> <option value="7 Star">7 Star</option></select>
						        <input type="hidden" id="txthidrating" name="txthidrating" value='<s:property value="txthidrating"/>'/>                         
	        				</div>       
	        			</div>   
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">        
	        				   <div class="form-group" style="padding-left:50px;">        
	        					  <label for="clear">Clear</label>                            
	        				      <button type="button" class="btn btn-default" name="btnclear" id="btnclear" title="Clear" onclick="funClear();"><i class="fa fa-trash-o" aria-hidden="true"></i></button>                         
	        				  </div>    
	        			  </div>
	        			  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">        
	        				   <div class="form-group">   
	        					  <label for="search">Search</label>                            
	        				     <button type="button"  class="btn btn-default" name="btnsearch" id="btnsearch" title="Search" onclick="funSearch();"><i class="fa fa-search" aria-hidden="true"></i></button>                       
	        				      <input type="hidden" id="hidcalc" name="hidcalc" value='<s:property value="hidcalc"/>'/> 
	        				  </div>    
	        			  </div> 
		        	</div> 
		        	<div class="row m-t-5">
		        	     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">     
		        				<div class="form-group"> 
		        				     <div id="bookingDiv"><jsp:include page="hotelbookingGrid.jsp"></jsp:include></div>   
		        				</div>      
		        			</div>
		        	</div>
		        	<div class="row m-t-5">
		        	      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">        
		        				   <div class="form-group">   
		        					  <label for="calculate">Calculate</label>                            
		        					  <button type="button" name="btncalc" id="btncalc"  onclick="funCalc();" title="Calculate" class="btn btn-default"><i class="fa fa-calculator" aria-hidden="true"></i></button>
		        				       <input type="hidden" id="bdocno" name="bdocno" value='<s:property value="bdocno"/>'/>
                                       <input type="hidden" id="broomid" name="broomid" value='<s:property value="broomid"/>'/>
		        				  </div>      
		        			  </div> 
		        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">        
		        				   <div class="form-group">   
		        					  <label for="calculate">Save</label>                            
		        				      <button class="btn btn-default" type="button" name="btnsave" id="btnsave" onclick="funSaveHotel();" title="Save"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
		        				  </div>      
		        			  </div> 	  
		        	</div>
		        	<div class="row m-t-5">
		        	     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">     
		        				<div class="form-group"> 
		        				     <div id="subDiv"><jsp:include page="subGrid.jsp"></jsp:include></div>   
		        				</div>    
		        			</div>
		        	</div>
	        	
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">        
	        				<div class="button-group">   
	        					<button type="button" class="buttonX btn btn-default" id="btncreatex" onclick="funCreateXO();" data-toggle="tooltip" title="CREATE XO" data-placement="top"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnconfirmx"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square"  aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnvoucher" onclick=""  data-toggle="tooltip" title="VOUCHER PRINT" data-placement="top"><i class="fa fa-print" aria-hidden="true"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btncreceipt" data-toggle="modal" data-target="#modalcommreceipt" ><i class="fa fa-file-text-o"  aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="top"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btninvoice" onclick="" data-toggle="tooltip" title="INVOICE" data-placement="top"><i class="fa fa-info"  aria-hidden="true" ></i></button>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	        				</div>
	        			</div>
	        		</div>
	        	</div>
			</div>
<!-- Hotel Content Ends Here -->  
			
			<!-- Transfer Content starts here -->
			<div id="modaltransfer" class="tab-pane fade">
				<div class="container">
					<div class="panel panel-default textclient">
						<div class="panel-body">
							<p class="m-b-0"></p>
						</div>
					</div>
					<div class="newclientinfo">
						<div class="row m-t-5">
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">
		        				<div class="form-inline">Date<div id="tfdate" style="display:inline-block;" class="m-l-10"></div></div>
		        			</div>
		        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		        				<label class="radio-inline" for="tfrsumm"><input type="radio" id="tfrsumm" name="stkledtf" onchange="funchecktransfer();" value="tfrsumm" class="opttransferclienttype">Existing Client</label>
		        				<label class="radio-inline" for="tfrdet"><input type="radio" id="tfrdet" name="stkledtf" onchange="funchecktransfer();" value="tfrdet" class="opttransferclienttype">New Client</label>
		        			</div>
		        		</div>
		        		<div class="row m-t-10">
		        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<div class="divtransferexistingclient">
									<div id="clienttf" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearchTransfer.jsp"></jsp:include></div>
		                     		<input type="hidden" name="hidclienttf" id="hidclienttf">
								</div>
								<div class="divtransfernewclient">
									<input type="text" id="txtclienttf" name="txtclienttf"  placeholder="Enter Client" class="form-control input-sm"/>
								</div>
			 				</div>
			 				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
			 					<input type="text" id="txtmobtf" name="txtmobtf"  onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
			 				</div>
							<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								<input type="text" id="txtemailtf" name="txtemailtf" placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
							</div>
		        		</div>
					</div>
					
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="trname">Guest Name</label>
	        					<input type="text" id="trname" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="fromdest">From Dest.</label>
	        					<input type="text" id="fromdest" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="todest">To Dest.</label>
	        					<input type="text" id="todest" class="form-control input-sm">
	        				</div>
	        			</div>
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
	        				<div class="form-group">
	        					<label for="vehicle">Vehicle</label>
	        					<input type="text" id="vehicle"  class="form-control input-sm">
	        				</div>
	        			</div>
	        		</div>
					<div class="row m-t-5">
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							<div class="form-group">
								<label for="transferdate">Date</label>
								<div id="transferdate"></div>
							</div>
						</div>  
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							<div class="form-group">
								<label class="transfertime">Time</label>
								<div id="transfertime"></div>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
							<div class="form-group">
								<label for="noofpax">No of Pax</label>
								<input type="number" id="noofpax" min="0" class="form-control input-sm">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">
							<div class="form-group">
								<label for="trremarks">Remarks</label>
								<input type="text" id="trremarks" class="form-control input-sm">
							</div>
						</div>
						<div class="col-xs-12 col-sm-4 col-md-4 col-lg-1 text-center">
	        				<div class="form-group">
	        					<label for="btnadd">Add</label><br>
	        					<button type="button" class="buttonX btn btn-default" id="btnadd" onclick="setTransferGrid();"><i class="fa fa-plus" aria-hidden="true" data-toggle="tooltip" title="ADD" data-placement="bottom"></i></button>
	        				</div>
	        			</div>
					</div>
					<div class="row m-t-5">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="transferdiv"><jsp:include page="transferGrid.jsp"></jsp:include></div>
						</div>
					</div>
					<div class="row m-t-5">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
							<div class="button-group">
								<button type="button" class="buttonX btn btn-default" id="btncreatextf" onclick="funCreateXOtf();"><i class="fa fa-pencil-square-o" aria-hidden="true" data-toggle="tooltip" title="CREATE XO" data-placement="bottom"></i></button>
          						<button type="button" class="buttonX btn btn-default" id="btnconfirmxtf"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square"  aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="bottom"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btnvouchertf" onclick=""><i class="fa fa-print"  aria-hidden="true" data-toggle="tooltip" title="VOUCHER PRINT" data-placement="bottom"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btncreceipttf" data-toggle="modal" data-target="#modalcommreceipt" ><i class="fa fa-file-text-o" aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="bottom"></i></button>
								<button type="button" class="buttonX btn btn-default" id="btninvoicetf" onclick=""><i class="fa fa-info" aria-hidden="true" data-toggle="tooltip" title="INVOICE" data-placement="bottom"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    			<button type="button" name="btnupdatetf" id="btnupdatetf" onclick="saveValidateTF();" class="buttonXX btn btn-default" ><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Transfer Content ends here -->
			
			<!-- Task Creation Starts Here -->
			<div id="modaltaskcreation" class="tab-pane fade">
				<div class="container">
					<div class="form-horizontal">
						<div class="form-group">
      						<label class="control-label col-sm-2" for="reftype">Reference Type</label>
						    <div class="col-sm-10">
						    	<select id="reftype" class="form-control input-sm">
									<option value="Enquiry">Enquiry</option>
									<option value="Quotation">Quotation</option>
									<option value="Others">Others</option>
								</select>
						    </div>
    					</div>
					    <div class="form-group">
					    	<label class="control-label col-sm-2" for="refno">Reference No</label>
					      	<div class="col-sm-10">          
					        	<input type="number" placeholder="Ref.No" id="refno" class="form-control input-sm">
					      	</div>
					    </div>
					    <div class="form-group">
					    	<label class="control-label col-sm-2" for="pwd">Start Date & Time</label>
					      	<div class="col-sm-2">          
					        	<div id="date"></div>
					      	</div>
					      	<div class="col-sm-4">
					      		<div id="vtime"></div>
					      	</div>
					    </div>
					    <!-- <div class="form-group">
					    	<label class="control-label col-sm-2" for="pwd">Start Time</label>
					      	<div class="col-sm-10">          
					        	<div id="vtime"></div>
					      	</div>
					    </div> -->
					    <div class="form-group">
					    	<label class="control-label col-sm-2" for="pwd">Assigned User</label>
					      	<div class="col-sm-10">          
					        	<div id="partss" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch2.jsp"></jsp:include></div>
                     			<input type="hidden" name="hiduser" id="hiduser">
					      	</div>
					    </div>
					    <div class="form-group">
					    	<label class="control-label col-sm-2" for="pwd">Description</label>
					      	<div class="col-sm-10">          
					        	<textarea class="textarea-simple-1 form-control" rows="4" placeholder="Description" id="desc"></textarea>
					      	</div>
					    </div>
					    <div class="form-group">        
					    	<div class="col-sm-offset-2 col-sm-10 text-right">
					        	<button type="button" class="buttonXX btn btn-default"  onclick="funSave();" ><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>
					      	</div>
					    </div>
					</div>
				</div>
			</div>
			<!-- Task Creation Content Ends Here -->
			
			<div id="modalpendingtask" class="tab-pane fade">
				<div class="container-fluid">
					<div class="row">                                                                         
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="pnddiv"><jsp:include page="pendingtaskGrid.jsp"></jsp:include></div>
						</div>
					</div>
					<div class="row m-t-5">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="flwupdiv"><jsp:include page="taskfollowupGrid.jsp"></jsp:include></div>
						</div>
					</div>
					<div class="row m-t-5">
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
							<div class="form-group">
								<label>Select Status</label>
								<select id="assgntask" class="form-control">
									<option value="">--Select--</option>
								</select>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
							<div class="form-group">
								<label>Assign To</label>
								<div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>
								<input type="hidden" name="hiduser2" id="hiduser2">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-5">
							<div class="form-group">
								<label>Remarks</label>
								<input type="text" class="form-control input-sm" id="remarks"/>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
							<div class="form-group">
								<label>&nbsp;</label><br>
							<button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="buttonXX btn btn-default" ><i class="fa fa-floppy-o"  aria-hidden="true" data-toggle="tooltip" title="SAVE" data-placement="top"></i></button>	
							</div>
						</div>
					</div>
				</div>
			</div>			
			
			<!-- Tour Content Starts Here -->
			<div id="modaltour" class="tab-pane fade" >
				<div class="container">
					<div class="row">
						<section>
        					<div class="wizard">
            					<div class="wizard-inner">
                					<div class="connecting-line"></div>
               						<ul class="nav nav-tabs" role="tablist">
					                    <li role="presentation" class="active">
                       						<a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" title="Step 1">
                           						<span class="round-tab">
                               						<i class="fa fa-user"></i>
                           						</span>
                       						</a>
                   						</li>
                   						<li role="presentation" class="disabled">   
                       						<a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" title="Step 2" onclick="funreloadtourgrid();">
                           						<span class="round-tab">
                               						<i class="fa fa-map-o"></i>
                           						</span>
                       						</a>
                   						</li>
                   						<li role="presentation" class="disabled">
                       						<a href="#step3" data-toggle="tab" aria-controls="step3" role="tab" title="Step 3">
                           						<span class="round-tab">
                               						<i class="fa fa-comments"></i>
                           						</span>
                       						</a>
                   						</li>
                   						<li role="presentation" class="disabled">
                       						<a href="#step4" data-toggle="tab" aria-controls="complete" role="tab" title="Complete">
                           						<span class="round-tab">
                               						<i class="fa fa-check"></i>
                           						</span>
                       						</a>
                   						</li>
               						</ul>
            					</div>
                					<div class="tab-content">
                    					<div class="tab-pane active" role="tabpanel" id="step1">   
                    						<div class="panel panel-default textclient m-t-5">
												<div class="panel-body">
													<p class="m-b-0"></p>
												</div>
											</div>
											<div class="newclientinfo">
												<div class="row m-t-10">
								        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2">    
								        				<div class="form-inline">Date<div id="trdate" style="display:inline-block;" class="m-l-10 verticalalignment"></div></div>  
								        			</div>
								        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
								        				 <label class="radio-inline" for="trrdet"><input type="radio" style="display:none" id="trrdet" name="stkledtr" onchange="funchecktour();" value="trrdet" class="optclienttype"></label><!-- Walk In Client -->
								        				<label class="radio-inline" for="trrsumm"><input type="radio" id="trrsumm" name="stkledtr" onchange="funchecktour();" value="trrsumm" class="optclienttype">Corporate Client</label>
								        			</div>
								        		 <div id="agenthide">
									        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-1">            
									        				<div class="input-group">  
									        					<div class="checkbox" style="margin:0px;"><label><input type="checkbox" id="txtagentchk"  name="txtagentchk" onclick="$(this).attr('value', this.checked ? 1 : 0);" onchange="funagentchange();">Agent</label></div>
		  													</div>
								        			   </div>  
								        			   <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">    
									       					<div class="agentclient"> 
									       						<div id="agentclienttr" onkeydown="return (event.keyCode!=13);"><jsp:include page="agentclientSearchTour.jsp"></jsp:include></div>  
									       					</div>
									        			</div>   
								        		  </div>
								        		</div>
								        		
								        		<div class="row m-t-10">
								       				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								       					<div class="divcorporateclient"> 
								       						<div id="clienttr" onkeydown="return (event.keyCode!=13);"><jsp:include page="clientSearchTour.jsp"></jsp:include></div>  
								        					<input type="hidden" name="hidclienttr" id="hidclienttr">
								       					</div>
								       					<div class="divwalkinclient">
								       						<input type="text" id="txtclienttr" name="txtclienttr"  placeholder="Enter Client" class="form-control input-sm" style="width:291px;"/>
								       					</div>
								        			</div> 
								        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								        				<input type="text" id="txtmobtr" name="txtmobtr" onblur="mobileValid(this.value);" placeholder="mobile number with country code" class="form-control input-sm"/>
								        			</div>
								       				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								       					<input type="text" id="txtemailtr" name="txtemailtr"  placeholder="someone@example.com" onblur="validateEmail(this.value);" class="form-control input-sm"/>
								       				</div>
								       				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								       					<div id="nation"><jsp:include page="nationtr.jsp"></jsp:include></div>
								       					<input type="hidden" name="nationidtr" id="nationidtr">
								       				</div>
								       			</div>
								       			<div class="row m-t-10" id="salesmanhide">
								       				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								       					<div id="salesman" onkeydown="return (event.keyCode!=13);"><jsp:include page="salesmantr.jsp"></jsp:include></div>
								       					<input type="hidden" name="salesmanidtr" id="salesmanidtr">          
								       				</div>
								       				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								       				     <div id="guesthide">       
								       					     <input type="text" name="guesttr" id="guesttr" placeholder="Enter Guest" class="form-control input-sm">             
								       				     </div>
								       				</div>   
								       			</div>
											</div>
					                        
					                        <ul class="list-inline pull-right m-t-20">    
					                            <li><button type="button" class="btn btn-primary next-step" onclick="funtrnext2allowance();">Next</button></li>
					                        </ul>  
                    					</div>
					                    <div class="tab-pane" role="tabpanel" id="step2">
					                        <div class="row m-t-10">
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
								        			<div class="form-group">
								        				<label for="tourtype">Tour Type</label> 
								        				<div id="tourtype" onkeydown="funload();" onclick="funload();"><jsp:include page="tourtype.jsp"></jsp:include></div>
								        				<input type="hidden" name="ttypeid" id="ttypeid" >	  
								        				<input type="hidden" name="transporttr" id="transporttr" >	  
								        			</div> 
								        		</div>
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
								        			<div class="form-group">
								        				<label>Date and Time</label>
														<div class="row">
															<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
																<div id="tourdate" onchange="funload();" style="display:inline-block;"></div>	
															</div>
															<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
																<div id="tourtime" style="display:inline-block !important;"></div>	
															</div>
									        			</div>
									        		</div>
								        		</div>
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
								        			<div class="form-group">
								        				<label>Vendor</label>
								        					<div id="vendor" ><jsp:include page="vendorsearch.jsp"></jsp:include></div>	
								        			</div>
							        				<input type="hidden" name="vndid" id="vndid" >
										  	   		<input type="hidden" name="tourdocno" id="tourdocno" >    
	                                                <input type="hidden" name="adultval" id="adultval" >        
										  	   		<input type="hidden" name="childval" id="childval" >
										  	   		<input type="hidden" name="admaxdis" id="admaxdis" >           
										  	   		<input type="hidden" name="chmaxdis" id="chmaxdis" >
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        				<div class="row">   
							        					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
							        						<div class="form-group">
							        							<label>Infant</label>
							        							<input type="text" id="infant" min="0" class="form-control input-sm">
							        						</div>
							        					</div>
							        					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
							        						<div class="form-group">
							        							<label>Adult</label>
							        							<input type="text" id="adult" min="0" class="form-control input-sm">
							        						</div>
							        					</div>
							        					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
							        						<div class="form-group">
							        							<label>Child</label>
							        							<input type="text" id="child" min="0" class="form-control input-sm">
							        						</div>
							        					</div>
							        				</div>
							        			</div>
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
								        			<div class="form-group">
								        				<label>Remarks</label>
								        				<input type="text" id="tremarks" class="form-control input-sm">	
								        			</div>
								        		</div>
								        	</div>
								        	<div class="row">
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">      
							        				<div class="form-group">
							        					<label id="cospricechild" class="control-label"></label>  
							        					<input type="text" name="spchild" id="spchild" class="form-control input-sm text-right">
							        				</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
								        			<div class="form-group">           
								        				<label class="control-label" id="cospriceadult"></label>    
								        				<input type="text" id="spadult" name="spadult" class="form-control input-sm text-right">
								        			</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        				<div class="form-group">
							        					<label class="control-label">Discount Type</label><br><br>
							        					<select id="cmbtourdiscounttype" name="cmbtourdiscounttype" class="form-control input-sm">
							        						<option value="">--Select--</option>
							        						<option value="PAY BACK">Payback</option>    
							        					</select>
							        				</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">   
							        				<div class="form-group">
							        					<label>Discount Child</label>
							        					<input type="text" name="tourdiscountchild" id="tourdiscountchild" class="form-control input-sm text-right">
							        				</div>
							        			</div>
							        			
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1"> 
							        				<div class="form-group">   
							        					<label>Discount Adult</label>
							        					<input type="text" name="tourdiscountadult" id="tourdiscountadult" class="form-control input-sm text-right">
							        				</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
							        				<div class="form-group">
							        					<label>Total</label><br><br>
							        					<input type="text" name="tourtotal" id="tourtotal" class="form-control input-sm text-right">
							        				</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        				<div class="form-group">
							        					<label>Transfer</label><br><br>
							        					<select class="form-control input-sm" id="cmbtourtransferchoose" name="cmbtourtransferchoose" onchange="funChooseTourTransfer(value);">
							        						<option value="">--Select--</option>
							        						<option value="1">Yes</option>
							        						<option value="0">No</option>
							        					</select>
							        				</div>
							        			</div>
							        		</div>
							        		<div class="tourtransferdiv">
							        			<div class="row">
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Group</label>
							        						<select class="form-control input-sm" id="cmbtourtransfergroup" name="cmbtourtransfergroup" onchange="getReturnTariffData();getTariffData();">
							        						<option value="">--Select--</option>  
							        					</select>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2"> 
							        					<div class="form-group">
							        						<label>Transfer Type</label>
							        						<select class="form-control input-sm" id="cmbtourtransfertype" name="cmbtourtransfertype" onchange="funNettotal();getReturnTariffData();getTariffData();">
							        							<option value="">--Select--</option>
							        							<option value="private">Private</option>
							        							<option value="sharing">Sharing</option>
							        						</select>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Quantity</label>
							        						<input type="text" name="tourtransferqty" id="tourtransferqty" class="form-control input-sm" onchange="funNettotal();">
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Location Type</label>
							        						<select class="form-control input-sm" id="cmbtourtransferloctype" name="cmbtourtransferloctype">
							        							<option value="H">Hotel</option>   
							        							<option value="F">Flight</option>
							        						</select>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Hotel Name</label>
							        						<input type="text" name="tourtransferlocrefname" id="tourtransferlocrefname" class="form-control input-sm">
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">                           
							        					<div class="form-group">
							        						<label>Room No</label>
							        						<input type="text" name="tourtransferlocrefno" id="tourtransferlocrefno" class="form-control input-sm">
							        					</div>
							        				</div>
							        			</div>
							        			<div class="row">
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Pickup Location</label>
							        						<div id="tourtransferpickuploc"><jsp:include page="pickuplocSearch.jsp"></jsp:include></div>
								        				    <input type="hidden" name="pickuplocid" id="pickuplocid" >	
								        				    <input type="hidden" name="pickuploc" id="pickuploc" >   
                                                  </div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Pickup Time</label>
							        						<div id="tourtransferpickuptime"></div>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Drop Off Location</label>
							        						<div id="tourtransferdropoffloc"><jsp:include page="dropofflocSearch.jsp"></jsp:include></div>
								        				    <input type="hidden" name="dropofflocid" id="dropofflocid" >  
								        				     <input type="hidden" name="dropoffloc" id="dropoffloc" >     	       
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Round trip</label>
							        						<select class="form-control input-sm" name="cmbtourtransferroundtrip" id="cmbtourtransferroundtrip" onchange="funChooseTourTransferRound(value);">
							        							<option value="">--Select--</option>
							        							<option value="1">Yes</option>
							        							<option value="0">No</option>
							        						</select>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">  
							        						<label>Rate</label>
							        						<input type="text" name="tourtransferratetot" id="tourtransferratetot" class="form-control input-sm text-right" onchange="funNettotal();">
							        						<input type="hidden" name="tourtransferrate" id="tourtransferrate" >                  
							        						<input type="hidden" name="tarifdetaildocno" id="tarifdetaildocno" >        
							        						<input type="hidden" name="estdistance" id="estdistance" >               
							        						<input type="hidden" name="esttime" id="esttime" >  
							        						<input type="hidden" name="exdistancerate" id="exdistancerate" >  
							        						<input type="hidden" name="extimerate" id="extimerate" >   
							        						<input type="hidden" name="roundtourtransferrate" id="roundtourtransferrate" >          
							        						<input type="hidden" name="roundtarifdetaildocno" id="roundtarifdetaildocno" >        
							        						<input type="hidden" name="roundestdistance" id="roundestdistance" >   
							        						<input type="hidden" name="roundesttime" id="roundesttime" >  
							        						<input type="hidden" name="roundexdistancerate" id="roundexdistancerate" >  
							        						<input type="hidden" name="roundextimerate" id="roundextimerate" >
							        						<input type="hidden" name="tarifdocno" id="tarifdocno" >
							        						<input type="hidden" name="roundtarifdocno" id="roundtarifdocno" >       
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Total</label>
							        						<input type="text" name="tourtransfertotal" id="tourtransfertotal" class="form-control input-sm text-right" >
							        					</div>
							        				</div>
							        			</div>
							        		</div>
							        		<div class="tourtransferrounddiv">
							        			<div class="row">
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Pickup Location</label>
							        						<div id="tourtransferroundpickuploc"><jsp:include page="roundpickuplocSearch.jsp"></jsp:include></div>
								        				    <input type="hidden" name="roundpickuplocid" id="roundpickuplocid" >
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Pickup Time</label>
							        						<div id="tourtransferroundpickuptime"></div>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-4 col-lg-2">
							        					<div class="form-group">
							        						<label>Drop Off Location</label>
							        						<div id="tourtransferrounddropoffloc"><jsp:include page="rounddropofflocSearch.jsp"></jsp:include></div>
								        				    <input type="hidden" name="rounddropofflocid" id="rounddropofflocid" > 
							        					</div>
							        				</div>
							        				
							        			</div>
							        		</div>
							        		<div class="row m-t-10">
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
							        				<div class="input-group">
							        					<div class="checkbox"><label><input type="checkbox" id="salesagent" name="salesagent" onclick="$(this).attr('value', this.checked ? 1 : 0);" onchange="funsachange();" value="salesagent"> Sales Agent</label></div>
  													</div>
							        			</div>     
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        				<div id="salesagenttr" onkeydown="return (event.keyCode!=13);"><jsp:include page="getsalesagent.jsp"></jsp:include></div>
  													<input type="hidden" name="salesagentdocno" id="salesagentdocno"><input type="hidden" name="salesagentacno" id="salesagentacno">
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-8 text-right">   
							        				<button type="button" class="buttonX btn btn-default" id="btnaddtour" onclick="setTourGrid();" data-toggle="tooltip"  title="ADD"  data-placement="bottom"><i class="fa fa-plus" aria-hidden="true"></i></button>   
							        				<button type="button" class="buttonXX btn btn-default" id="btnsavetour" onclick="saveValidateTR();"  data-toggle="tooltip" title="SAVE" data-placement="bottom"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
							        				 
							        			</div>
							        		</div>  
							        			
								        		<div class="row">
								        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
								        				<div id="tourdiv"><jsp:include page="tourGrid.jsp"></jsp:include></div>
								        			</div>
								        		</div>
						                        <ul class="list-inline pull-right m-t-20">
						                            <li><button type="button" class="btn btn-default prev-step">Previous</button></li>  
						                            <li><button id="trnext2" type="button" class="btn btn-primary next-step" onclick="getTours();">Next</button></li>
						                        </ul>  
					                    	</div>
					                    <div class="tab-pane" role="tabpanel" id="step3">
					                        <div class="row">
							        				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
							        					<div class="form-group">  
							        						<label>Tour</label>  
							        						<select class="form-control" id="cmbchoosetour" onchange="funtoursubload();">   
								        						<option value="">--Select--</option>
								        					</select>
							        					</div>
							        				</div>
							        				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-offset-6 col-lg-3 text-right">  
							        			<div class="form-group">
							        					<br>
							        					<button type="button" class="buttonXX btn btn-default" id="btnsavem" onclick="saveValidateSubTR();"  data-toggle="tooltip" title="SAVE" data-placement="bottom"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
							        				</div>  
							        			</div>
							        			</div>
							        			
							        		<div class="row m-t-10">
							        			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							        				<div id="toursubdiv"><jsp:include page="tourSubGrid.jsp"></jsp:include></div>
							        			</div>
							        		</div>
					                        <ul class="list-inline pull-right m-t-20">
					                            <li><button type="button" class="btn btn-default prev-step">Previous</button></li>    
					                            <li><button type="button" class="btn btn-primary btn-info-full next-step" onclick="funMycartLoad();">Next</button></li>
					                        </ul>
					                    </div>
					                    <div class="tab-pane" role="tabpanel" id="step4">
					                        <div class="row m-t-10">
					                        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					                        		<div class="text-center button-group m-b-10">     
														<button type="button" class="buttonX btn btn-default" id="btncreatextr" onclick="funCreateXOtr();" data-toggle="tooltip" title="CREATE XO" data-placement="top"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>  
														<!-- <button type="button" class="buttonX btn btn-default" id="btnconfirmxtr"  data-toggle="modal" data-target="#modalconfirmx"><i class="fa fa-check-square" aria-hidden="true" data-toggle="tooltip" title="CONFIRM XO" data-placement="top"></i></button> -->
														<button type="button" class="buttonX btn btn-default" id="btnxoprinttr" onclick="funcommrcptprintcheck();"  data-toggle="tooltip" title="XO PRINT" data-placement="top"><i class="fa fa-print" aria-hidden="true"></i></button>
														<button type="button" class="buttonX btn btn-default" id="btncreceipttr" data-toggle="modal" data-target="#modalcommreceipt"><i class="fa fa-file-text-o" aria-hidden="true" data-toggle="tooltip" title="COMMERCIAL RECEIPT" data-placement="top"></i></button>
														<button type="button" class="buttonX btn btn-default" id="btninvoicetr" onclick="funinvoicecheck();" data-toggle="tooltip" title="INVOICE" data-placement="top"><i class="fa fa-info" aria-hidden="true"></i></button> 
													    <button type="button" class="buttonX btn btn-default" id="btnvouchertr" onclick="funvoucherprintcheck();"  data-toggle="tooltip" title="VOUCHER PRINT" data-placement="top"><i class="fa fa-print" aria-hidden="true"></i></button>
													</div>
					                        		<div class="cart-container border img-rounded" style="margin:0 auto;">
														<div class="cart-header text-center">
															<label>My Cart</label>  
														</div>
														<div class="cart-body">   
														  <div class="cart-item img-rounded">
														    <p></p>
														  </div>
														</div>
														<div class="cart-footer">
															 <div class="row" id="nettot">
																<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
																	<p>Net Total</p>
																</div>
																<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
																	<p class="text-right"><strong></strong></p>   
																</div>
															</div>
														</div>
													</div>
					                        	</div>
																	                        
					                        </div>
					                    </div>
                    					<div class="clearfix"></div>
                					</div>
        						</div>
    						</section>
   						</div>
					</div>
				</div> 
			</div>
			<!-- Tour Content Ends Here -->
			
			<!-- Confirmation Modal starts here -->
			<div id="modalconfirmx" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-body">
							<div class="container-fluid">
								<div class="form-horizontal">
									<div class="form-group">
			      						<label class="control-label col-sm-3" for="cndate">Confirm Date</label>
									    <div class="col-sm-9">
									    	<div id="cndate"></div>
									    </div>
			    					</div>
			    					<div class="form-group">
			      						<label class="control-label col-sm-3" for="cntime">Confirm Time</label>
									    <div class="col-sm-9">
									    	<div id="cntime"></div>
									    </div>
			    					</div>
			    					<div class="form-group">
			      						<label class="control-label col-sm-3" for="txtconfno">Confirm No</label>
									    <div class="col-sm-9">
									    	<input type="text" id="txtconfno" name="txtconfno"  placeholder="Confirmation No" class="form-control input-sm"/>
									    </div>
			    					</div>
			    					<div class="form-group">
			      						<label class="control-label col-sm-3" for="txtcnfdesc">Remarks</label>
									    <div class="col-sm-9">
									    	<input type="text" id="txtcnfdesc" name="txtcnfdesc"  placeholder="Remarks" class="form-control input-sm"/>
									    </div>
			    					</div>
			    					<div class="form-group">        
					      				<div class="col-sm-offset-3 col-sm-9 text-right">
					        				<button type="button" name="btnupdate" id="btnupdate" onclick="funConfirmXO();" class="btn btn-default">Save</button>
					      				</div>
					    			</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Confirmation Modal Ends Here -->
			
			<!-- Commercial Reciept Modal Starts here -->
			
			<div id="modalcommreceipt" class="modal fade" role="dialog">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<button type="button" id="close3" class="close m-r-5" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title m-l-10 m-t-5">Commercial Receipt</h4>
						<div class="modal-body">
							<div class="container-fluid">
								<table width="100%">             
										  <tr>
										    <td width="12%" align="left">Pay Type</td>     
										    <td width="25%" align="left"><select id="cmbpaytype" name="cmbpaytype" class="form-control input-sm"  onchange="funchequedate();getAccounts(this.value);"></select>
										      <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype"/></td>
										    <td width="25%"></td> 
										       <td width="25%"></td>
										       <td width="25%"></td>
										    <td width="6%" align="right">Date</td>  
										    <td width="5%" align="right"><div id="crdate" name="crdate" ></div></td>
										   </tr>  
										  <tr class="m-t-5"> 
										    <td width="12%" align="left" class="p-t-5">Account</td>    
										    <td width="25%" align="left" class="p-t-5"><input type="text" id="txtaccid" name="txtaccid" class="form-control input-sm"   tabindex="-1"/></td>
										    <td colspan="5" class="p-t-5"><input type="text" id="txtaccname" name="txtaccname"class="form-control input-sm m-l-5"  tabindex="-1"/>
										    <input type="hidden" id="txtdocno" name="txtdocno" />
										    <input type="hidden" id="txttranno" name="txttranno" /></td>    
										  </tr>
										   <tr class="m-t-5">
										     <td width="12%" align="left" class="p-t-5">Card Type</td>
										     <td width="25%" align="left" class="p-t-5"> <select id="cmbcardtype" name="cmbcardtype" class="form-control input-sm"  onchange="funclearchequecardno();" >
										                          <option value="">--Select--</option></select>
										      <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" /></td>   
										    <td align="right" class="p-t-5 p-l-2">Chq/Card No/Online</td>
										   	<td colspan="2" class="p-t-5"><input type="text" id="txtrefno" name="txtrefno" class="form-control input-sm" onchange="funcardvalidation();"/></td>
										   	    <td align="right" class="p-t-5 p-l-2">Date</td>
										   	<td width="5%" align="right"><div id="jqxReferenceDate" name="jqxReferenceDate" ></div>
										   	<input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" /></td>
										  </tr>
										  <tr class="m-t-5">
										   <td width="12%" align="left" class="p-t-5">Description</td> 
										   <td width="25%" align="left" colspan="6" class="p-t-5"> <input type="text" id="txtdesc" name="txtdesc" class="form-control input-sm"/></td>
										  </tr>   
										  <tr class="m-t-5">
										    <td width="12%" align="left" class="p-t-5">Amount</td>            
										    <td width="25%" align="left" class="p-t-5"><input type="text" id="txtamount" name="txtamount" class="form-control input-sm text-right"/></td>
										    <td colspan="5" align="right" class="p-t-5">     
										      <button type="button" name="btnupdate" id="btnupdate" onclick="funreceiptorjv();" class="btn btn-default" >Save</button> 
										    </td>
										  </tr>     
                                </table>
							</div>
						</div>
					</div> 
				</div>
			</div>
		</div>
<input type="hidden" name="stockadult" id="stockadult">  
<input type="hidden" name="stockchild" id="stockchild">  
<input type="hidden" name="stockid" id="stockid">           
<input type="hidden" name="stocktype" id="stocktype">                        
<input type="hidden" name="agentid" id="agentid">   
<input type="hidden" name="cmode" id="cmode">                        
<input type="hidden" name="tourismconfig" id="tourismconfig">      
<input type="hidden" name="hidamountcr" id="hidamountcr"> 
<input type="hidden" name="privatetr" id="privatetr">       
<input type="hidden" name="hiddisapprconfirm" id="hiddisapprconfirm">     
<input type="hidden" name="disper" id="disper">     
<input type="hidden" name="limodocno" id="limodocno">   
<input type="hidden" name="refnametr" id="refnametr">  
<input type="hidden" name="cldocnotr" id="cldocnotr">  
<input type="hidden" name="jvtrno" id="jvtrno">         
<input type="hidden" name="clientacno" id="clientacno">              
<input type="hidden" name="tourchild" id="tourchild"> 
<input type="hidden" name="touradult" id="touradult">                          
<input type="hidden" name="trpname" id="trpname">  
<input type="hidden" name="tourrow" id="tourrow">  
<input type="hidden" name="cnfcheck" id="cnfcheck">           
<input type="hidden" name="clienttypetf" id="clienttypetf">    
<input type="hidden" name="clienttypehl" id="clienttypehl">
<input type="hidden" name="clienttypett" id="clienttypett">      
<input type="hidden" name="clienttypeva" id="clienttypeva">                       
<input type="hidden" name="clienttype" id="clienttype">   
<input type="hidden" name="clienttypetr" id="clienttypetr"> 
<input type="hidden" name="hidcldocno" id="hidcldocno">         
<input type="hidden" name="hidtype" id="hidtype">
<input type="hidden" name="hidhotel" id="hidhotel">                               
<input type="hidden" name="hidlocation" id="hidlocation">       
<input type="hidden" name="hidvocno" id="hidvocno">                         
<input type="hidden" name="txtrowno" id="txtrowno">
<input type="hidden" name="hidvndno" id="hidvndno">    
<input type="hidden" name="hidnetamt" id="hidnetamt">
<input type="hidden" name="cnttrno" id="cnttrno">
<input type="hidden" name="hidcomments" id="hidcomments">
<input type="hidden" name="txtrefname" id="txtrefname">      
<input type="hidden" name="txtoldstatus" id="txtoldstatus">  
<input type="hidden" name="txttrno" id="txttrno">  
<input type="hidden" name="txtenqdate" id="txtenqdate">   
<input type="hidden" name="txtendno" id="txtendno"> 
<input type="hidden" name="txtrdocno" id="txtrdocno"> 
<input type="hidden" name="txtqotno" id="txtqotno"> 
<input type="hidden" name="txtcrtuser" id="txtcrtuser">                           
<input type="hidden" name="txtasgnuser" id="txtasgnuser">   
<input type="hidden" name="txtpendocno" id="txtpendocno"> 
<input type="hidden" id="vgname" name="vgname" value='<s:property value="vgname"/>' />
<input type="hidden" id="vsname" name="vsname" value='<s:property value="vsname"/>' />
<input type="hidden" id="vipassno" name="vipassno" value='<s:property value="vipassno"/>' />
<input type="hidden" id="vifrom" name="vifrom" value='<s:property value="vifrom"/>' />
<input type="hidden" id="vremk" name="vremk" value='<s:property value="vremk"/>' />
<input type="hidden" id="tigname" name="tigname" value='<s:property value="tigname"/>' />
<input type="hidden" id="tisurname" name="tisurname" value='<s:property value="tisurname"/>' />
<input type="hidden" id="tipassno" name="tipassno" value='<s:property value="tipassno"/>' />
<input type="hidden" id="tiissuedfrom" name="tiissuedfrom" value='<s:property value="tiissuedfrom"/>' />
<input type="hidden" id="tifdest" name="tifdest" value='<s:property value="tifdest"/>' />
<input type="hidden" id="titdest" name="titdest" value='<s:property value="titdest"/>' />
<input type="hidden" id="tiremk" name="tiremk" value='<s:property value="tiremk"/>' />
<input type="hidden" id="hremk" name="hremk" value='<s:property value="hremk"/>' />
<input type="hidden" id="hguest" name="hguest" value='<s:property value="hguest"/>' />
<input type="hidden" id="trguest" name="trguest" value='<s:property value="trguest"/>' />
<input type="hidden" id="trfdest" name="trfdest" value='<s:property value="trfdest"/>' />
<input type="hidden" id="trtdest" name="trtdest" value='<s:property value="trtdest"/>' />
<input type="hidden" id="trveh" name="trveh" value='<s:property value="trveh"/>' />
<input type="hidden" id="trremk" name="trremk" value='<s:property value="trremk"/>' />
<input type="hidden" id="tourremk" name="tourremk" value='<s:property value="tourremk"/>' />
<div id="sertypewindow">
   		<div></div>  
	</div>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>

<script type="text/javascript">
	$(function () {
		$('a.dashboard-link').click(function () {
	    	var url = this.href;
		    if(url.includes("reload")){
		    	$('#cnfcheck').val('');  
	        	$('.textclient p').text('');      
			    $('.textpanel p').text('');
			    $('#cntime').val(new Date());
			    document.getElementById("jvtrno").value="";               
	        	document.getElementById("hidcldocno").value="";      
	            document.getElementById("hidtype").value="";
	            document.getElementById("hidhotel").value="";
	            document.getElementById("hidlocation").value="";         
	            document.getElementById("hidvocno").value="";
	            document.getElementById("txtrdocno").value="";  
	            document.getElementById("txtrefname").value="";
	            document.getElementById("txtendno").value=""; 
	        	var brhid=document.getElementById("cmbbranch").value; 
	        	var locid=document.getElementById("cmblocation").value;
	        	var todate=$('#todate').jqxDateTimeInput('val'); 
	            document.getElementById("salesagentdocno").value="";       
	     	    document.getElementById("salesagentacno").value=""; 
	     		$('#salesagent').attr('disabled', true);  
	     		$('#jqxsalesagent').attr('disabled', true);         
	     		document.getElementById('salesagent').checked=false;
	     		document.getElementById("salesagent").value=0;   
	     		$("#tourSubGrid").jqxGrid('clear');  
	     		$("#tourGrid").jqxGrid('clear'); 
	     		$("#tourGrid").jqxGrid('addrow', null, {});
	     		funcleartourfields();  
	     		$("#agentid").val('');
	     		$("#stocktype").val('');      
	     		$("#hidclienttr").val('');    
	     		$("#txtclienttr").val(''); 
	     		$("#txtmobtr").val(''); 
	     		$("#txtemailtr").val(''); 
	     		$("#nationidtr").val(''); 
	     		$("#jqxNationtr").val(''); 
	     		$("#jqxClienttr").val(''); 
	     		$("#jqxsalesagent").val('');   
	     		$("#cmbchoosetour").val(''); 
	     		$('#txtamount').val('');
	     		$('.cart-body').html(''); 
	     		$('#nettot').html('');
	        	$('.textclient').hide();
                $('.newclientinfo').show();
	        	$("#overlay, #PleaseWait").show();  
	        	//alert(todate);
	        	var jvtrno=document.getElementById("jvtrno").value;  
	   	           if(parseInt(jvtrno)>0){    
	   	        	 $('#btninvoicetr').attr('disabled', true); 
	   	        	 $('#btnaddtour').attr('disabled', true);
	   	           }else{
	   	        	 $('#btninvoicetr').attr('disabled', false); 
	   	        	 $('#btnaddtour').attr('disabled', false);
	   	           }
	            $('#traveldiv').load('travelGrid.jsp?check=1'+'&brhid='+brhid+'&locid='+locid+'&todate='+todate);   
	            $('.wizard .nav-tabs li').addClass('disabled');
	            $('.wizard .nav-tabs li').removeClass('active');
	            $('.wizard .tab-content .tab-pane').removeClass('active');
	            $('.wizard-inner .nav-tabs li:nth-child(1)').addClass('active');
	            $('.wizard-inner .nav-tabs li:nth-child(1)').removeClass('disabled');
	            $('.wizard-inner .nav-tabs li:nth-child(1)').find('a').trigger('click');
	            $('.wizard .tab-content .tab-pane:nth-child(1)').addClass('active');
		    }
		    else if(url.includes("excel")){
		    	 $("#traveldiv").excelexportjs({
					containerid: "traveldiv",
					datatype: 'json',
					dataset: null,
					gridId: "TravelGrid",
					columns: getColumns("TravelGrid") ,
					worksheetName:"Travel Desk"  
				});   
		    }else if(url.includes("modalpendingtask")){  
		    	reload();
		    }
		    else if(url.includes("modaltour")){                                     
		    	funcleartourfields();
		    	if($('#txtrdocno').val()==''){
		    	  setsalesman();
		    	}  
		    	var jvtrno=document.getElementById("jvtrno").value;
	   	           if(parseInt(jvtrno)>0){    
	   	        	 $('#btninvoicetr').attr('disabled', true); 
	   	        	 $('#btnaddtour').attr('disabled', true);
	   	           }else{
	   	        	 $('#btninvoicetr').attr('disabled', false); 
	   	        	 $('#btnaddtour').attr('disabled', false);
	   	           }
	               var distype=$('#tourGrid').jqxGrid('getcellvalue', 0, "distype"); 
	               if(distype="PAY BACK"){
	            	   $('#salesagent').attr('disabled', false); 
	               }else{  
	            	   $('#salesagent').attr('disabled', true);                        
	               }
	               $("#tourSubGrid").jqxGrid('clear');  
		           $('#cnfcheck').val('TOUR');     
		        	 if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){             
		        		 $('#tourhide').show();
		        	}else{
		        		 $('#tourhide').hide();       
		        	} 
		        	funreloadtourgrid();              
		    }else if(url.includes("modalhotel")){  
		    	    $("#jqxpricedet").jqxGrid('clear');
		    	    $('#txtrtypehl').load('roomTypeSearchhl.jsp');      
		        	var rdocno=$('#txtrdocno').val();     
		        	$('#subDiv').load('subGrid.jsp?rdocno='+rdocno+'&check='+1);                
		    }
	  	});
	});  
    $(document).ready(function(){
    	$('.textclient').hide();
        $('.newclientinfo').show(); 
    	$("#cmbbranch").select2({
		    placeholder: "Select a branch",
		    allowClear: true
		});
		$("#cmblocation").select2({
		    placeholder: "Select a location",
		    allowClear: true
		});
		//$('#guesthide').hide();       
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$("#date").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#jqxReferenceDate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#cndate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#crdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#cntime").jqxDateTimeInput({ width: '70%', height: '20px', formatString:'HH:mm', showCalendarButton: false});
    	$("#edate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#trdate").jqxDateTimeInput({ width: '102px', height: '20px',formatString:"dd.MM.yyyy"});
    	$("#tfdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#hldate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
        $("#fromdatehl").jqxDateTimeInput({ width: '100px', height: '20px',formatString:"dd.MM.yyyy"});    	
    	$("#todatehl").jqxDateTimeInput({ width: '100px', height: '20px',formatString:"dd.MM.yyyy"});
    	$("#vadate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#ttdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	$("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
    	$("#todate").jqxDateTimeInput({ width: '102px', height: '25px',formatString:"dd.MM.yyyy"});    	
    	$("#tourdate").jqxDateTimeInput({ width: '100px', height: '20px',formatString:"dd.MM.yyyy"});    	
    	$("#ticketdate").jqxDateTimeInput({ width: '100px', height: '20px',formatString:"dd.MM.yyyy"});    	
    	$("#transferdate").jqxDateTimeInput({ width: '100px', height: '20px',formatString:"dd.MM.yyyy"});
    	$("#transfertime").jqxDateTimeInput({ width: '20%', height: '20px', formatString:'HH:mm', showCalendarButton: false});
    	$("#tourtime").jqxDateTimeInput({ width: '70%', height: '20px', formatString:'HH:mm', showCalendarButton: false});
  	    $("#validupdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
    	$("#vvalidup").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
    	$('#sertypewindow').jqxWindow({ width: '30%', height: '30%',  maxHeight: '30%' ,maxWidth: '30%' , title: 'ServiceType Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#sertypewindow').jqxWindow('close');   
		$('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Send',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#printWindow').jqxWindow('close');
		$("#tourtransferpickuptime,#tourtransferroundpickuptime").jqxDateTimeInput({ width: '60px', height: '20px', formatString:'HH:mm', showCalendarButton: false});
		$('#jqxsalesagent').attr('disabled', true); 
		$('#jqxAgentClienttr').attr('disabled', true);   
		$('#salesagent').attr('disabled', true);    
		$('#txtaccid').attr('readonly', true);    
		$('#txtaccname').attr('readonly', true);     
		document.getElementById("rsumm").checked = true; 
		$('#txtclient').attr('disabled', true);
		document.getElementById('clienttype').value="1"; 
		document.getElementById("trrsumm").checked = true;                       
		//$('#txtclienttr').attr('disabled', true);
		document.getElementById('clienttypetr').value="1";   
		document.getElementById("varsumm").checked = true;                         
		$('#txtclientva').attr('disabled', true);
		document.getElementById('clienttypett').value="1"; 
		document.getElementById("ttrsumm").checked = true;                        
		$('#txtclienttt').attr('disabled', true);
		document.getElementById('clienttypett').value="1"; 
		document.getElementById("tfrsumm").checked = true;                          
		$('#txtclienttf').attr('disabled', true);
		document.getElementById('clienttypetf').value="1"; 
		document.getElementById("hlrsumm").checked = true;                       
		$('#txtclienthl').attr('disabled', true);
		document.getElementById('clienttypehl').value="1";
		$('#agenthide').show();
		funchequedate();
		funload();
		cltrload();
		getTourismConfig();
		$('#txtage1').hide(); $('#txtage2').hide(); $('#txtage3').hide(); $('#txtage4').hide(); $('#txtage5').hide(); $('#txtage6').hide();
		$('#age1').hide(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
		$('#todatehl').on('change', function (event) {  
			   var fromdates=new Date($('#fromdatehl').jqxDateTimeInput('getDate'));
			  // out date
			 	 var todates=new Date($('#todatehl').jqxDateTimeInput('getDate')); //del date
			   if(fromdates>todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');
				   var fromdates=new Date($('#fromdatehl').jqxDateTimeInput('getDate'));
				   $('#todatehl').jqxDateTimeInput('setDate', new Date(fromdates));    
			       return false;
			  }   
		 });
		 $('#fromdatehl').on('change', function (event) {  
			   var curdates=new Date();  
			  // out date
			   var fromdates=new Date($('#fromdatehl').jqxDateTimeInput('getDate')); //del date
			 	 
			   if(fromdates<curdates){
				   $.messager.alert('Message','From Date Less Than Current Date  ','warning');
				   var fromdates=new Date();      
				   $('#fromdatehl').jqxDateTimeInput('setDate', new Date(fromdates));    
			       return false;
			  }   
		 });    
		 $('#tourtime').val(new Date());
		 //$('#tourtransferpickuptime').val(new Date());   
		 //$('#tourtransferroundpickuptime').val(new Date());   
		 $(document).on('show.bs.modal', '.modal', function (event) {       
	            var zIndex = 1040 + (10 * $('.modal:visible').length);
	            $(this).css('z-index', zIndex);
	            setTimeout(function() {
	                $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
	            }, 0);
	        });
		 
		 
    	$('[data-toggle="tooltip"]').tooltip(); 
        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();
        
        function SearchContent(url,id){
		    $.get(url).done(function (data) {
		  	$('#'+id).jqxWindow('setContent', data);
			}); 
		}
        
        $('#btncreceipttr').click(function(){
        	getcommercialamt();       
         });   
        $('#btncreceipttr').click(function(){
        	funcommrecptcheck();   
         });
        $('#btnenquiry').click(function(){
        	$('#cnfcheck').val('SERVICE');      
        	if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){           
	       	$('#servicehide').show();   
	       	}else{
	       		 $('#servicehide').hide();             
	       	}
        	$('#micediv').load('serviceRequestGrid.jsp?rdocno='+$('#txtrdocno').val());
       });  
        $('#btnvisa').click(function(){ 
        	$('#cnfcheck').val('VISA');
        	if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){           
       		 $('#visahide').show();   
	       	}else{
	       		 $('#visahide').hide();       
	       	}                
        	var rdocno=$('#txtrdocno').val();
        	$('#visadiv').load('visaGrid.jsp?rdocno='+rdocno);  
        });
        $('#btnticket').click(function(){ 
        	$('#cnfcheck').val('TICKET');
        	if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){           
          		 $('#tickethide').show();   
          	}else{
          		 $('#tickethide').hide();                   
          	}      
        	var rdocno=$('#txtrdocno').val();
        	$('#ticketdiv').load('ticketGrid.jsp?rdocno='+rdocno);   
        });
        $('#btnhotel').click(function(){ 
        	$('#cnfcheck').val('HOTEL');      
        	if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){           
    	       	 $('#hotelhide').show();   
    	       	}else{
    	       	 $('#hotelhide').hide();             
    	       	}
        	if($('#hidtype').val()=='Service Request' || $('#hidtype').val()==''){                          
        		 $('#btnupdatehotel').attr('disabled', false);     
        		 $('#btnaddhotel').attr('disabled', false);
    	       	}else{
    	       	 $('#btnupdatehotel').attr('disabled', true);
    	       	 $('#btnaddhotel').attr('disabled', true);               
    	       	}
        	var rdocno=$('#txtrdocno').val();    
        	var type=$('#hidtype').val(); 
        	$('#hoteldiv').load('hotelGrid.jsp?rdocno='+rdocno+'&type='+encodeURIComponent(type));       
        });
        $('#btnjobstatus').click(function(){  
        	$("#vtime").val(new Date());      
        });
        $('#btntransfer').click(function(){
        	$("#transfertime").val(new Date());      
        	$('#cnfcheck').val('TRANSFER');
        	if($('#txtrdocno').val()=='' && $('#hidtype').val()==''){           
    	       	$('#transferhide').show();             
    	       	}else{
    	       		 $('#transferhide').hide();             
    	       	}    
        	var rdocno=$('#txtrdocno').val();    
        	$('#transferdiv').load('transferGrid.jsp?rdocno='+rdocno);  
        });
        $('#btncomment').click(function(){  
        	 getComments(); 
        var enqno=$('#txtendno').val();
    	if(enqno==""){
    		swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document'   
			});
    		return false;
    	}
        }); 
        $('#btnexcel').click(function(){                
        JSONToCSVCon(dataexcel, 'Travel details', true);      
        });
        $('#btncommentsend').click(function(){
        	var enqno=$('#txtendno').val();
        	var txtcomment=$('#txtcomment').val();
        	if(enqno==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
         $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#TravelGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
        
        //$('#trrdet').trigger('click');
		funchecktour();tourreadonly();    
		funroundpickuploc();funrounddropoffloc();     
		funpickuploc();fundropoffloc();  
		$('.tourtransferdiv').fadeOut('fast');
		$('.tourtransferrounddiv').fadeOut('fast');
		$('.divcorporateclient').attr('hidden',false);
		$('.divwalkinclient').attr('hidden',true);
		$('#rsumm').trigger('click');
		funcheck();
		$('.divexistingclient').attr('hidden',false);
		$('.divnewclient').attr('hidden',true);
		$('#varsumm').trigger('click');  
		$('.divvisaexistingclient').attr('hidden',false);
		$('.divvisanewclient').attr('hidden',true);
		$('#ttrsumm').trigger('click');
		$('.divticketexistingclient').attr('hidden',false);
		$('.divticketnewclient').attr('hidden',true);
		$('#hlrsumm').trigger('click');  
		$('.divhotelexistingclient').attr('hidden',false);
		$('.divhotelnewclient').attr('hidden',true);
		
		$('#tfrsumm').trigger('click');
		$('.divtransferexistingclient').attr('hidden',false);
		$('.divtransfernewclient').attr('hidden',true);
		
		funcheckhotel();funcheckticket();funcheckvisa();funchecktransfer();
		
		$('.optclienttype').change(function(){
			if($(this).attr('id')=='trrsumm'){
				$('.divcorporateclient').attr('hidden',false);
				$('.divwalkinclient').attr('hidden',true);
			}
			else{
				$('.divcorporateclient').attr('hidden',true);
				$('.divwalkinclient').attr('hidden',false);
			}
		});
		$('.optsrvcreqclienttype').change(function(){
			if($(this).attr('id')=='rsumm'){
				$('.divexistingclient').attr('hidden',false);
				$('.divnewclient').attr('hidden',true);
			}
			else{
				$('.divexistingclient').attr('hidden',true);
				$('.divnewclient').attr('hidden',false);
			}
		});
		$('.optvisaclienttype').change(function(){
			if($(this).attr('id')=='varsumm'){
				$('.divvisaexistingclient').attr('hidden',false);
				$('.divvisanewclient').attr('hidden',true);
			}
			else{
				$('.divvisaexistingclient').attr('hidden',true);
				$('.divvisanewclient').attr('hidden',false);
			}
		});
		$('.optticketclienttype').change(function(){
			if($(this).attr('id')=='ttrsumm'){
				$('.divticketexistingclient').attr('hidden',false);
				$('.divticketnewclient').attr('hidden',true);
			}
			else{
				$('.divticketexistingclient').attr('hidden',true);
				$('.divticketnewclient').attr('hidden',false);
			}
		});
		$('.opthotelclienttype').change(function(){
			if($(this).attr('id')=='hlrsumm'){
				$('.divhotelexistingclient').attr('hidden',false);
				$('.divhotelnewclient').attr('hidden',true);
			}
			else{
				$('.divhotelexistingclient').attr('hidden',true);
				$('.divhotelnewclient').attr('hidden',false);
			}
		});
		$('.opttransferclienttype').change(function(){
			if($(this).attr('id')=='tfrsumm'){
				$('.divtransferexistingclient').attr('hidden',false);
				$('.divtransfernewclient').attr('hidden',true);
			}
			else{
				$('.divtransferexistingclient').attr('hidden',true);
				$('.divtransfernewclient').attr('hidden',false);
			}
		});
		$(".next-step").click(function (e) {
	        var $active = $('.wizard .nav-tabs li.active');
	        $active.next().removeClass('disabled');
	        nextTab($active);
	    });
	    $(".prev-step").click(function (e) {
	        var $active = $('.wizard .nav-tabs li.active');
	        prevTab($active);
	    });
	    
	    $('.wizard a[data-toggle="tab"]').on('show.bs.tab', function (e) {
	
	        var $target = $(e.target);
	    
	        if ($target.parent().hasClass('disabled')) {
	            return false;
	        }
	    });
	    $("#adult").change(function(){
	        var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var stockadult=document.getElementById("stockadult").value;
	        if($('#stocktype').val()=="stock"){
	         if(parseInt(adult)>parseInt(stockadult)){
	               swal({
						type: 'warning',
						title: 'Warning',
						text: 'Out of stock!!!' 
					});
					$('#adult').val(stockadult);
	         }
	        } 
	    	var transfertype=document.getElementById("cmbtourtransfertype").value;
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;     
			if($('#privatetr').val()=="0"){                                                                                       
				var total=0.00;
			    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));  
				 if(adult!='' && adult!='0' && adult!='0.00'){    
					 if(discounttype=="DISCOUNT"){                                                       
					     total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));   
					 }else if(discounttype=="PAY BACK"){        
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult));
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));   
					 }
				 }
				 funRoundAmt(total,"tourtotal");	
			}else{
				var total=0.00;
			    total=parseFloat(spadult);                     
			    if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){  
					 if(discounttype=="DISCOUNT"){
							 total=parseFloat(total)-parseFloat(adultdis);             
					  }else if(discounttype=="PAY BACK"){        
							 total=parseFloat(total)+parseFloat(adultdis);                 
					  }else{   
						 total=parseFloat(spadult);       
					 }
				 }
			    funRoundAmt(adultdis,"tourdiscountadult");   
			    funRoundAmt(total,"tourtotal");  
			}
			 var qty=0;   
			 if(transfertype=="private"){        
			     qty=0;    
			 }else if(transfertype=="sharing"){   
				 if(adult!='' && child!=''){ 
				 qty=parseFloat(adult)+parseFloat(child);
				 }else if(adult!='' && child==''){
					 qty=adult; 
				 }else if(adult=='' && child!=''){
					 qty=child;  
				 }else{
					 qty=0;          
				 }
			 }else{  
				 qty=0;    
			 }
			 $('#tourtransferqty').val(qty);
	    });
	    $("#child").change(function(){  
	   		var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var stockchild=document.getElementById("stockchild").value;
	        if($('#stocktype').val()=="stock"){
	         if(parseInt(child)>parseInt(stockchild)){
	              swal({
						type: 'warning',
						title: 'Warning',
						text: 'Out of stock!!!' 
					});
					$('#child').val(stockchild);
	         }
	        }  
	    	var transfertype=document.getElementById("cmbtourtransfertype").value;
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;
			if($('#privatetr').val()=="0"){   
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
		    if(child!='' && child!='0' && child!='0.00'){ 
				 if(discounttype=="DISCOUNT"){
				     total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));   
				 }else if(discounttype=="PAY BACK"){        
					 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult));
				 }else{   
					 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
				 }
			 }   
		    funRoundAmt(total,"tourtotal");
			}
		    var qty=0;   
			 if(transfertype=="private"){
			     qty=0;    
			 }else if(transfertype=="sharing"){  
				 if(adult!='' && child!=''){ 
				 qty=parseFloat(adult)+parseFloat(child);
				 }else if(adult!='' && child==''){
					 qty=adult; 
				 }else if(adult=='' && child!=''){
					 qty=child;  
				 }else{
					 qty=0;          
				 }
			 }else{  
				 qty=0;    
			 }
			 $('#tourtransferqty').val(qty);
	    });
	    $("#tourdiscountchild").change(function(){
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;  
			if($('#privatetr').val()=="0"){   
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
		    if(childdis!='' && childdis!='0' && childdis!='0.00'){ 
				 if(discounttype=="DISCOUNT"){
					 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child));
					 }
					 }else if(discounttype=="PAY BACK"){  
						 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
							 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child));   
					 }
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 }
			 }   
		    funRoundAmt(childdis,"tourdiscountchild");
		    funRoundAmt(total,"tourtotal");    
			}
	    });
	    $("#tourdiscountadult").change(function(){   
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;
			if($('#privatetr').val()=="0"){  
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
		    if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){  
				 if(discounttype=="DISCOUNT"){
					 if(childdis!='' && childdis!='0' && childdis!='0.00'){
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)-(parseFloat(adultdis)*parseFloat(adult));    
					 }
				 }else if(discounttype=="PAY BACK"){        
					 if(childdis!='' && childdis!='0' && childdis!='0.00'){
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)+(parseFloat(adultdis)*parseFloat(adult));         
					 }
				 }else{   
					 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
				 }
			 }
		    funRoundAmt(adultdis,"tourdiscountadult");
		    funRoundAmt(total,"tourtotal");  
			}else{
				var total=0.00;
			    total=parseFloat(spadult);                     
			    if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){  
					 if(discounttype=="DISCOUNT"){
							 total=parseFloat(total)-parseFloat(adultdis);             
					  }else if(discounttype=="PAY BACK"){        
							 total=parseFloat(total)+parseFloat(adultdis);                 
					  }else{   
						 total=parseFloat(spadult);       
					 }
				 }
			    funRoundAmt(adultdis,"tourdiscountadult");   
			    funRoundAmt(total,"tourtotal");  
			}
	    });
	    $("#cmbtourdiscounttype").change(function(){     
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;
			if($('#privatetr').val()=="0"){   
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
				 if(discounttype=="DISCOUNT"){
					 if(adultdis!='' && childdis==''){      
						 total=parseFloat(total)-(parseFloat(adultdis)*parseFloat(adult)); 
					 }else if(adultdis=='' && childdis!=''){
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child)); 
					 }else if(adultdis!='' && childdis!=''){
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{}
				 }else if(discounttype=="PAY BACK"){   
					 if(adultdis!='' && childdis==''){              
						 total=parseFloat(total)+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else if(adultdis=='' && childdis!=''){
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child)); 
					 }else if(adultdis!='' && childdis!=''){
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{}  
				 }else{      
					 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 funRoundAmt(0,"tourdiscountchild");
					 funRoundAmt(0,"tourdiscountadult");  
				 }   
		    funRoundAmt(total,"tourtotal");
			}else{   
				var total=0.00;
			    total=parseFloat(spadult);                     
					 if(discounttype=="DISCOUNT"){
						 if(adultdis!=''){      
							 total=parseFloat(total)-parseFloat(adultdis);    
						 }
					 }else if(discounttype=="PAY BACK"){   
						 if(adultdis!=''){              
							 total=parseFloat(total)+parseFloat(adultdis); 
						 }    
					 }else{      
						 total=parseFloat(spadult);    
						 funRoundAmt(0,"tourdiscountchild");
						 funRoundAmt(0,"tourdiscountadult");  
					 }   
			    funRoundAmt(total,"tourtotal");
			}                
	    });   
	    
	    $("#spadult").change(function(){
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;  
			if($('#privatetr').val()=="0"){   
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
		    if(childdis!='' && childdis!='0' && childdis!='0.00'){ 
				 if(discounttype=="DISCOUNT"){
					 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child));
					 }
					 }else if(discounttype=="PAY BACK"){  
						 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
							 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child));   
					 }
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 }
			 }   
		    funRoundAmt(childdis,"tourdiscountchild");
		    funRoundAmt(total,"tourtotal");    
			}
	    });
	  $("#spchild").change(function(){
	    	var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var childdis=document.getElementById("tourdiscountchild").value;
			var adultdis=document.getElementById("tourdiscountadult").value;
			//var total=document.getElementById("tourtotal").value;   
		    var child=document.getElementById("child").value;
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;  
			if($('#privatetr').val()=="0"){   
			var total=0.00;
		    total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));                  
		    if(childdis!='' && childdis!='0' && childdis!='0.00'){ 
				 if(discounttype=="DISCOUNT"){
					 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child))-(parseFloat(adultdis)*parseFloat(adult));
					 }else{
						 total=parseFloat(total)-(parseFloat(childdis)*parseFloat(child));
					 }
					 }else if(discounttype=="PAY BACK"){  
						 if(adultdis!='' && adultdis!='0' && adultdis!='0.00'){ 
							 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child))+(parseFloat(adultdis)*parseFloat(adult)); 
					 }else{
						 total=parseFloat(total)+(parseFloat(childdis)*parseFloat(child));   
					 }
					 }else{   
						 total=(parseFloat(child)*parseFloat(spchild))+(parseFloat(adult)*parseFloat(spadult));
					 }
			 }   
		    funRoundAmt(childdis,"tourdiscountchild");
		    funRoundAmt(total,"tourtotal");    
			}
	    });
	    
	    
	    $("#cmbtourtransfertype").change(function(){                             
	    	var transfertype=document.getElementById("cmbtourtransfertype").value;
	    	var child=document.getElementById("child").value;
			var adult=document.getElementById("adult").value;
			var total=0;   
				 if(transfertype=="private"){
				     total=1;       
				 }else if(transfertype=="sharing"){  
					 if(adult!='' && child!=''){ 
					 total=parseFloat(adult)+parseFloat(child);
					 }else if(adult!='' && child==''){
						 total=adult; 
					 }else if(adult=='' && child!=''){
						 total=child;  
					 }else{
						 total=0;          
					 }
				 }else{  
					 total=0;    
				 }
				 $('#tourtransferqty').val(total);               
	    });
	    
	    $('.page-loader').hide();
	});    
	
	function funSendWhatsApp(sendmsg,sendmobile){
		//var sendmsg='Testing Whatsapp';
		sendmsg=encodeURI(sendmsg);
		//var sendmobile='917736626252';
		var sendurl='https://wa.me/'+sendmobile+'?text='+sendmsg;
		//top.addTab('WhatsApp',sendurl);
		var win= window.open(sendurl,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	}
	
	function tourreadonly(){ 
		$('#tourtransfertotal').attr('readonly', true );  
		$('#tourtransferratetot').attr('readonly', true );
		$('#tourtotal').attr('readonly', true );
		if($('#tourismconfig').val()!=1){
			    $('#spchild').attr('readonly', true ); 
			    $('#spadult').attr('readonly', true ); 
		}else{
		    	$('#spchild').attr('readonly', false ); 
			    $('#spadult').attr('readonly', false );
		}
	 }       
	     
	function funChooseTourTransferRound(value){ 
	if(value=="1"){
			$('.tourtransferrounddiv').fadeIn('slow');                      
			 document.getElementById("rounddropofflocid").value=$('#pickuplocid').val();
			 document.getElementById("jqxroundDropoffLoc").value=$('#pickuploc').val();
		     document.getElementById("jqxroundPickupLoc").value=$('#dropoffloc').val();
		     document.getElementById("roundpickuplocid").value=$('#dropofflocid').val();
		}
		else{
			$('.tourtransferrounddiv').fadeOut('slow');
		}
	getTariffData();getReturnTariffData(); 
	}
	function funChooseTourTransfer(value){
		if(value=="1"){
			$('.tourtransferdiv').fadeIn('slow');
			document.getElementById('cmbtourtransferloctype').value="H";      
			document.getElementById('tourtransferlocrefname').value=$('#cmblocation option:selected').html();  
		}    
		else{
			document.getElementById("cmbtourtransferroundtrip").value="";
			funChooseTourTransferRound(0);  
			$('.tourtransferdiv').fadeOut('slow');
		}
	}
	function nextTab(elem) {
	    $(elem).next().find('a[data-toggle="tab"]').click();
	}
	function prevTab(elem) {
	    $(elem).prev().find('a[data-toggle="tab"]').click();
	}
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#TravelGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.        
    	$("#TravelGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#txtendno').val();
    	$('#hidcomments').val($('#txtcomment').val());
   	    if (($(hidcomments).val()).includes('$')) { $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));};if (($(hidcomments).val()).includes('%')) { $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));};
   	    if (($(hidcomments).val()).includes('^')) { $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));};if (($(hidcomments).val()).includes('`')) { $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));};
   	    if (($(hidcomments).val()).includes('~')) { $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));};if ($(hidcomments).val().indexOf('\'')  >= 0 ) { $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));};
   	    if (($(hidcomments).val()).includes(',')) { $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));}
   	    if ($(hidcomments).val().indexOf('"') >= 0) { $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));};
   	    if (($(hidcomments).val()).match(/\\/g)) { $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));}; 
    
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				$('#txtcomment').val('');  
				getComments(); 		
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&enqno="+enqno,true);
		x.send();
    }
    function getComments(){
    	var enqno=$('#txtendno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='';
				if(items!=''){ 
				for(var i=0;i<items.length;i++){
					str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
				}
				$('.comments-container').html($.parseHTML(str));		
				}else{} 	
			}   
			else
			{
			}
		}
		x.open("GET","getComments.jsp?enqno="+enqno,true);
		x.send();
    }
   
   function funSerReqSave(){
	   if (document.getElementById('rsumm').checked){   
		   var refname=document.getElementById("jqxClient").value;
          }   
	     else if (document.getElementById('rdet').checked){       
	    	 var refname=document.getElementById("txtclient").value;
	      }           
	   var rdocno=document.getElementById("txtrdocno").value
	   var clienttype=document.getElementById("clienttype").value;          
	   var email=document.getElementById("txtemail").value;
	   var mobno=document.getElementById("txtmob").value;
	   var client=document.getElementById("hidclient").value;
	   var edate=$('#edate').jqxDateTimeInput('val');
	   var userid="<%= session.getAttribute("USERID").toString() %>";
	   var branchid=$('#cmbbranch').val();
	   var gridarray=new Array();       
	   var rows=$('#serviceReqGrid').jqxGrid('getrows')
   
   for(var i=0;i<rows.length;i++){
   var chk1=$('#serviceReqGrid').jqxGrid('getcellvalue',i,'remarks');
   var chk2=$('#serviceReqGrid').jqxGrid('getcellvalue',i,'pax');
		    if((typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != "") || (typeof(chk2) != "undefined" && typeof(chk2) != "NaN" && chk2 != "")){
		     gridarray.push(rows[i].serdocno+"::"+rows[i].remarks+"::"+rows[i].pax+"::"+rows[i].rowno);    
   			}   
   //alert(gridarray)
   }  
   
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					document.getElementById("jqxClient").value="";
					document.getElementById("txtclient").value="";
					document.getElementById("txtemail").value="";     
					document.getElementById("txtmob").value="";
					$('#micediv').load('serviceRequestGrid.jsp?rdocno='+$('#txtrdocno').val());         
				}
				else{
					swal({
						type: 'error',
						title: 'Error',  
						text: 'Not Updated'
					});
				}
				
			}
			else
			{
			}    
		}
		x.open("GET","saveSerReqData.jsp?gridarray="+gridarray+"&brhid="+branchid+"&edate="+edate+"&userid="+userid+"&clientid="+client+"&client="+refname+"&mob="+mobno+"&mail="+email+"&type="+clienttype+"&rdocno="+rdocno+"&locid="+$('#cmblocation').val(),true);     
		x.send();
   
   }
    function getGroup(){     
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					brchIdItems = items[0].split(",");  
					brchItems = items[1].split(",");
					var optionsbrch = '<option value="">--Select--</option>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsbrch += '<option value="' + brchIdItems[i] + '">'
								+ brchItems[i] + '</option>';    
					}
					$("select#cmbtourtransfergroup").html(optionsbrch);
				} 
			else    
			{       
			}                
		}
		x.open("GET","getGroup.jsp",true);                   
		x.send();  
	 }
    function funUser()
	{  
			//var mytext=localStorage.getItem("path");
			//var userid=Cookies.get("userid");
			var userid="<%= session.getAttribute("USERID").toString() %>";     
			var user=new Array();
			var x=new XMLHttpRequest();
			x.onreadystatechange=function()
			{
				if(x.readyState==4 && x.status==200)
				{
					var msg=x.responseText.trim().split(',');
					//alert(msg);
		            for(var i=0;i<=msg.length-1;i++)
		            {
		            	var cdoc=msg[i].split('::')[0];
		              	var unam=msg[i].split('::')[1];
		              	//var cc=cdoc+"::"+cl;
		              	user.push(unam+":"+cdoc);
		            }
		            autocomplete(document.getElementById("user"), user);
				}
			}  
			x.open("GET","getUser.jsp?userid="+userid,true);
			x.send();
	}   
    
    function funSave()   
    {
    	var reftype=document.getElementById("reftype").value;
    	var refno=document.getElementById("refno").value;
    	var sdate=$('#date').jqxDateTimeInput('val');
    	var stime=document.getElementById("vtime").value;
    	var user=document.getElementById("jqxInputUsers").value;
    	var hiduser=document.getElementById("hiduser").value;
    	var desc=document.getElementById("desc").value;
    	var userid="<%= session.getAttribute("USERID").toString() %>";     
    	if(refno=="")
    	{
    		swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Enter Ref. No.'      
			});
			 return 0;
    	}
    	if(stime=="")   
    	{
    		swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Enter time'      
			});
			 return 0;
    	}
    	if(user=="")
    	{
    		swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Enter Assigned User'      
			});
			 return 0;
    	}
    	if(desc=="")
    	{
    		swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Enter Description'      
			});
			 return 0;
    	}

    	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		    	     saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser);       
		     	}  
		 });      
    	
    }    
    function saveDatasss(reftype,refno,sdate,stime,user,desc,userid,hiduser){
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function()
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var msg=x.responseText.trim().split(',');
    					// alert(msg);
    					if(msg=="1"){ 
    			              	document.getElementById("refno").value="";
    			              	document.getElementById("vtime").value="";
    			              	document.getElementById("jqxInputUsers").value=""; 
    			              	document.getElementById("hiduser").value="";
    			              	document.getElementById("desc").value="";   
    			            	  swal({   
    									type: 'success',
    									title: 'Success',
    									text: 'Successfully Saved'      
    								});
    			               
    			              } else{
    		            	swal({
    							type: 'error',
    							title: 'Error',  
    							text: 'Not Saved'              
    						});    
    		            }
    				}         
    			}
    			x.open("GET","taskCreate.jsp?reftype="+reftype+"&refno="+refno+"&sdate="+sdate+"&stime="+stime+"&user="+user+"&desc="+desc+"&userid="+userid+"&hiduser="+hiduser,true);
    			x.send();
    }
       
    function funpendingUpdate(){                         
    	var docno=$('#txtpendocno').val();    
    	var crtuser=$('#txtcrtuser').val(); 
     	var status=$('#assgntask').val(); 
    	var oldstat= document.getElementById("txtoldstatus").value;  
      	var asgnuser=$('#hiduser2').val();    
      	var oldassuser=document.getElementById("txtasgnuser").value;   
    	var userid=$('#hiduser2').val();              
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{ 
				var items=x.responseText.trim();
				if(items>0){
					document.getElementById("remarks").value="";
					document.getElementById("txtcrtuser").value="";  
					document.getElementById("hiduser2").value="";
					document.getElementById("txtpendocno").value="";  
					document.getElementById("jqxInputUser").value=""; 
					swal({
						type: 'success',
						title: 'Success',
						text: 'Status Updated'
					});
					reload();         
				}else if(items==-888){  
					swal({
						type: 'error',
						title: 'Error',
						text: 'Task is not completed'  
					});
				}else{ 
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'                               
					});
				}    
			}else
			{
			}    
		}
		x.open("GET","penStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+$('#remarks').val(),true);           
		x.send();
    }
    function reload(){         
  	    var userid= "<%= session.getAttribute("USERID").toString() %>";
  		$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);    
    }
    function funstatusval(crtuserid){     
    	// var crtuserid=document.getElementById("txtcrtuser").value;  
    	 var sesuserid= "<%= session.getAttribute("USERID").toString() %>";
    	var optionref="";  
    	 if(crtuserid==sesuserid){   
    		  optionref += '<option value="Assigned">Assign</option>';
    		  optionref += '<option value="Accepted">Accepted</option>';
    		  optionref += '<option value="Completed">Completed</option>';
    		  optionref += '<option value="Close">Close</option>';          
    	      $("select#assgntask").html(optionref); 
    	 }else{
    		 optionref += '<option value="Assigned">Assign</option>';
   		     optionref += '<option value="Accepted">Accepted</option>';
   		     optionref += '<option value="Completed">Completed</option>';
   	         $("select#assgntask").html(optionref);  
    	 }
    }
function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var perm = items[2];  
				var optionsbranch;
				/* if(perm==0){
				 optionsbranch = '<option value="a" selected>All</option>';
				}
				else{    
					
				} */
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
				/* if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} */
				getLocation(); 
				reloadtravel();
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
	
	
	function funvisagrid()
		{
			var rows = $('#visaGrid').jqxGrid('getrows');
			var rowlength= rows.length;
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "givenname", document.getElementById("vname").value);
		     $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "surname", document.getElementById("vsurname").value);
			  $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "vtype", document.getElementById("jqxVisa").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "visaval", document.getElementById("vvalidity").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "vdocno", document.getElementById("vdocno").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "nationality", document.getElementById("jqxNation").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "natid", document.getElementById("nationid").value);
		     $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "passno", document.getElementById("vpassno").value);
		     $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "issuedfrom", document.getElementById("vissuedfrom").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "vupto", document.getElementById("vvalidup").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "remarks", document.getElementById("vremarks").value);
			 $('#visaGrid').jqxGrid('setcellvalue',  rowlength-1, "attach", "Attach");
			
		    
				   document.getElementById("vname").value ="";
				   document.getElementById("vsurname").value="";
				   document.getElementById("tpassno").value="";
				   document.getElementById("jqxVisa").value="";
				    document.getElementById("vdocno").value ="";
				   document.getElementById("vvalidity").value=""; 
				   document.getElementById("jqxNation").value=""; 
				   document.getElementById("nationid").value=""; 
				   document.getElementById("vpassno").value=""; 
				   document.getElementById("vissuedfrom").value="";
				   document.getElementById("vvalidup").value="";				   
		           document.getElementById("vremarks").value="";
				   $("#visaGrid").jqxGrid('addrow', null, {});
				   document.getElementById("vname").focus();
		 
		}
	//saving 
	
	function funvisaSave(){  
		if (document.getElementById('varsumm').checked){   
			   var refname=document.getElementById("jqxClientva").value;
	          }   
		     else if (document.getElementById('vardet').checked){       
		    	 var refname=document.getElementById("txtclientva").value;
		      }   
		   var clienttype=document.getElementById("clienttypeva").value;       
		   var email=document.getElementById("txtemailva").value;
		   var mobno=document.getElementById("txtmobva").value;
		   var client=document.getElementById("hidclientva").value;
		   var tdate=$('#vadate').jqxDateTimeInput('val');
		   var userid="<%= session.getAttribute("USERID").toString() %>";   
		   var branchid=$('#cmbbranch').val(); 	
		
	var rdocno=document.getElementById("txtrdocno").value;
    var gridarray=new Array();
    var rows=$('#visaGrid').jqxGrid('getrows')
	for(var i=0;i<rows.length;i++){
    var chk=$('#visaGrid').jqxGrid('getcellvalue',i,'givenname');
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		    
		    $('#vgname').val(rows[i].givenname);
				if (($(vgname).val()).includes('$')) { $(vgname).val($(vgname).val().replace(/$/g, ''));};if (($(vgname).val()).includes('%')) { $(vgname).val($(vgname).val().replace(/%/g, ''));};
		    	if (($(vgname).val()).includes('!')) { $(vgname).val($(vgname).val().replace(/!/g, ''));};if (($(vgname).val()).includes('@')) { $(vgname).val($(vgname).val().replace(/@/g, ''));};
		    	if (($(vgname).val()).includes('#')) { $(vgname).val($(vgname).val().replace(/#/g, ''));};if (($(vgname).val()).includes('&')) { $(vgname).val($(vgname).val().replace(/&/g, ''));};
		    	if (($(vgname).val()).includes('^')) { $(vgname).val($(vgname).val().replace(/^/g, ''));};if (($(vgname).val()).includes('`')) { $(vgname).val($(vgname).val().replace(/`/g, ''));};
		    	if (($(vgname).val()).includes('~')) { $(vgname).val($(vgname).val().replace(/~/g, ''));};if ($(vgname).val().indexOf('\'')  >= 0 ) { $(vgname).val($(vgname).val().replace(/'/g, ''));};
		    	if (($(vgname).val()).includes(',')) { $(vgname).val($(vgname).val().replace(/,/g, ''));}
		    
		    $('#vsname').val(rows[i].surname);
				if (($(vsname).val()).includes('$')) { $(vsname).val($(vsname).val().replace(/$/g, ''));};if (($(vsname).val()).includes('%')) { $(vsname).val($(vsname).val().replace(/%/g, ''));};
		    	if (($(vsname).val()).includes('!')) { $(vsname).val($(vsname).val().replace(/!/g, ''));};if (($(vsname).val()).includes('@')) { $(vsname).val($(vsname).val().replace(/@/g, ''));};
		    	if (($(vsname).val()).includes('#')) { $(vsname).val($(vsname).val().replace(/#/g, ''));};if (($(vsname).val()).includes('&')) { $(vsname).val($(vsname).val().replace(/&/g, ''));};
		    	if (($(vsname).val()).includes('^')) { $(vsname).val($(vsname).val().replace(/^/g, ''));};if (($(vsname).val()).includes('`')) { $(vsname).val($(vsname).val().replace(/`/g, ''));};
		    	if (($(vsname).val()).includes('~')) { $(vsname).val($(vsname).val().replace(/~/g, ''));};if ($(vsname).val().indexOf('\'')  >= 0 ) { $(vsname).val($(vsname).val().replace(/'/g, ''));};
		    	if (($(vsname).val()).includes(',')) { $(vsname).val($(vsname).val().replace(/,/g, ''));}
		    	
 			$('#vipassno').val(rows[i].passno);
				if (($(vipassno).val()).includes('$')) { $(vipassno).val($(vipassno).val().replace(/$/g, ''));};if (($(vipassno).val()).includes('%')) { $(vipassno).val($(vipassno).val().replace(/%/g, ''));};
		    	if (($(vipassno).val()).includes('!')) { $(vipassno).val($(vipassno).val().replace(/!/g, ''));};if (($(vipassno).val()).includes('@')) { $(vipassno).val($(vipassno).val().replace(/@/g, ''));};
		    	if (($(vipassno).val()).includes('#')) { $(vipassno).val($(vipassno).val().replace(/#/g, ''));};if (($(vipassno).val()).includes('&')) { $(vipassno).val($(vipassno).val().replace(/&/g, ''));};
		    	if (($(vipassno).val()).includes('^')) { $(vipassno).val($(vipassno).val().replace(/^/g, ''));};if (($(vipassno).val()).includes('`')) { $(vipassno).val($(vipassno).val().replace(/`/g, ''));};
		    	if (($(vipassno).val()).includes('~')) { $(vipassno).val($(vipassno).val().replace(/~/g, ''));};if ($(vipassno).val().indexOf('\'')  >= 0 ) { $(vipassno).val($(vipassno).val().replace(/'/g, ''));};
		    	if (($(vipassno).val()).includes(',')) { $(vipassno).val($(vipassno).val().replace(/,/g, ''));}
		    		
		     $('#vifrom').val(rows[i].issuedfrom);
				if (($(vifrom).val()).includes('$')) { $(vifrom).val($(vifrom).val().replace(/$/g, ''));};if (($(vifrom).val()).includes('%')) { $(vifrom).val($(vifrom).val().replace(/%/g, ''));};
		    	if (($(vifrom).val()).includes('!')) { $(vifrom).val($(vifrom).val().replace(/!/g, ''));};if (($(vifrom).val()).includes('@')) { $(vifrom).val($(vifrom).val().replace(/@/g, ''));};
		    	if (($(vifrom).val()).includes('#')) { $(vifrom).val($(vifrom).val().replace(/#/g, ''));};if (($(vifrom).val()).includes('&')) { $(vifrom).val($(vifrom).val().replace(/&/g, ''));};
		    	if (($(vifrom).val()).includes('^')) { $(vifrom).val($(vifrom).val().replace(/^/g, ''));};if (($(vifrom).val()).includes('`')) { $(vifrom).val($(vifrom).val().replace(/`/g, ''));};
		    	if (($(vifrom).val()).includes('~')) { $(vifrom).val($(vifrom).val().replace(/~/g, ''));};if ($(vifrom).val().indexOf('\'')  >= 0 ) { $(vifrom).val($(vifrom).val().replace(/'/g, ''));};
		    	if (($(vifrom).val()).includes(',')) { $(vifrom).val($(vifrom).val().replace(/,/g, ''));}
		    	
		    $('#vremk').val(rows[i].remarks);
				if (($(vremk).val()).includes('$')) { $(vremk).val($(vremk).val().replace(/$/g, ''));};if (($(vremk).val()).includes('%')) { $(vremk).val($(vremk).val().replace(/%/g, ''));};
		    	if (($(vremk).val()).includes('!')) { $(vremk).val($(vremk).val().replace(/!/g, ''));};if (($(vremk).val()).includes('@')) { $(vremk).val($(vremk).val().replace(/@/g, ''));};
		    	if (($(vremk).val()).includes('#')) { $(vremk).val($(vremk).val().replace(/#/g, ''));};if (($(vremk).val()).includes('&')) { $(vremk).val($(vremk).val().replace(/&/g, ''));};
		    	if (($(vremk).val()).includes('^')) { $(vremk).val($(vremk).val().replace(/^/g, ''));};if (($(vremk).val()).includes('`')) { $(vremk).val($(vremk).val().replace(/`/g, ''));};
		    	if (($(vremk).val()).includes('~')) { $(vremk).val($(vremk).val().replace(/~/g, ''));};if ($(vremk).val().indexOf('\'')  >= 0 ) { $(vremk).val($(vremk).val().replace(/'/g, ''));};
		    	if (($(vremk).val()).includes(',')) { $(vremk).val($(vremk).val().replace(/,/g, ''));}
		   
   			gridarray.push($('#vgname').val()+"::"+$('#vsname').val()+"::"+rows[i].vdocno+"::"+rows[i].natid+"::"+$('#vipassno').val()+"::"+$('#vifrom').val()+"::"+rows[i].vupto+"::"+$('#vremk').val()+"::"+rows[i].rowno);
   			
   			}
   //alert(gridarray)
   }
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					document.getElementById("jqxClientva").value="";
					document.getElementById("txtclientva").value="";
					document.getElementById("txtemailva").value="";
					document.getElementById("txtmobva").value=""; 
					if($("#txtrdocno").val()==''){      
						 $("#visaGrid").jqxGrid('clear');   
						 $("#visaGrid").jqxGrid('addrow', null, {});             
					}
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'
					});
				}
			}
			else
			{
			}    
		}
		x.open("GET","savevisaData.jsp?gridarray="+gridarray+"&rdocno="+rdocno+"&brhid="+branchid+"&edate="+tdate+"&userid="+userid+"&clientid="+client+"&client="+refname+"&mob="+mobno+"&mail="+email+"&locid="+$('#cmblocation').val()+"&type="+clienttype,true);
		x.send();
}    
	
/*visa ends */
	function getLocation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {  
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");        
				brchItems = items[1].split(",");
				var optionsbrch;// = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsbrch);
				reloadtravel();
			} else {
				//alert("Error");
			}     
		}
		x.open("GET","getLocation.jsp?brhid="+$('#cmbbranch').val(), true);   
		x.send();
	}
	function funpickuploc(){  
    	 $('#tourtransferpickuploc').load('pickuplocSearch.jsp');      
    } 
    function fundropoffloc(){          
   	 $('#tourtransferdropoffloc').load('dropofflocSearch.jsp');           
   }
    function funroundpickuploc(){           
   	 $('#tourtransferroundpickuploc').load('roundpickuplocSearch.jsp');      
   } 
   function funrounddropoffloc(){          
  	 $('#tourtransferrounddropoffloc').load('rounddropofflocSearch.jsp');           
  }
	function funticketgrid()
		{
			var rows = $('#ticketGrid').jqxGrid('getrows');
			var rowlength= rows.length;
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "givenname", document.getElementById("tgivenname").value);
		     $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "surname", document.getElementById("tsurname").value);
		     $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "passno", document.getElementById("tpassno").value);
		     $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "issuedfrom", document.getElementById("tissuedfrom").value);
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "vupto", document.getElementById("validupdate").value);
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "fromdest", document.getElementById("ticfdest").value);
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "todest", document.getElementById("tictdest").value);
			  $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "date", document.getElementById("ticketdate").value);
			   $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "ptype", document.getElementById("ptype").value);
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "remarks", document.getElementById("tiremarks").value);
			 $('#ticketGrid').jqxGrid('setcellvalue',  rowlength-1, "attach", "Attach");
		    
				   document.getElementById("tgivenname").value ="";
				   document.getElementById("tsurname").value="";
				   document.getElementById("tpassno").value="";
				   document.getElementById("tissuedfrom").value="";
				   document.getElementById("validupdate").value=""; 
				   document.getElementById("ticfdest").value=""; 
				   document.getElementById("tictdest").value=""; 
				   document.getElementById("ptype").value="child"; 
				   document.getElementById("ticketdate").value=""; 
		           document.getElementById("tiremarks").value="";
				   $("#ticketGrid").jqxGrid('addrow', null, {});
				   document.getElementById("tgivenname").focus();
		 
		}
	
	//saving
	
function funticketSave(){     
	if (document.getElementById('ttrsumm').checked){   
		   var refname=document.getElementById("jqxClienttt").value;
       }   
	     else if (document.getElementById('ttrdet').checked){       
	    	 var refname=document.getElementById("txtclienttt").value;
	      }   
	   var clienttype=document.getElementById("clienttypett").value;       
	   var email=document.getElementById("txtemailtt").value;
	   var mobno=document.getElementById("txtmobtt").value;
	   var client=document.getElementById("hidclienttt").value;
	   var tdate=$('#ttdate').jqxDateTimeInput('val');
	   var userid="<%= session.getAttribute("USERID").toString() %>";
	   var branchid=$('#cmbbranch').val();         
		
	var rdocno=document.getElementById("txtrdocno").value;
    var gridarray=new Array();
    var rows=$('#ticketGrid').jqxGrid('getrows')
	for(var i=0;i<rows.length;i++){
    var chk=$('#ticketGrid').jqxGrid('getcellvalue',i,'givenname');
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		    
		     $('#tigname').val(rows[i].givenname);
				if (($(tigname).val()).includes('$')) { $(tigname).val($(tigname).val().replace(/$/g, ''));};if (($(tigname).val()).includes('%')) { $(tigname).val($(tigname).val().replace(/%/g, ''));};
		    	if (($(tigname).val()).includes('!')) { $(tigname).val($(tigname).val().replace(/!/g, ''));};if (($(tigname).val()).includes('@')) { $(tigname).val($(tigname).val().replace(/@/g, ''));};
		    	if (($(tigname).val()).includes('#')) { $(tigname).val($(tigname).val().replace(/#/g, ''));};if (($(tigname).val()).includes('&')) { $(tigname).val($(tigname).val().replace(/&/g, ''));};
		    	if (($(tigname).val()).includes('^')) { $(tigname).val($(tigname).val().replace(/^/g, ''));};if (($(tigname).val()).includes('`')) { $(tigname).val($(tigname).val().replace(/`/g, ''));};
		    	if (($(tigname).val()).includes('~')) { $(tigname).val($(tigname).val().replace(/~/g, ''));};if ($(tigname).val().indexOf('\'')  >= 0 ) { $(tigname).val($(tigname).val().replace(/'/g, ''));};
		    	if (($(tigname).val()).includes(',')) { $(tigname).val($(tigname).val().replace(/,/g, ''));}
		    
		     $('#tisurname').val(rows[i].surname);
				if (($(tisurname).val()).includes('$')) { $(tisurname).val($(tisurname).val().replace(/$/g, ''));};if (($(tisurname).val()).includes('%')) { $(tisurname).val($(tisurname).val().replace(/%/g, ''));};
		    	if (($(tisurname).val()).includes('!')) { $(tisurname).val($(tisurname).val().replace(/!/g, ''));};if (($(tisurname).val()).includes('@')) { $(tisurname).val($(tisurname).val().replace(/@/g, ''));};
		    	if (($(tisurname).val()).includes('#')) { $(tisurname).val($(tisurname).val().replace(/#/g, ''));};if (($(tisurname).val()).includes('&')) { $(tisurname).val($(tisurname).val().replace(/&/g, ''));};
		    	if (($(tisurname).val()).includes('^')) { $(tisurname).val($(tisurname).val().replace(/^/g, ''));};if (($(tisurname).val()).includes('`')) { $(tisurname).val($(tisurname).val().replace(/`/g, ''));};
		    	if (($(tisurname).val()).includes('~')) { $(tisurname).val($(tisurname).val().replace(/~/g, ''));};if ($(tisurname).val().indexOf('\'')  >= 0 ) { $(tisurname).val($(tisurname).val().replace(/'/g, ''));};
		    	if (($(tisurname).val()).includes(',')) { $(tisurname).val($(tisurname).val().replace(/,/g, ''));}
		    
		     $('#tipassno').val(rows[i].passno);
				if (($(tipassno).val()).includes('$')) { $(tipassno).val($(tipassno).val().replace(/$/g, ''));};if (($(tipassno).val()).includes('%')) { $(tipassno).val($(tipassno).val().replace(/%/g, ''));};
		    	if (($(tipassno).val()).includes('!')) { $(tipassno).val($(tipassno).val().replace(/!/g, ''));};if (($(tipassno).val()).includes('@')) { $(tipassno).val($(tipassno).val().replace(/@/g, ''));};
		    	if (($(tipassno).val()).includes('#')) { $(tipassno).val($(tipassno).val().replace(/#/g, ''));};if (($(tipassno).val()).includes('&')) { $(tipassno).val($(tipassno).val().replace(/&/g, ''));};
		    	if (($(tipassno).val()).includes('^')) { $(tipassno).val($(tipassno).val().replace(/^/g, ''));};if (($(tipassno).val()).includes('`')) { $(tipassno).val($(tipassno).val().replace(/`/g, ''));};
		    	if (($(tipassno).val()).includes('~')) { $(tipassno).val($(tipassno).val().replace(/~/g, ''));};if ($(tipassno).val().indexOf('\'')  >= 0 ) { $(tipassno).val($(tipassno).val().replace(/'/g, ''));};
		    	if (($(tipassno).val()).includes(',')) { $(tipassno).val($(tipassno).val().replace(/,/g, ''));}
		    
		     $('#tiissuedfrom').val(rows[i].issuedfrom);
				if (($(tiissuedfrom).val()).includes('$')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/$/g, ''));};if (($(tiissuedfrom).val()).includes('%')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/%/g, ''));};
		    	if (($(tiissuedfrom).val()).includes('!')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/!/g, ''));};if (($(tiissuedfrom).val()).includes('@')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/@/g, ''));};
		    	if (($(tiissuedfrom).val()).includes('#')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/#/g, ''));};if (($(tiissuedfrom).val()).includes('&')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/&/g, ''));};
		    	if (($(tiissuedfrom).val()).includes('^')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/^/g, ''));};if (($(tiissuedfrom).val()).includes('`')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/`/g, ''));};
		    	if (($(tiissuedfrom).val()).includes('~')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/~/g, ''));};if ($(tiissuedfrom).val().indexOf('\'')  >= 0 ) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/'/g, ''));};
		    	if (($(tiissuedfrom).val()).includes(',')) { $(tiissuedfrom).val($(tiissuedfrom).val().replace(/,/g, ''));}
		    
		     $('#tifdest').val(rows[i].fromdest);
				if (($(tifdest).val()).includes('$')) { $(tifdest).val($(tifdest).val().replace(/$/g, ''));};if (($(tifdest).val()).includes('%')) { $(tifdest).val($(tifdest).val().replace(/%/g, ''));};
		    	if (($(tifdest).val()).includes('!')) { $(tifdest).val($(tifdest).val().replace(/!/g, ''));};if (($(tifdest).val()).includes('@')) { $(tifdest).val($(tifdest).val().replace(/@/g, ''));};
		    	if (($(tifdest).val()).includes('#')) { $(tifdest).val($(tifdest).val().replace(/#/g, ''));};if (($(tifdest).val()).includes('&')) { $(tifdest).val($(tifdest).val().replace(/&/g, ''));};
		    	if (($(tifdest).val()).includes('^')) { $(tifdest).val($(tifdest).val().replace(/^/g, ''));};if (($(tifdest).val()).includes('`')) { $(tifdest).val($(tifdest).val().replace(/`/g, ''));};
		    	if (($(tifdest).val()).includes('~')) { $(tifdest).val($(tifdest).val().replace(/~/g, ''));};if ($(tifdest).val().indexOf('\'')  >= 0 ) { $(tifdest).val($(tifdest).val().replace(/'/g, ''));};
		    	if (($(tifdest).val()).includes(',')) { $(tifdest).val($(tifdest).val().replace(/,/g, ''));}
		    
		     $('#titdest').val(rows[i].todest);
				if (($(titdest).val()).includes('$')) { $(titdest).val($(titdest).val().replace(/$/g, ''));};if (($(titdest).val()).includes('%')) { $(titdest).val($(titdest).val().replace(/%/g, ''));};
		    	if (($(titdest).val()).includes('!')) { $(titdest).val($(titdest).val().replace(/!/g, ''));};if (($(titdest).val()).includes('@')) { $(titdest).val($(titdest).val().replace(/@/g, ''));};
		    	if (($(titdest).val()).includes('#')) { $(titdest).val($(titdest).val().replace(/#/g, ''));};if (($(titdest).val()).includes('&')) { $(titdest).val($(titdest).val().replace(/&/g, ''));};
		    	if (($(titdest).val()).includes('^')) { $(titdest).val($(titdest).val().replace(/^/g, ''));};if (($(titdest).val()).includes('`')) { $(titdest).val($(titdest).val().replace(/`/g, ''));};
		    	if (($(titdest).val()).includes('~')) { $(titdest).val($(titdest).val().replace(/~/g, ''));};if ($(titdest).val().indexOf('\'')  >= 0 ) { $(titdest).val($(titdest).val().replace(/'/g, ''));};
		    	if (($(titdest).val()).includes(',')) { $(titdest).val($(titdest).val().replace(/,/g, ''));}
		    
		     $('#tiremk').val(rows[i].remarks);
				if (($(tiremk).val()).includes('$')) { $(tiremk).val($(tiremk).val().replace(/$/g, ''));};if (($(tiremk).val()).includes('%')) { $(tiremk).val($(tiremk).val().replace(/%/g, ''));};
		    	if (($(tiremk).val()).includes('!')) { $(tiremk).val($(tiremk).val().replace(/!/g, ''));};if (($(tiremk).val()).includes('@')) { $(tiremk).val($(tiremk).val().replace(/@/g, ''));};
		    	if (($(tiremk).val()).includes('#')) { $(tiremk).val($(tiremk).val().replace(/#/g, ''));};if (($(tiremk).val()).includes('&')) { $(tiremk).val($(tiremk).val().replace(/&/g, ''));};
		    	if (($(tiremk).val()).includes('^')) { $(tiremk).val($(tiremk).val().replace(/^/g, ''));};if (($(tiremk).val()).includes('`')) { $(tiremk).val($(tiremk).val().replace(/`/g, ''));};
		    	if (($(tiremk).val()).includes('~')) { $(tiremk).val($(tiremk).val().replace(/~/g, ''));};if ($(tiremk).val().indexOf('\'')  >= 0 ) { $(tiremk).val($(tiremk).val().replace(/'/g, ''));};
		    	if (($(tiremk).val()).includes(',')) { $(tiremk).val($(tiremk).val().replace(/,/g, ''));}
		    
		    gridarray.push($('#tigname').val()+"::"+$('#tisurname').val()+"::"+$('#tipassno').val()+"::"+$('#tiissuedfrom').val()+"::"+rows[i].vupto+"::"+$('#tifdest').val()+"::"+$('#titdest').val()+"::"+rows[i].date+"::"+rows[i].ptype+"::"+$('#tiremk').val()+"::"+rows[i].rowno);
   			}
   //alert(gridarray)
   }
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					document.getElementById("jqxClienttt").value="";
					document.getElementById("txtclienttt").value="";
					document.getElementById("txtemailtt").value="";
					document.getElementById("txtmobtt").value=""; 
					if($("#txtrdocno").val()==''){         
						 $("#ticketGrid").jqxGrid('clear');   
						 $("#ticketGrid").jqxGrid('addrow', null, {});   
					}
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'
					});
				}
			}
			else   
			{
			}    
		}
		x.open("GET","saveticketData.jsp?gridarray="+gridarray+"&rdocno="+rdocno+"&brhid="+branchid+"&edate="+tdate+"&userid="+userid+"&clientid="+client+"&client="+refname+"&mob="+mobno+"&mail="+email+"&locid="+$('#cmblocation').val()+"&type="+clienttype,true);
		x.send();                       
}  
	
	/* hotelgrid  */
	function funHotelgrid()
		{
			var rows = $('#hotelGrid').jqxGrid('getrows');
			var rowlength= rows.length;
			 $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "guestname", document.getElementById("hgname").value);
		     $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "rtype", document.getElementById("jqxRoomtype").value);
		     $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "rtypeid", document.getElementById("roomtypeid").value);
		     $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "package", document.getElementById("jqxPackagetype").value);
			 $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "packageid", document.getElementById("hpackageid").value);
			 $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "fromdate", document.getElementById("hfdest").value);
			 $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "todate", document.getElementById("htdest").value);
			 $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "remarks", document.getElementById("hremarks").value);
			  $('#hotelGrid').jqxGrid('setcellvalue',  rowlength-1, "attach", "Attach");
		    
				   document.getElementById("hgname").value ="";
				   document.getElementById("jqxRoomtype").value="";
				   document.getElementById("roomtypeid").value="";
				   document.getElementById("jqxPackagetype").value="";
				   document.getElementById("hpackageid").value=""; 
				   document.getElementById("hfdest").value=""; 
				   document.getElementById("htdest").value=""; 
		           document.getElementById("hremarks").value="";
				   $("#hotelGrid").jqxGrid('addrow', null, {});
				   document.getElementById("hgname").focus();
		 
		}
	
	function funhotelSave(){
		if (document.getElementById('hlrsumm').checked){   
			   var refname=document.getElementById("jqxClienthl").value;
	       }   
		     else if (document.getElementById('hlrdet').checked){         
		    	 var refname=document.getElementById("txtclienthl").value;
		      }   
		   var clienttype=document.getElementById("clienttypehl").value;       
		   var email=document.getElementById("txtemailhl").value;
		   var mobno=document.getElementById("txtmobhl").value;
		   var client=document.getElementById("hidclienthl").value;
		   var tdate=$('#hldate').jqxDateTimeInput('val');   
		   var userid="<%= session.getAttribute("USERID").toString() %>";
		   var branchid=$('#cmbbranch').val();      
		
	var rdocno=document.getElementById("txtrdocno").value;
    var gridarray=new Array();
    var rows=$('#hotelGrid').jqxGrid('getrows')
	for(var i=0;i<rows.length;i++){
    var chk=$('#hotelGrid').jqxGrid('getcellvalue',i,'guestname');
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		    
		    $('#hguest').val(rows[i].guestname);
				if (($(hguest).val()).includes('$')) { $(hguest).val($(hguest).val().replace(/$/g, ''));};if (($(hguest).val()).includes('%')) { $(hguest).val($(hguest).val().replace(/%/g, ''));};
		    	if (($(hguest).val()).includes('!')) { $(hguest).val($(hguest).val().replace(/!/g, ''));};if (($(hguest).val()).includes('@')) { $(hguest).val($(hguest).val().replace(/@/g, ''));};
		    	if (($(hguest).val()).includes('#')) { $(hguest).val($(hguest).val().replace(/#/g, ''));};if (($(hguest).val()).includes('&')) { $(hguest).val($(hguest).val().replace(/&/g, ''));};
		    	if (($(hguest).val()).includes('^')) { $(hguest).val($(hguest).val().replace(/^/g, ''));};if (($(hguest).val()).includes('`')) { $(hguest).val($(hguest).val().replace(/`/g, ''));};
		    	if (($(hguest).val()).includes('~')) { $(hguest).val($(hguest).val().replace(/~/g, ''));};if ($(hguest).val().indexOf('\'')  >= 0 ) { $(hguest).val($(hguest).val().replace(/'/g, ''));};
		    	if (($(hguest).val()).includes(',')) { $(hguest).val($(hguest).val().replace(/,/g, ''));}
		    
		     $('#hremk').val(rows[i].remarks);
				if (($(hremk).val()).includes('$')) { $(hremk).val($(hremk).val().replace(/$/g, ''));};if (($(hremk).val()).includes('%')) { $(hremk).val($(hremk).val().replace(/%/g, ''));};
		    	if (($(hremk).val()).includes('!')) { $(hremk).val($(hremk).val().replace(/!/g, ''));};if (($(hremk).val()).includes('@')) { $(hremk).val($(hremk).val().replace(/@/g, ''));};
		    	if (($(hremk).val()).includes('#')) { $(hremk).val($(hremk).val().replace(/#/g, ''));};if (($(hremk).val()).includes('&')) { $(hremk).val($(hremk).val().replace(/&/g, ''));};
		    	if (($(hremk).val()).includes('^')) { $(hremk).val($(hremk).val().replace(/^/g, ''));};if (($(hremk).val()).includes('`')) { $(hremk).val($(hremk).val().replace(/`/g, ''));};
		    	if (($(hremk).val()).includes('~')) { $(hremk).val($(hremk).val().replace(/~/g, ''));};if ($(hremk).val().indexOf('\'')  >= 0 ) { $(hremk).val($(hremk).val().replace(/'/g, ''));};
		    	if (($(hremk).val()).includes(',')) { $(hremk).val($(hremk).val().replace(/,/g, ''));}
		    
		    
		    
		    gridarray.push($('#hguest').val()+"::"+rows[i].rtypeid+"::"+rows[i].packageid+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+$('#hremk').val()+"::"+rows[i].rowno);
   			}
   //alert(gridarray)
   }
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					document.getElementById("jqxClienthl").value="";
					document.getElementById("txtclienthl").value="";
					document.getElementById("txtemailhl").value="";
					document.getElementById("txtmobhl").value=""; 
					if($("#txtrdocno").val()==''){                     
						 $("#hotelGrid").jqxGrid('clear');           
						 $("#hotelGrid").jqxGrid('addrow', null, {});   
					}
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'
					});
				}
			}
			else
			{
			}    
		}
		x.open("GET","savehotelData.jsp?gridarray="+gridarray+"&rdocno="+rdocno+"&brhid="+branchid+"&edate="+tdate+"&userid="+userid+"&clientid="+client+"&client="+refname+"&mob="+mobno+"&mail="+email+"&locid="+$('#cmblocation').val()+"&type="+clienttype,true);
		x.send();
}
	
	/* Transfergrid */
	
	function setTransferGrid(){
	
		var rows = $('#transferGrid').jqxGrid('getrows');
			var rowlength= rows.length;
			 $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "guestname", document.getElementById("trname").value);
		     $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "fromdest", document.getElementById("fromdest").value);
		     $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "todest", document.getElementById("todest").value);
		     $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "vehicle", document.getElementById("vehicle").value);
			 $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "noofpax", document.getElementById("noofpax").value);
			 $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "date", document.getElementById("transferdate").value);
			 $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "time", document.getElementById("transfertime").value);
			 $('#transferGrid').jqxGrid('setcellvalue',  rowlength-1, "remarks", document.getElementById("trremarks").value);
		    
				   document.getElementById("trname").value ="";
				   document.getElementById("fromdest").value="";
				   document.getElementById("todest").value="";
				   document.getElementById("vehicle").value="";
				   document.getElementById("noofpax").value=""; 
		           document.getElementById("trremarks").value="";
				   $("#transferGrid").jqxGrid('addrow', null, {});
				   document.getElementById("trname").focus();
	}
	
	//saving
	
	function funtransferSave(){
		if (document.getElementById('tfrsumm').checked){   
			   var refname=document.getElementById("jqxClienttf").value;
	       }   
		     else if (document.getElementById('tfrdet').checked){       
		    	 var refname=document.getElementById("txtclienttf").value;
		      }      
		   var clienttype=document.getElementById("clienttypetf").value;       
		   var email=document.getElementById("txtemailtf").value;
		   var mobno=document.getElementById("txtmobtf").value;
		   var client=document.getElementById("hidclienttf").value;
		   var tdate=$('#tfdate').jqxDateTimeInput('val');
		   var userid="<%= session.getAttribute("USERID").toString() %>";
		   var branchid=$('#cmbbranch').val();         
	var rdocno=document.getElementById("txtrdocno").value;
    var gridarray=new Array();
    var rows=$('#transferGrid').jqxGrid('getrows')
	for(var i=0;i<rows.length;i++){
    var chk=$('#transferGrid').jqxGrid('getcellvalue',i,'guestname');
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		     $('#trguest').val(rows[i].guestname);
				if (($(trguest).val()).includes('$')) { $(trguest).val($(trguest).val().replace(/$/g, ''));};if (($(trguest).val()).includes('%')) { $(trguest).val($(trguest).val().replace(/%/g, ''));};
		    	if (($(trguest).val()).includes('!')) { $(trguest).val($(trguest).val().replace(/!/g, ''));};if (($(trguest).val()).includes('@')) { $(trguest).val($(trguest).val().replace(/@/g, ''));};
		    	if (($(trguest).val()).includes('#')) { $(trguest).val($(trguest).val().replace(/#/g, ''));};if (($(trguest).val()).includes('&')) { $(trguest).val($(trguest).val().replace(/&/g, ''));};
		    	if (($(trguest).val()).includes('^')) { $(trguest).val($(trguest).val().replace(/^/g, ''));};if (($(trguest).val()).includes('`')) { $(trguest).val($(trguest).val().replace(/`/g, ''));};
		    	if (($(trguest).val()).includes('~')) { $(trguest).val($(trguest).val().replace(/~/g, ''));};if ($(trguest).val().indexOf('\'')  >= 0 ) { $(trguest).val($(trguest).val().replace(/'/g, ''));};
		    	if (($(trguest).val()).includes(',')) { $(trguest).val($(trguest).val().replace(/,/g, ''));}
		    
		    $('#trfdest').val(rows[i].fromdest);
				if (($(trfdest).val()).includes('$')) { $(trfdest).val($(trfdest).val().replace(/$/g, ''));};if (($(trfdest).val()).includes('%')) { $(trfdest).val($(trfdest).val().replace(/%/g, ''));};
		    	if (($(trfdest).val()).includes('!')) { $(trfdest).val($(trfdest).val().replace(/!/g, ''));};if (($(trfdest).val()).includes('@')) { $(trfdest).val($(trfdest).val().replace(/@/g, ''));};
		    	if (($(trfdest).val()).includes('#')) { $(trfdest).val($(trfdest).val().replace(/#/g, ''));};if (($(trfdest).val()).includes('&')) { $(trfdest).val($(trfdest).val().replace(/&/g, ''));};
		    	if (($(trfdest).val()).includes('^')) { $(trfdest).val($(trfdest).val().replace(/^/g, ''));};if (($(trfdest).val()).includes('`')) { $(trfdest).val($(trfdest).val().replace(/`/g, ''));};
		    	if (($(trfdest).val()).includes('~')) { $(trfdest).val($(trfdest).val().replace(/~/g, ''));};if ($(trfdest).val().indexOf('\'')  >= 0 ) { $(trfdest).val($(trfdest).val().replace(/'/g, ''));};
		    	if (($(trfdest).val()).includes(',')) { $(trfdest).val($(trfdest).val().replace(/,/g, ''));}
		    	
		    $('#trtdest').val(rows[i].todest);
				if (($(trtdest).val()).includes('$')) { $(trtdest).val($(trtdest).val().replace(/$/g, ''));};if (($(trtdest).val()).includes('%')) { $(trtdest).val($(trtdest).val().replace(/%/g, ''));};
		    	if (($(trtdest).val()).includes('!')) { $(trtdest).val($(trtdest).val().replace(/!/g, ''));};if (($(trtdest).val()).includes('@')) { $(trtdest).val($(trtdest).val().replace(/@/g, ''));};
		    	if (($(trtdest).val()).includes('#')) { $(trtdest).val($(trtdest).val().replace(/#/g, ''));};if (($(trtdest).val()).includes('&')) { $(trtdest).val($(trtdest).val().replace(/&/g, ''));};
		    	if (($(trtdest).val()).includes('^')) { $(trtdest).val($(trtdest).val().replace(/^/g, ''));};if (($(trtdest).val()).includes('`')) { $(trtdest).val($(trtdest).val().replace(/`/g, ''));};
		    	if (($(trtdest).val()).includes('~')) { $(trtdest).val($(trtdest).val().replace(/~/g, ''));};if ($(trtdest).val().indexOf('\'')  >= 0 ) { $(trtdest).val($(trtdest).val().replace(/'/g, ''));};
		    	if (($(trtdest).val()).includes(',')) { $(trtdest).val($(trtdest).val().replace(/,/g, ''));}
		    
		     $('#trveh').val(rows[i].vehicle);
				if (($(trveh).val()).includes('$')) { $(trveh).val($(trveh).val().replace(/$/g, ''));};if (($(trveh).val()).includes('%')) { $(trveh).val($(trveh).val().replace(/%/g, ''));};
		    	if (($(trveh).val()).includes('!')) { $(trveh).val($(trveh).val().replace(/!/g, ''));};if (($(trveh).val()).includes('@')) { $(trveh).val($(trveh).val().replace(/@/g, ''));};
		    	if (($(trveh).val()).includes('#')) { $(trveh).val($(trveh).val().replace(/#/g, ''));};if (($(trveh).val()).includes('&')) { $(trveh).val($(trveh).val().replace(/&/g, ''));};
		    	if (($(trveh).val()).includes('^')) { $(trveh).val($(trveh).val().replace(/^/g, ''));};if (($(trveh).val()).includes('`')) { $(trveh).val($(trveh).val().replace(/`/g, ''));};
		    	if (($(trveh).val()).includes('~')) { $(trveh).val($(trveh).val().replace(/~/g, ''));};if ($(trveh).val().indexOf('\'')  >= 0 ) { $(trveh).val($(trveh).val().replace(/'/g, ''));};
		    	if (($(trveh).val()).includes(',')) { $(trveh).val($(trveh).val().replace(/,/g, ''));}	
		    	
		     $('#trremk').val(rows[i].remarks);
				if (($(trremk).val()).includes('$')) { $(trremk).val($(trremk).val().replace(/$/g, ''));};if (($(trremk).val()).includes('%')) { $(trremk).val($(trremk).val().replace(/%/g, ''));};
		    	if (($(trremk).val()).includes('!')) { $(trremk).val($(trremk).val().replace(/!/g, ''));};if (($(trremk).val()).includes('@')) { $(trremk).val($(trremk).val().replace(/@/g, ''));};
		    	if (($(trremk).val()).includes('#')) { $(trremk).val($(trremk).val().replace(/#/g, ''));};if (($(trremk).val()).includes('&')) { $(trremk).val($(trremk).val().replace(/&/g, ''));};
		    	if (($(trremk).val()).includes('^')) { $(trremk).val($(trremk).val().replace(/^/g, ''));};if (($(trremk).val()).includes('`')) { $(trremk).val($(trremk).val().replace(/`/g, ''));};
		    	if (($(trremk).val()).includes('~')) { $(trremk).val($(trremk).val().replace(/~/g, ''));};if ($(trremk).val().indexOf('\'')  >= 0 ) { $(trremk).val($(trremk).val().replace(/'/g, ''));};
		    	if (($(trremk).val()).includes(',')) { $(trremk).val($(trremk).val().replace(/,/g, ''));}
		    
		    gridarray.push($('#trguest').val()+"::"+$('#trfdest').val()+"::"+$('#trtdest').val()+"::"+$('#trveh').val()+"::"+rows[i].noofpax+"::"+rows[i].date+"::"+rows[i].time+"::"+$('#trremk').val()+"::"+rows[i].rowno);
   			}
   //alert(gridarray)
   }  
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					document.getElementById("jqxClienttf").value="";
					document.getElementById("txtclienttf").value="";
					document.getElementById("txtemailtf").value="";   
					document.getElementById("txtmobtf").value="";         
					if($("#txtrdocno").val()==''){                          
						 $("#transferGrid").jqxGrid('clear');     
						 $("#transferGrid").jqxGrid('addrow', null, {});   
					}  
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'
					});
				}
			}
			else
			{
			}    
		}
		x.open("GET","savetransferData.jsp?gridarray="+gridarray+"&rdocno="+rdocno+"&brhid="+branchid+"&edate="+tdate+"&userid="+userid+"&clientid="+client+"&client="+refname+"&mob="+mobno+"&mail="+email+"&locid="+$('#cmblocation').val()+"&type="+clienttype,true);
		x.send();    
}

	/* Transfergrid ends*/
	
	/* Tourgrid */
function setTourGrid(){    
	    var transporttr1=document.getElementById("transporttr").value;     
		if($('#ttypeid').val()==''){  
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select Tour'
			});
			return 0;
		 }                        
		if($('#tourismconfig').val()!=1){                   
		  if($('#vndid').val()==''){     
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select Vendor'
			 });
			 return 0;
		   }    
		 }  

		if($('#cmbtourtransferchoose').val()=="1"){            
			if(parseInt(transporttr1)!=1){ 
				if($('#cmbtourtransfergroup').val()==''){     
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select group'
					});
					return 0;
				 }
		if($('#cmbtourtransfertype').val()==''){          
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select transfer type'
					});
					return 0;
				 }
		if($('#dropofflocid').val()==''){     
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select drop off location'   
				});
				return 0;
			 }
			}
			if($('#cmbtourtransferloctype').val()==''){     
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select location type' 
				});
				return 0;
			 }
			if($('#tourtransferlocrefname').val()==''){     
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select Hotel Name'  
				});
				return 0;
			 }
			
			if($('#tourtransferlocrefno').val()==''){     
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select Room No'
				});
				return 0;
			 }
			
			if($('#pickuplocid').val()==''){     
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select pickup location'
				});
				return 0;
			 }
			
		}
		if($('#child').val()=="0" && $('#adult').val()=="0"){          
			swal({      
				type: 'warning',
				title: 'Warning',
				text: 'Please enter adult/child count'      
			});
			return 0;       
		}
		  var vendorid=$('#tourGrid').jqxGrid('getcellvalue',  0, "vndid");
	      //alert($('#vndid').val()+"===vendorid=="+vendorid);                         
		  if($('#tourismconfig').val()!=1){   
		    if(typeof(vendorid) != "undefined" && typeof(vendorid) != "NaN" && vendorid != ""){       
				if(parseInt(vendorid)!=parseInt($('#vndid').val())){   
				swal({      
					type: 'warning',
					title: 'Warning',
					text: 'Vendor should be same as first given!!!'        
				});
				 return 0;  
				 } 
			   }   
		    }
		/*    var lammacheck=0;   
		    var vndid1=$('#vndid').val();
           if($('#tourismconfig').val()==1){
	           var rows1=$('#tourGrid').jqxGrid('getrows')
		       for(var i=0;i<rows1.length;i++){
	                 var vendorid1=$('#tourGrid').jqxGrid('getcellvalue',i,'vndid');
                     if(typeof(vendorid1) != "undefined" && typeof(vendorid1) != "NaN" && vndid1!=""){              
						if(parseInt(vendorid1)!=parseInt(vndid1)){      
							lammacheck=1;   
						 } 
				    }
			    }
		    }
		    if(lammacheck==1){  
		                 swal({      
								type: 'warning',
								title: 'Warning',
								text: 'Vendor should be same as first given!!!'               
							});
							$('#jqxvendor').val(''); 
							$('#vndid').val(''); 
							document.getElementById("jqxvendor").focus();        
							return 0;                    
		    }  */
			var discounttype=document.getElementById("cmbtourdiscounttype").value;
			var discountchild=document.getElementById("tourdiscountchild").value;
			var discountadult=document.getElementById("tourdiscountadult").value;
		    var child=document.getElementById("child").value;   
		    var adult=document.getElementById("adult").value;
		    var spchild=document.getElementById("spchild").value;
			var spadult=document.getElementById("spadult").value;
			var adultval=document.getElementById("adultval").value;
			var childval=document.getElementById("childval").value;     
			var stdtotal=(child*childval)+(adult*adultval);                              
			var tourdocno=document.getElementById("tourdocno").value; 
			var total=document.getElementById("tourtotal").value;    
			var rows = $('#tourGrid').jqxGrid('getrows');   
			var rowlength= rows.length;
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "stockid", document.getElementById("stockid").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "stocktype", document.getElementById("stocktype").value);             
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tourname", document.getElementById("jqxTourtype").value);
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tourid", document.getElementById("ttypeid").value);
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "vendor", document.getElementById("jqxvendor").value);
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "vndid", document.getElementById("vndid").value);
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "infant",  document.getElementById("infant").value);    
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "adult", adult);         
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "child", child);     
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "adultdis", discountadult);         
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "childdis", discountchild);       
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "date", $('#tourdate').jqxDateTimeInput('getDate'));
		     $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "time", document.getElementById("tourtime").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "remarks", document.getElementById("tremarks").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "adultval", adultval);  
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "spadult", spadult);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "childval", childval);      
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "spchild", spchild);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "total", total);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "stdtotal", stdtotal);      
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tourdocno", tourdocno); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "distype", discounttype);    
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "transferid", document.getElementById("cmbtourtransferchoose").value);       
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "groupid", document.getElementById("cmbtourtransfergroup").value);                      
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "transfertype", document.getElementById("cmbtourtransfertype").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("tourtransferqty").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "loctype", document.getElementById("cmbtourtransferloctype").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rname", document.getElementById("tourtransferlocrefname").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "refno", document.getElementById("tourtransferlocrefno").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "plocid", document.getElementById("pickuplocid").value);   
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "ploctime", document.getElementById("tourtransferpickuptime").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "dlocid", document.getElementById("dropofflocid").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rtripid", document.getElementById("cmbtourtransferroundtrip").value);      
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tvltotal", document.getElementById("tourtransfertotal").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rndplocid", document.getElementById("roundpickuplocid").value);        
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rndploctime", document.getElementById("tourtransferroundpickuptime").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rnddlocid", document.getElementById("rounddropofflocid").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdetaildocno", document.getElementById("tarifdetaildocno").value);   
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "estdistance", document.getElementById("estdistance").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "esttime", document.getElementById("esttime").value); 
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "exdistancerate", document.getElementById("exdistancerate").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "extimerate", document.getElementById("extimerate").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tourtransferrate", document.getElementById("tourtransferrate").value);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tourtransferratetot", document.getElementById("tourtransferratetot").value);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rttarifdetaildocno", document.getElementById("roundtarifdetaildocno").value);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rtestdistance", document.getElementById("roundestdistance").value);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rtesttime", document.getElementById("roundesttime").value);	
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rtexdistancerate", document.getElementById("roundexdistancerate").value);  
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rtextimerate", document.getElementById("roundextimerate").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rttourtransferrate", document.getElementById("roundtourtransferrate").value);
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "tarifdocno", document.getElementById("tarifdocno").value);      
			 $('#tourGrid').jqxGrid('setcellvalue',  rowlength-1, "rttarifdocno", document.getElementById("roundtarifdocno").value);
		     $("#tourGrid").jqxGrid('addrow', null, {});
		       document.getElementById("jqxTourtype").focus(); 
		       document.getElementById("dropoffloc").value="";       
		       document.getElementById("pickuploc").value=""; 
			   document.getElementById("tourdiscountchild").value=""; 
			   document.getElementById("tourdiscountadult").value=""; 
			   document.getElementById("tourtotal").value=""; 
			   document.getElementById("roundesttime").value =""; 
		       document.getElementById("roundexdistancerate").value =""; 
		       document.getElementById("roundextimerate").value ="";    
		       document.getElementById("roundtourtransferrate").value =""; 
		       document.getElementById("tarifdocno").value =""; 
		       document.getElementById("roundtarifdocno").value =""; 
		       document.getElementById("cmbtourdiscounttype").value =""; 
		       document.getElementById("cmbtourtransferchoose").value =""; 
		       document.getElementById("cmbtourtransfergroup").value =""; 
		       document.getElementById("cmbtourtransfertype").value =""; 
		       document.getElementById("tourtransferqty").value =""; 
		       document.getElementById("cmbtourtransferloctype").value ="";       
		       document.getElementById("tourtransferlocrefname").value =""; 
		       document.getElementById("tourtransferlocrefno").value =""; 
		       document.getElementById("pickuplocid").value =""; 
		       document.getElementById("jqxPickupLoc").value =""; 
		       document.getElementById("jqxroundDropoffLoc").value ="";
		       document.getElementById("jqxroundPickupLoc").value ="";
		       document.getElementById("jqxDropoffLoc").value ="";
		       document.getElementById("dropofflocid").value =""; 
		       document.getElementById("cmbtourtransferroundtrip").value =""; 
		       document.getElementById("tourtransfertotal").value =""; 
		       document.getElementById("roundpickuplocid").value =""; 
		       document.getElementById("rounddropofflocid").value =""; 
		       document.getElementById("tarifdetaildocno").value =""; 
		       document.getElementById("estdistance").value =""; 
		       document.getElementById("esttime").value =""; 
		       document.getElementById("exdistancerate").value =""; 
		       document.getElementById("extimerate").value =""; 
		       document.getElementById("tourtransferrate").value =""; 
		       document.getElementById("tourtransferratetot").value =""; 
		       document.getElementById("roundtarifdetaildocno").value =""; 
		       document.getElementById("roundestdistance").value ="";
		       document.getElementById("tourdocno").value ="";        
		       document.getElementById("jqxTourtype").value =""; 
			   document.getElementById("ttypeid").value="";
		       document.getElementById("jqxvendor").value ="";
			   document.getElementById("vndid").value="";         
			   document.getElementById("adultval").value=""; 
			   document.getElementById("spadult").value=""; 
			   document.getElementById("childval").value=""; 
			   document.getElementById("spchild").value="";
			   document.getElementById("adult").value="";       
			   document.getElementById("child").value=""; 
			   document.getElementById("infant").value=""; 
		       document.getElementById("tremarks").value=""; 
		       document.getElementById("stocktype").value="";   
		       $('#tourdate').val(new Date());  
		       $('#tourtime').val(new Date());
		       //$('#tourtransferpickuptime').val(new Date());
		       //$('#tourtransferroundpickuptime').val(new Date());
	}
	//saving         
	function funtourSave(){
		        var refname="",client="",guestname="";      
	            var servocno=document.getElementById("hidvocno").value;   
			   if (document.getElementById('trrsumm').checked){     
				    refname=document.getElementById("jqxClienttr").value;
				    guestname=document.getElementById("guesttr").value;    
		          }   
			    else if (document.getElementById('trrdet').checked){       
			    	  refname=document.getElementById("txtclienttr").value;
			      }
		   	   var clienttype=document.getElementById("clienttypetr").value; 
			   var email=document.getElementById("txtemailtr").value;
			   var nationid=document.getElementById("nationidtr").value;
			   var mobno=document.getElementById("txtmobtr").value; 
			   if($('#txtrdocno').val()==''){               
				   client=document.getElementById("hidclienttr").value;  
			   }else{
			      client=document.getElementById("hidcldocno").value;
	           }      
			   var limodocno=document.getElementById("limodocno").value; 
			   var agentid=document.getElementById("agentid").value;    
			   var salesagentdocno=document.getElementById("salesagentdocno").value; 
			   var salesagentacno=document.getElementById("salesagentacno").value; 
			   var tdate=$('#trdate').jqxDateTimeInput('val');
			   var userid="<%= session.getAttribute("USERID").toString() %>";   
			   var branchid=$('#cmbbranch').val();  
			   var locid=$('#cmblocation').val(); 
			   var rdocno=document.getElementById("txtrdocno").value;     
			   var gridarray=new Array();
			   var rows=$('#tourGrid').jqxGrid('getrows');
			   for(var i=0;i<rows.length;i++){
			    var chk=$('#tourGrid').jqxGrid('getcellvalue',i,'tourid');
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						 $('#tourremk').val(rows[i].remarks);  
						 if (($(tourremk).val()).includes('$')) { $(tourremk).val($(tourremk).val().replace(/$/g, ''));};if (($(tourremk).val()).includes('%')) { $(tourremk).val($(tourremk).val().replace(/%/g, ''));};
						 if (($(tourremk).val()).includes('^')) { $(tourremk).val($(tourremk).val().replace(/^/g, ''));};if (($(tourremk).val()).includes('`')) { $(tourremk).val($(tourremk).val().replace(/`/g, ''));};
						 if (($(tourremk).val()).includes('~')) { $(tourremk).val($(tourremk).val().replace(/~/g, ''));};if ($(tourremk).val().indexOf('\'')  >= 0 ) { $(tourremk).val($(tourremk).val().replace(/'/g, ''));};
						 if (($(tourremk).val()).includes(',')) { $(tourremk).val($(tourremk).val().replace(/,/g, ''));}
						 gridarray.push(rows[i].tourid+"::"+rows[i].date+"::"+$('#tourremk').val()+"::"+rows[i].vndid+"::"+rows[i].rowno
								+"::"+rows[i].adult+"::"+rows[i].child+"::"+rows[i].spadult+"::"+rows[i].spchild+"::"+rows[i].adultval+"::"+rows[i].childval+"::"+rows[i].total+"::"+rows[i].time+"::"+rows[i].adultdis+"::"+rows[i].childdis+":: "+rows[i].distype+":: "+rows[i].tourdocno+":: "+rows[i].infant+":: "+rows[i].stdtotal
								+":: "+rows[i].transferid+":: "+rows[i].groupid+":: "+rows[i].transfertype+":: "+rows[i].qty+":: "+rows[i].loctype
								+":: "+rows[i].rname+":: "+rows[i].refno+":: "+rows[i].plocid+":: "+rows[i].ploctime+":: "+rows[i].dlocid+":: "+rows[i].rtripid
								+":: "+rows[i].tvltotal+":: "+rows[i].rndplocid+":: "+rows[i].rndploctime+":: "+rows[i].rnddlocid+":: "+rows[i].tarifdetaildocno
								+":: "+rows[i].estdistance+":: "+rows[i].esttime+":: "+rows[i].exdistancerate+":: "+rows[i].extimerate+":: "+rows[i].tourtransferrate
								+":: "+rows[i].tourtransferratetot+":: "+rows[i].rttarifdetaildocno+":: "+rows[i].rtestdistance+":: "+rows[i].rtesttime
								+":: "+rows[i].rtexdistancerate+":: "+rows[i].rtextimerate+":: "+rows[i].rttourtransferrate+":: "+rows[i].tarifdocno+":: "+rows[i].roundtarifdocno+":: "+rows[i].rowdelete+":: "+rows[i].stocktype+":: "+rows[i].stockid);                                           
				   }    
   }  
   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){  
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split('###');
				if(items[0]=="0"){
					swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Updated'
					});
					   document.getElementById("jqxSalesmantr").value="";       
       				   document.getElementById("salesmanidtr").value=""; 
					   document.getElementById("txtrdocno").value=items[1];         
	                   document.getElementById("hidcldocno").value=client;   
	                   document.getElementById("hidtype").value="Service Request";  
	                   if(servocno==''){       
	                      document.getElementById("hidvocno").value=items[2]; 
	                      servocno=items[2];  
	                   }
	                   if(refname==''){       
	                	   refname=items[3];      
	                   }
	                   document.getElementById("txtrefname").value=refname;   
	                   $('.textpanel p').text('Doc No '+servocno+' - '+refname);    
	                   $('.textclient p').text(''+servocno+' - '+refname);
	                   $('.textclient').show();
	                   $('.newclientinfo').hide();
	                   $('.comments-container').html('');
	                   $('#jqxsalesagent').attr('disabled', true);            
	                   document.getElementById("salesagent").value=0;        
	          		   document.getElementById('salesagent').checked=false;    
	          		   funreloadtourgrid();            
	          		   $('#trnext2').attr('disabled', false);    
				}
				else{
					swal({ 
						type: 'error',
						title: 'Error',
						text: 'Not Updated'
					});
				}
			}   
			else  
			{     
			}           
		}
		x.open("GET","savetourData.jsp?gridarray="+encodeURIComponent(gridarray)+"&guest="+encodeURIComponent(guestname)+"&limodocno="+limodocno+"&rdocno="+rdocno+"&brhid="+branchid+"&edate="+$('#trdate').jqxDateTimeInput('val')+"&userid="+userid+"&clientid="+client+"&client="+encodeURIComponent(refname)+"&mob="+mobno+"&mail="+email+"&locid="+locid+"&type="+clienttype+"&nationid="+nationid+"&sadocno="+salesagentdocno+"&sacno="+salesagentacno+"&salid="+$('#salesmanidtr').val()+"&vocno="+$('#hidvocno').val()+"&agentid="+agentid,true);                    
		x.send();  
   }
	/* Tourgrid ends*/      
	function funsachange(){          
	     document.getElementById('salesagentdocno').value=""; 	  
	     document.getElementById('salesagentacno').value=""; 
	     document.getElementById('jqxsalesagent').value="";        
	     var salesagent=document.getElementById("salesagent").value;               
		 if(salesagent==1){
			 $('#jqxsalesagent').attr('disabled', false);    
		 }else{    
			 $('#jqxsalesagent').attr('disabled', true);     
		 }
	}
	function funagentchange(){                                  
	     var salesagent=document.getElementById("txtagentchk").value;                 
		 if(salesagent==1){     
			 $('#jqxAgentClienttr').attr('disabled', false);    
		 }else{     
			 $('#jqxAgentClienttr').attr('disabled', true);     
		 }
	}
	function funcheck(){  
		     document.getElementById('client').value="";
		     document.getElementById('txtclient').value="";
		     document.getElementById('txtmob').value="";
		     document.getElementById('txtemail').value=""; 
		     document.getElementById('jqxClient').value=""; 
			 if (document.getElementById('rsumm').checked) {   
					$('#jqxClient').attr('disabled', false);
					$('#txtclient').attr('disabled', true);
					 document.getElementById('clienttype').value="1";             
             }   
			 else if (document.getElementById('rdet').checked) {    
					$('#jqxClient').attr('disabled', true);
					$('#txtclient').attr('disabled', false);
					 document.getElementById('clienttype').value="2";     
			 } 
	}
	function funchecktour(){         
	     document.getElementById('clienttr').value="";
	     document.getElementById('txtclienttr').value="";
	     document.getElementById('txtmobtr').value="";
	     document.getElementById('txtemailtr').value=""; 
	     document.getElementById('jqxClienttr').value=""; 
	     document.getElementById('guesttr').value="";      
		 if (document.getElementById('trrsumm').checked) {   
				$('#jqxClienttr').attr('disabled', false);
				$('#txtclienttr').attr('disabled', true);
				document.getElementById('clienttypetr').value="1"; 
				$('#agenthide').hide();     
				$('#guesthide').show();
        }   
		 else if (document.getElementById('trrdet').checked) {       
				$('#jqxClienttr').attr('disabled', true);
				$('#txtclienttr').attr('disabled', false);
				document.getElementById('clienttypetr').value="2";
				$('#agenthide').show();  
				$('#guesthide').hide();   
		 } 
    }
	function funcheckvisa(){         
	     document.getElementById('clientva').value="";
	     document.getElementById('txtclientva').value="";
	     document.getElementById('txtmobva').value="";
	     document.getElementById('txtemailva').value=""; 
	     document.getElementById('jqxClientva').value=""; 
		 if (document.getElementById('varsumm').checked) {   
				$('#jqxClientva').attr('disabled', false);
				$('#txtclientva').attr('disabled', true);
				 document.getElementById('clienttypeva').value="1";           
       }   
		 else if (document.getElementById('vardet').checked) {       
				$('#jqxClientva').attr('disabled', true);
				$('#txtclientva').attr('disabled', false);
				 document.getElementById('clienttypeva').value="2";          
		 } 
    }
	function funcheckticket(){           
	     document.getElementById('clienttt').value="";
	     document.getElementById('txtclienttt').value="";
	     document.getElementById('txtmobtt').value="";
	     document.getElementById('txtemailtt').value="";  
	     document.getElementById('jqxClienttt').value=""; 
		 if (document.getElementById('ttrsumm').checked) {   
				$('#jqxClienttt').attr('disabled', false);
				$('#txtclienttt').attr('disabled', true);
				 document.getElementById('clienttypett').value="1";           
      }   
		 else if (document.getElementById('ttrdet').checked) {       
				$('#jqxClienttt').attr('disabled', true);
				$('#txtclienttt').attr('disabled', false);
				 document.getElementById('clienttypett').value="2";          
		 } 
   }
	function funcheckhotel(){           
	     document.getElementById('clienthl').value="";
	     document.getElementById('txtclienthl').value="";
	     document.getElementById('txtmobhl').value="";
	     document.getElementById('txtemailhl').value=""; 
	     document.getElementById('jqxClienthl').value=""; 
		 if (document.getElementById('hlrsumm').checked) {   
				$('#jqxClienthl').attr('disabled', false);
				$('#txtclienthl').attr('disabled', true);
				 document.getElementById('clienttypehl').value="1";           
     }   
		 else if (document.getElementById('hlrdet').checked) {       
				$('#jqxClienthl').attr('disabled', true);
				$('#txtclienthl').attr('disabled', false);
				 document.getElementById('clienttypehl').value="2";             
		 } 
  }
	function funchecktransfer(){                
	     document.getElementById('clienttf').value="";
	     document.getElementById('txtclienttf').value="";
	     document.getElementById('txtmobtf').value="";
	     document.getElementById('txtemailtf').value=""; 
	     document.getElementById('jqxClienttf').value=""; 
		 if (document.getElementById('tfrsumm').checked) {   
				$('#jqxClienttf').attr('disabled', false);
				$('#txtclienttf').attr('disabled', true);
				 document.getElementById('clienttypetf').value="1";           
    }   
		 else if (document.getElementById('tfrdet').checked) {       
				$('#jqxClienttf').attr('disabled', true);
				$('#txtclienttf').attr('disabled', false);
				 document.getElementById('clienttypetf').value="2";                 
		 } 
 }
	 
    function funchequedate(){
  	  paytype=document.getElementById("cmbpaytype").value; 
  	  if(paytype==3){
		      var chequedate = $('#jqxReferenceDate').jqxDateTimeInput('getDate');
			  var chequeDates =new Date(chequedate).setDate(chequedate.getDate());   
			  $('#jqxReferenceDate').jqxDateTimeInput('setDate', new Date(chequeDates)); 
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtrefno').attr('readonly', false);
			  $('#txtrefno').val('');
			  getCardTypes();
			  $('#txtdesc').val('');
  	  }
  	  else if(paytype==1){
  		  $('#cmbcardtype').attr('disabled', true); 
  		  $('#txtrefno').attr('readonly', true);
  		  $('#txtrefno').val('');
  		   getCardTypes();
  		   $('#txtdesc').val('');
  	  }
  	  else if(paytype==2){
  		  $('#cmbcardtype').attr('disabled', false); 
  		  $('#txtrefno').attr('readonly', false);
  		  $('#txtrefno').val('');
  		  getCardTypes();  
  		  $('#txtdesc').val('');
  	  }else if(paytype==4){          
  	      $('#cmbcardtype').attr('disabled', true); 
  		  $('#txtrefno').attr('readonly', true);
  		  $('#txtrefno').val('');
  		  $('#txtaccid').attr('readonly', true);
  		  $('#txtaccid').val('');
  		  $('#txtaccname').attr('readonly', true);
  		  $('#txtaccname').val('');   
  		  $('#txtdocno').val('');  
  		  $('#txtdesc').val('');                                                                       
  	  }
  }
	 function getAccounts(a){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var accountIdItems  = items[0];
	  				var accountItems = items[1];
	  				var docNoItems = items[2];
	  			$('#txtaccid').val(accountIdItems) ;
	  			$('#txtaccname').val(accountItems) ;
	  			$('#txtdocno').val(docNoItems) ;
	  		}
	  		}
	  		x.open("GET", "getAccounts.jsp?paytype="+a, true);
	  		x.send();
	 }
	 function funclearchequecardno(){
	    	$('#txtrefno').val('');
	    }
	 function funcardvalidation(){
 		 if($("#cmbpaytype").val()=='2'){
 			if(window.parent.cardnumbervalidator.value==1){
	            cardnumber($("#txtrefno").val());
  	    	}
 		 }
 	}
 	 function getPayType() {
	  				var optionscard  ='<option value="">--Select--</option>';
			            optionscard +='<option value="1">Cash</option>';
			            optionscard +='<option value="2">Card</option>';
			            optionscard +='<option value="3">Cheque/Online</option>';
			            if($('#tourismconfig').val()==1){
			            optionscard +='<option value="4">Direct payment</option>';
	  				    }
	  				$("select#cmbpaytype").html(optionscard);
	  } 
	 function getCardTypes() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var cardIdItems  = items[0].split(",");
	  				var cardItems = items[1].split(",");
	  				var optionscard = '<option value="">--Select--</option>';
	  				for (var i = 0; i < cardItems.length; i++) {
	  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
	  							+ cardItems[i] + '</option>';
	  				}
	  				$("select#cmbcardtype").html(optionscard);
	  				if ($('#hidcmbcardtype').val() != null) {
	  					$('#cmbcardtype').val($('#hidcmbcardtype').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getCardTypes.jsp", true);
	  		x.send();
	  }  
		function funload(){ 
			 $('#vendor').load('vendorsearch.jsp?tourid='+$('#ttypeid').val()+"&dates="+$('#tourdate').val());   	
		}
		
/* CREATE COMMERCIAL RECEIPT STARTS*/
        function funreceiptorjv(){
           var cmbpaytype=$('#cmbpaytype').val(); 
           if($('#tourismconfig').val()==1){         
           if(parseInt(cmbpaytype)==4){
               funDirectPayment();
            }else{
               funCreateReceipt();
            }    
           }else{
             funCreateReceipt();   
           }                
        }
		function funDirectPayment(){  
		    var brhid=$('#cmbbranch').val();      
		    var date=$('#crdate').jqxDateTimeInput('val');              
			var docno=$('#txtrdocno').val();  
			var txtdesc=$('#txtdesc').val();            
			var txtamount=$('#txtamount').val();
			var cldocno=$('#hidclienttr').val();  
			if(docno==''){  
				swal({
					type: 'warning',   
					title: 'Warning',       
					text: ' Please select a document '
				});
				 return 0;
			 }    
		   $.messager.confirm('Message', 'Do you want to create direct payment?', function(r){     
				     	if(r==false)
				     	  {
				     		return false; 
				     	  }  
				     	else {
				     		saveDPData(docno,txtdesc,txtamount,date,cldocno,brhid);              
				     	}  
				 });              
		}
	   function saveDPData(docno,txtdesc,txtamount,date,cldocno,brhid){                     
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;     
			   if(parseInt(items)>=1)
				{
				   swal({
						type: 'success',
						title: 'Success',  
						text: ' Successfully Created '
					});
					$('#txtdocno').val('');  
					$('#txtrefno').val(''); 
					$('#txtdesc').val('');            
					$('#txtamount').val('');   
					$('#txtaccid').val(''); 
					$('#txtaccname').val(''); 
					$('#cmbpaytype').val(''); 
					$('#cmbcardtype').val(''); 
					$('#jqxReferenceDate').val(new Date);  
					funchequedate();
					$(function () {   
						   $('#modalcommreceipt').modal('toggle');
						});
				}
				else
				{      
					swal({
						type: 'error',
						title: 'Error',  
						text: ' Not Created '
					});
				}
			}                 
			}   
			x.open("GET","createDP.jsp?date="+date+"&desc="+txtdesc+"&netamt="+txtamount+"&rdocno="+docno+"&cldocno="+cldocno+"&brhid="+brhid,true);                                     
			x.send();
		}      	
		function funCreateReceipt(){   
		    var date=$('#crdate').jqxDateTimeInput('val');              
			var docno=$('#txtrdocno').val();
			var cmbpaytype=$('#cmbpaytype').val(); 
			var brhid=$('#cmbbranch').val();     
			var locid=$('#cmblocation').val(); 
			var ReferenceDate=$('#jqxReferenceDate').jqxDateTimeInput('val');   
			var txtdocno=$('#txtdocno').val();  
			var cmbcardtype=$('#cmbcardtype').val();            
			var txtrefno=$('#txtrefno').val(); 
			var txtdesc=$('#txtdesc').val();            
			var txtamount=$('#txtamount').val(); 
			var refname=$('#refnametr').val();      
			if(docno==''){  
				swal({
					type: 'warning',   
					title: 'Warning',       
					text: ' Please select a document '
				});
				 return 0;
			 }  
			 if(cmbpaytype==''){    
				swal({
					type: 'warning',   
					title: 'Warning',       
					text: ' Please select a pay type '
				});
				 return 0;
			 }    
		   $.messager.confirm('Message', 'Do you want to create commercial receipt?', function(r){     
				     	if(r==false)
				     	  {
				     		return false; 
				     	  }  
				     	else {
				     		saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,locid,brhid,date,refname);          
				     	}  
				 });              
		}
		
		function saveReceiptData(cmbpaytype,ReferenceDate,txtdocno,cmbcardtype,txtrefno,txtdesc,txtamount,locid,brhid,date,refname){                   
			//alert("acgroup=="+acgroup);
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;     
			   if(parseInt(items)>=1)
				{
				   swal({
						type: 'success',
						title: 'Success',  
						text: ' Successfully Created '
					});
					$('#txtdocno').val('');  
					$('#txtrefno').val(''); 
					$('#txtdesc').val('');            
					$('#txtamount').val('');   
					$('#txtaccid').val(''); 
					$('#txtaccname').val(''); 
					$('#cmbpaytype').val(''); 
					$('#cmbcardtype').val(''); 
					$('#jqxReferenceDate').val(new Date);  
					funchequedate();
					$(function () {   
						   $('#modalcommreceipt').modal('toggle');
						});
				}
				else
				{      
					swal({
						type: 'error',
						title: 'Error',  
						text: ' Not Created '
					});
				}
			}                 
			}   
			x.open("GET","createCR.jsp?paytype="+cmbpaytype+"&date="+date+"&refdate="+ReferenceDate+"&acdocno="+txtdocno+"&cardtype="+cmbcardtype+"&refno="+txtrefno+"&desc="+txtdesc+"&netamt="+txtamount+"&rdocno="+$('#txtrdocno').val()+"&type="+$('#hidtype').val()+"&cldocno="+$('#hidcldocno').val()+"&locid="+locid+"&brhid="+brhid+"&refname="+encodeURIComponent(refname)+"&vocno="+$('#hidvocno').val(),true);                                      
			x.send();
		}    
/* CREATE COMMERCIAL RECEIPT ENDS*/
		
/* CREATE XO STARTS*/	  	
		  function funCreateXO(){   
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				var brhid=$('#cmbbranch').val();     
				if(docno==''){  
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;
				 }    
				var rows = $("#hotelGrid").jqxGrid('getrows');       
				   for(var i=0 ; i < rows.length ; i++){                  
					   gridarray3.push(rows[i].rowno);          
					   gridarray2.push(rows[i].vendorid);  
					   gridarray.push(0+" :: "+1+" :: "+(rows[i].hotelname+'-'+rows[i].location+'-'+rows[i].rtype+'-'+rows[i].fromdate+'-'+rows[i].todate)+" :: "+ rows[i].total +" :: "+rows[i].total+" :: "+0+" :: "+rows[i].total+" ::"+0+" :: "+0+" :: "+0+" :: "+rows[i].total+" :: ");
				   }   
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){     
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridData(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,brhid);      
					     	}  
					 });      
			}
			
			function saveGridData(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,brhid){     
				//alert("acgroup=="+acgroup);
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;     
				   if(parseInt(items)>=1)
					{
					   swal({
							type: 'success',
							title: 'Success',  
							text: ' Successfully Created '
						});
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',  
							text: ' Not Created '         
						});
					}
				}   
				}   
				x.open("GET","createXOhl.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2,true);                            
				x.send();
			}
	function funCreateXOtr(){ 
		          var temp=0; 
				  var rowno=$('#txtrdocno').val();
					if(rowno==''){    
						swal({
										type: 'warning',
										title: 'Warning',
										text: 'Please select a document'
							});
							return 0;			
					 }
				  var x=new XMLHttpRequest();   
				      x.onreadystatechange=function(){    
							if (x.readyState == 4 && x.status == 200) {
								items = x.responseText.trim().split('###'); 
								var cmode=items[2]; 
						        if(parseInt(items[0])==1 && $('#tourismconfig').val()!=1){         
						        	swal({
										type: 'warning',      
										title: 'Warning',
										text: 'Not approved!!'                 
									});
									 return 0;     
						        }
						      if($('#tourismconfig').val()==1){
						        if(parseInt(items[1])==2){                            
						         swal({
										type: 'warning',
										title: 'Warning',
										text: 'There is no vendor please update vendor'
									});
									 return 0;
						        }
						      }
						      if($('#tourismconfig').val()==1){
						          if(parseInt(items[1])==0){
						        	  funCreateCPUtraftervalidation(cmode);                  
						          }
						         }else{
						          if(parseInt(items[0])==0 && parseInt(items[1])==0){
						        	  funCreateXOtraftervalidation(cmode);                
						          }
						         }   
							}    
						else    
						{       
						}                            
					}
					x.open("GET","getDisapprConfirm.jsp?rdocno="+rowno,true);                           
					x.send(); 
			} 
			function funCreateXOtraftervalidation(cmode){  
			    var brhid=$('#cmbbranch').val();          
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				var total=0.0,vatamt=0.0,netamt=0.0,vatper=0.0;        
				var rows = $("#tourGrid").jqxGrid('getrows'); 
			 /*	for(var i=0 ; i < rows.length ; i++){       
					   var chks=rows[i].tourname;  
					   var stdtotal=rows[i].stdtotal;               
					   var taxtype=rows[i].tourtaxtype;   
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){         
					   gridarray3.push(rows[i].rowno);                                    
					   gridarray2.push(rows[i].vndid);
					   if(taxtype=="INCLUSIVE"){ 
						   vatper=5;
						   vatamt=parseFloat(stdtotal)-((parseFloat(stdtotal)/105)*100);    
						   total=parseFloat(stdtotal)-vatamt;
						   netamt=parseFloat(stdtotal);        
					   }else if(taxtype=="EXCLUSIVE"){
						   vatper=5;
						   vatamt=(parseFloat(stdtotal)*5)/100;    
						   total=parseFloat(stdtotal);
						   netamt=parseFloat(stdtotal)+vatamt; 
					   }else{
						   vatamt=0.0;    
						   total=parseFloat(stdtotal);  
						   netamt=parseFloat(stdtotal);     
					   }   
					   gridarray.push(0+" :: "+1+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" ::"+0+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: ");    
				 	   }
				 	}    */    
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){        
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridDatatr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,cmode,brhid);      
					     	}  
					 });      
			}   
			function saveGridDatatr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,cmode,brhid){     
				//alert("cmode=="+cmode);         
				var x=new XMLHttpRequest();  
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim().split('###');                  
				   if(parseInt(items[0])>=1)              
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'NPO -'+items[1]+'  Created Successfully'              
						});
					  // sendTypeContent('sendTypeWindow.jsp'); 
					  if(cmode==1){
					      funSendMail(items[2]);    
					  }else if(cmode==2){
					      funSendWhatsapp();
					  }else if(cmode==3){
					     funSendMailWhatsapp(items[2]);     
					  }else{}  
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created' 
						});
					}
				}   
				}   
				x.open("GET","createXOtr.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2+"&type="+$('#hidtype').val()+"&docno="+docno+"&brhid="+brhid,true);                                           
				x.send();
			} 
			function funCreateXOtt(){           
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();       
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				if(docno==''){ 
					swal({
						type: 'warning',
						title: 'Warning',   
						text: 'Please select a document'
					});
					 return 0;
				 }    
				var rows = $("#tourGrid").jqxGrid('getrows');       
				   for(var i=0 ; i < rows.length ; i++){ 
					   var chks=rows[i].tourname;       
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					   gridarray3.push(rows[i].rowno);             
					   gridarray2.push(rows[i].vndid);           
					   gridarray.push(0+" :: "+rows[i].pax+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ rows[i].value +" :: "+rows[i].value+" :: "+0+" :: "+rows[i].value+" ::"+0+" :: "+0+" :: "+0+" :: "+rows[i].value+" :: ");
				 	   }
				 	}   
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){       
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridDatatt(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3);      
					     	}  
					 });      
			}
			
			function saveGridDatatt(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3){     
				//alert("acgroup=="+acgroup);
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;     
				   if(parseInt(items)>=1)
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully Created'
						});
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'
						});
					}
				}   
				}       
				x.open("GET","createXOtt.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2,true);                            
				x.send();
			}
			function funCreateXOva(){        
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				if(docno==''){ 
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;
				 }    
				var rows = $("#tourGrid").jqxGrid('getrows');       
				   for(var i=0 ; i < rows.length ; i++){ 
					   var chks=rows[i].tourname;       
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					   gridarray3.push(rows[i].rowno);             
					   gridarray2.push(rows[i].vndid);           
					   gridarray.push(0+" :: "+rows[i].pax+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ rows[i].value +" :: "+rows[i].value+" :: "+0+" :: "+rows[i].value+" ::"+0+" :: "+0+" :: "+0+" :: "+rows[i].value+" :: ");
				 	   }
				 	}   
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){     
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridDatava(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3);      
					     	}  
					 });      
			}
			
			function saveGridDatava(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3){     
				//alert("acgroup=="+acgroup);
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;     
				   if(parseInt(items)>=1)
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully Created'
						});
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'
						});
					}
				}   
				}   
				x.open("GET","createXOva.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2,true);                            
				x.send();
			} 
			function funCreateXOsr(){        
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				if(docno==''){ 
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;  
				 }    
				var rows = $("#tourGrid").jqxGrid('getrows');       
				   for(var i=0 ; i < rows.length ; i++){ 
					   var chks=rows[i].tourname;       
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					   gridarray3.push(rows[i].rowno);             
					   gridarray2.push(rows[i].vndid);           
					   gridarray.push(0+" :: "+rows[i].pax+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ rows[i].value +" :: "+rows[i].value+" :: "+0+" :: "+rows[i].value+" ::"+0+" :: "+0+" :: "+0+" :: "+rows[i].value+" :: ");
				 	   }
				 	}   
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){     
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridDatasr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3);      
					     	}  
					 });      
			}
			
			function saveGridDatasr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3){     
				//alert("acgroup=="+acgroup);
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;     
				   if(parseInt(items)>=1)
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully Created'
						});
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'
						});
					}
				}   
				}   
				x.open("GET","createXOsr.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2,true);                            
				x.send();
			}
			function funCreateXOtf(){                            
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				if(docno==''){ 
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					 return 0;
				 }    
				var rows = $("#tourGrid").jqxGrid('getrows');       
				   for(var i=0 ; i < rows.length ; i++){ 
					   var chks=rows[i].tourname;       
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
					   gridarray3.push(rows[i].rowno);             
					   gridarray2.push(rows[i].vndid);           
					   gridarray.push(0+" :: "+rows[i].pax+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ rows[i].value +" :: "+rows[i].value+" :: "+0+" :: "+rows[i].value+" ::"+0+" :: "+0+" :: "+0+" :: "+rows[i].value+" :: ");
				 	   }
				 	}   
			   $.messager.confirm('Message', 'Do you want to create XO?', function(r){     
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     saveGridDatatf(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3);      
					     	}  
					 });      
			}
			
			function saveGridDatatf(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3){     
				//alert("acgroup=="+acgroup);
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;     
				   if(parseInt(items)>=1)
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'Successfully Created'
						});
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'
						});
					}
				}   
				}        
				x.open("GET","createXOtf.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2,true);                            
				x.send();
			} 
/* CREATE XO ENDS*/   

/* CONFIRM XO STARTS*/	        
		function funConfirmXO(){  
			var gridarray=new Array();
			var i=0; 
			if($("#cnfcheck").val()=="TOUR"){            
				var rows = $("#tourGrid").jqxGrid('getrows');
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}else if($("#cnfcheck").val()=="HOTEL"){
				var rows = $("#hotelGrid").jqxGrid('getrows'); 
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}else if($("#cnfcheck").val()=="SERVICE"){        
				var rows = $("#serviceReqGrid").jqxGrid('getrows'); 
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}else if($("#cnfcheck").val()=="VISA"){
				var rows = $("#visaGrid").jqxGrid('getrows'); 
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}else if($("#cnfcheck").val()=="TRANSFER"){
				var rows = $("#transferGrid").jqxGrid('getrows'); 
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}else if($("#cnfcheck").val()=="TICKET"){                 
				var rows = $("#ticketGrid").jqxGrid('getrows'); 
				for(i=0 ; i < rows.length ; i++){                  
				   gridarray.push(rows[i].rowno);             
				}
			}
			if(i==0){
				swal({
					type: 'warning',   
					title: 'Warning',  
					text: ' Please enter data '
				});
				 return 0;	
			}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText;     
			   if(parseInt(items)>=1)
				{
				   swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Confirmed'
					});
				    
				    $('#cntime').val(new Date());   
				    $('#cndate').val(new Date());    
					$('#txtconfno').val('');  
					$('#txtcnfdesc').val('');            
					$(function() {                 
						   $('#modalconfirmx').modal('toggle');
						});
				} 
				else
				{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Confirmed'
					});
				}
			}             
			}      
			x.open("GET","saveConfirmXO.jsp?cndate="+$('#cndate').val()+"&txtconfno="+$('#txtconfno').val()+"&txtcnfdesc="+$('#txtcnfdesc').val()+"&gridarray="+gridarray+"&cnfcheck="+$('#cnfcheck').val()+"&type="+$('#hidtype').val()+"&cntime="+$('#cntime').val()+"&docno="+$('#txtrdocno').val(),true);                                         
			x.send();
		}                 
/* CONFIRM XO ENDS*/	
 
/* VALIDATIONS STARTS*/ 
		function saveValidateSR(){
			  if($('#txtrdocno').val()==''){  
				  if (document.getElementById('rsumm').checked) {  
						if($('#hidclient').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }   
					 else if (document.getElementById('rdet').checked) {    
							if($('#txtclient').val()==''){
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'      
								});
								 return 0;
						}      
					 }
			  } 
			  if(!mobileValid($("#txtmob").val())){      
					 return 0;
				 }
				
				if(!validateEmail($("#txtemail").val())){
					 return 0;
				 }
			   var val=0; 
			   var rows=$('#serviceReqGrid').jqxGrid('getrows')
			   for(var i=0;i<rows.length;i++){
			   var chk1=$('#serviceReqGrid').jqxGrid('getcellvalue',i,'remarks');
			   var chk2=$('#serviceReqGrid').jqxGrid('getcellvalue',i,'pax');
			   if((typeof(chk1) != "undefined" && typeof(chk1) != "NaN" && chk1 != "") || (typeof(chk2) != "undefined" && typeof(chk2) != "NaN" && chk2 != "")){
					  val++;  	 
					}
			   }
			   if(val==0){   
				   swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Remarks or Pax'      
					});
					 return 0;
			   }
			   
			funSerReqSave();  
		}
		function saveValidateVA(){
			if($('#txtrdocno').val()==''){  
				  if (document.getElementById('varsumm').checked) {  
						if($('#hidclientva').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }   
					 else if (document.getElementById('vardet').checked) {    
							if($('#txtclientva').val()==''){
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'      
								});
								 return 0;
						}    
					 }  
			  }	
			if(!mobileValid($("#txtmobva").val())){          
				 return 0;
			 }  
			
			if(!validateEmail($("#txtemailva").val())){  
				 return 0;
			 }
			var chk=$('#visaGrid').jqxGrid('getcellvalue',0,'givenname');
		    if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	 swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Data'                 
					});
					 return 0;
		    }
			funvisaSave();  
		}
		function saveValidateTT(){      
			if($('#txtrdocno').val()==''){  
				  if (document.getElementById('ttrsumm').checked) {  
						if($('#hidclienttt').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }   
					 else if (document.getElementById('ttrdet').checked) {    
							if($('#txtclienttt').val()==''){
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'      
								});
								 return 0;
						}    
					 }  
			  }	
			if(!mobileValid($("#txtmobtt").val())){      
				 return 0;
			 }
			
			if(!validateEmail($("#txtemailtt").val())){    
				 return 0;
			 }
			var chk=$('#ticketGrid').jqxGrid('getcellvalue',0,'givenname');           
		    if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	 swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Data'                 
					});
					 return 0;
		    }
		    funticketSave();  
		} 
		function saveValidateHL(){      
			if($('#txtrdocno').val()==''){  
				  if (document.getElementById('hlrsumm').checked) {  
						if($('#hidclienthl').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }     
					 else if (document.getElementById('hlrdet').checked) {    
							if($('#txtclienthl').val()==''){
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'           
								});
								 return 0;
						}    
					 }  
			  }	
			if(!mobileValid($("#txtmobhl").val())){      
				 return 0;
			 }
			
			if(!validateEmail($("#txtemailhl").val())){
				 return 0;
			 }
			var chk=$('#hotelGrid').jqxGrid('getcellvalue',0,'guestname');           
		    if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	 swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Data'                 
					});
					 return 0;
		    }
		    funhotelSave();     
		}
		function saveValidateTF(){     
			if($('#txtrdocno').val()==''){     
				  if (document.getElementById('tfrsumm').checked) {    
						if($('#hidclienttf').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }     
					 else if (document.getElementById('tfrdet').checked) {    
							if($('#txtclienttf').val()==''){    
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'           
								});
								 return 0;
						}    
					 }  
			  }	
			if(!mobileValid($("#txtmobtf").val())){      
				 return 0; 
			 }
			
			if(!validateEmail($("#txtemailtf").val())){ 
				 return 0;
			 }
			var chk=$('#transferGrid').jqxGrid('getcellvalue',0,'guestname');                    
		     if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	 swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Data'                 
					});
					 return 0;
		     }
		     funtransferSave();
		}   
		function saveValidateTR(){     
			if($('#txtrdocno').val()==''){     
				  if (document.getElementById('trrsumm').checked) {    
						if($('#hidclienttr').val()==''){
							swal({   
								type: 'warning',
								title: 'Warning', 
								text: 'Please Enter Client'      
							});
							 return 0;
						}      
		             }     
					 else if (document.getElementById('trrdet').checked) {    
							if($('#txtclienttr').val()==''){
								swal({   
									type: 'warning',
									title: 'Warning', 
									text: 'Please Enter Client Name'           
								});
								 return 0;
						}    
					 }
				  if($('#txtmobtr').val()==''){
						swal({   
							type: 'warning',
							title: 'Warning', 
							text: 'Please enter mobile number'                  
						});
						 return 0;
				}
				  if(!mobileValid($("#txtmobtr").val())){      
						 return 0;
					 }
					
					if(!validateEmail($("#txtemailtr").val())){      
						 return 0;
					 }
			  }	
			
			 var chk=$('#tourGrid').jqxGrid('getcellvalue',0,'tourid');                   
		     if(typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
		    	 swal({   
						type: 'warning',
						title: 'Warning', 
						text: 'Please Enter Data'                 
					});
					 return 0;
		     }
		     var rows=$('#tourGrid').jqxGrid('getrows');
		     var id=0;
		     for(var i=0;i<rows.length;i++){
				    var chk=$('#tourGrid').jqxGrid('getcellvalue',i,'distype');           
					if(chk == "PAY BACK"){
		             id=1;  
					}
		     }				    
		     if(id==1){
	    		 document.getElementById("salesagent").value=1;  
	    		 document.getElementById('salesagent').checked=true;     
	    		 $('#jqxsalesagent').attr('disabled', false);  
	    		 $('#salesagent').attr('disabled', false);  
		    	 var salesagentdocno=document.getElementById("salesagentdocno").value; 
		    	 /* if(salesagentdocno==''){
		    		 swal({   
							type: 'warning',
							title: 'Warning', 
							text: 'Please select sales agent'                      
						});
						 return 0;
		    	 } */     
		     }else{
		    	 document.getElementById("salesagent").value=0;  
	    		 document.getElementById('salesagent').checked=false;     
	    		 $('#jqxsalesagent').attr('disabled', true);   
	    		 $('#salesagent').attr('disabled', true); 
		     }
		     funtourSave();         
		}
  function saveValidateSubTR(){     
	   if($('#cmbchoosetour').val()==''){        
			swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Please select a tour'           
			});
			 return 0;
		}
	     var chk=$('#tourSubGrid').jqxGrid('getcellvalue',0,'name');         
	     if(chk == null || typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
	    	 swal({   
					type: 'warning',
					title: 'Warning', 
					text: 'Please Enter Data'                            
				});
				 return 0;    
	     }
	     funTourSubSave();
  }
  function validateEmail($email) {  
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if(emailReg.test( $email )){
			return true;
		}
		else{
			swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Email Address Not Valid!!!'                             
			});
			return false;
		}
	  return true;
	}
  function mobileValid(value){     
	   if(value!=""){ 
	    var phoneno = /^\d{12}$/;  
		if(value.match(phoneno)){
			return true;
		}
		else{
			swal({   
				type: 'warning',
				title: 'Warning', 
				text: 'Invalid Mobile Number!!!'                             
			});
			return false;
		}
	    } 
	   return true;
}
  function invoiceValidatetr(){        
	     var chk=$('#tourGrid').jqxGrid('getcellvalue',0,'tourname');               
	     if(chk == null || typeof(chk) == "undefined" || typeof(chk) == "NaN" || chk == ""){
	    	 swal({   
					type: 'warning',
					title: 'Warning', 
					text: 'Please Enter Data'                                  
				});
				 return 0;    
	     }
	     funinvoicetr();
 }
  function funvalidatechilddis(){
  if($('#tourismconfig').val()!=1){
		var childdis=$('#tourdiscountchild').val();
		var chmaxdis=$('#chmaxdis').val();
		if(childdis>chmaxdis){
			swal({
					type: 'warning',
					title: 'Warning',     
					text: 'Maximum child discount is '+chmaxdis
				});
		  }
    	}
	 }
	function funvalidateadultdis(){ 
	 if($('#tourismconfig').val()!=1){ 
		var adultdis=$('#tourdiscountadult').val(); 
		var admaxdis=$('#admaxdis').val();
		if(adultdis>admaxdis){
			swal({
				type: 'warning',
				title: 'Warning',     
				text: 'Maximum adult discount is '+admaxdis    
				});
		     }
		    }
	 }
	function funconfirmcheck(){               
		  var rowno=$('#txtrdocno').val();
		  var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){  
					if (x.readyState == 4 && x.status == 200) {
						items = x.responseText;
				        if(parseInt(items)==0){  
				        	swal({
				    			type: 'warning',
				    			title: 'Warning',     
				    			text: 'Please Create XO...'      
				    			});
				        	 $('#modalconfirmx').modal('toggle');
				    	    }
					}    
				else    
				{       
				}                   
			}
			x.open("GET","getconfirmcheck.jsp?rdocno="+rowno,true);                           
			x.send(); 
	}   
	function funcommrcptprintcheck(){               
		  var rowno=$('#txtrdocno').val();
		  var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){  
					if (x.readyState == 4 && x.status == 200) {
						items = x.responseText;
				        if(parseInt(items)==0){  
				        	swal({
				    			type: 'warning',
				    			title: 'Warning',     
				    			text: 'Please Create XO...'      
				    			});
				    	    }else{
				    	    	funXOPrinttr();
				    	    }
					}      
				else    
				{       
				}                   
			}
			x.open("GET","getconfirmcheck.jsp?rdocno="+rowno,true);                           
			x.send(); 
	} 
 	function getcommercialamt(){               
		  var rowno=$('#txtrdocno').val();
		  var nettotal=$('#hidamountcr').val();
		  var amount=0.0;
		  var x=new XMLHttpRequest();  
		      x.onreadystatechange=function(){  
					if (x.readyState == 4 && x.status == 200) {
						items = x.responseText;
				        if(parseInt(items)>=0){   
				        	amount=parseFloat(nettotal)-parseFloat(items);   
				        	if(amount<0){
				        		amount=0.0;   
				        	}
                            $('#txtamount').val(amount);        
				        }
					}    
				else       
				{       
				}                   
			}
		      x.open("GET","getcommercialamt.jsp?rdocno="+rowno,true);                            
			x.send(); 
	} 
	function funcommrecptcheck(){               
		  var rowno=$('#txtrdocno').val();
		  var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){  
					if (x.readyState == 4 && x.status == 200) {
						items = x.responseText;
				        if(parseInt(items)==0){  
				        	swal({
				    			type: 'warning',
				    			title: 'Warning',     
				    			text: 'Please Create XO...'               
				    			});
				        	 $('#modalcommreceipt').modal('toggle');  
				    	    }
					}    
				else       
				{       
				}                   
			}
		      x.open("GET","getconfirmcheck.jsp?rdocno="+rowno,true);                            
			x.send(); 
	}
	function funinvoicecheck(){  
		  var rowno=$('#txtrdocno').val();
		  var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){  
					
			if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;     
				        if(parseInt(items)==0){  
				        	swal({
				    			type: 'warning',
				    			title: 'Warning',     
				    			text: 'Please Create XO...'         
				    			});
				    	    }else{
				    	    	invoiceValidatetr();                
				    	    }
					}else{       
				}                   
			}
	
			x.open("GET","getconfirmcheck.jsp?rdocno="+rowno,true);                           
			x.send(); 
	}
	function funvoucherprintcheck(){      
		  var rowno=$('#txtrdocno').val();
		  var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){  
					if (x.readyState == 4 && x.status == 200) {
						items = x.responseText;  
				        if(parseInt(items)==0){  
				        	swal({
				    			type: 'warning',
				    			title: 'Warning',     
				    			text: 'Please create invoice...'         
				    			});
				    	    }else{
				    	    	funVoucherPrinttr();                    
				    	    }
					}else{       
				}                   
			}
			x.open("GET","getvoucherprintcheck.jsp?rdocno="+rowno,true);                           
			x.send(); 
	}     
/* VALIDATIONS ENDS*/  
 
function funTourSubSave(){  
	    var rowno=$('#cmbchoosetour').val();
	    var gridarray=new Array();   
	    var rows=$('#tourSubGrid').jqxGrid('getrows');  
	 	for(var i=0;i<rows.length;i++){
	     var chk=$('#tourSubGrid').jqxGrid('getcellvalue',i,'name');
	 		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){     
	 		    	 $('#trpname').val(rows[i].name);       
	 		    		 				 if (($(trpname).val()).includes('$')) { $(trpname).val($(trpname).val().replace(/$/g, ''));};if (($(trpname).val()).includes('%')) { $(trpname).val($(trpname).val().replace(/%/g, ''));};
	 		    		 				 if (($(trpname).val()).includes('^')) { $(trpname).val($(trpname).val().replace(/^/g, ''));};if (($(trpname).val()).includes('`')) { $(trpname).val($(trpname).val().replace(/`/g, ''));};
	 		    		 				 if (($(trpname).val()).includes('~')) { $(trpname).val($(trpname).val().replace(/~/g, ''));};if ($(trpname).val().indexOf('\'')  >= 0 ) { $(trpname).val($(trpname).val().replace(/'/g, ''));};
	 		    		 				 if (($(trpname).val()).includes(',')) { $(trpname).val($(trpname).val().replace(/,/g, ''));}	 				   
	 				
	 		    gridarray.push($('#trpname').val()+"::"+rows[i].age+"::"+rows[i].height+"::"+rows[i].weight+"::"+rows[i].remarks+"::"+rows[i].rowno);                                        
	 		    }
	    }
	    var x=new XMLHttpRequest();
	 		x.onreadystatechange=function(){
	 			if (x.readyState==4 && x.status==200)
	 			{
	 				var items=x.responseText.trim();
	 				if(items=="0"){
	 					swal({
	 						type: 'success',
	 						title: 'Success',
	 						text: 'Successfully Updated'  
	 					});
	 					$('#toursubdiv').load('tourSubGrid.jsp?rdocno='+rowno);   
	 				}
	 				else{
	 					swal({
	 						type: 'error',
	 						title: 'Error', 
	 						text: 'Not Updated'
	 					});
	 				}   
	 			}
	 			else    
	 			{       
	 			}            
	 		}
	 		x.open("GET","savetourSubData.jsp?gridarray="+gridarray+"&rdocno="+rowno,true);      
	 		x.send();   
 }
	 function funbranch(){  
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items>0){  
					$('#cmbbranch').val(items);    
				}
				else{
				}   
			}  
			else    
			{       
			}            
		}
		x.open("GET","getBranch.jsp?locid="+$('#cmblocation').val(),true);         
		x.send();  
	 }
	 
/* INVOICE STARTS*/                                            
	 function funinvoicetr(){ 
	 var brhid=$('#cmbbranch').val(); 
	 var cldocno=$('#cldocnotr').val();    
	 var refname=$('#refnametr').val(); 
	 var reftype="SER";    
	 var type="tour";           
	 var salesacno=$('#salesagentacno').val();               
	 var clientacno=$('#clientacno').val();               
	 var tourdate=$('#tourGrid').jqxGrid('getcellvalue', 0, "date");
	 var total1= $("#tourGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);  
     var total=total1.sum.replace(/,/g,'');    
     var payback1= $("#tourGrid").jqxGrid('getcolumnaggregateddata', 'adultdis', ['sum'],true);      
     var payback2= $("#tourGrid").jqxGrid('getcolumnaggregateddata', 'childdis', ['sum'],true);   
     var payback=parseFloat(payback1.sum.replace(/,/g,''))+parseFloat(payback2.sum.replace(/,/g,''));  
     //var stdprice1= $("#tourGrid").jqxGrid('getcolumnaggregateddata', 'adultval', ['sum'],true);   
     var stdprice1= $("#tourGrid").jqxGrid('getcolumnaggregateddata', 'stdtotal', ['sum'],true);         
     var stdprice=parseFloat(stdprice1.sum.replace(/,/g,''));       
     var gridarray=new Array();            
		 var x=new XMLHttpRequest();
	 		x.onreadystatechange=function(){   
	 			if (x.readyState==4 && x.status==200)
	 			{
	 				var msg=x.responseText.trim().split("::");
	 				if(msg[0]>0){ 
	 					swal({
	 						type: 'success',
	 						title: 'Success',                   
	 						text: 'TINV'+'-'+msg[1]+" "+'Successfully Created.'     
	 					});
	 					 $('#btninvoicetr').attr('disabled', true); 
	 					 $('#btnaddtour').attr('disabled', true);   
	 					 $('#jvtrno').val(msg[2]);    
	 				} 
	 				else{
	 					swal({
	 						type: 'error',
	 						title: 'Error', 
	 						text: 'Not Created'
	 					});
	 				}   
	 			}
	 			else    
	 			{              
	 			}                
	 		}  
	 		x.open("GET","createInvoicetr.jsp?rowno="+$('#txtrdocno').val()+"&agentid="+$('#agentid').val()+"&stdprice="+stdprice+"&total="+total+"&payback="+payback+"&salesacno="+salesacno+"&clientacno="+clientacno+"&reftype="+reftype+"&type="+type+"&refname="+encodeURIComponent(refname)+"&cldocno="+cldocno+"&brhid="+brhid+"&docno="+$('#txtrdocno').val()+"&tourdate="+tourdate+"&vocno="+$('#hidvocno').val(),true);                                                          
	 		x.send();     
	}
/* INVOICE ENDS*/	 
function funRoundAmt(value,id){
		  var res=parseFloat(value).toFixed(window.parent.amtdec.value);              
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }
	
   function getTariffData(){             
	   var pickuplocid=$('#pickuplocid').val();
	   var dropofflocid=$('#dropofflocid').val();
	   var transfergroup=$('#cmbtourtransfergroup').val();  
	   var transfertype=$('#cmbtourtransfertype').val();  
	   var cldocno=$('#cldocnotr').val();      
	    	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){  
				if (x.readyState==4 && x.status==200)  
				{  
					var items=x.responseText.trim().split("::");  
					$('#tarifdetaildocno').val(items[0]);      
					$('#estdistance').val(items[1]);   
					$('#esttime').val(items[2]);   
					$('#exdistancerate').val(items[3]);        
					$('#extimerate').val(items[4]);     
					$('#tourtransferrate').val(items[5]);  
					$('#tarifdocno').val(items[6]);
					var rttransferrate=$('#roundtourtransferrate').val();
					var transferrate=items[5];   
					var totrate=0.00;  
					if($('#transporttr').val()=="0"){
					if($('#cmbtourtransferroundtrip').val()=="1"){ 
					if(rttransferrate!=''){     
						totrate=parseFloat(transferrate)+parseFloat(rttransferrate);   
						funRoundAmt(totrate,"tourtransferratetot");
					}else{
						funRoundAmt(transferrate,"tourtransferratetot");
					}
					}else{    
						funRoundAmt(transferrate,"tourtransferratetot");
					}
					}else{   
						funRoundAmt(totrate,"tourtransferratetot");
					}
					funNettotal();
				}      
				else
				{
				}  
			}
			x.open("GET","getTariffData.jsp?cldocno="+cldocno+"&transfertype="+transfertype+"&pickuplocid="+pickuplocid+"&dropofflocid="+dropofflocid+"&groupid="+transfergroup,true);             
			x.send();
	    }
   function getReturnTariffData(){                   
	   var pickuplocid=$('#roundpickuplocid').val();
	   var dropofflocid=$('#rounddropofflocid').val();
	   var transfergroup=$('#cmbtourtransfergroup').val();  
	   var transfertype=$('#cmbtourtransfertype').val();  
	   var cldocno=$('#cldocnotr').val();      
	    	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){  
				if (x.readyState==4 && x.status==200)
				{  
					var items=x.responseText.trim().split("::"); 
					$('#roundtarifdetaildocno').val(items[0]);      
					$('#roundestdistance').val(items[1]);   
					$('#roundesttime').val(items[2]);   
					$('#roundexdistancerate').val(items[3]);          
					$('#roundextimerate').val(items[4]);       
					$('#roundtourtransferrate').val(items[5]);  
					$('#roundtarifdocno').val(items[6]);
					var transferrate=$('#tourtransferrate').val();
					var rttransferrate=items[5];     
					var totrate=0.00;	
					if($('#transporttr').val()=="0"){
					if($('#cmbtourtransferroundtrip').val()=="1"){   
						if(transferrate!=''){                    
								totrate=parseFloat(transferrate)+parseFloat(rttransferrate);    
								funRoundAmt(totrate,"tourtransferratetot");  
						}else{  
							funRoundAmt(rttransferrate,"tourtransferratetot");
						}
					}  
					}else{
						funRoundAmt(totrate,"tourtransferratetot");     
					}
					funNettotal();
				}        
				else
				{
				}  
			}
			x.open("GET","getTariffData.jsp?cldocno="+cldocno+"&transfertype="+transfertype+"&pickuplocid="+pickuplocid+"&dropofflocid="+dropofflocid+"&groupid="+transfergroup,true);             
			x.send(); 
	    }   
   function funNettotal(){    
		var transferrate=$('#tourtransferratetot').val();
		var transferqty=$('#tourtransferqty').val();
		var total=0.00;
		if($('#transporttr').val()=="0"){
		if(transferrate!='' && transferqty!=''){
			total=parseFloat(transferrate)*parseFloat(transferqty);         
		}
		}else{
			total=0.00;  
		}
		  funRoundAmt(total,"tourtransfertotal");      
   }
  /*  Clear fields Starts*/
   function funcleartourfields(){ 
	   document.getElementById("cospricechild").innerHTML="Sell.Price Child";         
 	   document.getElementById("cospriceadult").innerHTML="Sell.Price Adult";                    
	   document.getElementById("dropoffloc").value="";       
       document.getElementById("pickuploc").value=""; 
	   document.getElementById("tourdiscountchild").value=""; 
	   document.getElementById("tourdiscountadult").value=""; 
	   document.getElementById("tourtotal").value=""; 
	   document.getElementById("roundesttime").value =""; 
       document.getElementById("roundexdistancerate").value =""; 
       document.getElementById("roundextimerate").value ="";    
       document.getElementById("roundtourtransferrate").value =""; 
       document.getElementById("tarifdocno").value =""; 
       document.getElementById("roundtarifdocno").value =""; 
       document.getElementById("cmbtourdiscounttype").value =""; 
       document.getElementById("cmbtourtransferchoose").value =""; 
       document.getElementById("cmbtourtransfergroup").value =""; 
       document.getElementById("cmbtourtransfertype").value =""; 
       document.getElementById("tourtransferqty").value =""; 
       document.getElementById("cmbtourtransferloctype").value ="";       
       document.getElementById("tourtransferlocrefname").value =""; 
       document.getElementById("tourtransferlocrefno").value =""; 
       document.getElementById("pickuplocid").value =""; 
       document.getElementById("jqxPickupLoc").value =""; 
       document.getElementById("jqxroundDropoffLoc").value ="";
       document.getElementById("jqxroundPickupLoc").value ="";
       document.getElementById("jqxDropoffLoc").value ="";
       document.getElementById("dropofflocid").value =""; 
       document.getElementById("cmbtourtransferroundtrip").value =""; 
       document.getElementById("tourtransfertotal").value =""; 
       document.getElementById("roundpickuplocid").value =""; 
       document.getElementById("rounddropofflocid").value =""; 
       document.getElementById("tarifdetaildocno").value =""; 
       document.getElementById("estdistance").value =""; 
       document.getElementById("esttime").value =""; 
       document.getElementById("exdistancerate").value =""; 
       document.getElementById("extimerate").value =""; 
       document.getElementById("tourtransferrate").value =""; 
       document.getElementById("tourtransferratetot").value =""; 
       document.getElementById("roundtarifdetaildocno").value =""; 
       document.getElementById("roundestdistance").value ="";
       document.getElementById("tourdocno").value ="";        
       document.getElementById("jqxTourtype").value =""; 
	   document.getElementById("ttypeid").value="";
       document.getElementById("jqxvendor").value ="";
	   document.getElementById("vndid").value="";         
	   document.getElementById("adultval").value=""; 
	   document.getElementById("spadult").value=""; 
	   document.getElementById("childval").value=""; 
	   document.getElementById("spchild").value="";
	   document.getElementById("adult").value="";       
	   document.getElementById("child").value=""; 
	   document.getElementById("infant").value=""; 
       document.getElementById("tremarks").value=""; 
       $('#tourdate').val(new Date());  
       $('#tourtime').val(new Date());
       //$('#tourtransferpickuptime').val(new Date());
       //$('#tourtransferroundpickuptime').val(new Date());
  }
  /*  Clear fields ends*/
  function getTours(){        
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');       
					trsIdItems = items[0].split(",");      
					trsItems = items[1].split(",");
					var optionsbrch = '<option value="">--Select--</option>';
					for (var i = 0; i < trsItems.length; i++) {    
						optionsbrch += '<option value="' + trsIdItems[i] + '">'
								+ trsItems[i] + '</option>';      
					}
					$("select#cmbchoosetour").html(optionsbrch);
				}    
			else    
			{       
			}                
		}
		x.open("GET","getTours.jsp?rdocno="+$('#txtrdocno').val(),true);                       
		x.send();  
	 }
  function funtoursubload(){  
	  var rowno=$('#cmbchoosetour').val();
	  var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');       
			        document.getElementById("touradult").value=items[0];  
			        document.getElementById("tourchild").value=items[1];  
			        $("#tourSubGrid").jqxGrid('clear');      
			        if(rowno>0){        
			        	   $('#toursubdiv').load('tourSubGrid.jsp?rdocno='+rowno);  
			       }
				}    
			else    
			{       
			}                   
		}
		x.open("GET","getTourSubGridLen.jsp?rdocno="+rowno,true);                           
		x.send(); 
  }
  function funMycartLoad(){             
	  var rowno=$('#txtrdocno').val();          
	  var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					var cartdata=x.responseText.trim().split("::")[0];
	 				var cartdata=JSON.parse(cartdata);
	 				var nettot=x.responseText.trim().split("::")[1];       
	 				var panelhtml='';
	 				$.each( cartdata, function( key, value ) {         
					    panelhtml+='<div class="cart-item img-rounded">';  
						panelhtml+='<p>'+cartdata[key].tourname+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date: &nbsp;'+cartdata[key].date+'&nbsp;&nbsp;Time: &nbsp;'+cartdata[key].time+'</p>'; 
						panelhtml+='<p>'+'Adult: &nbsp;'+cartdata[key].adult+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Child: &nbsp;'+cartdata[key].child+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Infant: &nbsp;'+cartdata[key].infant+'</p>';
						panelhtml+='<p>'+'Transfer: &nbsp;'+cartdata[key].ploc+' , '+cartdata[key].dloc+'</p>';
						panelhtml+='<p style="text-align:right">'+'Total: &nbsp;'+cartdata[key].total+'</p>';            
						panelhtml+='</div>';              
						});
					$('.cart-body').html($.parseHTML(panelhtml));
					var panelhtml=''; 
					  panelhtml+='<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">'; 
					  panelhtml+='<p style="text-align:left">'+'Net Total'+'</p>';  
					  panelhtml+='</div>'; 
					  panelhtml+='<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">'; 
					  panelhtml+='<p style="text-align:right"><strong>'+'AED '+nettot+'</strong></p>';  
					  panelhtml+='</div>';
					  $('#nettot').html($.parseHTML(panelhtml));
					  $('#hidamountcr').val(nettot);     
				}    
			else            
			{       
			}                   
		}
		x.open("GET","getMyCartData.jsp?rdocno="+rowno,true);                                  
		x.send(); 
  }
  
  /*  Voucher Receipt Print */
  function funVoucherPrinttr(){   
		  var url=document.URL;  
	      var reurl=url.split("cooperatetravel.jsp");      
	      var win= window.open(reurl[0]+"printtourvoucherreceiptcooperate?docno="+$('#txtrdocno').val()+"&branch="+document.getElementById("cmbbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();           
		}
 /*  Voucher Receipt Print Ends*/
 
  /*  XO Print */
  function funXOPrinttr(){     
		  var url=document.URL;  
	      var reurl=url.split("cooperatetravel.jsp");      
	      var win= window.open(reurl[0]+"printtourxocooperate?docno="+$('#txtrdocno').val()+"&branch="+document.getElementById("cmbbranch").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();           
		}
 /*  XO Print Ends*/  
function getLocationhl() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {  
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch;// = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmblocationhl").html(optionsbrch);
				
			} else {     
				//alert("Error");
			}  
		}
		x.open("GET","getLocationhl.jsp", true);       
		x.send();
	}  
function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
		        return false;
		    return true;
	}    
function funchildcheck(){  
	 var child=$('#childhl').val();        
		 if(child==0){               
			 $('#txtage1').val('');$('#txtage2').val('');$('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
			 $('#txtage1').hide();$('#txtage2').hide();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
			 $('#age1').hide(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
		 }else if(child==1){  
			 $('#txtage2').val('');$('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
			 $('#txtage1').show();$('#txtage2').hide();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
			 $('#age1').show(); $('#age2').hide(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
		 }else if(child==2){
			 $('#txtage3').val('');$('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
			 $('#txtage1').show();$('#txtage2').show();$('#txtage3').hide();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
			 $('#age1').show(); $('#age2').show(); $('#age3').hide(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
		 }else if(child==3){
			 $('#txtage4').val('');$('#txtage5').val('');$('#txtage6').val('');
			 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').hide();$('#txtage5').hide();$('#txtage6').hide();
			 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').hide(); $('#age5').hide(); $('#age6').hide();
		 }else if(child==4){
			 $('#txtage5').val('');$('#txtage6').val('');
			 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').hide();$('#txtage6').hide();
			 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').hide(); $('#age6').hide();    
		 }else if(child==5){
			 $('#txtage6').val('');
			 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').show();$('#txtage6').hide();  
			 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').show(); $('#age6').hide();  
		 }else if(child>=6){                      
			 $('#txtage1').show();$('#txtage2').show();$('#txtage3').show();$('#txtage4').show();$('#txtage5').show();$('#txtage6').show();
			 $('#age1').show(); $('#age2').show(); $('#age3').show(); $('#age4').show(); $('#age5').show(); $('#age6').show();
		 }
}
function funClear(){
	   document.getElementById("locidhl").value=""; 
	   document.getElementById("nationidhl").value=""; 
	   document.getElementById("hotelidhl").value=""; 
	   document.getElementById("adulthl").value=""; 
	   document.getElementById("childhl").value="";     
	   document.getElementById("txtage1").value=""; 
	   document.getElementById("txtage2").value=""; 
	   document.getElementById("txtage3").value=""; 
	   document.getElementById("txtage4").value=""; 
	   document.getElementById("txtage5").value=""; 
	   document.getElementById("txtage6").value=""; 
	   document.getElementById("jqxhotel").value=""; 
	   document.getElementById("jqxloc").value="";       
	   document.getElementById("jqxnation").value=""; 
	   //document.getElementById("txtclienthl").value=""; 
	   document.getElementById("txtemailhl").value=""; 
	   document.getElementById("txtmobhl").value=""; 
	   //document.getElementById("jqxClienthl").value="";  
	   document.getElementById("roomidhl").value=""; 
	   document.getElementById("roomtypeidhl").value=""; 
	   document.getElementById("txtrating").value="";
	   document.getElementById("jqxroomname").value=""; 
	   document.getElementById("jqxrtype").value="";
	   $('#cmbextrabed').val('0'); 
		$('#cmbmealplan').val('BB'); 
		$('#jqxhotelbook').jqxGrid('clear');   
		$('#jqxpricedet').jqxGrid('clear');
		funchildcheck();   
}
function funSearch(){
	 var txtage1 = document.getElementById("txtage1").value;   
	 var txtage2 = document.getElementById("txtage2").value;
	 var txtage3 = document.getElementById("txtage3").value;
	 var txtage4 = document.getElementById("txtage4").value;
	 var txtage5 = document.getElementById("txtage5").value;
	 var txtage6 = document.getElementById("txtage6").value;
     var locid = document.getElementById("locidhl").value;
	 var nationid = document.getElementById("nationidhl").value; 
	 var hotelid = document.getElementById("hotelidhl").value;
	 var txtpax = document.getElementById("adulthl").value;  
	 var txtchild = document.getElementById("childhl").value;  
	 var fromdate = $('#fromdatehl').jqxDateTimeInput('val');     
	 var todate = $('#todatehl').jqxDateTimeInput('val');     
	 var extrabed = $('#cmbextrabed').val(); 
	 var mealplan = $('#cmbmealplan').val(); 
	 var roomidhl = $('#roomidhl').val();      
	 var roomtypeidhl = $('#roomtypeidhl').val();
	 var txtrating = $('#txtrating').val();
	 var cldocno=document.getElementById("hidclienthl").value;  
	 document.getElementById('hidcalc').value="0";       
	 $("#overlay, #PleaseWait").show();                  
	 $("#bookingDiv").load("hotelbookingGrid.jsp?hotelid="+hotelid+"&roomid="+encodeURIComponent(roomidhl)+"&roomtypeid="+encodeURIComponent(roomtypeidhl)+"&rating="+encodeURIComponent(txtrating)+"&cldocno="+cldocno+"&mealplan="+mealplan+"&extrabed="+extrabed+"&locid="+locid+"&nationid="+nationid+"&pax="+txtpax+"&child="+txtchild+"&fromdate="+fromdate+"&todate="+todate+"&child1="+txtage1+"&child2="+txtage2+"&child3="+txtage3+"&child4="+txtage4+"&child5="+txtage5+"&child6="+txtage6+"&check="+1);  
}         
function funCalc(){
	$('#jqxpricedet').jqxGrid('clear');      
	var rows = $("#jqxhotelbook").jqxGrid('getrows');  

	var selectedrows=$("#jqxhotelbook").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});

	if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Please select documents.');
			return false;
	  }
		$.messager.confirm('Message', 'Do you want to calculate?', function(r){
		if(r==false)
		{
			return false; 
		}
		else
		{
		var i=0,j=0;   
		var name="";                 
		for (i = 0; i < selectedrows.length; i++) {   
		if(i==0){
			$("#jqxpricedet").jqxGrid('addrow', null, {}); 
			name=$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "hotel")+" - "+$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "loc")+" - "+$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "name");
			$('#jqxpricedet').jqxGrid('setcellvalue', i, "name" , name);               
			$('#jqxpricedet').jqxGrid('setcellvalue', i, "total" ,$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "price"));
		}  
		else{     
			$("#jqxpricedet").jqxGrid('addrow', null, {}); 
			name=$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "hotel")+" - "+$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "loc")+" - "+$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "name");
			$('#jqxpricedet').jqxGrid('setcellvalue', i, "name" , name);
			$('#jqxpricedet').jqxGrid('setcellvalue', i, "total" ,$('#jqxhotelbook').jqxGrid('getcellvalue', selectedrows[i], "price"));  
		}
			j++; 
		}
		}
		});
		 document.getElementById('hidcalc').value="1";
	}

function funSaveHotel(){
	var chk=document.getElementById('hidcalc').value; 
	 var refname="";
	if(chk!="1"){  
		$.messager.alert('Warning','Please calculate before save.');
		return false;
    }
	if (document.getElementById('hlrsumm').checked){     
	    refname=document.getElementById("jqxClienthl").value;
    }else if (document.getElementById('hlrdet').checked){       
	    refname=document.getElementById("txtclienthl").value;      
	}
	 var branch=document.getElementById("cmbbranch").value;
	 var clienttype=document.getElementById("clienttypehl").value; 
	 var email=document.getElementById("txtemailhl").value;
	 var mobno=document.getElementById("txtmobhl").value;                        
	 var client=document.getElementById("hidclienthl").value;	      
	 var txtage1 = document.getElementById("txtage1").value;   
	 var txtage2 = document.getElementById("txtage2").value;
	 var txtage3 = document.getElementById("txtage3").value;
	 var txtage4 = document.getElementById("txtage4").value;   
	 var txtage5 = document.getElementById("txtage5").value;  
	 var txtage6 = document.getElementById("txtage6").value;
     var locationid = document.getElementById("cmblocationhl").value;     
     var locid = document.getElementById("cmblocation").value;        
     var areaid = document.getElementById("locidhl").value;   
	 var nationid = document.getElementById("nationidhl").value; 
	 var hotelid = document.getElementById("hotelidhl").value;
	 var txtadult = document.getElementById("adulthl").value;  
	 var txtchild = document.getElementById("childhl").value;  
	 var fromdate = $('#fromdatehl').jqxDateTimeInput('val');     
	 var todate = $('#todatehl').jqxDateTimeInput('val');     
	 var extrabed = $('#cmbextrabed').val(); 
	 var mealplan = $('#cmbmealplan').val(); 
	 var roomidhl = $('#roomidhl').val(); 
	 var roomtypeidhl = $('#roomtypeidhl').val();
	 var txtrating = $('#txtrating').val(); 
	 var date = $('#hldate').jqxDateTimeInput('val');  
	 
	$("#overlay, #PleaseWait").show();
    var gridarray=new Array();
	   var rows = $("#jqxpricedet").jqxGrid('getrows'); 
	   var i=0;     
	   for(i=0;i<rows.length;i++){
		    var chk=$('#jqxpricedet').jqxGrid('getcellvalue',i,'name');   
		    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
		     gridarray.push(rows[i].name+"::"+rows[i].total+"::"+rows[i].rowno);                   
	        }
	   }
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
		   var items=x.responseText.split('###');     
		   if(parseInt(items[0])>=1)
			{  
			   swal({
					type: 'success',   
					title: 'Success',                    
					text: 'Successfully Saved'
				});
			   $("#overlay, #PleaseWait").hide();    
			   funClear();  
			   document.getElementById("txtrdocno").value=items[1];         
               document.getElementById("hidcldocno").value=client;   
               document.getElementById("hidtype").value="Service Request";     
               document.getElementById("hidvocno").value=items[1];         
               document.getElementById("txtrefname").value=refname;   
               $('.textpanel p').text('Doc No '+items[1]+' - '+refname);    
               $('.textclient p').text(''+items[1]+' - '+refname);   
               $('.textclient').show();
               $('.newclientinfo').hide();
               $('.comments-container').html('');
			   funreloadhotelgrid();
	           document.getElementById('hidcalc').value="0";      
			}
			else
			{
				swal({
					type: 'error',
					title: 'Error',
					text: 'Not Saved'       
				});   
			}
		}                                                       
		}       
		x.open("GET","savehotelData.jsp?gridarray="+gridarray+"&areaid="+areaid+"&locationid="+locationid+"&locid="+locid+"&rdocno="+$('#txtrdocno').val()+"&clienttype="+clienttype+"&email="+email+"&mobno="+mobno+"&clientid="+client+"&txtage1="+txtage1+"&txtage2="+txtage2+"&txtage3="+txtage3+"&txtage4="+txtage4+"&txtage5="+txtage5+"&txtage6="+txtage6+"&nationid="+nationid+"&hotelid="+hotelid+"&txtadult="+txtadult+"&txtchild="+txtchild+"&fromdate="+fromdate+"&todate="+todate+"&extrabed="+extrabed+"&mealplan="+mealplan+"&roomidhl="+encodeURIComponent(roomidhl)+"&roomtypeidhl="+roomtypeidhl+"&txtrating="+txtrating+"&edate="+date+"&refname="+encodeURIComponent(refname)+"&brhid="+branch,true);                            
		x.send();
}
function funreloadhotelgrid(){      
	$('#subDiv').load('subGrid.jsp?rdocno='+$('#txtrdocno').val()+'&check='+1); 
} 
function funreloadtourgrid(){            
	$('#tourdiv').load('tourGrid.jsp?rdocno='+$('#txtrdocno').val()); 
}     
function funtrnext2allowance(){
	var trrowno=$('#tourGrid').jqxGrid('getcellvalue', 0, "rowno"); 
    if(typeof(trrowno) == "undefined" || typeof(trrowno) == "NaN" || trrowno == "" || trrowno == "0" || trrowno == null){          
    	 $('#trnext2').attr('disabled', true);                
    }else{   
    	 $('#trnext2').attr('disabled', false); 
    }
}

function getTourismConfig(){ 
	    	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){  
				if (x.readyState==4 && x.status==200){                     
					var items=x.responseText.trim().split('###');  
					if(parseInt(items[0])>0){                                          
						document.getElementById('tourismconfig').value=1;  
					    tourreadonly();
					    getPayType();
					}
					if(parseInt(items[1])>0){
					    $('#btnxoprinttr').hide();
					}
				}      
				else   
				{
				}  
			}
			x.open("GET","getConfig.jsp",true);             
			x.send();    
	    }
	    
	    function cltrload(){
	    	 $('#salesman').load('salesmantr.jsp');
	    	 $('#clienttr').load('clientSearchTour.jsp');   
	    	 
	    }
 function sendTypeContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
function funSendMail(amendment){ 
    var id=1; 
    $('#printWindow').jqxWindow('close');               
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim();

	 }
	} 
	x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&amendment='+amendment+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);              
	x.send(); 
	}

function funSendWhatsapp(){
  var id=2;
    $('#printWindow').jqxWindow('close');               
	var x=new XMLHttpRequest();   
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim();
		if(items.split("::")[1].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Mobile not configured'       
			});
		}
		else if(items.split("::")[2].trim()==""){
			swal({
				type: 'error',
				title: 'WhatsApp Message',
				text: 'Message not configured'       
			});
		}
		else{
			var sendmobile=items.split("::")[1].trim();
			var sendmessage=items.split("::")[2].trim();
			funSendWhatsApp(sendmessage,sendmobile);
		}
	 }
	} 
	x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);              
	x.send(); 
	}	
 function funSendMailWhatsapp(amendment){
	    var id=3;    
	    $('#printWindow').jqxWindow('close');               
		var x=new XMLHttpRequest();   
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText.trim();
			if(items.split("::")[1].trim()==""){
				swal({
					type: 'error',
					title: 'WhatsApp Message',
					text: 'Mobile not configured'       
				});
			}
			else if(items.split("::")[2].trim()==""){
				swal({
					type: 'error',
					title: 'WhatsApp Message',
					text: 'Message not configured'       
				});
			}
			else{
				var sendmobile=items.split("::")[1].trim();     
				var sendmessage=items.split("::")[2].trim();
				funSendWhatsApp(sendmessage,sendmobile);
			}
			/* if(items=="success")   
			{
				$.messager.alert('Message', ' Mail Sent ','info');   
			}
			else    
			{
				$.messager.alert('Message', ' Not Sent ','warning');
			} */            
		 }
		} 
		x.open("GET","sendMail.jsp?rdocno="+$('#txtrdocno').val()+'&amendment='+amendment+'&brhid='+$('#cmbbranch').val()+'&id='+id,true);                    
		x.send();   
		}
 function reloadtravel(){
	 var brhid=document.getElementById("cmbbranch").value; 
 	 var locid=document.getElementById("cmblocation").value;
 	 var todate=$('#todate').jqxDateTimeInput('val'); 
	 $('#traveldiv').load('travelGrid.jsp?check=1'+'&brhid='+brhid+'&locid='+locid+'&todate='+todate);
 }           
 function funtoursopen(){
		 var docno=document.getElementById("ttypeid").value;   
		 var path1="com/dashboard/travel/tours/tours.jsp";
		 var name="Tours";  
		 var url=document.URL;
		 var reurl=url.split("com");    

		 window.parent.formName.value="Tours";
		 window.parent.formCode.value="TRS";
		 var detName="Tours";

		 var path= path1+"?docno="+docno;  

		 top.addTab( detName,reurl[0]+""+path);                   

		 }

function funCreateCPUtraftervalidation(cmode){ 
				var brhid=$('#cmbbranch').val();              
				var docno=$('#txtrdocno').val();
				var hotel=$('#hidhotel').val();    
				var location=$('#hidlocation').val();    
				var vocno=$('#hidvocno').val();  
				var vndid=$('#hidvndno').val();            
				var netamt=$('#hidnetamt').val(); 
				var gridarray=new Array(); 
				var gridarray2=new Array();  
				var gridarray3=new Array(); 
				var total=0.0,vatamt=0.0,netamt=0.0,vatper=0.0;        
				var rows = $("#tourGrid").jqxGrid('getrows'); 
			 /*	for(var i=0 ; i < rows.length ; i++){       
					   var chks=rows[i].tourname;  
					   var stdtotal=rows[i].stdtotal;               
					   var taxtype=rows[i].tourtaxtype;   
				 	   if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){         
					   gridarray3.push(rows[i].rowno);                                    
					   gridarray2.push(rows[i].vndid);
					   if(taxtype=="INCLUSIVE"){ 
						   vatper=5;
						   vatamt=parseFloat(stdtotal)-((parseFloat(stdtotal)/105)*100);    
						   total=parseFloat(stdtotal)-vatamt;
						   netamt=parseFloat(stdtotal);        
					   }else if(taxtype=="EXCLUSIVE"){
						   vatper=5;
						   vatamt=(parseFloat(stdtotal)*5)/100;    
						   total=parseFloat(stdtotal);
						   netamt=parseFloat(stdtotal)+vatamt; 
					   }else{
						   vatamt=0.0;    
						   total=parseFloat(stdtotal);  
						   netamt=parseFloat(stdtotal);     
					   }   
					   gridarray.push(0+" :: "+1+" :: "+(rows[i].tourname+" - "+rows[i].date+" - "+rows[i].remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" ::"+0+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: ");    
				 	   }
				 	}    */    
			   $.messager.confirm('Message', 'Do you want to create Ni Purchase?', function(r){          
					     	if(r==false)
					     	  {
					     		return false; 
					     	  }  
					     	else {
					    	     createCPUtr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,cmode,brhid);      
					     	}  
					 });      
			}   
			function createCPUtr(docno,vndid,netamt,gridarray,vocno,gridarray2,gridarray3,cmode,brhid){     
				//alert("cmode=="+cmode);         
				var x=new XMLHttpRequest();  
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim().split('###');                  
				   if(parseInt(items[0])>=1)              
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'CPU -'+items[1]+'  Created Successfully'              
						});
					  // sendTypeContent('sendTypeWindow.jsp'); 
					  if(cmode==1){
					      funSendMail(items[2]);    
					  }else if(cmode==2){
					      funSendWhatsapp();
					  }else if(cmode==3){
					     funSendMailWhatsapp(items[2]);     
					  }else{}  
					}
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created' 
						});
					}
				}   
				}   
				x.open("GET","createCPUtr.jsp?rowarray="+gridarray3+"&vocno="+vocno+"&vndid="+vndid+"&netamt="+netamt+"&gridarray="+gridarray+"&gridarray2="+gridarray2+"&type="+$('#hidtype').val()+"&docno="+docno+"&brhid="+brhid,true);                                             
				x.send();
			}
		function setsalesman(){         
			  var userid="<%= session.getAttribute("USERID").toString() %>";
			  $.ajax({
					  url: "getSalesman.jsp",
					  type: "post",
					  data: {userid:userid},
					  success: function(data){              
						  var items=data.trim().split('###'); 
						  $('#jqxSalesmantr').val(items[0]);            
						  $('#salesmanidtr').val(items[1]);             
					  },
					  error:function(){
					  }   
				});   
			}
  </script>  
 <div id="printWindow">
	<div></div><div></div>
</div>
</form>   
</body>   
</html>