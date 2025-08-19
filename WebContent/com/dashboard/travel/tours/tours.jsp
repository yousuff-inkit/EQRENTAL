<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Underwriting</title>
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
		background-color:#E9E9E9;
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
  .buttonX {
   width: 40px;             
   height: 35px;           
   border: none;
   background-color:#9cf75c;  
   box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);  
   transition: all 0.3s ease 0s;
   cursor: pointer;
   outline: none;
  }

.buttonX:hover {
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  transform: translateY(-7px);
}
  
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
   
  .textclient{
   color:blue;
  } 
     .custompanel{ 
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;    
      border-radius: 8px;
    }
    .textpanel{
    	color: blue;   
  		overflow:auto;
  		width:500px;   
  		height:50px;
  		padding-top: 3px;
      	padding-bottom: 3px;
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
  </style>   
</head>       
<body onload="funToursLoad(1);">            
  <form autocomplete="off"> 
  <div class="container">
  <div class="row">
	  <div class="tourshead">  
		    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">    
		      <div class="form-group">
				<div style="font-size: 20px;" id="tourname"></div>  
			  </div>     
		    </div> 
	    </div>
  </div>      
	<div class="row">
	   <div class="col-md-6" id="imageset">
		  <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width:100%;height:400px">    
			  <ol class="carousel-indicators">
			    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			    <li data-target="#myCarousel" data-slide-to="1"></li>           
			  </ol>
			  
			  <div class="carousel-inner" style="width:100%;height:400px;">            
			    <div class="item active">  
			      <img  alt="tour"></img>
			    </div>
			    <div class="item" >
			      <img src="" alt="tours"></img>  
			    </div> 
			  </div>
			  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#myCarousel" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right"></span>
			    <span class="sr-only">Next</span>
			  </a>
		  </div> 
	</div>
	<div class="col-md-6">
	        <div class="row m-t-5">
		           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">     
				      <div class="form-group"> 
						<div id="tourtype"><jsp:include page="tourtype.jsp"></jsp:include></div>   
						<input type="hidden" name="ttypeid" id="ttypeid" >      
					  </div> 
				    </div>  
	         </div>
	      <div class="toursbody">         
	          <div class="row m-t-5">
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">       
	        				<div class="form-group">   
	        					<label for="desc" id="txtdesc"></label>          
	        				</div>    
	        		</div>
	         </div>
	         <div class="row m-t-5">  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
	        				<div class="form-group">     
	        					<label for="transport" id="txttransport"></label>                     
	        				</div>    
	        		</div>     
	         </div>
	         <div class="row m-t-5">  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">         
	        				<div class="form-group">   
	        					<label for="child">Child age</label>          
	        				</div>    
	        		</div>  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
	        				<div class="form-group">    
	        				<label for="child" id="childage"></label>       
	        				</div>    
	        		</div>    
	         </div>
	          <div class="row m-t-5">  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">         
	        				<div class="form-group">   
	        					<label for="height">Height</label>          
	        				</div>    
	        		</div>  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
	        				<div class="form-group">   
	        					<label for="height" id="txtheight"></label>                            
	        				</div>    
	        		</div>   
	         </div>
	         <div class="row m-t-5">  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">         
	        				<div class="form-group">   
	        					<label for="weight">Weight</label>          
	        				</div>    
	        		</div>  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
	        				<div class="form-group">   
	        				<label for="weight" id="txtweight"></label>                    
	        				</div>    
	        		</div>   
	         </div>
	         <div class="row m-t-5">  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">         
	        				<div class="form-group">   
	        					<label for="ageres">Age restriction</label>          
	        				</div>    
	        		</div>  
	        		<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">  
	        				<div class="form-group">   
	        					<label for="ageres" id="txtageres"></label>                            
	        				</div>    
	        		</div>   
	       </div>
	   </div>  
	</div>
 </div> 
 
 <div class="row">
     <div class="col-md-12" id="navdataset">   
	    <nav class="navbar navbar-default travel-navbar">
    		<div class="collapse navbar-collapse" id="myNavbar">     
      			<ul class="nav navbar-nav">
					<li ><a data-toggle="pill" href="#modalItinerary"></a></li>
					<li><a data-toggle="pill" href="#modalNotes"></a></li>
				    <li><a data-toggle="pill" href="#modalCancelNotes"></a></li>
				    <li><a data-toggle="pill" href="#modalTerms"></a></li>
				    <li><a data-toggle="pill" href="#modalRequest"></a></li>
				    <li><a data-toggle="pill" href="#modalTT"></a></li>      
     			</ul>
    		</div>  
	   </nav>
	</div>
 </div>
<div class="container-fluid m-t-60" id="modaldataset">   
  <div class="tab-content">
    <div id="modalItinerary" class="tab-pane fade in">   
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>  
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
	    <div id="modalNotes" class="tab-pane fade">    
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>   
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
	 <div id="modalCancelNotes" class="tab-pane fade">
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>   
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
	 <div id="modalTerms" class="tab-pane fade">
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>   
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
	 <div id="modalRequest" class="tab-pane fade">
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>   
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
	 <div id="modalTT" class="tab-pane fade">
			<div class="container">
	        		<div class="row m-t-5">
	        			<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
	        				<div class="form-group">
	        					<p></p>   
	        				</div>
	        			</div>
	        		</div>
			</div>
	</div>
  </div>
 </div>	
</div> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){       
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
        
    });
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
				/* if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} */
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
function funToursLoad(docno){ 
	  var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					var tourdata=x.responseText.trim().split("::")[0];
					var imgdata=x.responseText.trim().split("::")[1];
					var navdata=x.responseText.trim().split("::")[2];
					var modaldata=x.responseText.trim().split("::")[3];
	 			    tourdata=JSON.parse(tourdata);
	 			    imgdata=JSON.parse(imgdata);
	 			    navdata=JSON.parse(navdata);
	 			    modaldata=JSON.parse(modaldata);
	 				var panelhtml='';
	 				$.each( tourdata, function( key, value ) {           
					    panelhtml+='<div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">';  
					    panelhtml+='<div class="form-group">';  
					    panelhtml+='<div style="font-size: 20px;" id="tourname">'+tourdata[key].tourname+'</div>';       
						panelhtml+='</div>';   
						panelhtml+='</div>';            
						});
					$('.tourshead').html($.parseHTML(panelhtml));
					panelhtml='';  
					$.each( tourdata, function( key, value ) {           
					    panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="desc" id="txtdesc">'+tourdata[key].description+'</label>';                   
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
						panelhtml+='</div>';
						 
						panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="transport" id="txttransport">'+tourdata[key].transport+'</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
						panelhtml+='</div>'; 
						
						panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="child">Child age</label>';         
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="child" id="childage">'+tourdata[key].childage+'</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
						panelhtml+='</div>'; 
						
						panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="height">Height</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="height" id="txtheight">'+tourdata[key].height+'</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
						panelhtml+='</div>'; 
						
						panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="weight">Weight</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="weight" id="txtweight">'+tourdata[key].weight+'</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
						panelhtml+='</div>';   
						
						panelhtml+='<div class="row m-t-5">'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="ageres">Age restriction</label>';       
						panelhtml+='</div>';              
						panelhtml+='</div>'; 
					    panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">'; 
					    panelhtml+='<div class="form-group">';     
					    panelhtml+='<label for="ageres" id="txtageres">'+tourdata[key].ageres+'</label>';       
						panelhtml+='</div>';                
						panelhtml+='</div>'; 
						panelhtml+='</div>';
						});	
					$('.toursbody').html($.parseHTML(panelhtml));
					   panelhtml='';
					   var val1=0;
					   $.each( imgdata, function( key, value ) {
						   val1=imgdata[key].val;  
					   });
					   if(val1>0){
						   panelhtml+='<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width:100%;height:400px">'; 
		                   panelhtml+='<ol class="carousel-indicators">'; 
					           $.each( imgdata, function( key, value ) {
						 					if(imgdata[key].srno=="0"){
						 						panelhtml+='<li data-target="#myCarousel" data-slide-to="'+imgdata[key].srno+'" class="active"></li>';
						 					}else{
						 						panelhtml+='<li data-target="#myCarousel" data-slide-to="'+imgdata[key].srno+'"></li>';
						 					}       
											});
							   panelhtml+='</ol>';	
							   panelhtml+='<div class="carousel-inner" style="width:100%;height:400px;">'; 
					           $.each( imgdata, function( key, value ) {
						 					var url= imgdata[key].path; 
						 					url=url.replace( /;/g, "/");  
											var host = window.location.origin;
											var splt = url.split("webapps/");
					                        //var splt = url.split("WebContent/");      
					                        //url=host+"/CarRental/"+splt[1];
					                        url=host+"/"+splt[1];  
					                       if(imgdata[key].srno=="0"){   
					                        	panelhtml+='<div class="item active">';  
					    					    panelhtml+=' <img src="'+url+'" alt="tour"></img>';                                   
					    						panelhtml+='</div>';   
					                        }else{  
					                        	panelhtml+='<div class="item">';  
					    					    panelhtml+=' <img src="'+url+'" alt="tours"></img>';                      
					    						panelhtml+='</div>';
					                        }
											});
								 panelhtml+='</div>';
								 panelhtml+='<a class="left carousel-control" href="#myCarousel" data-slide="prev">'; 				
								 panelhtml+='<span class="glyphicon glyphicon-chevron-left"></span>'; 
								 panelhtml+='<span class="sr-only">Previous</span>'; 
								 panelhtml+='</a>';
								 panelhtml+='<a class="right carousel-control" href="#myCarousel" data-slide="next">';
								 panelhtml+='<span class="glyphicon glyphicon-chevron-right"></span>';
								 panelhtml+='<span class="sr-only">Next</span>';
								 panelhtml+='</a>';
								 panelhtml+='</div>';  
					   }
					$('#imageset').html($.parseHTML(panelhtml));        
					 
						 panelhtml='';   
						 var val2=0;
						   $.each( navdata, function( key, value ) {   
							   val2=navdata[key].val;  
						   });
						   if(val2>0){  
							 panelhtml+='<nav class="navbar navbar-default travel-navbar">';
							 panelhtml+='<div class="collapse navbar-collapse" id="myNavbar">'; 				
							 panelhtml+='<ul class="nav navbar-nav">';
							 $.each( navdata, function( key, value ) {
				 					if(navdata[key].terms=="ITENARY"){
				 						panelhtml+='<li ><a data-toggle="pill" href="#modalItinerary">Itinerary</a></li>';
				 					}else if(navdata[key].terms=="NOTES"){
				 						panelhtml+='<li><a data-toggle="pill" href="#modalNotes">Notes</a></li>';
				 					}else if(navdata[key].terms=="CANCELLATION TERMS"){
				 						panelhtml+='<li><a data-toggle="pill" href="#modalCancelNotes">Cancellation terms</a></li>';
				 					}else if(navdata[key].terms=="TERMS AND CONDITIONS"){
				 						panelhtml+='<li><a data-toggle="pill" href="#modalTerms">Terms & Conditions</a></li>';
				 					}else if(navdata[key].terms=="REQUEST"){
				 						panelhtml+='<li><a data-toggle="pill" href="#modalRequest">Request</a></li>';
				 					}else if(navdata[key].terms=="TT"){
				 						panelhtml+='<li><a data-toggle="pill" href="#modalTT">TT</a></li>';
				 					}
									});   
							 panelhtml+='</ul>';
							 panelhtml+='</nav>';
						   }
					       $('#navdataset').html($.parseHTML(panelhtml));  	 
						       
					     panelhtml=''; 
					     var val3=0;
						   $.each( modaldata, function( key, value ) {   
							   val3=modaldata[key].val;  
						   });
						 if(val3>0){        
							 panelhtml+='<div class="tab-content">';
							 panelhtml+='<div id="modalItinerary" class="tab-pane fade in">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {
				 					if(modaldata[key].terms=="ITENARY"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';                
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 
							 panelhtml+='<div id="modalNotes" class="tab-pane fade">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {
				 					if(modaldata[key].terms=="NOTES"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';              
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 
							 panelhtml+='<div id="modalCancelNotes" class="tab-pane fade">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {
				 					if(modaldata[key].terms=="CANCELLATION TERMS"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';              
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 
							 panelhtml+='<div id="modalTerms" class="tab-pane fade">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {
				 					if(modaldata[key].terms=="TERMS AND CONDITIONS"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';              
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 
							 panelhtml+='<div id="modalRequest" class="tab-pane fade">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {
				 					if(modaldata[key].terms=="REQUEST"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';              
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 
							 panelhtml+='<div id="modalTT" class="tab-pane fade">';
							 panelhtml+='<div class="container">';
							 panelhtml+='<div class="row m-t-5">';
							 panelhtml+='<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">';
							 panelhtml+='<div class="form-group">';
							 $.each( modaldata, function( key, value ) {  
				 					if(modaldata[key].terms=="TT"){            
				 						panelhtml+='<p>* '+modaldata[key].conditions+'</p>';              
				 					}
									});
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>';
							 panelhtml+='</div>'; 
						}
						$('#modaldataset').html($.parseHTML(panelhtml));	              
				}          
			else            
			{       
			}                   
		}
		x.open("GET","getToursData.jsp?rdocno="+docno,true);                                             
		x.send(); 
}
  </script>       
</form>
</body>
</html>
