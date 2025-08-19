<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Delivery Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">

<%-- <jsp:include page="../../../../includeswithoutcss.jsp"></jsp:include> --%>
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />

  <style type="text/css">
  	body {
		font: 12px Tahoma;
		background: #E0ECF8;
	}
	input[type="text"]{
		height: 34px;
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
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
	.chip {
  		display: inline-block;
    	padding: 0 15px;
    	height: 25px;
    	font-size: 12px;
    	line-height: 25px;
    	border-radius: 4px;
    	background-color: #f1f1f1;
    	margin-right:5px;
    	margin-bottom:5px;
	}
	
	.closebtn {
  padding-left: 10px;
  color: #888;
  font-weight: bold;
  float: right;
  font-size: 16px;
  cursor: pointer;
}

.closebtn:hover {
  color: #000;
}
  </style>
</head>
<body>
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    <form autocomplete="off">
  		<div class="container-fluid">
    		<div class="row rowgap">
      			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      				<!-- <div class="primarypanel custompanel"><select name="cmbbranch" id="cmbbranch" class="form-control"><option value="">--Select--</option></select></div> -->
        			<div class="primarypanel custompanel">
  						<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        				<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        				<select name="cmbbranch" id="cmbbranch" style="min-width:125px;" class="form-control"><option value="">--Select--</option></select>
       					<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="todate" data-toggle="tooltip" title="To Date"></div>
        				<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="fromdate" data-toggle="tooltip" title="From Date"></div>
        			</div>
        			<div class="actionpanel custompanel">
          				<button type="button" class="btn btn-default" id="btncableissue" data-target="#modalcableissue"><i class="fa fa-superpowers " aria-hidden="true" data-toggle="tooltip" title="Cable Issue" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-hourglass-start " aria-hidden="true" data-toggle="tooltip" title="Delivery Start" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default" id="btnjobstatus"  data-target="#modaldeliveryend" ><i class="fa fa-hourglass-end " aria-hidden="true" data-toggle="tooltip" title="Delivery End" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default" id="btnbranching"  data-target="#modalbranching" ><i class="fa fa-arrows " aria-hidden="true" data-toggle="tooltip" title="Branching" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default hidden" id="btnteamselection" data-target="#modalteamselection"><i class="fa fa-users " aria-hidden="true" data-toggle="tooltip" title="Team Selection" data-placement="bottom"></i></button>
      				</div>
        			<div class="warningpanel custompanel hidden">
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnpartsdelay" data-toggle="tooltip" title="Parts Delay" data-placement="bottom" data-filtervalue="Delayed" data-datafield="partsstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-partsdelay">3</span>
          				</div>	
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnhrsexceeded" data-toggle="tooltip" title="Hours Exceeded" data-placement="bottom"  data-filtervalue="0" data-datafield="hrsdiff" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-hourglass-2 " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-hrsexceeded">3</span>
          				</div>
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnoverdue" data-toggle="tooltip" title="Overdue" data-placement="bottom"   data-filtervalue="0" data-datafield="promiseddate" data-filtertype="datefilter"  data-filtercondition="LESS_THAN"><i class="fa fa-toggle-up " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-overdue">3</span>
          				</div>
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnextendeddate" data-toggle="tooltip" title="Extended Date" data-placement="bottom"  data-filtervalue="0" data-datafield="extdate" data-filtertype="datefilter"  data-filtercondition="NOT_NULL"><i class="fa fa-level-up " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-extendeddate">3</span>
          				</div>
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnhighpriority" data-toggle="tooltip" title="High Priority" data-placement="bottom" data-filtervalue="High" data-datafield="priority" data-filtertype="stringfilter"  data-filtercondition="contains"><i class="fa fa-exclamation-triangle " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-highpriority">3</span>
          				</div>
          				<div class="btn-group" role="group">
          					<button type="button" class="btn btn-default" id="btnunattended" data-toggle="tooltip" title="Un Attended" data-placement="bottom" data-filtervalue="0" data-datafield="unattendedstatus" data-filtertype="numericfilter"  data-filtercondition="GREATER_THAN"><i class="fa fa-low-vision " aria-hidden="true"></i></button>
          					<span class="badge badge-notify badge-unattended">3</span>
          				</div>
        			</div>
        			<div class="detailpanel custompanel hidden">
          				<button type="button" class="btn btn-default" id="btnpartsdetails"  data-target="#modalpartsdetails" ><i class="fa fa-cogs " aria-hidden="true" data-toggle="tooltip" title="Parts Details" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default" id="btnworks" data-target="#modalworksdetails" ><i class="fa fa-list-alt " aria-hidden="true" data-toggle="tooltip" title="Works" data-placement="bottom"></i></button>
          				<button type="button" class="btn btn-default" id="btnvehmovement" data-target="#modalvehmovement"><i class="fa fa-exchange " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Status" data-placement="bottom"></i></button>  
        			</div>
        			<div class="otherpanel custompanel">
        				<button type="button" class="btn btn-default" id="deliveryprint"  ><i class="fa fa-print " aria-hidden="true" data-toggle="tooltip" title="Delivery Print" data-placement="bottom"></i></button>
        				<button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        			</div>
        			<div class="textpanel custompanel">
						<p class="h4">&nbsp;</p>
        			</div>
      			</div>
    		</div>
    		<div class="row">
      			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        			<div id="delmgmtgriddiv"><jsp:include page="delMgmtGrid.jsp"></jsp:include></div>
      			</div>
    		</div>
	
	<div id="modalbranching" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Branching Details</h4>
          		</div>
          		<div class="modal-body">
            		<p><!-- Some text in the modal. --></p>
            		<div class="container-fluid">
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Done By
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<select name="cmbbrdoneby" id="cmbbrdoneby" class="form-control" style="width:100%;">
            						<option value="">--Select--</option>
            						<option value="1">Own</option>
            						<option value="2">Client</option>
            						<option value="3">Vendor</option>
            					</select>
							</div>
            			</div>
            			<div id="brvendorrow" class="collapse" aria-expanded="false">
            				<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Vendor
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
	            					<input type="text" name="brvendor" id="brvendor" class="form-control" onkeyup="funFilterList(id);">
	            					<ul class="list-group hidden" data-type="vendor" style="max-height:200px;overflow-y:auto;"></ul>
	            				</div>
	            			</div>
	            			<div class="row rowgap">
	            				
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Inv No
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
	            					<input type="text" name="brvendorinvno" id="brvendorinvno" class="form-control" >
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Inv Date
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
	            					<div id="brvendorinvdate" name="brvendorinvdate"></div>
	            				</div>
	            			</div>
	            			<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-offset-1 col-md-2 col-lg-2 text-right">
	            					Amount
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="brvendoramt" id="brvendoramt" class="form-control text-right" >
	            				</div>	            				
	            				<div class="col-xs-12 col-sm-12 col-md-1 col-lg-1 text-right">
	            					VAT
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="brvendorvatamt" id="brvendorvatamt" class="form-control text-right" disabled="true">
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2 text-right">
	            					Net Amount
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="brvendornetamt" id="brvendornetamt" class="form-control text-right"  disabled="true">
	            				</div>
	            			</div>
            			</div>
            			
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Fleet
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="brfleetno" id="brfleetno" class="form-control" onkeyup="funFilterList(id);">
            					<ul class="list-group hidden" data-type="fleet" style="max-height:200px;overflow-y:auto;"></ul>
							</div>
            			</div>
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Driver
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="brdriver" id="brdriver" class="form-control">
								<ul class="list-group hidden" data-type="driver" style="max-height:200px;overflow-y:auto;"></ul>
							</div>
            			</div>
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Start Date &amp; Time</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="startdate"></div></div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="starttime"></div></div>
            					</div>
            				</div>
						</div>
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Start Km &amp; Fuel</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<input type="text" name="startkm" id="startkm" class="form-control" style="text-align:right;">
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<select name="cmbstartfuel" id="cmbstartfuel" class="form-control">
            								<option value="">--Select--</option>
            								<option value=0.000>Level 0/8</option>
            								<option value=0.125>Level 1/8</option>
            								<option value=0.250>Level 2/8</option>
            								<option value=0.375>Level 3/8</option>
            								<option value=0.500>Level 4/8</option>
    										<option value=0.625>Level 5/8</option>
    										<option value=0.750>Level 6/8</option>
    										<option value=0.875>Level 7/8</option>
    										<option value=1.000>Level 8/8</option>
            							</select>
            						</div>
            					</div>
            				</div>
						</div>
						<div id="brownrow" class="collapse" aria-expanded=false>
							<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">End Date &amp; Time</div>
	            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
	            					<div class="row">
	            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="enddate"></div></div>
	            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="endtime"></div></div>
	            					</div>
	            				</div>
							</div>
							<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">End Km &amp; Fuel</div>
	            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
	            					<div class="row">
	            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	            							<input type="text" name="endkm" id="endkm" class="form-control" style="text-align:right;">
	            						</div>
	            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
	            							<select name="cmbendfuel" id="cmbendfuel" class="form-control">
	            								<option value="">--Select--</option>
	            								<option value=0.000>Level 0/8</option>
	            								<option value=0.125>Level 1/8</option>
	            								<option value=0.250>Level 2/8</option>
	            								<option value=0.375>Level 3/8</option>
	            								<option value=0.500>Level 4/8</option>
	    										<option value=0.625>Level 5/8</option>
	    										<option value=0.750>Level 6/8</option>
	    										<option value=0.875>Level 7/8</option>
	    										<option value=1.000>Level 8/8</option>
	            							</select>
	            						</div>
	            					</div>
	            				</div>
							</div>
						</div>
						<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Address</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="braddress" id="braddress" class="form-control">
							</div>
            			</div>
						<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Remarks</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="brremarks" id="brremarks" class="form-control">
							</div>
            			</div>
            		</div>
            	</div>
            	<div class="modal-footer text-right">
            		<button type="button" name="btnbrupdate" id="btnbrupdate" class="btn btn-default btn-primary">UPDATE</button>
          		</div>
          	</div>
        </div>
	</div>
	
	<div id="modalcableissue" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Cable Issue of <span class="contract-details"></span></h4>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row rowgap opasset-section">
							<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Asset Groups &amp; Qty</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<select name="cmbassetgroup" id="cmbassetgroup" class="form-control" style="width:100%;">
            								<option value="">--Select--</option>
            							</select>
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
            							<input type="text" name="assetgroupqty" id="assetgroupqty" class="form-control text-right" onkeypress="return isNumber(event)">
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
            							<button type="button" class="btn btn-default" id="btnaddasset" onclick="funAddAssets();">Add</button>
            						</div>
            					</div>
            					<div class="row chips" style="padding-left:15px;margin-top:5px;">
            						
            					</div>
            				</div>
						</div>
					</div>
				</div>
				<div class="modal-footer text-right">
            		<button type="button" name="btncableissuesave" id="btncableissuesave" class="btn btn-default">Save Changes</button>
            	</div>
			</div>
		</div>
	</div>
    <!-- Vehicle Movement Modal-->
    <div id="modalvehmovupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Delivery Start Details</h4>
          		</div>
          		<div class="modal-body">
            		<p><!-- Some text in the modal. --></p>
            		<div class="container-fluid">
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Done By
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<select name="cmbdoneby" id="cmbdoneby" class="form-control" style="width:100%;">
            						<option value="">--Select--</option>
            						<option value="1">Own</option>
            						<option value="2">Client</option>
            						<option value="3">Vendor</option>
            					</select>
							</div>
            			</div>
            			<div id="vendorrow" class="collapse" aria-expanded="false">
            				<div class="row rowgap">
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Vendor
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
	            					<input type="text" name="vendor" id="vendor" class="form-control" onkeyup="funFilterList(id);">
	            					<ul class="list-group hidden" data-type="vendor" style="max-height:200px;overflow-y:auto;"></ul>
	            				</div>
	            			</div>
	            			<div class="row rowgap">
	            				
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Inv No
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
	            					<input type="text" name="vendorinvno" id="vendorinvno" class="form-control" >
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
	            					Inv Date
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
	            					<div id="vendorinvdate" name="vendorinvdate"></div>
	            				</div>
	            			</div>
	            			<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-offset-1 col-md-2 col-lg-2 text-right">
	            					Amount
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="vendoramt" id="vendoramt" class="form-control text-right" >
	            				</div>	            				
	            				<div class="col-xs-12 col-sm-12 col-md-1 col-lg-1 text-right">
	            					VAT
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="vendorvatamt" id="vendorvatamt" class="form-control text-right" disabled="true">
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2 text-right">
	            					Net Amount
	            				</div>
	            				<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
	            					<input type="text" name="vendornetamt" id="vendornetamt" class="form-control text-right"  disabled="true">
	            				</div>
	            			</div>
            			</div>
            			
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Fleet
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="fleetno" id="fleetno" class="form-control" onkeyup="funFilterList(id);">
            					<ul class="list-group hidden" data-type="fleet" style="max-height:200px;overflow-y:auto;"></ul>
							</div>
            			</div>
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Driver
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="driver" id="driver" class="form-control">
								<ul class="list-group hidden" data-type="driver" style="max-height:200px;overflow-y:auto;"></ul>
							</div>
            			</div>
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Start Date &amp; Time</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="indate"></div></div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="intime"></div></div>
            					</div>
            				</div>
						</div>
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Start Km &amp; Fuel</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<input type="text" name="inkm" id="inkm" class="form-control" style="text-align:right;">
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<select name="cmbinfuel" id="cmbinfuel" class="form-control">
            								<option value="">--Select--</option>
            								<option value=0.000>Level 0/8</option>
            								<option value=0.125>Level 1/8</option>
            								<option value=0.250>Level 2/8</option>
            								<option value=0.375>Level 3/8</option>
            								<option value=0.500>Level 4/8</option>
    										<option value=0.625>Level 5/8</option>
    										<option value=0.750>Level 6/8</option>
    										<option value=0.875>Level 7/8</option>
    										<option value=1.000>Level 8/8</option>
            							</select>
            						</div>
            					</div>
            				</div>
						</div>
						<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Delivery Address</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="address" id="address" class="form-control">
							</div>
            			</div>
						<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Contact Person </div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="inremarks" id="inremarks" class="form-control">
							</div>
            			</div>
            			<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Mobile </div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="inmobile" id="inmobile" class="form-control">
							</div>
            			</div>
            		</div>
            	</div>
            	<div class="modal-footer text-right">
            		<button type="button" name="btninupdate" id="btninupdate" class="btn btn-default btn-primary">UPDATE</button>
          		</div>
          	</div>
        </div>
	</div>
	<div id="modaldeliveryend" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Delivery End Details</h4>
          		</div>
          		<div class="modal-body">
            		<p><!-- Some text in the modal. --></p>
            		<div class="container-fluid">
            			
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">End Date &amp; Time</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="outdate"></div></div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"><div id="outtime"></div></div>
            					</div>
            				</div>
						</div>
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">End Km &amp; Fuel</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div class="row">
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<input type="text" name="outkm" id="outkm" class="form-control" style="text-align:right;">
            						</div>
            						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            							<select name="cmboutfuel" id="cmboutfuel" class="form-control">
            								<option value="">--Select--</option>
            								<option value=0.000>Level 0/8</option>
            								<option value=0.125>Level 1/8</option>
            								<option value=0.250>Level 2/8</option>
            								<option value=0.375>Level 3/8</option>
            								<option value=0.500>Level 4/8</option>
    										<option value=0.625>Level 5/8</option>
    										<option value=0.750>Level 6/8</option>
    										<option value=0.875>Level 7/8</option>
    										<option value=1.000>Level 8/8</option>
            							</select>
            						</div>
            					</div>
            				</div>
						</div>
						<div class="row rowgap">
        		    		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">Remarks</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" name="outremarks" id="outremarks" class="form-control">
							</div>
            			</div>
            		</div>
            	</div>
            	<div class="modal-footer text-right">
            		<button type="button" name="btnoutupdate" id="btnoutupdate" class="btn btn-default">UPDATE</button>
            	</div>
          	</div>
        </div>
	</div>
	
</div>


    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Comments</h4>
          </div>
          <div class="modal-body">
            <div class="comments-outer-container container-fluid">
              <div class="comments-container">
                
              </div>
              <div class="create-msg-container">
                <!-- <div class="container-fluid"> -->
                  <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      <div class="input-group">
                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        <div class="input-group-btn">
                          <button type="button" id="btncommentsend" class="btn btn-default">
                            <i class="fa fa-paper-plane"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                <!-- </div> -->
              </div>
            </div>
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>
  </div>
  </form>
  <input type="hidden" name="jobcarddocno" id="jobcarddocno">
  <input type="hidden" name="jobcardvocno" id="jobcardvocno">
  <input type="hidden" name="deldocno" id="deldocno">
  <input type="hidden" name="jobcardbrid" id="jobcardbrid">
  <input type="hidden" name="z1count" id="z1count">
  <input type="hidden" name="z2count" id="z2count">
  <input type="hidden" name="z3count" id="z3count">
  <input type="hidden" name="z4count" id="z4count">
  <input type="hidden" name="z5count" id="z5count">
  <input type="hidden" name="z6count" id="z6count">
  <input type="hidden" name="z7count" id="z7count">
  <input type="hidden" name="z8count" id="z8count">
  <input type="hidden" name="z9count" id="z9count">
  <input type="hidden" name="z10count" id="z10count">
  <input type="hidden" name="z11count" id="z11count">
  <input type="hidden" name="z12count" id="z12count">
  <input type="hidden" name="z13count" id="z13count">
  <input type="hidden" name="z14count" id="z14count">
  <input type="hidden" id="delstartkm" name="delstartkm">
<div  id="delstartdate" name="delstartdate" hidden="true"></div>
<div  id="delstarttime" name="delstarttime"  hidden="true"></div>
  
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script type="text/javascript">
	(function($) {
		$.fn.inputFilter = function(inputFilter) {
	    	return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
	      		if (inputFilter(this.value)) {
	        		this.oldValue = this.value;
	        		this.oldSelectionStart = this.selectionStart;
	        		this.oldSelectionEnd = this.selectionEnd;
	      		} else if (this.hasOwnProperty("oldValue")) {
	        		this.value = this.oldValue;
	        		this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
	      		} else {
	        		this.value = "";
	      		}
	    	});
	  	};
	}(jQuery));
    $(document).ready(function(){
    	$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		var onemonthbefore=new Date();
		onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
		$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
		
        $('[data-toggle="tooltip"]').tooltip(); 
        $('#cmbdoneby,#cmbbranch,#cmbbrdoneby').select2();
        getInitData();
        funGetCountData();
        $("#indate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#intime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#outtime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $("#startdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#starttime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#endtime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        
        $("#delstartdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#delstarttime").jqxDateTimeInput({ width: '80px', height: '15px', formatString:"HH:mm",showCalendarButton:false});
        $("#vendorinvdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        $("#brvendorinvdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
        
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	    
        
        $('.load-wrapp').hide();
     
        $('#btncableissuesave').click(function(){
        	if($('#jobcarddocno').val()=='' || $('#jobcarddocno').val()=='0' || $('#jobcarddocno').val()=='undefined'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select valid document'
				});
        		return false;
        	}
        	
        	if($('.chips .chip.new-chip').length==0){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select valid cables'
				});
        		return false;
        	}
        	
        	var cablearray=new Array();
        	$('.chips .chip.new-chip').each(function(){
        		cablearray.push($(this).attr('data-docno')+"::"+$(this).find('span.chip-qty').text());
        	});
        	
        	$.post('saveCableIssue.jsp',{'docno':$('#jobcarddocno').val(),'cablearray[]':cablearray},function(data,status){
        		data=JSON.parse(data);
        		if(data.errorstatus=="0"){
        			
 					$('.modal.fade.in').modal('hide');
 					funTriggerSubmit();
 					Swal.fire({
						icon: 'success',
						title: 'Message',
						text: 'Cable issued for Contract No: '+$('#jobcardvocno').val()
					});
 				}
 				else{
 					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Not Updated'
					});
 				}
        		$('#cmbassetgroup').val(null).trigger('change');
    			$('#assetgroupqty').val('');
    			$('.chips').empty();
    			$('#jobcarddocno,#jobcardvocno').val('');
    			$('.textpanel p').text(' ');
    			$('.contract-details').text('');
        	});
        });
        
        $('#deliveryprint').click(function(){
        	var url=document.URL;
			//var reurl=url.split("delMgmt.jsp");
			var reurl=url.split("com/");
			//alert("brnahc=="+$('#cmbbranch').val());
			
				var win= window.open(reurl[0]+"printRentalContract11?docno="+document.getElementById("jobcarddocno").value+"&deldocno="+document.getElementById("deldocno").value+"&brhid="+document.getElementById("jobcardbrid").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				
				win.focus();
        });
        
        $("#inkm").inputFilter(function(value) {
    		return /^\d*$/.test(value);    // Allow digits only, using a RegExp
  		});
  		$("#outkm").inputFilter(function(value) {
    		return /^\d*$/.test(value);    // Allow digits only, using a RegExp
  		});
  		$("#startkm").inputFilter(function(value) {
    		return /^\d*$/.test(value);    // Allow digits only, using a RegExp
  		});
  		$("#endkm").inputFilter(function(value) {
    		return /^\d*$/.test(value);    // Allow digits only, using a RegExp
  		});
  		$("#vendoramt,#vendorvatamt,#vendornetamt,#brvendoramt,#brvendorvatamt,#brvendornetamt").inputFilter(function(value) {
    		return /^\d*$/.test(value);    // Allow digits only, using a RegExp
  		});
  		$('#vendoramt').change(function(){
  			if($('#vendor').val()==''){
  				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a vendor'
				});
        		return false;
  			}
  			var taxpercent=$('#vendor').attr('data-taxpercent');
  			if(taxpercent=="" || taxpercent=="undefined" || taxpercent==null || typeof(taxpercent)=="undefined"){
  				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Tax not configured'
				});
        		return false;
  			}
  			$('#vendorvatamt,#vendornetamt').attr('disabled',false);
  			var vatamt=parseFloat($(this).val())*(parseFloat(taxpercent)/100);
  			vatamt=vatamt.toFixed(2);
  			var netamt=parseFloat($(this).val())+parseFloat(vatamt);
  			netamt=netamt.toFixed(2);
  			$('#vendorvatamt').val(vatamt);
  			$('#vendornetamt').val(netamt);
  			$('#vendorvatamt,#vendornetamt').attr('disabled',true);
  		});
  		$('#brvendoramt').change(function(){
  			if($('#brvendor').val()==''){
  				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a vendor'
				});
        		return false;
  			}
  			var taxpercent=$('#brvendor').attr('data-taxpercent');
  			if(taxpercent=="" || taxpercent=="undefined" || taxpercent==null || typeof(taxpercent)=="undefined"){
  				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Tax not configured'
				});
        		return false;
  			}
  			$('#brvendorvatamt,#brvendornetamt').attr('disabled',false);
  			var vatamt=parseFloat($(this).val())*(parseFloat(taxpercent)/100);
  			vatamt=vatamt.toFixed(2);
  			var netamt=parseFloat($(this).val())+parseFloat(vatamt);
  			netamt=netamt.toFixed(2);
  			$('#brvendorvatamt').val(vatamt);
  			$('#brvendornetamt').val(netamt);
  			$('#brvendorvatamt,#brvendornetamt').attr('disabled',true);
  		});
  		$('#cmbdoneby').on("change", function (e) {  			
  			if($(this).val()=="3"){
  				$('#vendorrow').collapse("show");
  			}
  			else{
  				if($("#vendorrow").hasClass('in')){
  					$('#vendorrow').collapse("hide");
  				}
  			}
  		});
  		$('#cmbbrdoneby').on("change", function (e) {  			
  			if($(this).val()=="3"){
  				$('#brvendorrow').collapse("show");
  			}
  			else{
  				if($("#brvendorrow").hasClass('in')){
  					$('#brvendorrow').collapse("hide");
  				}
  			}
  			if($(this).val()=="1"){
  				$('#brownrow').collapse("show");
  			}
  			else{
  				if($("#brownrow").hasClass('in')){
  					$('#brownrow').collapse("hide");
  				}
  			}
  		});
        $('#btnsubmit').click(function(){
        	funGetCountData();
        	var brhid=$('#cmbbranch').val();
        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	 		var todate=$('#todate').jqxDateTimeInput('val');
	 		$("#overlay, #PleaseWait").show();
        	$('#delmgmtgriddiv').load('delMgmtGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
        });
        $('#fleetno,#driver,#vendor,#brfleetno,#brdriver,#brvendor').click(function(){
        	var targetid=$(this).attr('id');
        	var doneby="";
        	if(targetid=="brfleetno" || targetid=="brdriver" || targetid=="brvendor"){
        		doneby=$('#cmbbrdoneby').val();	
        	}
        	else{
        		doneby=$('#cmbdoneby').val();
        	}
        	
        	if(doneby=='1'){
        		$(this).closest('div').find('ul.list-group').removeClass('hidden');
        	}
        	if(($(this).attr('id')=='vendor' || $(this).attr('id')=='brvendor') && doneby=='3'){
        		$(this).closest('div').find('ul.list-group').removeClass('hidden');
        	}
        });
        $('#btnexcel').click(function(){
        	$("#floorMgmtGrid").excelexportjs({
				containerid: "floorMgmtGrid",
				datatype: 'json',
				dataset: null,
				gridId: "floorMgmtGrid",
				columns: getColumns("floorMgmtGrid"),
				worksheetName: "Delivery Management Data of Equipments"
			});
        });
       	
        $('.actionpanel button,.detailpanel button,#btncomment').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	var selectedrows=$('#floorMgmtGrid').jqxGrid('getselectedrowindexes');
        	if(selectedrows.length==0 && $(this).attr('id')!='btncableissue'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	if(modaltarget=="#modalbranching"){
        		for(var i=0;i<selectedrows.length;i++){
		        	var doctype=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doctype');
		        	if(doctype!="PIK"){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Only Pickup Allowed'
						});
		        		return false;
		        	}
        		}
        	}
        	if(modaltarget=="#modalvehmovupdate"){
        		for(var i=0;i<selectedrows.length;i++){
        			var delmode=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'delmode');
		        	var doctype=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doctype');
		        	if(doctype=="PIK"){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Pickup Not Allowed'
						});
		        		return false;
		        	}
		        	if(parseInt(delmode)>=1){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Delivery started'
						});
		        		return false;
		        	}	
        		}
        		
        	}
        	if(modaltarget=="#modaldeliveryend"){
        		for(var i=0;i<selectedrows.length;i++){
	        		var delmode=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'delmode');
		        	if(parseInt(delmode)<1){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Please start delivery'
						});
		        		return false;
		        	}
		        	if(parseInt(delmode)>=2){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Delivery Completed'
						});
		        		return false;
		        	}
		        	var doneby=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doneby');
	        		if(doneby!="1"){
		        		Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Delivery started by vendor,cannot make delivery end'
						});
		        		return false;
		        	}
		        }
        	}
        	
        	if($(this).attr('id')=='btncableissue' && jobcarddocno==''){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a valid document'
				});
        		return false;
        	}
        	$(modaltarget).modal('show');
        });
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(txtcomment==""){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        $('#btnoutupdate').click(function(){
        	var fleetno="0",drvdocno="0";
        	var selectedrows=$('#floorMgmtGrid').jqxGrid('getselectedrowindexes');
        	
        	if(selectedrows.length==0){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	if($('#outdate').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Date'
				});
        		return false;
        	}
        	var outdatetemp=$('#outdate').jqxDateTimeInput('getDate');
        	outdatetemp.setHours(0,0,0,0);
        	var delstartdate=$('#delstartdate').jqxDateTimeInput('getDate');
        	delstartdate.setHours(0,0,0,0);
        	if(outdatetemp<delstartdate){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Delivery End date cannot be less than delivery start date'
				});
        		return false;
        	}
        	if($('#outtime').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Time'
				});
        		return false;
        	}
        	if(delstartdate-outdatetemp==0){
        		var outtimetemp=$('#outtime').jqxDateTimeInput('getDate');
        		var delstartttime=$('#delstarttime').jqxDateTimeInput('getDate');
        		if(outtimetemp.getHours()<delstartttime.getHours()){
    				Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Delivery End time cannot be less than delivery start time'
					});
	        		return false;
    			}
    			if(outtimetemp.getHours()==delstartttime.getHours()){
    				if(outtimetemp.getMinutes()<delstartttime.getMinutes()){
    					Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Delivery End time cannot be less than delivery start time'
						});
		        		return false;
    				}
    			}
        	}
        	if($('#outkm').val()==''){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please enter Km'
				});
        		return false;
        	}
        	if(parseFloat($('#outkm').val())<parseFloat($('#delstartkm').val())){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Delivery End km cannot be less than delivery start km'
				});
        		return false;
        	}
        	if($('#cmboutfuel').val()==''){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Fuel'
				});
        		return false;
        	}
        	
        	var outdate=$('#outdate').jqxDateTimeInput('val');
        	var outtime=$('#outtime').jqxDateTimeInput('val');
        	var outremarks=$('#outremarks').val();
        	var docno=$('#jobcarddocno').val();
        	var km=$('#outkm').val();
        	var fuel=$('#cmboutfuel').val();
        	var errorstatus="0";
        	var strequipno="";
        	var gridarray=new Array();
        	for(var i=0;i<selectedrows.length;i++){
        		if(strequipno==""){
        			strequipno+=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		else{
        			strequipno+=","+$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		var calcdocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
       			var equipno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
       			docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
	        	var fleetno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'delfleetno');
	        	var doneby=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doneby');						
        		gridarray.push(calcdocno+" :: "+equipno+" :: "+docno+" :: "+fleetno+" :: "+doneby);
        	}
        	Swal.fire({
				icon: 'warning',
				title: 'Are you sure?',
				text: "Do you want to create Delivery end for Equip No: "+strequipno,
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
						$.post('saveMovData.jsp',{'gridarray[]':gridarray,'km':km,'fuel':fuel,'date':outdate,'time':outtime,'remarks':outremarks,'mode':2},function(data,status){
			 				data=JSON.parse(data);
			 				errorstatus=data.errorstatus;
			 				if(errorstatus=="0"){
			 					$('.modal.fade.in').modal('hide');
			 					funTriggerSubmit();
			 					Swal.fire({
									icon: 'success',
									title: 'Message',
									text: 'Delivery Ended for Equip No: '+strequipno
								});
			 				}
			 				else{
			 					Swal.fire({
									icon: 'warning',
									title: 'Warning',
									text: 'Not Updated'
								});
			 				}
			        	});	
					
							
				}
			});
        	
        });
        
        $('#btninupdate').click(function(){
        	var fleetno="0",drvdocno="0";
        	var selectedrows=$('#floorMgmtGrid').jqxGrid('getselectedrowindexes');
        	
        	if(selectedrows.length==0){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('#cmbdoneby').val()==''){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select done by'
				});
        		return false;
        	}
        	if($('#fleetno').val()=='' && $('#cmbdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Fleet'
				});
        		return false;
        	}
        	if($('#driver').val()=='' && $('#cmbdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Driver'
				});
        		return false;
        	}
        	if($('#indate').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Date'
				});
        		return false;
        	}
        	if($('#intime').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Time'
				});
        		return false;
        	}
        	if($('#inkm').val()=='' && $('#cmbdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Km'
				});
        		return false;
        	}
        	if($('#cmbinfuel').val()=='' && $('#cmbdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Fuel'
				});
        		return false;
        	}
        	if($('#address').val().length>300){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Address max 300 chars'
				});
        		return false;
        	}
        	if($('#cmbdoneby').val()=='1'){
        		if($('#fleetno').attr('data-fleetno')=='' || typeof($('#fleetno').attr('data-fleetno')) === 'undefined' || $('#fleetno').attr('data-fleetno')===false){
        			Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select Fleet'
					});
	        		return false;	
        		}
        		if($('#driver').attr('data-drvdocno')==''){
        			Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select Driver'
					});
	        		return false;	
        		}
        		fleetno=$('#fleetno').attr('data-fleetno');
        		drvdocno=$('#driver').attr('data-drvdocno');
        	}
        	var fleetname=$('#fleetno').val();
        	var drivername=$('#driver').val();
        	var indate=$('#indate').jqxDateTimeInput('val');
        	var intime=$('#intime').jqxDateTimeInput('val');
        	var inremarks=$('#inremarks').val();
        	var docno=$('#jobcarddocno').val();
        	var km=$('#inkm').val();
        	var fuel=$('#cmbinfuel').val();
        	var address=$('#address').val();
        	var mobile=$('#inmobile').val();
        	var strequipno="";
        	var gridarray=new Array();
        	for(var i=0;i<selectedrows.length;i++){
        		if(strequipno==""){
        			strequipno+=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		else{
        			strequipno+=","+$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		var calcdocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
       			var equipno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
       			var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
        		gridarray.push(calcdocno+"::"+equipno+"::"+docno);
        	}
        	
        	
        	Swal.fire({
				icon: 'warning',
				title: 'Are you sure?',
				text: "Do you want to create Delivery start for Equip No: "+strequipno,
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
					var errorstatus="0";
					var vendordocno="",vendorinvno="",vendoramt="0.0",vendorvatamt="0.0",vendornetamt="0.0",vendorinvdate="";
       				if($('#cmbdoneby').val()=="3"){
       					vendordocno=$('#vendor').attr('data-docno');
       					vendorinvno=$('#vendorinvno').val();
       					vendoramt=$('#vendoramt').val();
       					vendorvatamt=$('#vendorvatamt').val();
       					vendornetamt=$('#vendornetamt').val();
       					vendorinvdate=$('#vendorinvdate').jqxDateTimeInput('val');
       				}
       				$.post('saveMovData.jsp',{'gridarray[]':gridarray,'vendorinvdate':vendorinvdate,'vendordocno':vendordocno,'vendorinvno':vendorinvno,'vendoramt':vendoramt,'vendorvatamt':vendorvatamt,'vendornetamt':vendornetamt,'address':address,'gridindex':i,'gridlength':selectedrows.length,'fleetname':fleetname,'drivername':drivername,'km':km,'fuel':fuel,'doneby':$('#cmbdoneby').val(),'fleetno':fleetno,'drvdocno':drvdocno,'date':indate,'time':intime,'remarks':inremarks,'mobile':mobile,'mode':1},function(data,status){
		 				data=JSON.parse(data);
		 				errorstatus=data.errorstatus;
		 				if(errorstatus=="0"){
		 					$('.modal.fade.in').modal('hide');
		 					$('#btnsubmit').trigger('click');
		 					Swal.fire({
								icon: 'success',
								title: 'Message',
								text: 'Delivery Started for Equip No: '+strequipno
							});
		 				}
		 				else{
		 					Swal.fire({
								icon: 'warning',
								title: 'Warning',
								text: 'Not Updated'
							});
		 				}       	
		        	});
					
					
				}
			});
        	
        });
        
        $('#btnbrupdate').click(function(){
        	var fleetno="0",drvdocno="0";
        	var selectedrows=$('#floorMgmtGrid').jqxGrid('getselectedrowindexes');
        	
        	if(selectedrows.length==0){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	if($('#cmbbrdoneby').val()==''){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select done by'
				});
        		return false;
        	}
        	if($('#brfleetno').val()=='' && $('#cmbbrdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Fleet'
				});
        		return false;
        	}
        	if($('#brdriver').val()=='' && $('#cmbbrdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Driver'
				});
        		return false;
        	}
        	if($('#startdate').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Date'
				});
        		return false;
        	}
        	if($('#starttime').jqxDateTimeInput('getDate')==null){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Time'
				});
        		return false;
        	}
        	if($('#startkm').val()=='' && $('#cmbbrdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Km'
				});
        		return false;
        	}
        	if($('#cmbstartfuel').val()=='' && $('#cmbbrdoneby').val()=='1'){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please select Fuel'
				});
        		return false;
        	}
        	if($('#braddress').val().length>300){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Address max 300 chars'
				});
        		return false;
        	}
        	if($('#cmbbrdoneby').val()=='1'){
        		if($('#brfleetno').attr('data-fleetno')=='' || typeof($('#brfleetno').attr('data-fleetno')) === 'undefined' || $('#brfleetno').attr('data-fleetno')===false){
        			Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select Fleet'
					});
	        		return false;	
        		}
        		if($('#brdriver').attr('data-drvdocno')==''){
        			Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select Driver'
					});
	        		return false;	
        		}
        		fleetno=$('#brfleetno').attr('data-fleetno');
        		drvdocno=$('#brdriver').attr('data-drvdocno');
        	}
        	var fleetname=$('#brfleetno').val();
        	var drivername=$('#brdriver').val();
        	var date=$('#startdate').jqxDateTimeInput('val');
        	var time=$('#starttime').jqxDateTimeInput('val');
        	var remarks=$('#brremarks').val();
        	var docno=$('#jobcarddocno').val();
        	var km=$('#startkm').val();
        	var fuel=$('#cmbstartfuel').val();
        	var address=$('#braddress').val();
        	var strequipno="";
        	var gridarray=new Array();
        	for(var i=0;i<selectedrows.length;i++){
        		if(strequipno==""){
        			strequipno+=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		else{
        			strequipno+=","+$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
        		}
        		var calcdocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'calcdocno');
       			var equipno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'fleet_no');
       			var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
        		gridarray.push(calcdocno+"::"+equipno+"::"+docno);
        	}
        	
        	
        	Swal.fire({
				icon: 'warning',
				title: 'Are you sure?',
				text: "Do you want to create Branching for Equip No: "+strequipno,
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
					var errorstatus="0";
					var vendordocno="",vendorinvno="",vendoramt="0.0",vendorvatamt="0.0",vendornetamt="0.0",vendorinvdate="";
       				var enddate="",endtime="",endkm="0.0",endfuel="0.0";
       				
       				if($('#cmbbrdoneby').val()=="3"){
       					vendordocno=$('#brvendor').attr('data-docno');
       					vendorinvno=$('#brvendorinvno').val();
       					vendoramt=$('#brvendoramt').val();
       					vendorvatamt=$('#brvendorvatamt').val();
       					vendornetamt=$('#brvendornetamt').val();
       					vendorinvdate=$('#brvendorinvdate').jqxDateTimeInput('val');
       				}
       				if($('#cmbbrdoneby').val()=="1"){
       					enddate=$('#enddate').jqxDateTimeInput('val');
       					endtime=$('#endtime').jqxDateTimeInput('val');
       					endkm=$('#endkm').val();
       					endfuel=$('#cmbendfuel').val();
       				}
       				$.post('saveBrData.jsp',{'enddate':enddate,'endtime':endtime,'endkm':endkm,'endfuel':endfuel,'gridarray[]':gridarray,'vendorinvdate':vendorinvdate,'vendordocno':vendordocno,'vendorinvno':vendorinvno,'vendoramt':vendoramt,'vendorvatamt':vendorvatamt,'vendornetamt':vendornetamt,'address':address,'gridindex':i,'gridlength':selectedrows.length,'fleetname':fleetname,'drivername':drivername,'km':km,'fuel':fuel,'doneby':$('#cmbbrdoneby').val(),'fleetno':fleetno,'drvdocno':drvdocno,'date':date,'time':time,'remarks':remarks,'mode':1},function(data,status){
		 				data=JSON.parse(data);
		 				errorstatus=data.errorstatus;
		 				if(errorstatus=="0"){
		 					$('.modal.fade.in').modal('hide');
		 					$('#btnsubmit').trigger('click');
		 					Swal.fire({
								icon: 'success',
								title: 'Message',
								text: 'Branching done for Equip No: '+strequipno
							});
		 				}
		 				else{
		 					Swal.fire({
								icon: 'warning',
								title: 'Warning',
								text: 'Not Updated'
							});
		 				}       	
		        	});
					
					
				}
			});
        	
        });
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#floorMgmtGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#floorMgmtGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
    });
    
    function funFilterList(id) {
    	
	}
    function funTriggerSubmit(){
    	funGetCountData();
        var brhid=$('#cmbbranch').val();
        var fromdate=$('#fromdate').jqxDateTimeInput('val');
 		var todate=$('#todate').jqxDateTimeInput('val');
 		$("#overlay, #PleaseWait").show();
        $('#delmgmtgriddiv').load('delMgmtGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
    }
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnoverdue"){
    		filtervalue=new Date();
    	} 
    	//var filtercondition = 'contains';
    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#floorMgmtGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#floorMgmtGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){
    	var comment=$('#txtcomment').val();
    	var jobcarddocno=$('#jobcarddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				getComments();		
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&jobcarddocno="+jobcarddocno,true);
		x.send();
    }
    function getComments(){
    	var jobcarddocno=$('#jobcarddocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var i=0;i<items.length;i++){
						str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?jobcarddocno="+jobcarddocno,true);
		x.send();
    }
    
    function funGetCountData(){
    	$.get('getCountData.jsp',function(data){
    		data=JSON.parse(data.trim());
    		var htmldata='';
    		$.each(data.fleetdata,function(index,value){
    			htmldata+='<li class="list-group-item"><a href="#" data-fleetno="'+value.fleetno+'">'+value.fleetno+' '+value.fleetname+'</a></li>';
    		});
    		$('ul.list-group[data-type="fleet"]').html($.parseHTML(htmldata));
    		
    		htmldata='';
    		$.each(data.drvdata,function(index,value){
    			htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.drvdocno+'">'+value.drvname+'</a></li>';
    		});
    		$('ul.list-group[data-type="driver"]').html($.parseHTML(htmldata));
    		
    		htmldata='';
    		$.each(data.vendordata,function(index,value){
    			htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.cldocno+'" data-taxpercent="'+value.taxpercent+'">'+value.refname+'</a></li>';
    		});
    		$('ul.list-group[data-type="vendor"]').html($.parseHTML(htmldata));
    		
    		$('ul.list-group[data-type="driver"] li,ul.list-group[data-type="fleet"] li,ul.list-group[data-type="vendor"] li').click(function(){
    			var targettext=$(this).find('a').text();
    			var targetid=$(this).closest('ul').closest('div.col-xs-12').find('input.form-control').attr('id');
    			if(targetid=="fleetno" || targetid=="brfleetno"){
    				$('#'+targetid).val(targettext);
    				$('#'+targetid).attr("data-fleetno",$(this).find('a').attr('data-fleetno'));    				
    			}
    			else if(targetid=="vendor" || targetid=="brvendor"){
    				$('#'+targetid).val(targettext);
    				$('#'+targetid).attr("data-docno",$(this).find('a').attr('data-docno'));
    				$('#'+targetid).attr("data-taxpercent",$(this).find('a').attr('data-taxpercent'));
    			}
    			else{
    				$('#'+targetid).val(targettext);
    				$('#'+targetid).attr("data-drvdocno",$(this).find('a').attr('data-docno'));
    			}
    			$(this).closest('ul').addClass('hidden');
    			return false;
    		});
    		
    	});
    }
	
	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data.trim());
			var htmldata='';
    		$.each(data.branchdata,function(index,value){
	  			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  		});
	  		$('#cmbbranch').html($.parseHTML(htmldata));
	  		$('#cmbbranch').select2();
	  		
	  		htmldata='<option value="">--Select--</option>';
	  		$.each(data.assetgrpdata,function(index,value){
	  			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  		});
	  		$('#cmbassetgroup').html($.parseHTML(htmldata));
	  		$('#cmbassetgroup').select2();
	  		
		});			
	}    
    
	function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if ( (charCode > 31 && (charCode < 48 && charCode!=46)) || charCode > 57) {
            return false;
        }
        return true;
    }
	
	function funAddAssets(){
		if($('#cmbassetgroup').val()!='' && $('#assetgroupqty').val()!=''){
			var chiphtml='';
			var assetdata=$('#cmbassetgroup').select2('data');
			//console.log(assetdata);
			var balqty=$("#cmbassetgroup").select2().find(":selected").data("balqty");
			var restrictAdd=0;
			$('.chips .chip').each(function(){
				if($(this).attr('data-docno')==assetdata[0].id){
					restrictAdd=1;
				}
			});
			if(restrictAdd==1){
				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: assetdata[0].text+' already selected'
				});
				return false;
			}
			var assetqty=$('#assetgroupqty').val()
			
			if(assetqty>balqty){
				Swal.fire({
					icon: 'error',
					title: 'Warning',
					text: 'Maximum quantity for '+assetdata[0].text+' : '+balqty
				});
				return false;
			}
			chiphtml+='<div class="chip new-chip" data-docno="'+assetdata[0].id+'">';
			chiphtml+=assetdata[0].text;
			chiphtml+=': <span class="chip-qty">'+assetqty+'</span>';
			chiphtml+='<span class="closebtn" onclick="this.parentElement.remove();">&times;</span>';
			chiphtml+='</div>';
			
			$('.chips').append($.parseHTML(chiphtml));
		}
	}

  </script>
</body>
</html>
