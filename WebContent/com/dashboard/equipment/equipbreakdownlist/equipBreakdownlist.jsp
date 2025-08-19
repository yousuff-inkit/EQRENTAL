<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Breakdown List</title>
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
    
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom" onclick="funreload(event)"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
        	<select name="cmbbranch" id="cmbbranch" style="min-width:125px;" class="form-control"><option value="">--Select--</option></select>
        	<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="todate" data-toggle="tooltip" title="To Date"></div>
        	<div type="button" class="col-md-2 form-control pull-right" style="margin-left:5px;padding-right:0px" id="fromdate" data-toggle="tooltip" title="From Date"></div>
        </div>
      </div>
    </div>
    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="breakdowndiv"><jsp:include page="equipBreakdownlistGrid.jsp"></jsp:include></div>
      </div>
    </div>

  </div>

<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>

<script type="text/javascript">
		$(document).ready(function () {
			getInitData();
			 
			$("#fromdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
		 	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
			var onemonthbefore=new Date();
			onemonthbefore=new Date(onemonthbefore.setMonth(onemonthbefore.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate',onemonthbefore);
			
			 $('.load-wrapp').hide();
		});
		
		 $('#btnexcel').click(function(){
			$("#breakdownGrid").excelexportjs({
				containerid: "breakdownGrid",
				datatype: 'json',
				dataset: null,
				gridId: "breakdownGrid",
				columns: getColumns("breakdownGrid"),
				worksheetName: "Breakdown List"
			});
		});

		function funreload(event){
			var brhid = $('#cmbbranch').val();
	 		var fromdate=$('#fromdate').jqxDateTimeInput('val');
	 		var todate=$('#todate').jqxDateTimeInput('val');
	   		$("#breakdowndiv").load("equipBreakdownlistGrid.jsp?brhid="+brhid+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
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
			});			
		}    
		
	</script>
  
</body>
</html>
