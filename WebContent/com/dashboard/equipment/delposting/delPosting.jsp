<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Delivery Posting</title>
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
      	<!-- <div class="primarypanel custompanel"><select name="cmbbranch" id="cmbbranch" class="form-control"><option value="">--Select--</option></select></div> -->
        <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        	<select name="cmbbranch" id="cmbbranch" style="min-width:125px;" class="form-control"><option value="">--Select--</option></select>
		</div>
        <div class="primarypanel custompanel">
        	<select name="cmbtype" id="cmbtype" style="min-width:125px;" class="form-control">
        		<option value="PRE">Pre-Posted</option>
        		<option value="POST">Posted</option>
        	</select>
        </div>
       
        <div class="otherpanel custompanel">
			<button type="button" class="btn btn-default" id="btncreateni" data-toggle="tooltip" title="Create NI Purchase" data-placement="bottom"><i class="fa fa-sticky-note" aria-hidden="true"></i></button>
			<button type="button" class="btn btn-default" id="btnupdate" data-toggle="tooltip" title="Update" data-placement="bottom"><i class="fa fa-check" aria-hidden="true"></i></button>       
		</div>
       
       <div class="textpanel custompanel">
			<p class="h4"> </p>
        </div>
       
		<input type="hidden" id="docno" name="docno"/>
		<input type="hidden" id="cpudocno" name="cpudocno"/>
		<input type="hidden" id="date" name="date"/>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="delpostingdiv"><jsp:include page="delPostingGrid.jsp"></jsp:include></div>
      </div>
    </div>

	</div>

    </div>
  </form>
  
    <div id="modalnipurchase" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Create NI Purchase</h4>
          		</div>
          		<div class="modal-body">
            		<p><!-- Some text in the modal. --></p>
            		<div class="container-fluid">
            			
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Post Date
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div id="postdate" class="form-control"></div>
							</div>
            			</div>
            			
            	</div>
            	<div class="modal-footer text-right">
            		<button type="button" name="btnsavenipurchase" id="btnsavenipurchase" class="btn btn-default btn-primary">Create</button>
          		</div>
          	</div>
        </div>
	</div>
 </div>
  
   <div id="modalupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Update</h4>
          		</div>
          		<div class="modal-body">
            		<p><!-- Some text in the modal. --></p>
            		<div class="container-fluid">
            			<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Inv No
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" id="invno" class="form-control" autocomplete="off">
							</div>
            			</div>
						
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Inv Date
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<div id="invdate" class="form-control"></div>
							</div>
            			</div>
						
						<div class="row rowgap">
            				<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 text-right">
            					Gate In-Pass
            				</div>
            				<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            					<input type="text" id="gatepassno" class="form-control" autocomplete="off">
							</div>
            			</div>	
            			
            	</div>
            	<div class="modal-footer text-right">
            		<button type="button" name="btnupdatedoc" id="btnupdatedoc" class="btn btn-default btn-primary">Update</button>
          		</div>
          	</div>
        </div>
	</div>
 </div>
	
   

<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>

<script type="text/javascript">
		(function($) {
			$.fn.inputFilter = function(inputFilter) {
				return this.on("input keydown keyup mousedown mouseup select contextmenu drop",
					function() {
						if (inputFilter(this.value)) {
							this.oldValue = this.value;
							this.oldSelectionStart = this.selectionStart;
							this.oldSelectionEnd = this.selectionEnd;
						} else if (this.hasOwnProperty("oldValue")) {
							this.value = this.oldValue;
							this.setSelectionRange(
							this.oldSelectionStart,
							this.oldSelectionEnd);
						} else {
							this.value = "";
						}
				});
			};
		}(jQuery));

		$(document).ready(function() {
			$('[data-toggle="tooltip"]').tooltip();
			$('#cmbbranch').select2();
			getInitData();
			$("#postdate").jqxDateTimeInput({
				width : '125px',
				height : '15px',
				formatString : "dd.MM.yyyy"
			});
			
			$("#date").jqxDateTimeInput({
				width : '125px',
				height : '15px',
				formatString : "dd.MM.yyyy"
			});
			
			$("#invdate").jqxDateTimeInput({
				width : '125px',
				height : '15px',
				formatString : "dd.MM.yyyy"
			});
			
			$('.load-wrapp').hide();
		});

		$('#btnexcel').click(function(){
	        $("#floorMgmtGrid").excelexportjs({
				containerid: "floorMgmtGrid",
				datatype: 'json',
				dataset: null,
				gridId: "floorMgmtGrid",
				columns: getColumns("floorMgmtGrid"),
				worksheetName: "Delivery Posting Data of Equipments"
			});
	    });

		$('#btnsubmit').click(function() {
			fillGrid();
		});
		
		$("#btncreateni").click(function(){
			if($('#docno').val().trim()==""){
				$.messager.alert('warning','Please select a document');    
				return false;
			} 
			
			if($('#cpudocno').val().trim()!="0"){
				$.messager.alert('warning','Document already posted');    
				return false;
			} 
			
			if(!$.isNumeric($('#cmbbranch').val())){
				$.messager.alert('warning','Please select a branch');    
				return false;
			} 
			
			$("#modalnipurchase").modal('show');
		})

		$("#btnsavenipurchase").click(function(){
				var rowindex=$("#rowindex").val();
				var branch=$("#cmbbranch").val();
				var docno=$("#docno").val();

				var contractdocno = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'contractdocno');
				var client = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'client');
				var gatepassno = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'gatepassno');
				var vendorid = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'vndid');
				var invno = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'invno');
				var vendoramount = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'amount');
				var vendortaxamount = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'vat');
				var vendornetamount = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'netamt');
				var fleet = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'fleet');
				var driver = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'driver');
				var address = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'address');
				var desc = $('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'remarks');
				var datetime = $('#date').val()+' '+$('#floorMgmtGrid').jqxGrid('getcellvalue',rowindex,'time');
				   
				var date = $('#postdate').val();     
				var invdate = $('#postdate').val(); 
			
				var chkinclusive=0;
				var vendortax = 1;

				var vendordiscount = 0;
				var vendortaxtotal = vendornetamount;
				
				var description="Cont No - "+contractdocno+" - "+client+" - "+gatepassno;
				
				var gridarray=new Array();				
				gridarray.push(fleet+"::"+driver+"::"+vendoramount+"::"+vendordiscount+"::"+vendornetamount+"::"+vendortaxamount+"::"+vendortaxtotal+"::"+datetime+"::"+description);
	
			   	$.messager.confirm('Message', 'Do you want to create NI Purchase?', function(r){        
					if(r){
						var x=new XMLHttpRequest();  
						x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200)
							{
								var items=x.responseText.split("::");     
					   			if(parseInt(items[0])==0)                       
								{  
						   			$.messager.alert('Message', 'NI Purchase - '+items[1]+' Successfully Created ');
						   			fillGrid ();
						   			$("#modalnipurchase").modal('hide');
						   			$('#postdate').jqxDateTimeInput('setDate',new Date());
								}
								else
								{       
									$.messager.alert('Warning', 'Not Created');
								}
							}   
						}        
						x.open("GET","createNIPurchase.jsp?gridarray="+gridarray+"&branch="+branch+"&address="+address+"&docno="+docno+"&invdate="+invdate+"&date="+date
								+"&desc="+encodeURIComponent(desc)+"&invno="+invno+"&vendorid="+vendorid
								+"&bill="+vendortax+"&chkinclusive="+chkinclusive,true);                                
						x.send();
					}else{
						$("#modalnipurchase").modal('hide');
			   			$('#postdate').jqxDateTimeInput('setDate',new Date());
					}
				});      
		});
		
		$("#btnupdate").click(function(){
			if($('#docno').val().trim()==""){
				$.messager.alert('warning','Please select a document');    
				return false;
			} 
						
			$("#modalupdate").modal('show');
		})
		
		$("#btnupdatedoc").click(function(){		
				
				var docno=$("#docno").val().trim();
				var invno=$("#invno").val().trim();     
				var invdate=$('#invdate').val().trim(); 
				var gatepassno=$("#gatepassno").val().trim();
							
			   	$.messager.confirm('Message', 'Do you want to save changes?', function(r){        
					if(r){
						var x=new XMLHttpRequest();  
						x.onreadystatechange=function(){
							if (x.readyState==4 && x.status==200)
							{
								var items=x.responseText;  
					   			if(parseInt(items)==0)                       
								{  
						   			$.messager.alert('Message', 'Record Successfully Updated');
						   			fillGrid ();
						   			$("#modalupdate").modal('hide');
						   			
								}
								else
								{       
									$.messager.alert('Warning', 'Not Updated');
								}
							}   
						}        
						x.open("GET","updateData.jsp?docno="+docno+"&invno="+invno+"&invdate="+invdate+"&gatepassno="+gatepassno,true);                                
						x.send();
					}else{
						$("#modalupdate").modal('hide');			   			
					}
				});      
		});
		
		function fillGrid (){
			var brhid = $('#cmbbranch').val();
			var type = $('#cmbtype').val();
			$('#delpostingdiv').load('delPostingGrid.jsp?id=1&brhid=' + brhid +"&type="+type);

		    $('.textpanel p').text('');
		    $('#docno').val('');
		} 
		
		function getInitData() {
			$.get('getInitData.jsp', function(data) {
				data = JSON.parse(data.trim());
				var htmldata = '';
				$.each(data.branchdata, function(index, value) {
					htmldata += '<option value="'+value.docno+'">'+ value.refname + '</option>';
				});
				$('#cmbbranch').html($.parseHTML(htmldata));
				$('#cmbbranch').select2();
			});
		}
	</script>

</body>
</html>
