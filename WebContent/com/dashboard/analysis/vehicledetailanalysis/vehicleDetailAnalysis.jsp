<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Vehicle Detail Analysis</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">

<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<%-- <jsp:include page="../../../../includeswithoutcss.jsp"></jsp:include> --%>
  <style type="text/css">
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
	.borderless td, .borderless th {
	    border: none;
	}
	.borderless tbody tr td{
		border-top:none;
		border-top:0;
		padding-top:0;
		padding-bottom:0;
	}
	fieldset {
    	border: 1px solid rgb(221, 221, 221);
    	/* padding: 0 0.6em 0.6em 0.6em;
    	margin: 0 0 0.8em 0; */
    	padding-left: 0.6em;
    	padding-right: 0.6em;
    	padding-bottom: 0.6em;
    	border-radius: 8px;
	}

	legend {
	    font-size: 1.2em !important;
	    text-align: left !important;
		width:inherit; /* Or auto */
	    padding:0 5px; /* To give a bit of padding on the left and right */
	    border-bottom:none;
		margin-bottom:0;
	}
  </style>
</head>
<body>
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  	<div class="container-fluid" >
    	<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
        		<div class="primarypanel custompanel">
  					<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        			<select style="display:none;" name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        			<select name="cmbfleet" id="cmbfleet" style="min-width:250px;"><option value="">--Select--</option></select>
        		</div>
        		<!-- <div class="actionpanel custompanel">
          			<button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-car " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Update" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnjobstatus"  data-target="#modaljobstatus" ><i class="fa fa-filter " aria-hidden="true" data-toggle="tooltip" title="Job Status" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnteamselection" data-target="#modalteamselection"><i class="fa fa-users " aria-hidden="true" data-toggle="tooltip" title="Team Selection" data-placement="bottom"></i></button>
        		</div> -->
        		<!-- <div class="warningpanel custompanel">
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
        			</div> -->
        		<div class="detailpanel custompanel" style="display:inline-flex;padding-top:15px;padding-bottom:15px;">
        			<div id="fromdate"></div>
        			<div id="todate"></div>  
        		</div>
        		<div class="otherpanel custompanel">
          			<button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        		</div>
        		<div class="textpanel custompanel hidden">
					<p class="h4">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="max-height:550px;overflow-y:auto;">
        		<table class="table borderless">
        			<tr>
        				<td style="width:50%;">
        					<fieldset><legend>Movement Info</legend>
        						<div id="movementdiv"><jsp:include page="movementGrid.jsp"></jsp:include></div>
        					</fieldset>
        				</td>
        				<td rowspan="3"  style="width:50%;padding:0;">
        					<table class="table borderless">
        						<tr><td><fieldset><legend>Depreciation Info</legend><div id="deprdiv"><jsp:include page="deprGrid.jsp"></jsp:include></div></fieldset></td></tr>
        						<tr><td><fieldset><legend>Income Info</legend><div id="incomediv"><jsp:include page="incomeGrid.jsp"></jsp:include></div></fieldset></tr>
        					</table>
        				</td>
        			</tr>
        			<tr>
        				<td><fieldset><legend>Accidents Info</legend><div id="accidentsdiv"><jsp:include page="accidentsGrid.jsp"></jsp:include></div></fieldset></td>
        			</tr>
        			<tr>
        				<td><fieldset><legend>Maintenance Info</legend><div id="maintenancediv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div></fieldset></td>
        			</tr>
        			
        		</table>
        		
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
  <input type="hidden" name="docno" id="docno">
  <input type="hidden" name="vocno" id="vocno">
  <input type="hidden" name="rowindex" id="rowindex">
  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        var fromdate=new Date();
        fromdate.setMonth(fromdate.getMonth()-1);
        $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:fromdate});  
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
        /*$('#cmbbranch').select2({
        	placeholder:"Select Branch",
        	allowClear:true
        });*/
        $('#cmbfleet').select2({
        	placeholder:"Select Vehicle",
        	allowClear:true
        });
        funGetInitData();
        
        $('.load-wrapp').hide();
        $('#btnsubmit').click(function(){
        	//funGetCountData();
        	$('.page-loader').hide();
        	//var brhid=$('#cmbbranch').val();
        	if($('#cmbfleet').val()==''){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a vehicle'
				});
        		return false;
        	}
        	var fleetno=$('#cmbfleet').val();
        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
        	var todate=$('#todate').jqxDateTimeInput('val');
        	$('#movementdiv').load('movementGrid.jsp?id=1&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
        	$('#accidentsdiv').load('accidentsGrid.jsp?id=1&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
        	$('#maintenancediv').load('maintenanceGrid.jsp?id=1&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
        	$('#deprdiv').load('deprGrid.jsp?id=1&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
        	$('#incomediv').load('incomeGrid.jsp?id=1&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
        });
        
        $('#btnexcel').click(function(){
        	var fleetno=$('#cmbfleet').val();
        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
        	var todate=$('#todate').jqxDateTimeInput('val');
        	if($("#movementGrid").jqxGrid('getrows').length>0){
        		$("#movementGrid").excelexportjs({
					containerid: "movementGrid",
					datatype: 'json',
					dataset: null,
					gridId: "movementGrid",
					columns: getColumns("movementGrid"),
					worksheetName: "Movement Data of Fleet #"+fleetno+" from "+fromdate+" to "+todate
				});
        	}
        	if($("#accidentsGrid").jqxGrid('getrows').length>0){
        		$("#accidentsGrid").excelexportjs({
					containerid: "accidentsGrid",
					datatype: 'json',
					dataset: null,
					gridId: "accidentsGrid",
					columns: getColumns("accidentsGrid"),
					worksheetName: "Accidents History of Fleet #"+fleetno+" from "+fromdate+" to "+todate
				});
        	}
			if($("#maintenanceGrid").jqxGrid('getrows').length>0){
				$("#maintenanceGrid").excelexportjs({
					containerid: "maintenanceGrid",
					datatype: 'json',
					dataset: null,
					gridId: "maintenanceGrid",
					columns: getColumns("maintenanceGrid"),
					worksheetName: "Maintenance Data of Fleet #"+fleetno+" from "+fromdate+" to "+todate
				});	
			}
			if($("#deprGrid").jqxGrid('getrows').length>0){
				$("#deprGrid").excelexportjs({
					containerid: "deprGrid",
					datatype: 'json',
					dataset: null,
					gridId: "deprGrid",
					columns: getColumns("deprGrid"),
					worksheetName: "Depreciation Data of Fleet #"+fleetno+" from "+fromdate+" to "+todate
				});
			}
			if($("#incomeGrid").jqxGrid('getrows').length>0){
				$("#incomeGrid").excelexportjs({
					containerid: "incomeGrid",
					datatype: 'json',
					dataset: null,
					gridId: "incomeGrid",
					columns: getColumns("incomeGrid"),
					worksheetName: "Income Data of Fleet #"+fleetno+" from "+fromdate+" to "+todate
				});
			}
			
        });
        
        $('.actionpanel button,.detailpanel button,.otherpanel button').click(function(){
        	var jobcarddocno=$('#jobcarddocno').val();
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	var modaltarget=$(this).attr('data-target');
        	$(modaltarget).modal('show');
        });
        
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var jobcarddocno=$('#docno').val();
        	if(txtcomment==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(jobcarddocno==""){
        		swal({
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#floorMgmtGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		swal({
					type: 'error',
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
	function funGetInitData(){
		$.get("getInitData.jsp", function(data, status){
    		data=JSON.parse(data);
    		var htmldata='<option value="">--Select--</option>';
    		$(data.branchdata).each(function(index,value){
    			htmldata+='<option value="'+value.docno+'">'+value.name+'</option>';	
    		});
    		$('#cmbbranch').html($.parseHTML(htmldata));
    		/*$('#cmbbranch').select2({
	        	placeholder:"Select Branch",
	        	allowClear:true
	        });*/
	        htmldata='<option value="">--Select--</option>';
    		$(data.fleetdata).each(function(index,value){
    			htmldata+='<option value="'+value.fleetno+'">'+value.name+'</option>';	
    		});
    		$('#cmbfleet').html($.parseHTML(htmldata));
    		$('#cmbfleet').select2({
	        	placeholder:"Select Vehicle",
	        	allowClear:true,
	        	matcher: function (params, data) {
		            if ($.trim(params.term) === '') {
		                return data;
		            }
		
		            keywords=(params.term).split(" ");
		
		            for (var i = 0; i < keywords.length; i++) {
		                if (((data.text).toUpperCase()).indexOf((keywords[i]).toUpperCase()) == -1) 
		                return null;
		            }
		            return data;
		        }
	        });
  		});
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
    	var docno=$('#docno').val();
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
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&docno="+docno,true);
		x.send();
    }
    function getComments(){
    	var jobcarddocno=$('#docno').val();
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
		x.open("GET","getComments.jsp?docno="+jobcarddocno,true);
		x.send();
    }
    
    /*function funGetCountData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				var htmldata='<option value="">All</option>';
				$.each(items.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.clientdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbilltoclient').html($.parseHTML(htmldata));
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.insurdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbilltoinsur').html($.parseHTML(htmldata));
	  			$('.cmbbilltoclient,.cmbbilltoinsur,#cmbbranch').select2();
	  			
			}
			else
			{
			}
		}
		x.open("GET","getCountData.jsp",true);
		x.send();
    }*/
    
function funDateInPeriod(value){
    var styear = new Date(window.parent.txtaccountperiodfrom.value);
    var edyear = new Date(window.parent.txtaccountperiodto.value);
    var mclose = new Date(window.parent.monthclosed.value);
    mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	//$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     	swal({
			type: 'error',
			title: 'Warning',
			text: 'Transaction prior or after Account Period is not valid.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
    	 //$.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     	swal({
			type: 'error',
			title: 'Warning',
			text: 'Future Date, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
    	//$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     	swal({
			type: 'error',
			title: 'Warning',
			text: 'Closing Done, Transaction Restricted.'
		});
     $('#txtvalidation').val(1);
     return 0;
    }
    
    $('#txtvalidation').val(0);
     return 1;
 }
  </script>
</body>
</html>
