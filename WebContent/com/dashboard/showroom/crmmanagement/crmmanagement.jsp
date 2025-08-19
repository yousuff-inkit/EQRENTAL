<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client Management</title>              
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>               
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
  <style type="text/css"> 
	  .branch {
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	}  
      .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 15px;
		/* background-color:#fff; */
		background-image: linear-gradient(to right bottom, #7468fd, #5677ff, #3784fe, #178ef9, #0897f2);
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
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:360px;  
  		/* height:50px;       */           
  } 
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    .custompanel1{
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
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
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
    .actionpanel{
        padding-right: 5px; 
    }
    .otherpanel{
        padding-right: 5px; 
    }
    .primarypanel{
        padding-right: 5px; 
    }
    .padtop{
        padding-top: 5px; 
    }
    .class-pad5{
     padding-top: 5px; 
    }
    .card-body span{
      color:#FFFFFF;
    }
  </style>
</head>       
<body >         
<form id="frmCRMManagement"  method="post" autocomplete="off">         
  <div class="container-fluid">
        <div class="row padtop">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="hotdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">  
                            <div id="hot"></div>
                            <span><img src="icons/icons8-new-resume-template-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Hot</span><br/>        
                             <span class="counter">2</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="colddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="cold"></div>
                            <span><img src="icons/icons8-resume-template-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Cold</span><br/>
                             <span class="counter">3</span>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="visiteddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">  
                            <div id="visited"></div>
                            <span><img src="icons/icons8-inspection-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Visited</span><br/>  
                             <span class="counter">1</span>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-1">&nbsp;</div>      
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="potcusdiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="potcus"></div>
                            <span><img src="icons/icons8-client-management-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Potential Customer</span><br/>  
                             <span class="counter">4</span>  
                        </div>
                    </div>
                </div>
           </div>	
    </div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="actionpanel custompanel1">                                      
          <button type="button" class="btn btn-default" id="btnregistration" data-toggle="tooltip"  title="Customer Registration" data-placement="bottom"><i class="fa fa-pencil-square "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnbooktestdrive"  data-toggle="tooltip" title="Book Test Drive" data-placement="bottom"><i class="fa fa-bus "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnconvert"  data-toggle="tooltip" title="Convert to client" data-placement="bottom"><i class="fa fa-retweet "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnstatusupdate" data-toggle="tooltip"  title="Status Update" data-placement="bottom"><i class="fa fa-pencil-square-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnfollowup" data-toggle="tooltip"  title="Followup" data-placement="bottom"><i class="fa fa-commenting-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        </div>  
        <div class="textpanel custompanel" >   
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">           
        <div id="crmdiv"><jsp:include page="crmmanagementGrid.jsp"></jsp:include></div>            
      </div>
    </div>    
	 <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
        <div id="flwupDiv"><jsp:include page="flwupGrid.jsp"></jsp:include></div>
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
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>    
   <div id="modalcusregistration" class="modal fade" role="dialog">       
    	<div class="modal-dialog modal-xl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Customer Registration<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>   
          		</div>
          		<div class="modal-body">   
  					<div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Name">Name</label>     
		        					<input type="text" id="txtname" name="txtname" readonly class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Mobile">Mobile</label>     
		        					<input type="text" id="txtmobile" name="txtmobile" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Email">Email</label>     
		        					<input type="text" id="txtemail" name="txtemail" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 	  
            		</div> 
            		<div class="row"> 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
		        				<div class="form-group">
		        					<label for="Address">Address</label>     
		        					<input type="text" id="txtaddress" name="txtaddress" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">
  					         <div class="form-inline">  
  					            <label for="Whatsapp" class="col-sm-11 col-form-label">Whatsapp</label>    
							    <div class="col-sm-1"> <input type="checkbox" id="chkwhatsapp" name="chkwhatsapp" onchange="funwhatsappcheck();"></div>
							  </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="Whatsapp No">&nbsp;Whatsapp No</label>           
		        					<input type="text" id="txtwhatsappno" name="txtwhatsappno" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 	
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
		        				<div class="form-group">
		        					<label for="Salesman">Salesman</label>     
		        					<input type="text" id="txtsalesman" name="txtsalesman" class="form-control input-sm">    
	                     	    </div>  
		                   </div>   
            		</div>
            	  <div class="row">       
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">             
				        <div id="quesdiv"><jsp:include page="questionaireGrid.jsp"></jsp:include></div>             
				      </div>
				      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">               
				        <div id="branddiv"><jsp:include page="brandGrid.jsp"></jsp:include></div>             
				      </div>
			      </div>      
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btncusregistrationsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>  
    <div id="modalstatusupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog sm">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>  
            		<h4 class="modal-title">Status Update<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>
          		</div> 
          		<div class="modal-body">
  					<div class="row">  
  					       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="Driver">Status:</label>   
		        					<select class="form-control select2" name="cmbstatus" id="cmbstatus" style="width:100%;">
		        					<option value="">--Select--</option>
		        					<option value="1">Visited</option>
		        					<option value="2">Potential Customer</option>
		        					<option value="3">Hot</option> 
		        					<option value="4">Cold</option></select>   
	                     	    </div>  
		                   </div>
  					</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnstatussave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>  
    <div id="modalfollowup" class="modal fade" role="dialog">  
    	<div class="modal-dialog sm">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>  
            		<h4 class="modal-title">Follow-Up<span></span></h4>  <label for="otherdetails3" id="lblotherdetails3"></label>
          		</div> 
          		<div class="modal-body">
  					<div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date</label>      
		        					<div  id="flwupdate" > </div>  
		                        </div> 
		                     </div>    
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">  
		        				<div class="form-group">
		        					<label for="Remarks">Remarks</label>     
		        					<input type="text" id="txtflwupremarks" name="txtflwupremarks" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div> 
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnflwupsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>  
       <div id="modaltestdrive" class="modal fade" role="dialog">       
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Book Test Drive<span></span></h4>  <label for="otherdetails4" id="lblotherdetails4"></label>   
          		</div>
          		<div class="modal-body">    
  					<div class="row"> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Name">Name</label>     
		        					<input type="text" id="txtname" name="txtname" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="License No">License No</label>       
		        					<input type="text" id="txtlicenseno" name="txtlicenseno" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div> 
            		<div class="row"> 
            		      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Date</label>     
		        					<div  id="testdate"></div>   
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Time">Time</label>     
		        					<div  id="testtime"></div>            
	                     	    </div>  
		                   </div> 	 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="Fleet">Fleet</label>      
		        					<input type="text" id="txtfleet" name="txtfleet" class="form-control input-sm">    
	                     	    </div>  
		                   </div> 
            		</div>
            		<div class="row"> 
            		      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        				<div class="form-group">
		        					<label for="Date">Lic. Exp. Date</label>     
		        					<div  id="licexpdate"></div>   
	                     	    </div>  
		                   </div> 
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="lictype">Lic. Type</label>        
		        					<select class="form-control select2" name="cmblictype" id="cmblictype" style="width:100%;">
		        					<option value="">--Select--</option>
		        					<option value="GCC">GCC</option>
		        					<option value="IDP">IDP</option>
		        					<option value="UAE">UAE</option></select>          
	                     	    </div>  
		                   </div> 
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="licissuedfrom">Lic. Issued from</label>     
		        					 <input type="text" id="txtlicissuedfrom" name="txtlicissuedfrom" class="form-control input-sm">        
	                     	    </div>  
		                   </div> 	
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>    
          			<button type="button" class="btn btn-default btn-primary" id="btntestdrivesave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div> 
  <input type="hidden" name="hidbrhid" id="hidbrhid"> 
  <input type="hidden" name="hiddocno" id="hiddocno">   
  <input type="hidden" name="hidcomments" id="hidcomments">  
  <input type="hidden" name="lblname" id="lblname">   
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
	    $('#searchWindow').jqxWindow({width: '50%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	    $('#searchWindow').jqxWindow('close');  
	    $("#flwupdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
	    $("#testdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	$("#testtime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
    	$("#licexpdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	    funwhatsappcheck();     
	   
	    $('#btnregistration').click(function(){
	    	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	$('#quesdiv').load('questionaireGrid.jsp?id=1');    
	    	$('#branddiv').load('brandGrid.jsp?id=1');     
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
	    	$("#modalcusregistration").modal('toggle');                            
        });
	    $('#btnstatusupdate').click(function(){
	    	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();
	    	$("#modalstatusupdate").modal('toggle');                         
        });
	    $('#btnfollowup').click(function(){  
	    	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails3").innerHTML=$("#lblname").val();
	    	$("#modalfollowup").modal('toggle');                           
        });
	    $('#btnbooktestdrive').click(function(){ 
	    	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails4").innerHTML=$("#lblname").val();
	    	$("#modaltestdrive").modal('toggle');                           
        });
	    $('#btnattachs').click(function(){   
         	funAttachs(event);      
         });
        $('#btnsubmit').click(function(){    
            loads(); 
            $("#jqxFollowupGrid").jqxGrid('clear');   
            $('.textpanel p').text(''); 
        });
        $('#btncomment').click(function(){    
        	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	 getComments(); 
        }); 
        $('#btnexcel').click(function(){    
        	$("#crmdiv").excelexportjs({ 
        		containerid: "crmdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxCRMGrid",   
        		columns: getColumns("jqxCRMGrid") ,   
        		worksheetName:"CRM Management"    
         		});
        });
        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var docno=$('#hiddocno').val();  
	        if(docno==""){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
        	if(txtcomment==""){
        		Swal.fire({
        			icon: 'warning',
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
        		$('#jqxCRMGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function funwhatsappcheck(){    
    	if(document.getElementById("chkwhatsapp").checked){
    		$('#txtwhatsappno').attr("disabled",false);    
    	}else{
    		$('#txtwhatsappno').attr("disabled",true); 
    	}
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
    	$("#jqxCRMGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxCRMGrid").jqxGrid('applyfilters');    
 	}   
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hidrowno').val();  
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&reftrno="+enqno,true);
		x.send();
    }
    function getComments(){  
    	var enqno=$('#hidrowno').val();
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
		x.open("GET","getComments.jsp?reftrno="+enqno,true);    
		x.send();
    }
    function loads(){   
	    $("#overlay, #PleaseWait").show();  
	    $('#crmdiv').load('crmmanagementGrid.jsp?id=1');         
    }  
	function funAttachs(event){                         
		var brchid=document.getElementById("hidbrhid").value;    
   		var docno=document.getElementById("hiddocno").value;  
   		var url=document.URL;
		var reurl=url.split("com/");
 		if(docno!="" && docno!="0"){                   
   			var frmdet="PCC"; 
   			var fname="Client";
   		    var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
   		}else{   
   			Swal.fire({
				icon: 'warning',
				title: 'Warning',
				text: 'Please select a document'   
			});  
			return;
		    }               
	   }
  </script>  
<div id="searchWindow">
	<div></div><div></div>
</div> 
  </div>
  </form>   
</body>
</html>
