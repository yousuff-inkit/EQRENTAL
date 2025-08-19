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
	#modalequip .modal-body{
		background: #E0ECF8;
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
          			<button type="button" class="btn btn-default" id="btnfollowup" data-target="#modalfollowup"><i class="fa fa-calendar-check-o" aria-hidden="true" data-toggle="tooltip" title="Follow Up" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnapprove" data-target="#modalapproval"><i class="fa fa-check" aria-hidden="true" data-toggle="tooltip" title="Maintenance Approval" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btncontractcreate"><i class="fa fa-sticky-note" aria-hidden="true" data-toggle="tooltip" title="Contract Create" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnquoteprint"><i class="fa fa-print" aria-hidden="true" data-toggle="tooltip" title="Print" data-placement="bottom"></i></button>
        		</div>
        	</div>
        </div>
        <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="rentalquotediv"><jsp:include page="rentalQuoteGrid.jsp"></jsp:include></div>
        	</div>
        </div>
        <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="rentalquotefollowupdiv"><jsp:include page="rentalQuoteFollowupGrid.jsp"></jsp:include></div>
        	</div>
        </div>
        <div id="modalfollowup" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Quote Follow Up</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="form-horizontal">
	            				<div class="form-group">
    								<label class="control-label col-sm-2" for="email">Date:</label>
    								<div class="col-sm-10">
      									<div id="followupdate"></div>
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-2" for="email">Status:</label>
    								<div class="col-sm-10">
      									<select name="cmbfollowupstatus" id="cmbfollowupstatus" class="form-control">
      										<option value="">--Select--</option>
      									</select>
    								</div>
  								</div>
  								<div class="form-group">
    								<label class="control-label col-sm-2" for="email">Description:</label>
    								<div class="col-sm-10">
      									<input type="text" name="followupdesc" id="followupdesc" class="form-control">
    								</div>
  								</div>
	            			</div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            	<button type="button" class="btn btn-default btn-primary" id="btnfollowupsave">Update</button>
		          	</div>
	          	</div>
	        </div>
	      </div>
	      
	      <div id="modalapproval" class="modal fade" role="dialog">
	    	<div class="modal-dialog modal-lg">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Maintenance Approval</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div id="approvaldiv"><jsp:include page="approvalGrid.jsp"></jsp:include></div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            	<button type="button" class="btn btn-default btn-primary" id="btnapprovalsave">Update</button>
		          	</div>
	          	</div>
	        </div>
	      </div>
	      
	    <div id="modalequip" class="modal fade" role="dialog">
	    	<div class="modal-dialog modal-lg">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Equipment Search</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div id="equipmastersearchdiv"><jsp:include page="equipMasterSearch.jsp"></jsp:include></div>
	            		</div>
	            	</div>
	          	</div>
	        </div>
	      </div>
	      <div id="equipwindow">
   				<div></div>
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
			
			 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		    
			$("#followupdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
			$('[data-toggle="tooltip"]').tooltip(); 
			$('.load-wrapp').hide();
			getInitData();
			
			$('#btncontractcreate').click(function(){
				var docno=$('#docno').val();
				if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	var brhid=$('#rentalQuoteGrid').jqxGrid('getcellvalue',$('#gridindex').val(),'brhid');
	        	var url=document.URL;
	     		var reurl=url.split("com/");
	     		var path1="com/operations/marketing/rentalcontract/rentalContract.jsp";
  	     		var path= path1+"?refno="+docno+"&id=3&brhid="+brhid;
  	     		window.parent.formName.value="Contract Create";
				window.parent.formCode.value="ERC";
		 		top.addTab( "Contract Create",reurl[0]+""+path);
			});
			$('#btnquoteprint').click(function(){
				var docno=$('#docno').val();
				if(docno==""){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	var url=document.URL;
	     		var reurl=url.split("com/");
 				var win= window.open(reurl[0]+"com/operations/marketing/rentalquote/printRentalQuote?docno="+docno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 				win.focus();
		 		
			});
			$('#btnapprovalsave').click(function(){
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
					text: "Do you want to update maintenance approval QOT "+vocno,
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var fleetrows=$('#approvalGrid').jqxGrid('getrows');
						var fleetarray=new Array();
						for(var i=0;i<fleetrows.length;i++){
							var fleetno=$('#approvalGrid').jqxGrid('getcellvalue',i,'fleet_no');
							if(fleetno!="" && fleetno!="undefined" && fleetno!=null && typeof(fleetno)!="undefined" && fleetno!="0"){
								var calcdocno=$('#approvalGrid').jqxGrid('getcellvalue',i,'calcdocno');
								var grpid=$('#approvalGrid').jqxGrid('getcellvalue',i,'grpid');
								fleetarray.push(calcdocno+"::"+fleetno+"::"+grpid);
							}						
						}
						$.post('updateMainApproval.jsp',{'docno':docno,'fleetarray[]':fleetarray},function(data,status){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								$('.modal.fade.in').modal('hide');
								Swal.fire({
									icon: 'success',
									title: 'Success',
									text: 'Maintenance Approved Successfully'
								});
								$('#btnsubmit').trigger('click');
							}
							else{
								Swal.fire({
									icon: 'error',
									title: 'Warning',
									text: 'Please select a document'
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
	        	if($(this).attr('id')=='btnfollowup'){
	        		var processstatus=$('#rentalQuoteGrid').jqxGrid('getcellvalue',$('#gridindex').val(),'processstatus');
	        		if(parseInt(processstatus)>=2){
	        			Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Already Approved'
						});
		        		return false;
	        		}
	        	}
	        	if($(this).attr('id')=='btnapprove'){
	        		var processstatus=$('#rentalQuoteGrid').jqxGrid('getcellvalue',$('#gridindex').val(),'processstatus');
	        		if(parseInt(processstatus)>=3){
	        			Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Already Approved'
						});
		        		return false;
	        		}
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
				$('.modal.fade.in').find('.jqx-datetimeinput').each(function(){
					$(this).jqxDateTimeInput('setDate',new Date());
				});
				$('.modal.fade.in').modal('hide');
				$('#rentalQuoteFollowupGrid').jqxGrid('clear');
	        	//funGetCountData();
	        	var brhid=$('#cmbbranch').val();
	        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
		 		var todate=$('#todate').jqxDateTimeInput('val');
		 		$("#overlay, #PleaseWait").show();
	        	$('#rentalquotediv').load('rentalQuoteGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
	        });
			
			 $('#btnexcel').click(function(){
					$("#rentalQuoteGrid").excelexportjs({
						containerid: "rentalQuoteGrid",
						datatype: 'json',
						dataset: null,
						gridId: "rentalQuoteGrid",
						columns: getColumns("rentalQuoteGrid"),
						worksheetName: "Quotation Follow Up"
					});
				});
	        
	        $('#btnfollowupsave').click(function(){
	        	if($('#docno').val()==''){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
					return false;
	        	}
	        	if($('#cmbfollowupstatus').val()==''){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select a status'
					});
					return false;
	        	}
	        	var vocno=$('#vocno').val();
	        	var docno=$('#docno').val();
	        	Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to followup QOT "+vocno,
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var status=$('#cmbfollowupstatus').val();
						var date=$('#followupdate').jqxDateTimeInput('val');
						var desc=$('#followupdesc').val();
						$.post('saveFollowupData.jsp',{'docno':docno,'date':date,'status':status,'desc':desc},function(data,poststatus){
							data=JSON.parse(data);
							if(data.errorstatus=="0"){
								Swal.fire({
									icon: 'success',
									title: 'Success',
									text: 'Successfully Updated'
								});
								$('.modal.fade.in input').val('');
								$('#followupdate').jqxDateTimeInput('setDate',new Date());
								$('.modal.fade.in select').val('1');
								$('.modal.fade.in').modal('hide');
								if(status=="2"){
									$('#btnsubmit').trigger('click');									
								}
								else{
									$('#rentalquotefollowupdiv').load('rentalQuoteFollowupGrid.jsp?docno='+docno+'&id=1');
								}
								
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
		});
		
		function innerWindowSearchContent(url,windowid){
			$.get(url).done(function (data) {
				$('#'+windowid).jqxWindow('setContent', data);
			});
		}
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
	  			/*htmldata='';
	  			var htmldata2='';
				$.each(data.fleetdata,function(index,value){
	  				htmldata+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'" data-refname="'+value.refname+'">'+value.docno+'</li>';
	  				htmldata2+='<li class="list-group-item"><a href="#" data-docno="'+value.docno+'" data-refname="'+value.refname+'">'+value.refname+'</li>';
	  			});
	  			
	  			$('#fleetno').closest('.form-group').find('ul').html($.parseHTML(htmldata));
	  			$('#fleetname').closest('.form-group').find('ul').html($.parseHTML(htmldata2));
				
				$('ul[data-type="fleet"] li a').click(function(){
					var docno=$(this).attr('data-docno');
					$('#approvalGrid').jqxGrid('setcellvalue',$('#fleetindex').val(),'fleet_no',docno);
					$(this).closest('ul[data-type="fleet"]').hide();
					return false;
				});*/
			});
		}
		
		function funFilterList(el){
			var input=$(el).val();
			input = input.toUpperCase();
			var li=$(el).closest('.form-group').find('.searchlist li');
			for (i = 0; i < li.length; i++) {
    			var a = li[i].getElementsByTagName("a")[0];
    			var txtValue = a.textContent || a.innerText;
    			if (txtValue.toUpperCase().indexOf(input) > -1) {
      				li[i].style.display = "";
    			} else {
      				li[i].style.display = "none";
    			}
  			}
			
		}
		
		function funRoundAmt(value,id){
			var res=parseFloat(value).toFixed(2);
			var res1=(res=='NaN'?"0":res);
			document.getElementById(id).value=res1;  
		} 
    	function isNumber(evt) {
	    	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
	     		// document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	            return false;
			}
	        //document.getElementById("errormsg").innerText="";  
	        return true;
	    }
	</script>
</body>
</html>