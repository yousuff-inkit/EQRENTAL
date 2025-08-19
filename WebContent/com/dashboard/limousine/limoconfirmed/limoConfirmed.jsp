<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Booking</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
    <jsp:include page="../../../../bookingIncludes.jsp"></jsp:include>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

    <style type="text/css">
        @media (min-width: 900px) {
            .modal-xl {
                width: 100%;
                max-width: 1200px;
            }
        }
        
        .branch {
            font-weight: normal;
        }
        
        .tabling {
            border: 1px solid red;
            padding-right: 10px;
            padding-left: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
        }
        
        .textpanel {
            color: blue;
        }
        
        .custompanel {
            float: left;
            display: inline-block;
            margin-top: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
            border-radius: 8px;
        }
        
        .badge-notify {
            position: absolute;
            right: -5px;
            top: -8px;
            z-index: 2;
            background-color: red;
        }
        
        .comment {
            background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            clear: both;
            float: right;
            display: block;
            padding-top: 8px;
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 5px;
            border-radius: 12px;
            border-top-right-radius: 0;
            margin-bottom: 8px;
            transition: all 0.5s ease-in;
        }
        
        .msg-details {
            text-align: right;
        }
        
        .comments-container {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 8px;
            padding-right: 5px;
        }
        
        .comments-outer-container {
            width: 100%;
            height: 100%;
        }
        
        .msg {
            word-break: break-all;
        }
        
        .rowgap {
            margin-bottom: 6px;
        }
        .div-inline{
		    display:inline-block;
		}
    </style>
</head>

<body onload="getBranch();">
    <form autocomplete="off">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="branchpanel custompanel form-inline">
                    	<div class="form-group">
    						<label for="cmbbranch" class="col-sm-3 control-label">Branch</label>
						    <div class="col-sm-9">
						        <select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:100%;">
	                        		<option value="">--Select--</option>
	                        	</select>
						 		<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>' />
						 	</div>
						</div>
						<div class="form-group">
							<div id="fromdate"></div>
						</div>
						<div class="form-group">
							<div id="todate"></div>
						</div>
                    </div>
                    <div class="primarypanel custompanel">
                        <button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
                        <div class="dropdown div-inline">
  							<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
  							<ul class="dropdown-menu">
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#FFEBEB;"></i>Reservation</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#e8d4b4;"></i>Job Assigned</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#e8d4b4;"></i>Driver Accepted</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#c06c84;"></i>Change In Time</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#F6F874;"></i>Waiting For Guest</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#B5E3AE;"></i>Trip Started</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#296620;"></i>Trip Ended</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#AEAF9D;"></i>No Show</a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#E88375;"></i>No Vendor Amount </a></li>
    							<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#DBA67B;"></i>Cancelled </a></li>
  							</ul>
						</div>
                        
                    </div>
                    <!-- <div class="actionpanel custompanel">
                        <button type="button" class="btn btn-default" id="btnstatus" data-toggle="modal" data-target="#modalstatusupdate"><i class="fa fa-database " aria-hidden="true" data-toggle="tooltip" title="STATUS UPDATE" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnjobassign" data-toggle="modal" data-target="#modaljobaasign"><i class="fa fa-pencil-square-o " aria-hidden="true" data-toggle="tooltip" title="JOB ASSIGNMENT" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnchangetime" data-toggle="modal" data-target="#modalchangetime"><i class="fa fa-history " aria-hidden="true" data-toggle="tooltip" title="CHANGE IN TIME" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btnconfirmss" data-toggle="modal" data-target="#modalconfirm"><i class="fa fa-check-circle " aria-hidden="true" data-toggle="tooltip" title="CONFIRM" data-placement="bottom"></i></button>
                        <button type="button" class="btn btn-default" id="btntaskcreation" data-toggle="modal" data-target="#modaltaskcreation"><i class="fa fa-plus-square " aria-hidden="true" data-toggle="tooltip" title="TASK CREATION" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnvendorprice"><i class="fa fa-exchange " aria-hidden="true" data-toggle="tooltip" title="Vendor Price" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btncomplete"><i class="fa fa-check-square " aria-hidden="true" data-toggle="tooltip" title="Complete" data-placement="bottom"></i></button>
                    </div>
                    <div class="warningpanel custompanel">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnteamselection" data-toggle="modal" data-target="#modalpendingtask"><i class="fa fa-newspaper-o " aria-hidden="true" data-toggle="tooltip" title="PENDING TASK" data-placement="bottom"></i></button>
                            <span class="badge badge-notify badge-pendingtask"></span>
                        </div>
                        <div class="btn-group hidden" role="group">
                            <button type="button" class="btn btn-default" id="btnconfirm" data-toggle="tooltip" title="Confirmation" data-placement="bottom" data-filtervalue="Confirmation" data-datafield="status"><i class="fa fa-check-square-o " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-confirm"></span>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnjbassign" data-toggle="tooltip" title="Job Assigned" data-placement="bottom" data-filtervalue="Job Assigned" data-datafield="status"><i class="fa fa-file-text " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-jbassign"></span>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" id="btnchngetime" data-toggle="tooltip" title="Change in Time" data-placement="bottom" data-filtervalue="Change in Time" data-datafield="status"><i class="fa fa-clock-o " aria-hidden="true"></i></button>
                            <span class="badge badge-notify badge-chngetime"></span>
                        </div>
                    </div> -->
                    <div class="otherpanel custompanel">
                        <button type="button" class="btn btn-default" id="btncomment" data-toggle="modal" data-target="#modalcomments"><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
                    	<button type="button" class="btn btn-default" id="btnlogs"><i class="fa fa-list " aria-hidden="true" data-toggle="tooltip" title="Logs" data-placement="bottom"></i></button>
                    </div>
                    <div class="textpanel custompanel">
                        <p style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div id="bookdiv">
                        <jsp:include page="bookingGrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
        <!-- Logs Modal -->
		<div id="modallogs" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Logs</h4>
					</div>
					<div class="modal-body">
						<div class="table-responsive">
							<table class="table table-striped" id="tbllogs">
								<thead>
									<tr>
										<th>Branch</th>
										<th>User</th>
										<th>Date &amp; Time</th>
										<th>User Remarks</th>
										<th>System Remarks</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Vendor Price Modal -->
		<div id="modalvendorprice" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Vendor Price</h4>
					</div>
					<div class="modal-body">
						<div class="text-center" style="margin-bottom:15px;"><span class="label label-default vendor-job"></span></div>
						<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Amount</label>
                    			<div class="col-sm-10">
                        			<input type="text" class="form-control text-right" id="vendoramount" name="vendoramount" onblur="funRoundAmt(this.value,this.id);"/>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Discount</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="vendordiscount" id="vendordiscount" class="form-control text-right"  onblur="funRoundAmt(this.value,this.id);">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Net Amount</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="vendornetamount" id="vendornetamount" class="form-control text-right" onblur="funRoundAmt(this.value,this.id);">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnvendorpriceupdate" id="btnvendorpriceupdate">Save changes</button>
					</div>
				</div>
			</div>
		</div>
        <!-- Status update Modal-->
        <div id="modalstatusupdate" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Status Update</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Status</label>
                    			<div class="col-sm-10">
                        			<select class="form-control" name="cmbstatus" id="cmbstatus" style="width: 100%">
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                    			
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="remarks" id="remarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                	<div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdate" id="btnstatuspdate">Save changes</button>
	          		</div>
                </div>
            </div>
        </div>

        <!-- Job Assign Modal-->
        <div id="modaljobaasign" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Job Assignment</h4>
                    </div>
                    <div class="modal-body">
						<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Date</label>
                    			<div class="col-sm-9">
                        			<div id="uptodate"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="cmbprocess" >Process</label>
                    			<div class="col-sm-9">
                    				<select id="cmbprocess" class="form-control">
                                        <option value="">--Select--</option>
                                        <option value="1">Branch Transfer</option>
                                        <option value="2">Assignment</option>
                                    </select>
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="driverss" >Driver</label>
                    			<div class="col-sm-9">
                    				<div id="driverss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="driverSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="driver" id="driver">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="fleetsearchdiv" >Fleet</label>
                    			<div class="col-sm-9">
                    				<div id="fleetsearchdiv" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="fleetSearchInput.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="fleetno" id="fleetno">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="fleetsearchdiv" >Transfer branch</label>
                    			<div class="col-sm-9">
                    				<select id="cmbtransferbranch" class="form-control">
                                        <option value="">--Select--</option>
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>                    	
                    </div>
                    <div class="modal-footer">
                    	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                		<button type="button" class="btn btn-default btn-primary" onclick="funSave();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Change Time Modal-->
        <div id="modalchangetime" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Change In Time</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">New Date</label>
                    			<div class="col-sm-9">
                        			<div id="cgdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">New Time</label>
                    			<div class="col-sm-9">
                        			<div id="cgtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Assign Driver</label>
                    			<div class="col-sm-9">
                        			<div id="cgdriverss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="cgdriverSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="cgdriver" id="cgdriver">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Remarks</label>
                    			<div class="col-sm-9">
                        			<input type="text" class="form-control" placeholder="Remarks" id="cgdesc"></textarea>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-default btn-primary" onclick="funCTSave();">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Comments Modal-->
        <div id="modalcomments" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#CDFDFA">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Comments</h4>
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
        <!-- task creation Modal-->
        <div id="modaltaskcreation" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Task Creation</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Reference Type</label>
                    			<div class="col-sm-9">
                        			<select id="reftype" class="form-control">
                                        <option value="Booking">Booking</option>
                                        <option value="Others">Others</option>
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Reference No</label>
                    			<div class="col-sm-9">
                        			<input type="number" placeholder="Ref.No" id="refno" class="form-control">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Start Date</label>
                    			<div class="col-sm-9">
                        			 <div id="date" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Start Time</label>
                    			<div class="col-sm-9">
                        			<div id="vtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Assigned User</label>
                    			<div class="col-sm-9">
                        			<div id="userss" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="userSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="tuser" id="tuser">
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-3 control-label" for="uptodate">Description</label>
                    			<div class="col-sm-9">
                        			<input type="text" class="form-control" placeholder="Description" id="desc"/>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  		</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-default btn-primary" onclick="funSaveTask();">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Pending Modal-->
        <div id="modalpendingtask" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Pending Task</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">
                            <div class="container-fluid">
                                <table width="100%">
                                    <tr>
                                        <td colspan="6">
                                            <div id="pnddiv">
                                                <jsp:include page="pendingtaskGrid.jsp"></jsp:include>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <div id="flwupdiv">
                                                <jsp:include page="taskfollowupGrid.jsp"></jsp:include>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="7%" align="right">Select Status</td>
                                        <td width="9%">
                                            <select id="assgntask" class="form-control"></select>
                                        </td>
                                        <td width="7%" align="right">Assign To</td>
                                        <td width="4%">
                                            <div id="part" onkeydown="return (event.keyCode!=13);">
                                                <jsp:include page="userSearch2.jsp"></jsp:include>
                                            </div>
                                            <input type="hidden" name="puser" id="puser">
                                        </td>
                                        <td width="5%" align="right">Remarks</td>
                                        <td width="25%">
                                            <input type="text" class="form-control" id="remarks" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default btn-primary">Update Changes</button>
                        
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="hidcomments" id="hidcomments">
        <input type="hidden" name="txtrowno" id="txtrowno">
        <input type="hidden" name="txtdocno" id="txtdocno">
        <input type="hidden" name="bdocno" id="bdocno">
        <input type="hidden" name="type" id="type">
        <input type="hidden" name="rowno" id="rowno">
        <input type="hidden" name="bookdocno" id="bookdocno">
        <input type="hidden" name="detaildocno" id="detaildocno">
        <input type="hidden" name="txtoldstatus" id="txtoldstatus">
        <input type="hidden" name="txtcrtuser" id="txtcrtuser">
        <input type="hidden" name="txtasgnuser" id="txtasgnuser">
        <input type="hidden" name="txtpendocno" id="txtpendocno">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
            	$('[data-toggle="tooltip"]').tooltip();
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#uptodate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#fromdate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#todate").jqxDateTimeInput({
                    width: '125px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#date").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#vtime").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#cgdate").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#cgtime").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: 'HH:mm',
                    showCalendarButton: false
                });
                $("#cmbbranch").select2({
                    placeholder: "Select Branch",
                    allowClear: true,
                    width: '100%'
                });
                $("#cmbstatus").select2({
                    placeholder: "Select Status",
                    allowClear: true,
                    width: '100%'
                });
                
                $('.warningpanel div button').click(function() {
                    $(this).toggleClass('active');
                    if ($(this).hasClass('active')) {
                        addGridFilters($(this).attr('data-filtervalue'), $(this).attr('data-datafield'));
                    } else {
                        $('#jqxbookGrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                    }
                });
                $('#fromdate,#todate').jqxDateTimeInput('setDate',new Date());
                /*var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                fromdate=fromdate.setMonth(fromdate.getMonth()-1);
                $('#fromdate').jqxDateTimeInput('setDate',new Date(fromdate));*/
                getBrch();
                funGetCountData();
                
                $('#btnsubmit').click(function() {
                	if($('.warningpanel div button').hasClass('active')){
                		$('#jqxbookGrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                		$('.warningpanel div button').removeClass('active');
                	}
                    funGetCountData();
                    reload();
                });
                
                $('#btnlogs').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	$("#overlay, #PleaseWait").show();
                	var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                	var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                    var x = new XMLHttpRequest();
                	x.onreadystatechange = function() {
                    	if (x.readyState == 4 && x.status == 200) {
                        	var items = x.responseText.trim();
                        	items=JSON.parse(items);
                        	var htmldata='';
                        	$(items.logdata).each(function( index ,value) {
  								htmldata+='<tr>';
  								htmldata+='<td>'+value.branch+'</td>';
  								htmldata+='<td>'+value.user+'</td>';
  								htmldata+='<td>'+value.logdate+'</td>';
  								htmldata+='<td>'+value.userremarks+'</td>';
  								htmldata+='<td>'+value.systemremarks+'</td>';
  								htmldata+='</tr>';
							});
							$("#overlay, #PleaseWait").hide();
							$('#tbllogs tbody').html($.parseHTML(htmldata));
							$('#modallogs .modal-title').text('Logs of '+bookdocno+' - '+docname);
							$('#modallogs').modal();
                		
                    	}else {
                    	}
                	}
                	x.open("GET", "getLogs.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                	x.send();
                });
                $('#btncomplete').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	if(selectedrows.length==0){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	else{
						var assigntype=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'assigntype');
						var bstatus=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'bstatus');
						if(assigntype!='3'){
							swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            text: 'Document must be assigned to vendor'
	                        });
	                        return false;
						}
						if(bstatus=='7'){
							swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            text: 'Document already completed'
	                        });
	                        return false;
						}
						var vendornetamount=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'vendornetamount');
						if(vendornetamount=="" || vendornetamount==null || vendornetamount=="undefined" || typeof(vendornetamount)=="unedfined" || parseFloat(vendornetamount)==0.0){
							swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            text: 'Vendor amount is mandatory'
	                        });
	                        return false;
						}
                		var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                		var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                		Swal.fire({
			  					title: 'Are you sure?',
			  					text: "Do you want to complete "+bookdocno+" - "+docname,
			  					icon: 'warning',
			  					showCancelButton: true,
			  					confirmButtonColor: '#3085d6',
			  					cancelButtonColor: '#d33',
			  					confirmButtonText: 'Yes'
							}).then((result) => {
			  					if (result.value) {
			    					$("#overlay, #PleaseWait").show();
			                        var x = new XMLHttpRequest();
					                x.onreadystatechange = function() {
					                    if (x.readyState == 4 && x.status == 200) {
					                        var items = x.responseText.trim();
					                        if(items=="0"){
					                			swal({
					                                type: 'success',
					                                title: 'Message',
					                                text: 'Updated Successfully'
					                            });
					                            $('#btnsubmit').trigger('click');
					                            $("#overlay, #PleaseWait").hide();
					                		}
					                		else{
					                			swal({
						                            type: 'warning',
						                            title: 'Warning',
						                            text: 'Vendor amount is mandatory'
						                        });
						                        $("#overlay, #PleaseWait").hide();
					                		}
					                		
					                    } else {
					                    }
					                }
					                x.open("GET", "completeVendorJob.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
					                x.send();
			  					}
							});
                	}
                });
                $('#btnvendorprice').click(function(){
                	var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                	
                	if(selectedrows.length==0){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select any valid documents'
                        });
                        return false;
                	}
                	else if(selectedrows.length>0 && selectedrows.length!=1){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Can select only one document at a time'
                        });
                        return false;
                	}
                	else{
						var assigntype=$("#jqxbookGrid").jqxGrid('getcellvalue',selectedrows[0],'assigntype');
						if(assigntype!='3'){
							swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            text: 'Document must be assigned to vendor'
	                        });
	                        return false;
						}
                		var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                		var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                		getVendorPrice(bookdocno,docname);
                	}
                });
                $('#vendordiscount').change(function(){
                	if($(this).val()!=''){
                		var vendoramount=$('#vendoramount').val();
                		var vendordiscount=$('#vendordiscount').val();
                		if(vendoramount!=''){
                			vendoramount=parseFloat(vendoramount);
                			vendordiscounnt=parseFloat(vendordiscount);
                			var vendornetamount=vendoramount-vendordiscount;
                			vendornetamount=vendornetamount.toFixed(2);
                			$('#vendornetamount').val(vendornetamount);
                			funRoundAmt(vendordiscounnt,"vendordiscounnt");
                			funRoundAmt(vendornetamount,"vendornetamount");
                		}
                	}
                });
                
                $('#btnvendorpriceupdate').click(function(){
                	var vendoramount=$('#vendoramount').val();
                	var vendordiscount=$('#vendordiscount').val();
                	var vendornetamount=$('#vendornetamount').val();
                	if(vendornetamount=="" || vendornetamount==null || vendornetamount=="undefined" || typeof(vendornetamount)=="undefined"){
                		swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Vendor Net Amount is mandatory'
                        });
                        return false;
                	}
                	else{
                		if(parseFloat(vendornetamount)==0.00){
                			swal({
	                            type: 'warning',
	                            title: 'Warning',
	                            text: 'Vendor Net Amount cannot be zero'
	                        });
	                        return false;
                		}
                		else{
                			var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                			var bookdocno=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"docno");
                			var docname=$("#jqxbookGrid").jqxGrid("getcellvalue",selectedrows[0],"job");
                			Swal.fire({
			  					title: 'Are you sure?',
			  					text: "Do you want to save changes?",
			  					icon: 'warning',
			  					showCancelButton: true,
			  					confirmButtonColor: '#3085d6',
			  					cancelButtonColor: '#d33',
			  					confirmButtonText: 'Yes'
							}).then((result) => {
			  					if (result.value) {
			    					$("#overlay, #PleaseWait").show();
			                        var x = new XMLHttpRequest();
					                x.onreadystatechange = function() {
					                    if (x.readyState == 4 && x.status == 200) {
					                        var items = x.responseText.trim();
					                        if(items=="0"){
					                			swal({
					                                type: 'success',
					                                title: 'Message',
					                                text: 'Updated Successfully'
					                            });
					                            $('#vendoramount,#vendordiscount,#vendornetamount').val('');
					                            $('#btnsubmit').trigger('click');
					                            $('#modalvendorprice').modal('hide');
					                            $("#overlay, #PleaseWait").hide();
					                		}
					                		
					                    } else {
					                    }
					                }
					                x.open("GET", "updateVendorPrice.jsp?bookdocno="+bookdocno+"&docname="+docname+"&vendoramount="+vendoramount+"&vendordiscount="+vendordiscount+"&vendornetamount="+vendornetamount, true);
					                x.send();
			  					}
							});
                			
                		}
                	}
                });
                $('#btnconfirmss').click(function() {
               		var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    if(selectedrows.length==0){
                    	swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    else{
                    	for(var i=0;i<selectedrows.length;i++){
                    		var status=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'status');
                    		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                    		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
                    		if(status.trim()!="Trip Ended"){
                    			swal({
		                            type: 'warning',
		                            title: 'Warning',
		                            text: 'Trip not ended '+bookdocno+' - '+jobname
		                        });
		                        return false;
                    		}
                    	}
                    	var gridarray=new Array();
                    	for(var i=0;i<selectedrows.length;i++){
                    		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                    		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
							gridarray.push(bookdocno+"::"+jobname);
                    	}
                    	funupdatecn(gridarray);
                    }
                    
                });
                $('#btnjobassign').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    
                    if(selectedrows.length == 0){
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
                $('#btnteamselection').click(function() {
                    load();
                });
                $('#btnchangetime').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    selectedrows = selectedrows.sort(function(a, b) {
                        return a - b
                    });
                    if (selectedrows.length == 0) {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });

                $('#btnexcel').click(function() {
                    $("#bookdiv").excelexportjs({
						containerid: "bookdiv",
						datatype: 'json',
						dataset: null,
						gridId: "jqxbookGrid",
						columns: getColumns("jqxbookGrid"),
						worksheetName: "Confirmed Jobs"
					});
                });
                $('#btnstatus').click(function() {
                    var rows = $("#jqxbookGrid").jqxGrid('getrows');
                    var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                    selectedrows = selectedrows.sort(function(a, b) {
                        return a - b
                    });
                    if (selectedrows.length == 0) {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    getStatus();
                });
                $('#btnstatuspdate').click(function() {
                    if($('#cmbstatus').val() == '') {
                        $('#cmbstatus').closest('.form-group').addClass('has-error').find('span.help-block').removeClass('hidden').text('Please select status');
                        /*swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a status'
                        });*/
                        return false;
                    }
                    else{
                    	$('#cmbstatus').closest('.form-group').removeClass('has-error').find('span.help-block').addClass('hidden').text('');
                    }
                    if($('#remarks').val().length>500){
                    	$('#remarks').closest('.form-group').addClass('has-error').find('span.help-block').removeClass('hidden').text('Max 500 chars allowed');
                    	return false;
                    }
                    else{
                    	$('#remarks').closest('.form-group').removeClass('has-error').find('span.help-block').addClass('hidden').text('');
                    }
                    funUpdateStatus();
                });
                $('#btncommentsend').click(function() {
                    var docno = $('#txtdocno').val();
                    var txtcomment = $('#txtcomment').val();
                    if (docno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    if (txtcomment == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please type in comment'
                        });
                        return false;
                    }
                    saveComment();
                });
                $('#btncomment').click(function() {
                    getComments();
                    var docno = $('#txtdocno').val();
                    if (docno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
            });
			function funRoundAmt(value,id){
				var res=parseFloat(value).toFixed(window.parent.amtdec.value);
				var res1=(res=='NaN'?"0":res);
				document.getElementById(id).value=res1;
			}
			function getVendorPrice(bookdocno,docname){
				var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        var vendorprice=items;
                        if(vendorprice=="" || vendorprice=="undefined" || typeof(vendorprice)=="undefined"){
                        	vendorprice=0.00;
                        }
                        else{
                        	vendorprice=parseFloat(vendorprice);
                        }
                		$('#vendoramount').val(vendorprice);
                		$('.vendor-job').text(bookdocno+' - '+docname);
                		funRoundAmt(vendorprice,"vendoramount");
                		funRoundAmt(0.0,"vendordiscount");
                		funRoundAmt(vendorprice,"vendornetamount");
                		$("#modalvendorprice").modal();
                		
                    } else {
                    }
                }
                x.open("GET", "getVendorPrice.jsp?bookdocno="+bookdocno+"&docname="+docname, true);
                x.send();
			}
            function reload() {
                $("#overlay, #PleaseWait").show();
                var branch = $('#cmbbranch').val();
                var fromdate=$('#fromdate').jqxDateTimeInput('val');
                var todate=$('#todate').jqxDateTimeInput('val');
                $('#bookdiv').load('bookingGrid.jsp?branch=' + branch + '&id=1&fromdate='+fromdate+'&todate='+todate);
            }

            function addGridFilters(filtervalue, datafield) {
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                var filtercondition = 'equal';
                var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
                filtergroup.addfilter(filter_or_operator, filter1);
                //filtergroup.addfilter(filter_or_operator, filter2);
                // add the filters.
                $("#jqxbookGrid").jqxGrid('addfilter', datafield, filtergroup);
                // apply the filters.   
                $("#jqxbookGrid").jqxGrid('applyfilters');
            }

            function getBranch() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        //alert(items);
                        items = items.split('####');

                        var branchIdItems = items[0].split(",");
                        var branchItems = items[1].split(",");
                        var perm = items[2];
                        var optionsbranch;
                        if (perm == 0) {
                            optionsbranch = '<option value="a" selected>All</option>';
                        } else {

                        }
                        for (var i = 0; i < branchItems.length; i++) {
                            optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
                        }
                        $("select#cmbbranch").html(optionsbranch);
                        /* if ($('#hidcmbbranch').val() != null) {
                        	$('#cmbbranch').val($('#hidcmbbranch').val());
                        } */
                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/getBranch.jsp", true);
                x.send();
            }

            function getBrch() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        items = x.responseText;
                        items = items.split('####');
                        brchIdItems = items[0].split(",");
                        brchItems = items[1].split(",");
                        var optionsbrch = '<option value="">--Select--</option>';
                        for (var i = 0; i < brchItems.length; i++) {
                            optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                        }
                        $("select#cmbtransferbranch").html(optionsbrch);

                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "getBranch.jsp", true);
                x.send();
            }

            function funUpdateStatus() {
                var statusid = $('#cmbstatus').val();
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');                
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Warning', 'Please select documents.');
                    return false;
                }
                if (statusid == '') {
                    //$.messager.alert('Message', 'Select Status', 'warning');
                    Swal.fire({
						icon: 'error',
					  	title: 'Select Status'
					});
                    return false;
                }
                Swal.fire({
  					title: 'Are you sure?',
  					text: "Do you want to save changes?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					$("#overlay, #PleaseWait").show();
                        var i = 0;
                        var temprow = "";
                        var j = 0;
                        for (i = 0; i < selectedrows.length; i++) {
                            if (i == 0) {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = rowno;
                            } else {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = temprow + "," + rowno;
                            }
                            temptrno3 = temprow + ",";
                            j++;
                        }
                        $('#rowno').val(temptrno3);
                        savestatus($('#rowno').val());
  					}
				})
               
            }

            function savestatus(rowno) {
                var statusid = $('#cmbstatus').val();
                var remarks = $('#remarks').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items == "0") {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Status Updated'
                            });
                            $('#rowno').val("");
                            $('#remarks').val("");
                            $('#cmbstatus').val("");
                            reload();
                            $('#modalstatusupdate').modal('hide');
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated'
                            });
                            $('#rowno').val("");
                        }

                    } else {}
                }
                x.open("GET", "statUpdate.jsp?statusid=" + statusid + "&rowno=" + rowno + "&remarks=" + remarks, true);
                x.send();
            }

            function getStatus() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        items = items.split('####');

                        var srno = items[0].split(",");
                        var status = items[1].split(",");
                        var optionsbranch = '<option value="" selected>-- Select -- </option>';
                        for (var i = 0; i < status.length; i++) {
                            optionsbranch += '<option value="' + srno[i].trim() + '">' + status[i] + '</option>';
                        }
                        $("select#cmbstatus").html(optionsbranch);

                    } else {}
                }
                x.open("GET", "getStatuses.jsp", true);
                x.send();
            }

            function funSave() {
                var rows = $("#jqxbookGrid").jqxGrid('getrows');
                var process = $("#cmbprocess").val();
                var transferbranch = $("#cmbtransferbranch").val();
                var driver = $("#driver").val();
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                if (process == '') {
                    //$.messager.alert('Message', 'Select Process', 'warning');
                    swal({
                    	type: 'error',
                        title: 'Please select process'
                    });
                    return 0;
                }
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    //$.messager.alert('Warning', 'Please select documents.');
                    swal({
                    	type: 'error',
                        title: 'Please select documents'
                    });
                    return false;
                }
                if (process == "1") {
                    if (transferbranch == '') {
                        //$.messager.alert('Message', 'Select Transfer Branch', 'warning');
                        swal({
	                    	type: 'error',
	                        title: 'Please select Transfer branch'
	                    });
                        return false;
                    }
                }
                if(process=="2"){
                	for(var i=0;i<selectedrows.length;i++){
                		var tarifdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'tarifdocno');
                		var bookdocno=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'docno');
                		var jobname=$('#jqxbookGrid').jqxGrid('getcellvalue',selectedrows[i],'job');
                		if(tarifdocno=="" || tarifdocno=="undefined" || tarifdocno=="0" || tarifdocno==null){
                			swal({
                                type: 'error',
                                title: 'Tarif not configured',
                                text: 'Please set tarif of '+bookdocno+' - '+jobname
                            });
                            return false;
                		}
                	}
                }
                if (process == "2") {
                    if (driver == '') {
                        //$.messager.alert('Message', 'Select Driver', 'warning');
                        swal({
	                    	type: 'error',
	                        title: 'Please select driver'
	                    });
                        return false;
                    }
                }
                Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
					}).then((result) => {
  						if (result.value) {
    						$("#overlay, #PleaseWait").show();
	
	                        var i = 0;
	                        var tempbook = "",
	                            tempdetail = "",
	                            temprow = "",
	                            temptype = "";
	                        var j = 0;
	                        for (i = 0; i < selectedrows.length; i++) {
	
	                            if (i == 0) {
	                                var booktrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
	                                tempbook = booktrno;
	                                var detailtrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
	                                tempdetail = detailtrno;
	                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
	                                temprow = rowno;
	                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
	                                temptype = type;
	                            } else {
	                                var booktrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
	                                tempbook = tempbook + "," + booktrno;
	                                var detailtrno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
	                                tempdetail = tempdetail + "," + detailtrno;
	                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
	                                temprow = temprow + "," + rowno;
	                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
	                                temptype = temptype + "," + type;
	                            }
	                            temptrno1 = tempbook + ",";
	                            temptrno2 = tempdetail + ",";
	                            temptrno3 = temprow + ",";
	                            temptrno4 = temptype + ",";
	                            j++;
	
	                        }
	                        $('#bookdocno').val(temptrno1);
	                        $('#detaildocno').val(temptrno2);
	                        $('#rowno').val(temptrno3);
	                        $('#type').val(temptrno4);
	                        savegriddata($('#rowno').val(), $('#bookdocno').val(), $('#detaildocno').val(), $('#type').val());
  						}
				});
                
            }

            function savegriddata(rowno, bookdoc, detaildoc, type) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        if (parseInt(items) >= 1) {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved'
                            });
                            $("#jqxbookGrid").jqxGrid('clear');
                            $('#bookdocno').val("");
                            $('#rowno').val("");
                            $('#type').val("");
                            $('#detaildocno').val("");
                            $("#cmbprocess").val("");
                            $("#cmbtransferbranch").val("");
                            $("#driver").val("");
                            $("#fleetno").val("");
                            $("#jqxInputUser").val("");
                            $("#fleetSearchInput").val("");
                            reload();
                            $('#modaljobaasign').modal('hide');
                        } else {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Not Saved'
                            });
                            $('#bookdocno').val("");
                            $('#rowno').val("");
                            $('#type').val("");
                            $('#detaildocno').val("");
                        }
                    }
                }
                x.open("GET", "saveData.jsp?bookdocno=" + bookdoc + "&type=" + type + "&rowno=" + rowno + "&detaildocno=" + detaildoc + "&cmbprocess=" + $("#cmbprocess").val() + "&cmbtransferbranch=" + $("#cmbtransferbranch").val() + "&hiddriver=" + $("#driver").val() + "&fleetno=" + $("#fleetno").val() + "&date=" + $('#uptodate').jqxDateTimeInput('val') + "&brch=" + $('#cmbbranch').val(), true);
                x.send();
            }

            function funGetCountData() {
            	var fromdate=$('#fromdate').jqxDateTimeInput('val');
            	var todate=$('#todate').jqxDateTimeInput('val');
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split("::");
                        $('.badge-confirm').text(items[0]);
                        $('.badge-jbassign').text(items[1]);
                        $('.badge-chngetime').text(items[2]);
                    } else {}
                }
                x.open("GET", 'getCountData.jsp?branch='+$('#cmbbranch').val()+'&fromdate='+fromdate+'&todate='+todate, true);
                x.send();
            }

            function saveComment() {
                var comment = $('#txtcomment').val();
                var docno = $('#txtdocno').val();
                $('#hidcomments').val($('#txtcomment').val());
                if (($(hidcomments).val()).includes('$')) {
                    $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));
                };
                if (($(hidcomments).val()).includes('%')) {
                    $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));
                };
                if (($(hidcomments).val()).includes('^')) {
                    $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));
                };
                if (($(hidcomments).val()).includes('`')) {
                    $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));
                };
                if (($(hidcomments).val()).includes('~')) {
                    $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));
                };
                if ($(hidcomments).val().indexOf('\'') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));
                };
                if (($(hidcomments).val()).includes(',')) {
                    $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));
                }
                if ($(hidcomments).val().indexOf('"') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));
                };
                if (($(hidcomments).val()).match(/\\/g)) {
                    $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));
                };

                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        $('#txtcomment').val('');
                        getComments();
                    } else {}
                }
                x.open("GET", "saveComment.jsp?comment=" + encodeURIComponent($('#hidcomments').val()) + "&docno=" + docno, true);
                x.send();
            }

            function getComments() {
                var docno = $('#txtdocno').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        var str = '';
                        if (items != '') {
                            for (var i = 0; i < items.length; i++) {
                                str += '<div class="comment"><div class="msg"><p>' + items[i].split("::")[0] + '</p></div><div class="msg-details"><p>' + items[i].split("::")[1] + ' - ' + items[i].split("::")[2] + '</p></div></div>';
                            }
                            $('.comments-container').html($.parseHTML(str));
                        } else {}
                    } else {}
                }
                x.open("GET", "getComments.jsp?docno=" + docno, true);
                x.send();
            }

            function funSaveTask() {
                var reftype = document.getElementById("reftype").value;
                var refno = document.getElementById("refno").value;
                var sdate = $('#date').jqxDateTimeInput('val');
                var stime = document.getElementById("vtime").value;
                var user = document.getElementById("jqxUser").value;
                var hiduser = document.getElementById("tuser").value;
                var desc = document.getElementById("desc").value;
                var userid = "<%= session.getAttribute("USERID").toString()%>";
                if (refno == "") {
                    //$.messager.alert('Message', 'Enter Ref. No.', 'warning');
                    swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Ref. No'
                    });
                    document.getElementById('refno').focus();
                    return false;
                }
                if (stime == "") {
                    //$.messager.alert('Message', 'Enter time', 'warning');
                    swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter time'
                    });
                    document.getElementById('stime').focus();
                    return false;
                }
                if (user == "") {
                    //$.messager.alert('Message', 'Enter Assigned User', 'warning');
                    swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Assigned User'
                    });
                    document.getElementById('user').focus();
                    return false;
                }
                if (desc == "") {
                    //$.messager.alert('Message', 'Enter Description', 'warning');
                    swal({
                    	type: 'info',
                        title: 'Warning',
                        text: 'Enter Description'
                    });
                    document.getElementById('desc').focus();
                    return false;
                }
				Swal.fire({
  					title: 'Are you sure?',
  					text: "Do you want to save changes?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					saveDatasss(reftype, refno, sdate, stime, user, desc, userid, hiduser);
  					}
				});
                
            }

            function saveDatasss(reftype, refno, sdate, stime, user, desc, userid, hiduser) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var msg = x.responseText.trim().split(',');
                        // alert(msg);
                        if (msg == "1") {
                            document.getElementById("refno").value = "";
                            document.getElementById("vtime").value = "";
                            document.getElementById("jqxUser").value = "";
                            document.getElementById("tuser").value = "";
                            document.getElementById("desc").value = "";
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved'
                            });

                        } else {
                            swal({
                                type: 'error',
                                title: 'Message',
                                text: 'Not Saved'
                            });
                        }
                    }
                }
                x.open("GET", "taskCreate.jsp?reftype=" + reftype + "&refno=" + refno + "&sdate=" + sdate + "&stime=" + stime + "&user=" + user + "&desc=" + desc + "&userid=" + userid + "&hiduser=" + hiduser, true);
                x.send();
            }

            function funpendingUpdate() {
                var docno = $('#txtpendocno').val();
                var crtuser = $('#txtcrtuser').val();
                var status = $('#assgntask').val();
                var oldstat = document.getElementById("txtoldstatus").value;
                var asgnuser = $('#puser').val();
                var oldassuser = document.getElementById("txtasgnuser").value;
                var userid = $('#puser').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items > 0) {
                            document.getElementById("txtcrtuser").value = "";
                            document.getElementById("puser").value = "";
                            document.getElementById("txtpendocno").value = "";
                            document.getElementById("jqxInputUsers").value = "";
                            $('#remarks').val('');
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Status Updated'
                            });
                            funGetCountData();
                            reload();
                        } else if (items == -888) {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Task is not completed'
                            });
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated'
                            });
                        }
                    } else {}
                }
                x.open("GET", "penStatUpdate.jsp?userid=" + userid + "&docno=" + docno + "&status=" + status + "&asgnuser=" + asgnuser + "&oldassuser=" + oldassuser + "&oldstatus=" + oldstat + "&crtuser=" + crtuser + "&remarks=" + $('#remarks').val(), true);
                x.send();
            }

            function funstatusval(crtuserid) {
                // var crtuserid=document.getElementById("txtcrtuser").value;  
                var sesuserid = "<%=session.getAttribute("USERID").toString()%>";
                var optionref = "";
                if (crtuserid == sesuserid) {
                    optionref += '<option value="Assigned">Assign</option>';
                    optionref += '<option value="Accepted">Accepted</option>';
                    optionref += '<option value="Completed">Completed</option>';
                    optionref += '<option value="Close">Close</option>';
                    $("select#assgntask").html(optionref);
                } else {
                    optionref += '<option value="Assigned">Assign</option>';
                    optionref += '<option value="Accepted">Accepted</option>';
                    optionref += '<option value="Completed">Completed</option>';
                    $("select#assgntask").html(optionref);
                }
            }

            function funCTSave() {
                var remarks = $('#cgdesc').val();
                var rows = $("#jqxbookGrid").jqxGrid('getrows');
                var selectedrows = $("#jqxbookGrid").jqxGrid('selectedrowindexes');
                if (selectedrows.length == 0) {
                    $("#overlay, #PleaseWait").hide();
                    //$.messager.alert('Warning', 'Please select documents.');
                    swal({
                    	type: 'error',
                        title: 'Warning',
                        text: 'Please select documents.'
                    });
                    return false;
                }
                if (remarks == "") {
                    //$.messager.alert('Message', 'Please Enter Remarks', 'warning');
                    swal({
                    	type: 'error',
                        title: 'Warning',
                        text: 'Please Enter Remarks'
                    });
                    document.getElementById('cgremarks').focus();
                    return false;
                }
                Swal.fire({
  					title: 'Are you sure?',
  					text: "Do you want to save changes?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					$("#overlay, #PleaseWait").show();

                        var i = 0;
                        var temprow = "",
                            tempbk = "",
                            tempdet = "",
                            temptype = "";
                        var j = 0;
                        for (i = 0; i < selectedrows.length; i++) {

                            if (i == 0) {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = rowno;
                                var detno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                tempdet = detno;
                                var bkno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                                tempbk = bkno;
                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                temptype = type;
                            } else {
                                var rowno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
                                temprow = temprow + "," + rowno;
                                var detno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "tdocno");
                                tempdet = tempdet + "," + detno;
                                var bkno = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "docno");
                                tempbk = tempbk + "," + bkno;
                                var type = $('#jqxbookGrid').jqxGrid('getcellvalue', selectedrows[i], "type");
                                temptype = temptype + "," + type;
                            }
                            temptrno3 = temprow + ",";
                            temptrno4 = tempdet + ",";
                            temptrno5 = temptype + ",";
                            temptrno6 = tempbk + ",";
                            j++;

                        }
                        $('#rowno').val(temptrno3);
                        $('#bookdocno').val(temptrno6);
                        $('#detaildocno').val(temptrno4);
                        $('#type').val(temptrno5);
                        savecg($('#bookdocno').val(), $('#detaildocno').val(), $('#type').val(), $('#rowno').val());
  					}
				});
                
            }

            function savecg(bdocno, ddocno, type, rowno) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items > 0) {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Saved'
                            });
                            $('#rowno').val("");
                            $('#bookdocno').val("");
                            $('#detaildocno').val("");
                            $('#type').val("");
                            $('#cgdesc').val("");
                            $('#jqxInputdriver2').val("");
                            $('#cgdriver').val("");
                            $('#cgdesc').val('');
                            reload();
                            $('#modalchangetime').modal('hide');
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Saved'
                            });
                            $('#rowno').val("");
                            $('#bookdocno').val("");
                            $('#detaildocno').val("");
                            $('#type').val("");
                        }

                    } else {}
                }
                x.open("GET", "saveCT.jsp?bookdocno=" + bdocno + "&detaildocno=" + ddocno + "&rowss=" + rowno + "&type=" + type + "&cgdate=" + $('#cgdate').val().replace(/ /g, "%20") + "&cgtime=" + $('#cgtime').val() + "&cgdesc=" + $('#cgdesc').val() + "&cgdriver=" + $('#cgdriver').val(), true);
                x.send();
            }

            function load() {
                var userid = "<%=session.getAttribute("USERID").toString()%>";
                $('#pnddiv').load('pendingtaskGrid.jsp?userid=' + userid);
            }

            function funupdatecn(gridarray) {
            	Swal.fire({
  					title: 'Are you sure?',
  					text: "Do you want to confirm?",
  					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					updatConfrm(gridarray);
  					}
				})
            }

            function updatConfrm(gridarray) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        //alert(items);       
                        if (parseInt(items) > 0) {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Confirmed'
                            });
                            reload();
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Confirmed'
                            });
                        }
                    } else {}
                }
                x.open("GET", "SaveCofrm.jsp?gridarray="+gridarray, true);
                x.send();
            }
            
            function getDriverFleet(driverid){
            	var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if(items!=""){
                        	$('#fleetSearchInput').jqxInput('val', {label: items.split("::")[1], value: items.split("::")[0]});
                        	$('#fleetno').val(items.split("::")[0]);
                        }
                        else{
                        	$('#fleetSearchInput').jqxInput('val', '');
                        }
                    } else {}
                }
                x.open("GET", "getDriverFleet.jsp?driverid="+driverid, true);
                x.send();
            }
            
        </script>
    </form>
</body>

</html>