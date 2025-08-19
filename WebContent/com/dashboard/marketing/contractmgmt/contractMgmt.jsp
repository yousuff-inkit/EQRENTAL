<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Floor Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">

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
        		<div class="primarypanel custompanel">
  					<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        			<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        		<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="todate" data-toggle="tooltip" title="To Date"></div>
        		<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="fromdate" data-toggle="tooltip" title="From Date"></div>
       
        		</div>
        		<div class="actionpanel custompanel">
          			<button type="button" class="btn btn-default" id="btncontract" data-target="#modalupdate"><i class="fa fa-sticky-note" aria-hidden="true" data-toggle="tooltip" title="LPO Update" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btntariff" data-target="#modaltariff"><i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="Tariff Change" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btncontractprint"><i class="fa fa-print" aria-hidden="true" data-toggle="tooltip" title="Print" data-placement="bottom"></i></button>
        		</div>
        		<div class="textpanel custompanel">
					<p class="h4">&nbsp;</p>
        		</div>
        	</div>
        </div>
        <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="contractmgmtdiv"><jsp:include page="contractMgmtGrid.jsp"></jsp:include></div>
        	</div>
        </div>
       <%--  <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="contractmgmtdetaildiv"><jsp:include page="contractMgmtDetailGrid.jsp"></jsp:include></div>
        	</div>
        </div> --%>
        
          <div id="modalupdate" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title" id="contracttitle">Contract</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="form-horizontal">
	            				<div class="form-group">
    								<label class="control-label col-sm-2">LPO No:</label>
    								<div class="col-sm-10">
      									<input type="text" name="lpono" id="lpono" class="form-control">
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-2">LPO Date:</label>
    								<div class="col-sm-10">
    									<div class="col-md-2 form-control" id="lpodate"></div>
    								</div>
  								</div>
	            			</div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            	<button type="button" class="btn btn-default btn-primary" id="btncontractupdate">Update</button>
		          	</div>
	          	</div>
	        </div>
	      </div>
	   	      	      
	      <div id="modaltariff" class="modal fade" role="dialog">
	    	<div class="modal-dialog modal-lg" style="width:80%">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Tariff</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div id="contractmgmtdetaildiv"><jsp:include page="contractMgmtDetailGrid.jsp"></jsp:include></div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            	<button type="button" class="btn btn-default btn-primary" id="btntariffupdate">Update</button>
		          	</div>
	          	</div>
	        </div>
	      </div>
	      
	</div>
	</form>
	
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>

<script type="text/javascript">
		$(document).ready(function(){
			$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
		 	$("#lpodate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	
			 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		    
			$('[data-toggle="tooltip"]').tooltip(); 
			$('.load-wrapp').hide();
			getInitData();
			
			$('#btncontractprint').click(function(){
				var docno=$('#docno').val();
				if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
				
				var brhid=$('#brhid').val();
	        	var url=document.URL;
	     		var reurl=url.split("com/");
 				var win= window.open(reurl[0]+"printRentalContract?docno="+docno+"&branch="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				win.focus();
		 		
			});
			
			$('#btncontractupdate').click(function(){
				var docno=$('#docno').val();
				var vocno=$('#vocno').val();
	        	if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to update Contract "+vocno,
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var lpono=$('#lpono').val();
						var lpodate=$('#lpodate').jqxDateTimeInput('val');
						var brhid=$('#brhid').val();
						$.post('updateContract.jsp',{'docno':docno,'lpono':lpono,'lpodate':lpodate,'brhid':brhid},function(data,status){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								$('.modal.fade.in').modal('hide');
								Swal.fire({
									icon: 'success',
									title: 'Success',
									text: 'Contract Updated Successfully'
								});
								$('#btnsubmit').trigger('click');
							}
							else{
								Swal.fire({
									icon: 'error',
									title: 'Warning',
									text: 'Not updated'
								});
				        		return false;
							}
						});
					}
				});
			});
			
			$('#btntariffupdate').click(function(){
				var docno=$('#docno').val();
	        	if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to update rate details?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var brhid=$('#brhid').val();
						var rows=$('#contractMgmtDetailGrid').jqxGrid('getrows');
						
						var tariffarray=new Array();
						
					 	for(var i=0 ; i < rows.length ; i++){
					   		if(rows[i].subcatid!=null && rows[i].subcatid!="" && rows[i].subcatid!="undefined" && typeof(rows[i].subcatid)!="undefined"){
					   			tariffarray.push(rows[i].subcatid+" :: "+rows[i].grpid+" :: "+rows[i].tarifdocno+" :: "+rows[i].qty+" :: "+rows[i].hiremode+" :: "+rows[i].subtotal+" :: "+rows[i].maxdiscount+" :: "+rows[i].discount+" :: "+rows[i].total+" :: "+rows[i].vatperc+" :: "+rows[i].vatamt+" :: "+rows[i].nettotal+" :: "+rows[i].flname+" :: "+rows[i].detaildocno);
					   		}
						}
						
						$.post('updateContractTariff.jsp',{'docno':docno,'brhid':brhid,'tariffarray[]':tariffarray},function(data,status){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								$('.modal.fade.in').modal('hide');
								Swal.fire({
									icon: 'success',
									title: 'Success',
									text: 'Rate Updated Successfully'
								});
								$('#btnsubmit').trigger('click');
							}
							else{
								Swal.fire({
									icon: 'error',
									title: 'Warning',
									text: 'Not Updated'
								});
				        		return false;
							}
						});
					}
				});
			});
			
			
			$('.actionpanel button').click(function(){
	        	var docno=$('#docno').val();
	        	if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	var modaltarget=$(this).attr('data-target');
	        	$(modaltarget).modal('show');
	        });
			
			$('#btnsubmit').click(function(){
				$('.modal.fade.in').find('input:text').val('');
				$('.modal.fade.in').find('select').val('').trigger('change');
				$('.modal.fade.in').find('input:checkbox').each(function(){
					if($(this).is(':checked')){
						$(this).trigger('click');
					}
				});
				$('.textpanel p').text(' ');		
				$('.modal.fade.in').find('.jqx-datetimeinput').each(function(){
					$(this).jqxDateTimeInput('setDate',new Date());
				});
				$('.modal.fade.in').modal('hide');
				$('#contractMgmtDetailGrid').jqxGrid('clear');
	        	var brhid=$('#cmbbranch').val();
	        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
		 		var todate=$('#todate').jqxDateTimeInput('val');
		 		$("#overlay, #PleaseWait").show();
	        	$('#contractmgmtdiv').load('contractMgmtGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
	        });
			
			 $('#btnexcel').click(function(){
					$("#contractMgmtGrid").excelexportjs({
						containerid: "contractMgmtGrid",
						datatype: 'json',
						dataset: null,
						gridId: "contractMgmtGrid",
						columns: getColumns("contractMgmtGrid"),
						worksheetName: "Contract Management"
					});
				});
	       
		});
		
		function getInitData(){
			$.get('getInitData.jsp',function(data){
				data=JSON.parse(data);
				var htmldata='';
				$.each(data.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			htmldata='';
				$.each(data.processdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbfollowupstatus').html($.parseHTML(htmldata));
	  			$('#cmbbranch').select2({'placeholder':'Select Branch','allowClear':true});
			});
		}
		
	</script>
</body>
</html>