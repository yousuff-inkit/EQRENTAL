<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Ticket Voucher Create</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>        
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
  	html,body{
		width:100%;
		height:100%;
		//background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}  
  .hidden-scrollbar {
    overflow: auto; 
    height: 600px;
   }  
    .modal-header,.modal-footer {     
           background-color:#fff091;    
    } 
    .modal-body { 
           background-color:#fcf9c0;         
    }  
  .rowspace { 
        border-collapse:separate; 
        border-spacing:0 5px;       
    } 
  
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   .form-group label{
		font-weight:normal;
	}
	.input-sm{
		height:24px;    
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
      .btnStyle{  
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);              
	    position: relative;
	   -webkit-transition: all 0.3s;
	   -moz-transition: all 0.3s;
	   transition: all 0.3s;
  }
    #myNavbar,
#myNavbar ul,
#myNavbar ul li,
#myNavbar ul li a {
  margin: 0;
  padding: 0;
  border: 0;
  list-style: none;
  line-height: 1;  
  display: block;
  position: relative;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
#myNavbar:after,
#myNavbar > ul:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;  
  height: 0;
}
#myNavbar {
  width: auto;
  border-bottom: 3px solid #2467A6;
  font-family: Raleway, sans-serif;
  line-height: 1;  
}
#myNavbar{     
  background-color:#E9E9E9;
}
#myNavbar > ul > li {
  float: left;
}
#myNavbar.align-center > ul {
  font-size: 0;
  text-align: center;
}
#myNavbar.align-center > ul > li {
  display: inline-block;
  float: none;
}
#myNavbar.align-right > ul > li {
  float: right;
}
#myNavbar.align-right > ul > li > a {
  margin-right: 0;
  margin-left: -4px;
}
#myNavbar > ul > li > a {
  z-index: 2;
  padding: 18px 25px 12px 25px;
  font-size: 15px;
  font-weight: 400;
  text-decoration: none;
  color: #2467A6;
  -webkit-transition: all .2s ease;
  -moz-transition: all .2s ease;
  -ms-transition: all .2s ease;
  -o-transition: all .2s ease;
  transition: all .2s ease;
  margin-right: -4px;
}
#myNavbar > ul > li.active > a,
#myNavbar > ul > li:hover > a,
#myNavbar > ul > li > a:hover {
  color: #ffffff;
}
#myNavbar > ul > li > a:after {
  position: absolute;
  left: 0;
  bottom: 0;
  right: 0;
  z-index: -1;
  width: 100%;
  height: 120%;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  content: "";
  -webkit-transition: all .3s ease;
  -o-transition: all .3s ease;
  transition: all .3s ease;
  -webkit-transform: perspective(5px) rotateX(2deg);
  -webkit-transform-origin: bottom;
  -moz-transform: perspective(5px) rotateX(2deg);
  -moz-transform-origin: bottom;
  transform: perspective(5px) rotateX(2deg);
  transform-origin: bottom;
}
#myNavbar > ul > li.active > a:after,
#myNavbar > ul > li:hover > a:after,
#myNavbar > ul > li > a:hover:after {
   background: #2467A6; 
}
.borderStyle{  
    margin-bottom: 0;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    border: none;
    line-height: 1.42857143;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 1px 2px 7px 3px #d4cece;                         
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }
  </style>   
</head>                 
<body onload="getGDS();getType();getTicketType();funload();setvalues();getBranch();">                                        
  <form autocomplete="off" id="frmticketvouchercreate" action="saveticketvouchercreate" method="post"> 
  <div class="container-fluid " style="margin:auto;">      
  <div class="borderStyle">
  <div class="row " >
     <div class="col-md-12" id="navdataset">   
	    <nav class="navbar navbar-default travel-navbar">
    		<div class="collapse navbar-collapse" id="myNavbar">     
      			<ul class="nav navbar-nav">  
					<li class="active" id="mod1"><a data-toggle="pill" href="#modalGeneral" >General</a></li>       
					<li id="mod2"><a data-toggle="pill" href="#modalFare">Fare</a></li>
				    <li id="mod3"><a data-toggle="pill" href="#modalAddInfo">Additional Info</a></li>         
     			</ul>
     			<ul class="nav navbar-nav navbar-right">       
     			   <li style="padding-top: 1em;"><select id="cmbbranch" name="cmbbranch" style="height:25px;"  value='<s:property value="cmbbranch"/>'  class="form-control input-sm"></select>    
							<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></li>    
     			   <li style="padding-top: 1em;"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' class="form-control input-sm" placeHolder="DocNo" readonly style="width:100px;background-color:#fff"></li>     
			       <li><a href="javascript:void(0);" id="btnCreate" onclick="funremovereadonly();"><span class="glyphicon glyphicon-plus"></span>Add</a></li>  
			       <li><a href="javascript:void(0);" id="btnEdit" onclick="funedit();"><span class="glyphicon glyphicon-edit"></span>Edit</a></li>                                                              
			       <li><a href="javascript:void(0);" id="btnDelete" onclick="fundelete();"><span class="glyphicon glyphicon-trash"></span>Delete</a></li>  
			       <li><a href="javascript:void(0);" onclick="funsearch();"><span class="glyphicon glyphicon-search"></span>Search</a></li>                 
			    </ul>
    		</div>  
	   </nav>
	</div>  
 </div>
<div class="container-fluid m-t-60" id="modaldataset">        
  <div class="tab-content">  
    <div id="modalGeneral" class="tab-pane fade in active">   
	        		            <div class="row m-t-10">
	        		                           <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        						<div class="form-group">
							        							<label>Ticket No</label>  
							        							<input type="text" id="ticketno" name="ticketno"  value='<s:property value="ticketno"/>' class="form-control input-sm" placeHolder="Enter Ticket No">        
							        						</div>
							        					</div>
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
								        			<div class="form-group">
								        				<label for="client">Customer</label>    
								        				<div id="tourtype"><jsp:include page="clientSearch.jsp"></jsp:include></div>      
								        				<input type="hidden" name="clid" id="clid"  value='<s:property value="clid"/>'>	    
								        			</div> 
								        		</div>
								        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
								        			<div class="form-group">
								        				<label for="tourtype">Supplier</label>    
								        				<div id="supplier"><jsp:include page="suppplierSearch.jsp"></jsp:include></div>      
								        				<input type="hidden" name="vndid" id="vndid"  value='<s:property value="vndid"/>'>	  
								        			</div> 
								        		</div>
								        	   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        						<div class="form-group">
							        							<label>Booking Date</label>     
							        						     <div  id="bookingdate" name="bookingdate"  value='<s:property value="bookingdate"/>' class="m-l-10">            
							        						</div>
							        		            </div>                 
							                    </div> 
							                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        						<div class="form-group">
							        							<label>Issue Date</label>     
							        						     <div  id="issuedate"  name="issuedate"  value='<s:property value="issuedate"/>' class="m-l-10">           
							        						</div>
							        		            </div>
							                    </div>
							        </div>            
							     <div class="row m-t-10"> 
							         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        		<div class="form-group">
							        			<label>Guest</label>      
							        				<input type="text" id="guestname" name="guestname"  value='<s:property value="guestname"/>' class="form-control input-sm" placeHolder="Enter Guest Name">              
							        		</div>
							        	</div>  
							        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
							        		<div class="form-group">
							        			<label>Airline</label>     
							        				<input type="text" id="airline" name="airline"  value='<s:property value="airline"/>' class="form-control input-sm" placeHolder="Enter Airline" readonly>  
							        				<input type="hidden" id="airlineid" name="airlineid"  value='<s:property value="airlineid"/>' readonly>                       
							        		</div>
							        	</div>
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
							        		<div class="form-group">
							        			<label>Sector</label>       
							        				<input type="text" id="sector" name="sector"  value='<s:property value="sector"/>' class="form-control input-sm" placeHolder="Enter Sector">                    
							        		</div>
							        	</div> 	
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
							        		<div class="form-group">
							        			<label>Class</label>     
							        				<input type="text" id="txtclass" name="txtclass"  value='<s:property value="txtclass"/>' class="form-control input-sm" placeHolder="Enter Class">                    
							        		</div>
							        	</div> 	
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
							        		<div class="form-group">
							        			<label>GDS</label>     
							        			<select  id="cmbgds"  name="cmbgds"  value='<s:property value="cmbgds"/>' style="height:25px;" class="form-control input-sm">  
							        						<option value="">------Select------</option>        
							        					</select>
							        			<input type="hidden" name="hidgds" id="hidgds"  value='<s:property value="hidgds"/>'>
							        		</div>
							        	</div>
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">              
							        		<div class="form-group">
							        			<label>Booking Staff</label>     
							        				<input type="text" id="bstaff" name="bstaff"  value='<s:property value="bstaff"/>' class="form-control input-sm" placeHolder="Enter Booking Staff" readonly> 
							        				<input type="hidden" name="bstaffid" id="bstaffid"  value='<s:property value="bstaffid"/>'>                     
							        		</div>
							        	</div> 	  
	                              </div>
	                <div class="row m-t-10"> 
							         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
							        		<div class="form-group">
							        			<label>Ticketing Staff</label>        
							        				<input type="text" id="tstaff" name="tstaff"  value='<s:property value="tstaff"/>' class="form-control input-sm" placeHolder="Enter Ticketing Staff" readonly> 
													<input type="hidden" name="tstaffid" id="tstaffid"  value='<s:property value="tstaffid"/>'>                      
							        		</div>
							        	</div>  
							        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
							        		<div class="form-group">
							        			<label>Issue Type</label>   
							        			<select id="cmbissuetype" name="cmbissuetype"  value='<s:property value="cmbissuetype"/>' style="height:25px;" class="form-control input-sm">
							        						<option value="">------Select------</option>
							        						<option value="1">INBOUND</option>
							        						<option value="2">OUTBOUND</option>   
							        					</select>  
							        			<input type="hidden" name="hidissuetype" id="hidissuetype"  value='<s:property value="hidissuetype"/>'>		
							        		</div>
							        	</div> 
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							        		<div class="form-group">
							        			<label>Type</label> 
							        			<select  id="cmbtype" name="cmbtype"  value='<s:property value="cmbtype"/>' style="height:25px;" class="form-control input-sm">  
							        						<option value="">------Select------</option>        
							        					</select>  
							        			<input type="hidden" name="hidtype" id="hidtype"  value='<s:property value="hidtype"/>'>			    
							        		</div>
							        	</div> 	
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">            
							        		<div class="form-group">  
							        			<label>Ticket Type</label>  
							        			<select  id="cmbtickettype" name="cmbtickettype" style="height:25px;" value='<s:property value="cmbtickettype"/>' class="form-control input-sm">    
							        						<option value="">------Select------</option>        
							        					</select>
							        			<input type="hidden" name="hidtickettype" id="hidtickettype"  value='<s:property value="hidtickettype"/>'>			   
							        		</div>
							        	</div> 
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
							        		<div class="form-group">
							        			<label>PNR No</label>            
							        				<input type="text" id="prnno" name="prnno" onkeydown="focustonexttab1(event);"  value='<s:property value="prnno"/>' class="form-control input-sm" placeHolder="Enter PNR No">                 
							        		</div>  
							        	</div> 
	                   </div>
	        </div>
	    <div id="modalFare" class="tab-pane fade">      
			<div class="">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Rate(AED)</label>       
							        <input type="text" id="txtrate"  name="txtrate"  value='<s:property value="txtrate"/>' class="form-control input-sm" placeHolder="Enter Rate" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Supplier Amount</label>       
							        <input type="text" id="suppamt" name="suppamt" onchange="funcalcsuptot();"  value='<s:property value="suppamt"/>' class="form-control input-sm" placeHolder="Enter Supplier Amount" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Tax Amount</label>       
							        <input type="text" id="taxamt" name="taxamt" onchange="funcalcsuptot();"  value='<s:property value="taxamt"/>' class="form-control input-sm" placeHolder="Enter Tax Amount" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">              
							    <div class="form-group">
							        <label>Supplier Total</label>       
							        <input type="text" id="supptot" name="supptot" onchange="funtotal();" readonly value='<s:property value="supptot"/>' class="form-control input-sm" placeHolder="Enter Supplier Total" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Service Fee</label>       
							        <input type="text" id="servfee" name="servfee" onchange="funtotal();" value='<s:property value="servfee"/>' class="form-control input-sm" placeHolder="Enter Service Fee" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
	        		</div>
	       <div class="row m-t-5">
	                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">    
						<div class="form-group">
							  <label>Payback Amount</label>       
							   <input type="text" id="paybackamt" name="paybackamt" onchange="funtotal();" value='<s:property value="paybackamt"/>' class="form-control input-sm" placeHolder="Enter Payback Amount" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
						 </div>
					</div>
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">        
						<div class="form-group">
							  <label>Payback Account</label>    
							  <div class="form-inline">      
							   <input type="text" id="payacno"   value='<s:property value="payacno"/>' class="form-control input-sm" placeHolder="Account No" readonly style="width:100px">   
							   <input type="text" id="paybackacc"   value='<s:property value="paybackacc"/>' class="form-control input-sm" placeHolder="Account Name" readonly style="width:530px"> 
							   <input type="hidden" name="acc_docno" id="acc_docno"  value='<s:property value="acc_docno"/>'>  
							   </div>                                           
						 </div>
					</div> 
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">           
						<div class="form-group">  
							  <label>Selling Price</label>       
							   <input type="text" id="sellingprice" name="sellingprice" onkeydown="focustonexttab2(event);" readonly value='<s:property value="sellingprice"/>' class="form-control input-sm" placeHolder="Enter Selling Price" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
						 </div>  
					</div>
	       </div>
			</div> 
	</div>
	 <div id="modalAddInfo" class="tab-pane fade">
			<div class="">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">           
						    <div class="form-group">
							  <label>Fare Basis</label>       
							   <input type="text" id="farebasis" name="farebasis"  value='<s:property value="farebasis"/>' class="form-control input-sm" placeHolder="Enter Fare Basis">                                  
						    </div>
					     </div>
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						    <div class="form-group">
							  <label>Region Code</label>   
							  <select id="cmbregioncode"  name="cmbregioncode"  value='<s:property value="cmbregioncode"/>' style="height:25px;" class="form-control input-sm">
							        						<option value="">------Select------</option>
							        						<option value="1">INT</option>
							        					</select>  
							       	<input type="hidden" name="hidregioncode" id="hidregioncode"  value='<s:property value="hidregioncode"/>'> 					    
						    </div>
					     </div>
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">           
						    <div class="form-group">
							  <label>Remarks</label>       
							   <input type="text" id="txtremarks" name="txtremarks"  value='<s:property value="txtremarks"/>' class="form-control input-sm" placeHolder="Enter Remarks">                                  
						    </div>
					     </div>  
	        		</div>
	        		<div class="row m-t-5">
	        		     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						    <div class="form-group">
							  <label>Booking Agency IATA No</label>       
							   <input type="text" id="bookingiatano" name="bookingiatano"  value='<s:property value="bookingiatano"/>' class="form-control input-sm" placeHolder="Enter Booking Agency IATA No">                                  
						    </div>
					     </div> 
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						    <div class="form-group">
							  <label>Ticketing Agency IATA No</label>       
							   <input type="text" id="ticketingiatano" name="ticketingiatano"  value='<s:property value="ticketingiatano"/>' class="form-control input-sm" placeHolder="Enter Ticketing Agency IATA No">                                  
						    </div>
					     </div>
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						    <div class="form-group">
							  <label>Booking Agency Office ID</label>       
							   <input type="text" id="bookingofficeid" name="bookingofficeid"  value='<s:property value="bookingofficeid"/>' class="form-control input-sm" placeHolder="Enter Booking Agency Office ID">                                  
						    </div>
					     </div> 
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                
						    <div class="form-group">
							  <label>Ticketing Agency Office ID</label>         
							   <input type="text" id="ticketingofficeid"  name="ticketingofficeid"  value='<s:property value="ticketingofficeid"/>' class="form-control input-sm" placeHolder="Enter Ticketing Agency Office ID">                                  
						    </div>
					     </div>
					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						    <div class="form-group">
							  <label>PNR First Owner Office ID</label>         
							   <input type="text" id="firstofficeid" name="firstofficeid"  value='<s:property value="firstofficeid"/>' class="form-control input-sm" placeHolder="Enter PNR First Owner Office ID">                                    
						    </div>
					     </div> 
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                
						    <div class="form-group">
							  <label>PNR Current Owner Office ID</label>           
							   <input type="text" id="currentofficeid" name="currentofficeid"  value='<s:property value="currentofficeid"/>' class="form-control input-sm" placeHolder="Enter PNR Current Owner Office ID">                                  
						    </div>
					     </div>
	        		</div> 
	        		<div class="row m-t-5">
	        		   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">                
						    <div class="form-group" align="right">
						        <button type="button" class="btn btn-default btnStyle" id="btnaddtour" onclick="funsave();" data-toggle="tooltip"  title="ADD"  data-placement="bottom"><i class="fa fa-plus" aria-hidden="true"></i></button>
						    </div>
					     </div>
	        		</div>
			</div>
	</div>
  </div>
 </div>	
 
 <div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div id="traveldiv"><jsp:include page="ticketGrid.jsp"></jsp:include></div>
					</div>	
	</div>
	
	</div>
</div>        
<input type="hidden" id="hidcpudoc" name="hidcpudoc" value='<s:property value="hidcpudoc"/>'/> 
<input type="hidden" id="hidinvtrno" name="hidinvtrno" value='<s:property value="hidinvtrno"/>'/>    
<input type="hidden" id="hidrowno" name="hidrowno" value='<s:property value="hidrowno"/>'/>   
<input type="hidden" id="masterdocno" name="masterdocno" value='<s:property value="masterdocno"/>'/>       
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>                 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
<div id="accountsearchwndow">    
   <div ></div>                              
</div> 
<div id="mainsearchwndow">    
   <div ></div>                              
</div> 
<div id="airlinesearchwndow">    
   <div ></div>                              
</div> 
</form>   
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){   
         document.getElementById("mode").value="VIEW";                                                                 
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
         $("#bookingdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
         $("#issuedate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
         $('#accountsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#accountsearchwndow').jqxWindow('close');
		 $('#airlinesearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Airline Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#airlinesearchwndow').jqxWindow('close');
		 $('#mainsearchwndow').jqxWindow({ width: '65%', height: '57%',  maxHeight: '60%' ,maxWidth: '70%' , title: 'Main Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#mainsearchwndow').jqxWindow('close');
		 $( "#payacno" ).dblclick(function() {   
			accounSearchContent('accounSearch.jsp');  
		 });
		 $( "#airline" ).dblclick(function() {   
			airlineSearchContent('airlineSearch.jsp');  
		 });
         var userid="<%= session.getAttribute("USERID").toString() %>";
         var username="<%= session.getAttribute("USERNAME").toString() %>";
         document.getElementById('bstaffid').value=userid;
         document.getElementById('bstaff').value=username;
         document.getElementById('tstaffid').value=userid;  
         document.getElementById('tstaff').value=username;   
         if($("#msg").val()=="Successfully Saved"){ 
	          Swal.fire({
				title: 'Success',
				text: ' '+$('#msg').val(),
				type: 'success',
				confirmButtonColor: '#3085d6',
				confirmButtonText: 'OK'
				}).then((result) => {
				if (result.value) {
				Swal.fire({
				title: 'Do you want to create new document?',  
				type: 'question',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'OK'
				}).then((result) => {
				if (result.value) {
				  funremovereadonly();     
				}
				})
				}
			  })
			document.getElementById("msg").value="";  
         }else if($("#msg").val()=="Not Saved"){           
		     swal({  
							type: 'error',  
							title: 'Error',  
							text: ' '+$('#msg').val()
						});    
			document.getElementById("msg").value="";	  		 
	     }else if($("#msg").val()=="Successfully Deleted"){                   
		     swal({  
							type: 'success',
							title: 'Success',  
							text: ' '+$('#msg').val()
						});    
			document.getElementById("msg").value="";
			funremovereadonly();	  		 
	     }else if($("#msg").val()=="Row Successfully Deleted"){                        
		     swal({  
							type: 'success',
							title: 'Success',  
							text: ' '+$('#msg').val()
						});    
			document.getElementById("msg").value="";
	     }else if($("#msg").val()=="Not Deleted"){               
		     swal({  
							type: 'error',
							title: 'Error',  
							text: ' '+$('#msg').val()
						});    
			document.getElementById("msg").value="";  	  		 
	     }else if($("#msg").val()=="Updated Successfully"){                   
		     swal({  
							type: 'success',
							title: 'Success',  
							text: ' '+$('#msg').val()
						});    
			document.getElementById("msg").value="";
	     }else if($("#msg").val()=="Not Updated"){                     
		     swal({  
							type: 'error',
							title: 'Error',  
							text: ' '+$('#msg').val()  
						});    
			document.getElementById("msg").value="";    	  		 
	     }else{}
	     if($("#masterdocno").val()==""){         
	        $("#txtrate").val('1'); 
	     }
	     funChkButtonchk();  
    });
    function airlineSearchContent(url) {  
	 $.get(url).done(function (data) {
	 $('#airlinesearchwndow').jqxWindow('open');  
	 $('#airlinesearchwndow').jqxWindow('setContent', data);      
	 }); 
	} 
    function accounSearchContent(url) {  
	 $.get(url).done(function (data) {
	 $('#accountsearchwndow').jqxWindow('open');  
	 $('#accountsearchwndow').jqxWindow('setContent', data);  
	 }); 
	}
	function SearchContent(url) {  
	 $.get(url).done(function (data) {
	 $('#mainsearchwndow').jqxWindow('open');  
	 $('#mainsearchwndow').jqxWindow('setContent', data);  
	 }); 
	}
	function getAccount(event){          
		var x= event.keyCode;
	    if(x==114){       
	    	accountsearchwndow('accounSearch.jsp');              
	      }
	}
	function getAirline(event){        
		var x= event.keyCode;
	    if(x==114){       
	    	airlinesearchwndow('airlineSearch.jsp');              
	      }
	}
    function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 46) || (charCode == 47) || (charCode > 57)))                
		        return false;
		    return true;
	}  
	function funRoundAmt(value,id){
		  var res=parseFloat(value).toFixed(window.parent.amtdec.value);  
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
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
			    if ($('#hidcmbbranch').val() != null && $('#hidcmbbranch').val() != "") {
					$('#cmbbranch').val($('#hidcmbbranch').val());   
				} 
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
	function getGDS(){     
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					brchIdItems = items[0].split(",");  
					brchItems = items[1].split(",");
					var optionsbrch = '<option value="">------Select------</option>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsbrch += '<option value="' + brchIdItems[i] + '">'
								+ brchItems[i] + '</option>';    
					}
					$("select#cmbgds").html(optionsbrch);
					if($('#hidgds').val()!=""){  
				     	document.getElementById("cmbgds").value=$('#hidgds').val();
				    }  
				} 
			else    
			{       
			}                
		}
		x.open("GET","getGDS.jsp",true);                     
		x.send();  
	 }
	 function getType(){     
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					brchIdItems = items[0].split(",");  
					brchItems = items[1].split(",");
					var optionsbrch = '<option value="">------Select------</option>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsbrch += '<option value="' + brchIdItems[i] + '">'
								+ brchItems[i] + '</option>';    
					}
					$("select#cmbtype").html(optionsbrch);
					if($('#hidtype').val()!=""){
			    	  document.getElementById("cmbtype").value=$('#hidtype').val();
			      }      
				} 
			else    
			{       
			}                
		}
		x.open("GET","getType.jsp",true);                     
		x.send();  
	 }
	 function getTicketType(){     
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					brchIdItems = items[0].split(",");  
					brchItems = items[1].split(",");
					var optionsbrch = '<option value="">------Select------</option>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsbrch += '<option value="' + brchIdItems[i] + '">'
								+ brchItems[i] + '</option>';    
					}
					$("select#cmbtickettype").html(optionsbrch); 
					if($('#hidtickettype').val()!=""){
	   		           document.getElementById("cmbtickettype").value=$('#hidtickettype').val(); 
	               }     
				} 
			else    
			{       
			}                
		}
		x.open("GET","getTicketType.jsp",true);                            
		x.send();  
	 }
	 function funremovereadonly(){
	         var branch=$('#cmbbranch').val();  
	         $('#frmticketvouchercreate input').val('');
			 $('#frmticketvouchercreate select').val('');
			 document.getElementById("docno").value="";
			 document.getElementById("masterdocno").value=""; 
			 $("#TravelGrid").jqxGrid('clear'); 
			 var userid="<%= session.getAttribute("USERID").toString() %>";
	         var username="<%= session.getAttribute("USERNAME").toString() %>";
	         document.getElementById('bstaffid').value=userid;
	         document.getElementById('bstaff').value=username;
	         document.getElementById('tstaffid').value=userid;  
	         document.getElementById('tstaff').value=username;   
	         $('#bookingdate').val(new Date());
	         $('#issuedate').val(new Date());      
	         $("#txtrate").val('1'); 
	         $('#hidcmbbranch').val(branch);
	         getBranch();         
	 }
	 function funsave(){  
	    var cldocno=$('#TravelGrid').jqxGrid('getcellvalue', 0, "cldocno"); 
		var vnddocno=$('#TravelGrid').jqxGrid('getcellvalue', 0, "vnddocno");
		var rows=$('#TravelGrid').jqxGrid('getrows');
	    if($('#mode').val()=="E"){
		    if($('#hidrowno').val()==""){      
		           swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please select a document '     
					});
					return false;       
		    } 
	    }else{
	        document.getElementById("mode").value="A";                     
	    }       
		var ticketno=document.getElementById("ticketno").value;  
		if(ticketno=="" || ticketno=="0"){    
			     swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please enter ticket number '
						});
						$('#mod1').addClass('active');
					    $('#mod3').removeClass('active'); 
					    $('#modalGeneral').addClass('in active');
					    $('#modalAddInfo').removeClass('in active');   
			            $('#ticketno').focus();      
						return false;      
		}
		var clid=document.getElementById("clid").value;  
		if(clid=="" || clid=="0"){    
			       swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please select a customer '
						});     
		            $('#mod1').addClass('active');
				    $('#mod3').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');
				    $('#modalAddInfo').removeClass('in active');   
		            $('#jqxclient').focus();    
					return false;
		} 
		var vndid=document.getElementById("vndid").value;  
		if(vndid=="" || vndid=="0"){    
			       swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please enter supplier '
						});
					$('#mod1').addClass('active');
				    $('#mod3').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');
				    $('#modalAddInfo').removeClass('in active');   
		            $('#jqxsupplier').focus();			     
					return false;
		} 
	/*   if(($('#mode').val()=="A") || ($('#mode').val()=="E" && rows.length>1)){
			if(typeof(cldocno) != "undefined" && typeof(cldocno) != "NaN" && cldocno != ""  && cldocno != "0"  && cldocno != null){
			 if(cldocno!=clid){
			      swal({
						 type: 'warning',
						 title: 'Warning',   
						 text: ' Customer cannot be changed!'  
					});
					$('#mod1').addClass('active');
				    $('#mod3').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');
				    $('#modalAddInfo').removeClass('in active'); 
				    $('#jqxclient').val('');
				    $('#clid').val('');  
		            $('#jqxclient').focus(); 
				    return false;
			 }
			}   
			if(typeof(vnddocno) != "undefined" && typeof(vnddocno) != "NaN" && vnddocno != ""  && vnddocno != "0"   && vnddocno != null){
			 if(vnddocno!=vndid){
			      swal({
						 type: 'warning',
						 title: 'Warning',   
						 text: ' Supplier cannot be changed!'    
					}); 
					$('#mod1').addClass('active');
				    $('#mod3').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');  
				    $('#modalAddInfo').removeClass('in active');   
				    $('#jqxsupplier').val('');
				    $('#vndid').val('');
		            $('#jqxsupplier').focus();
				    return false;
			 }
			}
		} */
		document.getElementById("frmticketvouchercreate").submit();            
	 }
	 function funload(){  
		 var docno=$('#masterdocno').val(); 
		 var branch=$('#cmbbranch').val();   
		 $('#traveldiv').load('ticketGrid.jsp?docno='+docno+'&branch='+branch);      
		 }
	 function funsearch(){
		  funremovereadonly();
	      SearchContent('mainSearch.jsp');           
	 }	 
	 function setvalues(){
	  document.getElementById("mode").value="VIEW"; 
	  var rowno=document.getElementById("hidrowno").value;     
	  if(parseInt(rowno)>0){  
	    if($('#hidissuetype').val()!=""){
	    	document.getElementById("cmbissuetype").value=$('#hidissuetype').val();
	    }
	    if($('#hidregioncode').val()!=""){
	    	document.getElementById("cmbregioncode").value=$('#hidregioncode').val();   
	    }
	  }
	 }
	 
	 function funtotal(){        
		 var supptot=$('#supptot').val();
		 var servfee=$('#servfee').val();
		 var payamt=$('#paybackamt').val(); 
		 if(supptot==""){
		 	supptot="0";
		 }
		 if(servfee==""){
		 	servfee="0";
		 }
		 if(payamt==""){
		 	payamt="0";  
		 }
		 var sprice=parseFloat(supptot)+parseFloat(servfee)+parseFloat(payamt);  
		 funRoundAmt(sprice,"sellingprice");
	 }
	 function funcalcsuptot(){  
		 var suppamt=$('#suppamt').val();
		 var taxamt=$('#taxamt').val();
		 var servfee=$('#servfee').val();
		 var payamt=$('#paybackamt').val(); 
		 if(suppamt==""){
		 	suppamt="0";
		 }
		 if(taxamt==""){
		 	taxamt="0";
		 }
		 if(servfee==""){
		 	servfee="0";
		 }
		 if(payamt==""){
		 	payamt="0";  
		 }
		 var supptot=parseFloat(suppamt)+parseFloat(taxamt);     
		 funRoundAmt(supptot,"supptot");
		 var sprice=parseFloat(supptot)+parseFloat(servfee)+parseFloat(payamt);  
		 funRoundAmt(sprice,"sellingprice");           
	 }
	 
	 function focustonexttab1(e){  
		 if(e.keyCode==9){
		    $('#mod2').addClass('active');
		    $('#mod1').removeClass('active'); 
		    $('#modalFare').addClass('in active');
		    $('#modalGeneral').removeClass('in active');
		   }
	 }
	 function focustonexttab2(e){  
		 if(e.keyCode==9){
		    $('#mod3').addClass('active');
		    $('#mod2').removeClass('active'); 
		    $('#modalAddInfo').addClass('in active'); 
		    $('#modalFare').removeClass('in active');
		   }
	 }
	 function fundelete(){
	 	var docno=document.getElementById("masterdocno").value;    
		if(docno=="" || docno=="0"){    
			     swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please select a document '  
						});
						return false;         
		}
		var rows=$('#TravelGrid').jqxGrid('getrows');
		var val=0;
		for(var i=0;i<rows.length;i++){
			        var cpudoc=$('#TravelGrid').jqxGrid('getcellvalue',i,'cpudoc');
			        var invtrno=$('#TravelGrid').jqxGrid('getcellvalue',i,'invtrno');
				    if(parseInt(cpudoc)>0 || parseInt(invtrno)>0){   
				    	val=1;
				    }   
               }
        if(val==1){                
			        swal({
							type: 'warning',
							title: 'Warning',  
							text: ' You cannot delete the document. Purchase or Travel Invoice already created for the document!!!'         
						});
						return false;           
		}
		document.getElementById("mode").value="D";             
		document.getElementById("frmticketvouchercreate").submit();   
	 }
	function funedit(){        
	    var docno=document.getElementById("masterdocno").value;   
	    var rowno=document.getElementById("hidrowno").value;        
		if(docno=="" || docno=="0"){    
			     swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please select a document '  
						});
						return false;         
		}
		if(rowno=="" || rowno=="0"){      
			     swal({
							type: 'warning',
							title: 'Warning',  
							text: ' There is no document selected for editing!!!'    
						});
						return false;           
		}
		var cpudoc=document.getElementById("hidcpudoc").value;                                 
        var invtrno=document.getElementById("hidinvtrno").value;   
        if(parseInt(cpudoc)>0 || parseInt(invtrno)>0){               
			        swal({
							type: 'warning',
							title: 'Warning',  
							text: ' You cannot edit the document. Purchase or Travel Invoice already created for the document!!!'         
						});
						return false;           
		}         
		document.getElementById("mode").value="E";                        
	 }
	 function fungriddelete(rowno){         
		if(parseInt(rowno)>0){   
		    document.getElementById("hidrowno").value=rowno;            
			document.getElementById("mode").value="GD";                  
			document.getElementById("frmticketvouchercreate").submit(); 
		}
	 }
    function funChkButtonchk(){
				var FormNamechk="Ticket Voucher Create";
				var dtype="TVC";  
				var doc_no=0;
				
				if(!(dtype=='FRO' || dtype=='LEC' || dtype=='OPN' || dtype=='FPP'|| dtype=='PREP'|| dtype=='BRCN'|| dtype=='MAPP'|| dtype=='UCPP' || dtype=='SAT'  || dtype=='CUR'  || dtype=='STE' )){  
					doc_no=document.getElementById('docno').value;       
			    }
			   
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						items = items.split('##');
						
				 			var add  = items[0].split(",");
							var edit = items[1].split(",");
							var del  = items[2].split(",");
							var print = items[3].split(",");
							var attach = items[4].split(",");
							var excel  = items[5].split(",");
							var email  = items[6].split(",");
							var costing = items[7].split(",");
                            var terms  = items[8].split(",");
                            var other  = items[9].split(",");
							
                            if(parseInt(other)==1) {                
           
								if(parseInt(add)==0) {		
									$("#btnCreate").attr('disabled', true );      
								}
								
								if(parseInt(edit)==0) {
									$("#btnEdit").attr('disabled', true );
								}
								
								if(parseInt(del)==0) {
									$("#btnDelete").attr('disabled', true );
								} 
                            }
						
					 }else {}
				}
				
				x.open("GET","chkmenubuttons.jsp?formdetail="+FormNamechk+"&docno="+doc_no,true);  
				x.send();
			
			}   
  </script>       
</body>
</html>