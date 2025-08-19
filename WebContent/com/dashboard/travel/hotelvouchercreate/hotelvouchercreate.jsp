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
<body onload="funload();setvalues();getBranch();">                             
  <form autocomplete="off" id="frmhotelvouchercreate" action="savehotelvouchercreate" method="post">       
  <div class="container-fluid " style="margin:auto;">      
  <div class="borderStyle">
  <div class="row " >
     <div class="col-md-12" id="navdataset">   
	    <nav class="navbar navbar-default travel-navbar">
    		<div class="collapse navbar-collapse" id="myNavbar">     
      			<ul class="nav navbar-nav">  
					<li class="active" id="mod1"><a data-toggle="pill" href="#modalGeneral" >General</a></li>  
					<li id="mod2"><a data-toggle="pill" href="#modalFare">Fare</a></li>
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
							        							<label>Supplier Conformation No</label>  
							        							<input type="text" id="suppconfno" name="suppconfno"  value='<s:property value="suppconfno"/>' class="form-control input-sm" placeHolder="Supplier Conformation No">        
							        						</div>
							        			</div>
							        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
									        		<div class="form-group">  
									        			<label>Voucher Type</label>       
									        			<select id="cmbvtype" name="cmbvtype"  value='<s:property value="cmbvtype"/>'  class="form-control input-sm" style="height:25px;width:150px">
								        					<option value="H">Hotel</option>
								        					<option value="V">Visa</option>  
								        					<option value="O">Others</option></select>                   
								        					<input type="hidden" id="hidcmbvtype" name="hidcmbvtype" value='<s:property value="hidcmbvtype"/>'/>   
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
							        							<label>Issue Date</label>     
							        						     <div  id="issuedate"  name="issuedate"  value='<s:property value="issuedate"/>' class="m-l-10">           
							        						</div>
							        		            </div>
							                    </div>
							        </div>            
							     <div class="row m-t-10"> 
							         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
							        		<div class="form-group">
							        			<label>Country</label>      
							        				<div id="country" onkeydown="return (event.keyCode!=13);"><jsp:include page="countrySearch.jsp"></jsp:include></div>
						        					<input type="hidden" name="countryid" id="countryid"  value='<s:property value="countryid"/>'>                    
							        		</div>
							        	</div>  
							        	 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">     
							        		<div class="form-group">
							        			<label>City</label>     
							        				<div id="city" onkeydown="return (event.keyCode!=13);"><jsp:include page="citySearch.jsp"></jsp:include></div>
						        					<input type="hidden" name="cityid" id="cityid"  value='<s:property value="cityid"/>'>                            
							        		</div>
							        	</div>
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">     
							        		<div class="form-group">
							        			<label>Hotel</label>       
							        				<div id="txthotel" onkeydown="return (event.keyCode!=13);"><jsp:include page="hotelSearch.jsp"></jsp:include></div>
	        					                    <input type="hidden" name="hotelid" id="hotelid" value='<s:property value="hotelid"/>'>                      
							        		</div>
							        	</div> 	
							        	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">            
							        		<div class="form-group">
							        			<label>Room Type</label>     
							        				<div id="txtrtype" onkeydown="return (event.keyCode!=13);"><jsp:include page="roomTypeSearch.jsp"></jsp:include></div>                         
	        				                       <input type="hidden" name="roomtypeid" id="roomtypeid" value='<s:property value="roomtypeid"/>'>                    
							        		</div>
							        	</div> 	
							        
	                              </div>
	                             <div class="row m-t-10"> 
	                                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">              
							        		<div class="form-group">  
							        			<label>Meal Plan</label>       
							        			<select id="cmbmealplan" name="cmbmealplan"  value='<s:property value="cmbmealplan"/>' class="form-control input-sm" style="height:25px;width:100px">
						        					<option value="">--Select--</option>    
						        					<option value="BB">BB</option>
						        					<option value="HB">HB</option>  
						        					<option value="FB">FB</option>
						        					<option value="INC">INC</option></select>              
						        					<input type="hidden" id="hidcmbmealplan" name="hidcmbmealplan" value='<s:property value="hidcmbmealplan"/>'/>   
							        		</div>  
							        	</div>   
	                                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
							        		<div class="form-group">
							        			<label>Guest</label>      
							        				<input type="text" id="guestname" name="guestname"  value='<s:property value="guestname"/>' class="form-control input-sm" placeHolder="Enter Guest Name">              
							        		</div>
							        </div>
							         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">              
									        	<div class="form-group">
									        			<label>Issuing Staff</label>       
									        				<input type="text" id="isstaff" name="isstaff"  onkeydown="focustonexttab1(event);"  value='<s:property value="isstaff"/>' class="form-control input-sm" placeHolder="Enter Issuing Staff" readonly> 
									        				<input type="hidden" name="isstaffid" id="isstaffid"  value='<s:property value="isstaffid"/>'>                     
									        	</div>
							        </div> 
	                             </div>
	        </div>
	    <div id="modalFare" class="tab-pane fade">      
			<div class="">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Rate</label>       
							        <input type="text" id="txtrate"  name="txtrate"  value='<s:property value="txtrate"/>' class="form-control input-sm" placeHolder="Enter Rate" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">          
							    <div class="form-group">
							        <label>Supplier Total</label>       
							        <input type="text" id="supptot" name="supptot" onchange="funtotal();funvatclac();" value='<s:property value="supptot"/>' class="form-control input-sm" placeHolder="Enter Supplier Total" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Non Vatable Amount</label>                  
							        <input type="text" id="nonvatamt" name="nonvatamt" onchange="funvatclac();funtotal();"  value='<s:property value="nonvatamt"/>' class="form-control input-sm" placeHolder="Enter Non Vatable Amount" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">              
							    <div class="form-group">
							        <label>VAT 5%</label>       
							        <input type="text" id="taxamt" name="taxamt"  value='<s:property value="taxamt"/>' readonly class="form-control input-sm" placeHolder="Vat 5%" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
							   </div>
						</div> 
						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">        
							    <div class="form-group">
							        <label>Vatable Amount</label>              
							        <input type="text" id="vatamt" name="vatamt"  value='<s:property value="vatamt"/>' readonly class="form-control input-sm" placeHolder="Vatable Amount" onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
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
							  <label >Inclusive</label>         
							   <input type="checkbox" id="inclusiveval" name="inclusiveval" readonly value='<s:property value="inclusiveval"/>' style="width: 20px;"  class="form-control input-sm" onclick="$(this).attr('value', this.checked ? 1 : 0);"  onchange="inclusiveChange();">                                    
						       <input type="hidden" id="hidchkval" name="hidchkval" readonly value='<s:property value="hidchkval"/>' class="form-control input-sm">
						 </div>  
					</div>
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                                
						<div class="form-group">    
							   <label>Vat Amount</label>            
							   <input type="text" id="clvatamt" name="clvatamt" readonly value='<s:property value="clvatamt"/>' class="form-control input-sm" placeHolder="Vat Amount" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                    
						 </div>  
					</div>
			</div>
			<div class="row m-t-5">		
					 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
						<div class="form-group">  
							  <label>Selling Price</label>                
							   <input type="text" id="sellingprice" name="sellingprice" readonly value='<s:property value="sellingprice"/>' class="form-control input-sm" placeHolder="Selling Price" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);" style="text-align:right">      
							   <input type="hidden" id="sellingpricetot" name="sellingpricetot" readonly value='<s:property value="sellingpricetot"/>' class="form-control input-sm" placeHolder="Selling Price" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);" style="text-align:right">                                  
						 </div>  
					</div>
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
					         <div style="padding-top:15px;">                
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
						<div id="hoteldiv"><jsp:include page="hotelGrid.jsp"></jsp:include></div>  
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
         $("#issuedate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
         $('#accountsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#accountsearchwndow').jqxWindow('close');
		 $('#mainsearchwndow').jqxWindow({ width: '65%', height: '57%',  maxHeight: '60%' ,maxWidth: '70%' , title: 'Main Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
		 $('#mainsearchwndow').jqxWindow('close');
		 $( "#payacno" ).dblclick(function() {   
			accounSearchContent('accounSearch.jsp');  
		 });
         var userid="<%= session.getAttribute("USERID").toString() %>";
         var username="<%= session.getAttribute("USERNAME").toString() %>";
         document.getElementById('isstaffid').value=userid;
         document.getElementById('isstaff').value=username;
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
	      if($('#countryid').val()==""){ 
	          $('#country').load('countrySearch.jsp'); 
	        }
	        if($('#cityid').val()==""){     
              var docno=document.getElementById("countryid").value; 
		      $('#city').load('citySearch.jsp?docno='+docno);
		    } 
	      if($('#masterdocno').val()==""){     
		         $('#nonvatamt').val(0);
		         $("#txtrate").val(1);    
		         $('#hidchkval').val(0);  
	        } 
	        funChkButtonchk();    
    });
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
	 function funremovereadonly(){
	        var branch=$('#cmbbranch').val();
	       if($('#countryid').val()==""){ 
	          $('#country').load('countrySearch.jsp'); 
	        }
	        if($('#cityid').val()==""){     
              var docno=document.getElementById("countryid").value; 
		      $('#city').load('citySearch.jsp?docno='+docno);
		    } 
	         $('#frmhotelvouchercreate input').val('');   
			 $('#frmhotelvouchercreate select').val('');
			 $("#TravelGrid").jqxGrid('clear'); 
			 var userid="<%= session.getAttribute("USERID").toString() %>";
	         var username="<%= session.getAttribute("USERNAME").toString() %>";
	         document.getElementById('isstaffid').value=userid;
	         document.getElementById('isstaff').value=username;
	         $('#issuedate').val(new Date()); 
	         $('#nonvatamt').val(0);  
	          $("#txtrate").val('1'); 
	         $('#hidcmbbranch').val(branch);
	         $('#cmbvtype').val('H');  
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
	    var clid=document.getElementById("clid").value;  
		if(clid=="" || clid=="0"){    
			       swal({
							type: 'warning',
							title: 'Warning',  
							text: ' Please select a customer '
						});     
            $('#mod1').addClass('active');
		    $('#mod2').removeClass('active'); 
		    $('#modalGeneral').addClass('in active');
		    $('#modalFare').removeClass('in active');   
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
		    $('#mod2').removeClass('active'); 
		    $('#modalGeneral').addClass('in active');
		    $('#modalFare').removeClass('in active');   
            $('#jqxsupplier').focus();			     
			return false;
		} 
	   if(($('#mode').val()=="A") || ($('#mode').val()=="E" && rows.length>1)){
			if(typeof(cldocno) != "undefined" && typeof(cldocno) != "NaN" && cldocno != ""  && cldocno != "0" && cldocno!=null ){
			 if(cldocno!=clid){
			      swal({
						 type: 'warning',
						 title: 'Warning',   
						 text: ' Customer cannot be changed!'  
					});
					$('#mod1').addClass('active');
				    $('#mod2').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');
				    $('#modalFare').removeClass('in active'); 
				    $('#jqxclient').val('');
				    $('#clid').val('');  
		            $('#jqxclient').focus(); 
				    return false;
			 } 
			}   
			if(typeof(vnddocno) != "undefined" && typeof(vnddocno) != "NaN" && vnddocno != ""  && vnddocno != "0"  && vnddocno!=null ){    
			 if(vnddocno!=vndid){
			      swal({
						 type: 'warning',
						 title: 'Warning',   
						 text: ' Supplier cannot be changed!'    
					}); 
					$('#mod1').addClass('active');
				    $('#mod2').removeClass('active'); 
				    $('#modalGeneral').addClass('in active');  
				    $('#modalFare').removeClass('in active');  
				    $('#jqxsupplier').val('');
				    $('#vndid').val('');
		            $('#jqxsupplier').focus();
				    return false;
			 }
			}
		}  
		document.getElementById("frmhotelvouchercreate").submit();              
	 }
	 function funload(){  
		 var docno=$('#masterdocno').val(); 
		 var branch=$('#cmbbranch').val(); 
		 $('#hoteldiv').load('hotelGrid.jsp?docno='+docno+'&branch='+branch);       
		 }
	 function funsearch(){
	      funremovereadonly();
	      SearchContent('mainSearch.jsp');           
	 }	 
	 function setvalues(){
	  var rowno=document.getElementById("hidrowno").value;     
	  if(parseInt(rowno)>0){  
	    if($('#hidcmbmealplan').val()!=""){
	    	document.getElementById("cmbmealplan").value=$('#hidcmbmealplan').val();   
	    }
	    if($('#hidcmbvtype').val()!=""){   
	    	document.getElementById("cmbvtype").value=$('#hidcmbvtype').val();        
	    }
		 if($('#hidchkval').val()>0){  
			document.getElementById("inclusiveval").checked=true;    
		}else{
		   document.getElementById("inclusiveval").checked=false;
		}
	  }
	 }
	 function funtotal(){  
	     var nonvatamt=$('#nonvatamt').val();
		 var supptot=$('#supptot').val();
		 var servfee=$('#servfee').val();
		 var payamt=$('#paybackamt').val(); 
		 var clvatamt=0.0,sellingpricetot=0.0;  
		 if(supptot==""){  
		 	supptot="0";
		 }
		 if(servfee==""){
		 	servfee="0";
		 }
		 if(payamt==""){
		 	payamt="0";  
		 }
		 if(nonvatamt==""){   
		 	nonvatamt="0";  
		 }
		 var sprice=parseFloat(supptot)+parseFloat(servfee)+parseFloat(payamt);  
		 funRoundAmt(sprice,"sellingpricetot");  
		 if(document.getElementById("inclusiveval").checked){       
			  clvatamt=(sprice-parseFloat(nonvatamt))-(((sprice-parseFloat(nonvatamt))/105)*100);    
			  funRoundAmt(clvatamt,"clvatamt");  
              funRoundAmt(sprice,"sellingprice");
		 }
		 else{
			clvatamt=(sprice*5)/100;
			sellingpricetot=clvatamt+(sprice-parseFloat(nonvatamt));         
			funRoundAmt(clvatamt,"clvatamt");  
            funRoundAmt(sellingpricetot,"sellingprice");         
		 }
	 }
	 
	 function funvatclac(){  
		 var nonvatamt=$('#nonvatamt').val();        
		 var supptot=$('#supptot').val();
		 if(supptot==""){
		 	supptot="0";
		 }
		 var vatamt=(parseFloat(supptot)-parseFloat(nonvatamt))-(((parseFloat(supptot)-parseFloat(nonvatamt))/105)*100);   
		 funRoundAmt(vatamt,"taxamt");
		 var total=parseFloat(supptot)-parseFloat(nonvatamt)-parseFloat(vatamt);   
		 funRoundAmt(total,"vatamt");        
	 }
	 
	 function focustonexttab1(e){  
		 if(e.keyCode==9){
		    $('#mod2').addClass('active');
		    $('#mod1').removeClass('active'); 
		    $('#modalFare').addClass('in active');
		    $('#modalGeneral').removeClass('in active');
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
			    if ($('#hidcmbbranch').val() != null  && $('#hidcmbbranch').val() != "") {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} 
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);  
		x.send();
	}
	function inclusiveChange(){
		 if(document.getElementById("inclusiveval").checked){       
			 document.getElementById("hidchkval").value = 1; 
		 }
		 else{
			 document.getElementById("hidchkval").value = 0;
		 }
		 funtotal();
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
		document.getElementById("frmhotelvouchercreate").submit();   
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
			document.getElementById("frmhotelvouchercreate").submit();   
		}
	 }
    function funChkButtonchk(){
				var FormNamechk="Voucher Creation";        
				var dtype="HVC";  
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