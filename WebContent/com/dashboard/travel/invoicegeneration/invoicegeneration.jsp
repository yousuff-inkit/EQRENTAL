<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Tour Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>        
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">  
  .modal-md{
     width:700px;  
  }
  .hidden-scrollbar {
    overflow: auto; 
    height: 600px;
   }  
  .modal-header {     
           background-color:#589EFD;   
           box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);
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
  		padding-top: 10px;
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
     .datepanel{
      /* border:1px solid #ccc; */
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    /*   border-radius: 8px; */
    }
    .padding0
    {
    padding:0 !important;
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
  .rowgap{
    	margin-bottom:6px;
    }
    label{
    font-weight:400;
    }
    /* #invmod{
       background-color: #b3ffff ; 
    }
    #purmod{
       background-color: #f3fab9;   
    } */         
  </style>   
</head>       
<body onload="getBranch();">           
  <form autocomplete="off">  
  <div class="container-fluid">  
    <div class="row">   
	      <div class="col-md-9 padding0" style=" border: 1px solid #ccc; margin: 5px; border-radius: 10px; ">  
	        <div class="datepanel">
				 <div class="col-md-3 padding0">  
						<label for="cmbtype" class="col-md-3">Type</label>      
						<div class="col-md-9">
							<select id="cmbtype" name="cmbtype"  value='<s:property value="cmbtype"/>' onchange="fungirdshow();" class="form-control input-sm">  
							<option value="T">TICKET</option><option value="H">VOUCHER</option></select>
							<input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>  
						</div>      
				  </div>
				   <div class="col-md-4 padding0">  
						<label for="cmbtype" class="col-md-3">Branch</label>    
						<div class="col-md-9">
							<select id="cmbbranch" name="cmbbranch"  value='<s:property value="cmbbranch"/>'  class="form-control input-sm" style=" width: 100%;"></select>    
							<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>        
						</div>      
				  </div>
				  <div class="col-md-5 padding0">  
						<label for="tourtype" class="col-md-3 padding0">Customer</label>      
						<div class="col-md-9 padding0">   
							<div id="tourtype"><jsp:include page="clientSearch.jsp"></jsp:include></div>        
							<input type="hidden" name="clid" id="clid">  	    
				       </div>
				  </div>
			   
			</div>   
		 </div>
         <div class="col-md-2  padding0">    
             <div class="primarypanel custompanel">                     
	  			&nbsp;<button type="button" class="btn btn-default  btnStyle" id="btnsubmit" data-tooltip="tooltip"  title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>       
	          	<button type="button" class="btn btn-default  btnStyle" id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	            <button type="button" class="btn btn-default  btnStyle" id="btninoice"  data-tooltip="tooltip" title="Travel Invoice Create" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
	            <button type="button" class="btn btn-default  btnStyle" id="btnpurchase"  data-tooltip="tooltip" title="Purchase Create" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
            </div>        
          </div>
    </div> 
    <div class="row">        
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  padding0">                                                                
        <div id="ticketdiv"><jsp:include page="ticketGrid.jsp"></jsp:include></div>  
        <div id="hoteldiv"><jsp:include page="hotelGrid.jsp"></jsp:include></div>
      </div>
    </div>    
   <input type="hidden" name="hidrowno" id="hidrowno">
</div> 
   <!-- Modal Purchase -->             
    <div id="modalpurchase" class="modal fade" role="dialog">              
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>       
            <h4 class="modal-title" style="text-align:center">Purchase Create</h4>                       
             <p id="clientref1" style="text-align:center"></p>       
          </div>                             
          <div class="modal-body" id="purmod">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">  
                 <div class="row rowgap">
                   <div class="col-md-4"> 
							  <div class="form-group">
							        <label  for="invno">Inv No</label>  
							        <input type="text" id="invno" class="form-control input-sm" style="width:130px">        
							   </div>
					</div> 
					<div class="col-md-4"> 
							  <div class="form-group">
							        <label  for="invdate">Inv Date</label>  
							        <div id="invdate" class="form-control input-sm"></div>          
							   </div>
					</div> 
					<div class="col-md-4"> 
							  <div class="form-group">
							        <label  for="postdate2">Post Date</label>  
							        <div id="postdate2" class="form-control input-sm"></div>        
							   </div>
					</div>                    
            	</div> 
            	 <div class="row rowgap">    
                   <div class="col-md-3"> 
							  <div class="form-group">
							        <label  for="invno">Non vatable Amount</label>    
							        <input type="text" id="nonvatamt" class="form-control input-sm" style="width:130px;text-align: right;"  onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);">        
							   </div>
					</div> 
					<div class="col-md-3">   
							  <div class="form-group">
							        <label  for="postdate2">VAT 5%</label>           
							        <input type="text" id="taxamt" class="form-control input-sm" style="width:130px;text-align: right;"  onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);">       
							   </div>
					</div>
					<div class="col-md-3"> 
							  <div class="form-group">
							        <label  for="invdate">Vatable Amount</label>            
							        <input type="text" id="vatamt" class="form-control input-sm" style="width:130px;text-align: right;"  onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);">          
							   </div>
					</div> 
					<div class="col-md-3">   
							  <div class="form-group">
							        <label  for="postdate2">Supplier Amount</label>         
							        <input type="text" id="suppamt" readonly class="form-control input-sm" style="width:130px;text-align: right;"  onkeypress="return isNumberKey(event)"  onblur="funRoundAmt(this.value,this.id);">       
							   </div>
					</div>                     
            	</div>
            	<div class="row rowgap">  
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">      
						<button type="button" class="btn btn-default btnStyle" id="btnupdate"  data-toggle="tooltip" title="Create" data-placement="bottom" onclick="funCreateNiPurchase();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>
				</div>                   
            	</div>   
            </div>  
           <!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
          </div>  
        </div>  
   </div>                  
   <!-- Modal Invoice -->          
    <div id="modalinvoice" class="modal fade" role="dialog">              
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Travel Invoice Create</h4>                            
              <p id="clientref2"  style="text-align:center"></p>   
          </div>                             
          <div class="modal-body" id="invmod">
            <p><!-- Some text in the modal. --></p>    
            <div class="container-fluid">  
                <div class="col-md-offset-4 col-md-4 col-md-offset-4">   
							  <div class="form-group">
							        <label  for="postdate1">Post Date</label>     
							        <div id="postdate1" class="form-control input-sm"></div>        
							   </div>
					</div>                                                                   
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">     
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" data-toggle="tooltip" title="Create" data-placement="bottom" onclick="funinvoice();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>            
					</div>          
				</div>                       
            	</div>        
            </div>  
           <!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
          </div>  
        </div>  
      </div>   
       <input type="hidden" id="hidticketrowno" class="form-control input-sm" style="width:130px">       
       <input type="hidden" id="hidhotelrowno" class="form-control input-sm" style="width:130px">
</form>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){         
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
		 $("#postdate1").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"}); 
		 $("#postdate2").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#invdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#ticketdiv').show(); 
		 $('#hoteldiv').hide();   
         $('#btnpurchase').hide();
	    	$('[data-toggle="tooltip"]').tooltip(); 
	        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();
	        
	        function SearchContent(url,id) 
	        {
			    
			    $.get(url).done(function (data) {
			  	$('#'+id).jqxWindow('setContent', data);
				}); 
			}
	        $('#btnsubmit').click(function(){    
	             $('#invdate').val(new Date()); 
			     $('#postdate2').val(new Date());    
			     $('#postdate1').val(new Date());    
			     $('#invno').val('');
			     $('#clientref1').text('');  
			     $('#clientref2').text('');    
			     funload();
	        }); 
	        $('#btninoice').click(function(){     
	              if($('#cmbtype').val()=="H"){     
				        funinvoicehotelcount();    
		             }else{
		                funinvoiceTicketCount();     
		             }              
	        }); 
	        $('#btnpurchase').click(function(){ 
	           if($('#cmbtype').val()=="H"){   
				   funpurchasehotelcount();       
	             }else{}                            
	        });  
	        $('#btnexcel').click(function(){  
	          if($('#cmbtype').val()=="H"){              
	             JSONToCSVCon(hdataexcel, 'VOUCHER- Invoice Generation', true);     
	           }else{
	             JSONToCSVCon(tdataexcel, 'TICKET- Invoice Generation', true);   
	           }         
	        });
	         $('.warningpanel div button').click(function(){
	        	$(this).toggleClass('active');
	        	if($(this).hasClass('active')){
	        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
	        	}
	        	else{   
	        		$('#jqxHotelGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
	        		$('#jqxTicketGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
	        	}
	        });  
    });
    function fungirdshow(){
        if($('#cmbtype').val()=="H"){ 
             $('#btnpurchase').show();         
             $('#ticketdiv').hide(); 
		     $('#hoteldiv').show(); 
        }else{  
             $('#btnpurchase').hide();  
	         $('#ticketdiv').show(); 
			 $('#hoteldiv').hide();   
        }
        $('#clientref1').text('');  
	    $('#clientref2').text('');  
    }  
    function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

        var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
        
       // alert("arrData");
        var CSV = '';    
        //Set Report title in first row or line
        
        CSV += ReportTitle + '\r\n\n';

        //This condition will generate the Label/Header
        if (ShowLabel) {
            var row = "";
            
            //This loop will extract the label from 1st index of on array
            for (var index in arrData[0]) {
                
                //Now convert each value to string and comma-seprated
                row += index + ',';
            }

            row = row.slice(0, -1);
            
            //append Label row with line break
            CSV += row + '\r\n';
        }
        
        //1st loop is to extract each row
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            
            //2nd loop will extract each column and convert it in string comma-seprated
            for (var index in arrData[i]) {
                row += '"' + arrData[i][index] + '",';
            }

            row.slice(0, row.length - 1);
            
            //add a line break after each row
            CSV += row + '\r\n';
        }

        if (CSV == '') {        
            alert("Invalid data");
            return;
        }   
        
        //Generate a file name
        var fileName = "";
        //this will remove the blank-spaces from the title and replace it with an underscore
        fileName += ReportTitle.replace(/ /g,"_");   
        
        //Initialize file format you want csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
        
        // Now the little tricky part.
        // you can use either>> window.open(uri);
        // but this will not work in some browsers
        // or you will not get the correct file extension    
        
        //this trick will generate a temp <a /> tag
        var link = document.createElement("a");    
        link.href = uri;
        
        //set the visibility hidden so it will not effect on your web-layout
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        
        //this part will append the anchor tag and remove it after automatic click
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
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
    	$("#jqxHotelGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.        
    	$("#jqxHotelGrid").jqxGrid('applyfilters');
    	
    	$("#jqxTicketGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.        
    	$("#jqxTicketGrid").jqxGrid('applyfilters');
 	}
   
function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var perm = items[2];
				var optionsbranch;
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
			} else {
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
	
	 function funload(){     
		 $("#overlay, #PleaseWait").show(); 
		 var cldocno=$('#clid').val();
		 var brhid=$('#cmbbranch').val();        
		 if($('#cmbtype').val()=="H"){     
				$('#hoteldiv').load('hotelGrid.jsp?id=1'+'&brhid='+brhid+'&cldocno='+cldocno);		 
		 }else{
		        $('#ticketdiv').load('ticketGrid.jsp?id=1'+'&brhid='+brhid+'&cldocno='+cldocno);	
		 } 
	  }
	 
	 function funCreateNiPurchase(){     
	   if($('#cmbtype').val()=="T"){
	      funCreateNiPurchaseTicket();  
	   }else{
	      funCreateNiPurchaseHotel();     
	   }
	 }
	 function funCreateNiPurchaseHotel(){                          
	        var tot=0.0,taxamt=0.0,supamt=0.0;          
	        var suptot=$('#suppamt').val();             
			var	nonvatamt=$('#nonvatamt').val();         
			var vatamt=$('#vatamt').val();  
			var taxamt=$('#taxamt').val();       
			//taxamt=(parseFloat(suptot)-parseFloat(nonvatamt))-(((parseFloat(suptot)-parseFloat(nonvatamt))/105)*100); 
			supamt=suptot - taxamt;                                
            var type="Hotel";     
            var invno=$('#invno').val();
            var invdate=$('#invdate').jqxDateTimeInput('val');     
            var postdate2=$('#postdate2').jqxDateTimeInput('val'); 
	        var rows = $("#jqxHotelGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxHotelGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'          
					});
			  return false;
			}
		    tot=parseFloat(nonvatamt) + parseFloat(vatamt) + parseFloat(taxamt);    
		    if(tot!=parseFloat(suptot)){
		         swal({
						type: 'warning',
						title: 'Warning',   
						text: 'Sum of non vatable amount,vatable amount and vat amount should be equals to supplier total!'              
					});
			     return false;   
		    }  
			$.messager.confirm('Message', 'Do you want to create Ni Purchase?', function(r){         
			 if(r==false)
			  {
			   return false; 
			  }
			 else
			 {
				var i=0,chk=0,cpudoc=0;    
				var j=0;
				var temptrn=""; 
				var fvnddocno,lvnddocno;                    
				for (i = 0; i < selectedrows.length; i++) {        
				if(i==0){
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
					fvnddocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					temptrn=tranid;
					}
				else{
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					lvnddocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc=cpudoc + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					if(fvnddocno!=lvnddocno){
					  chk=1;
					  break;        
					}
					temptrn=temptrn+","+tranid;
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidhotelrowno').val(temptrn1); 
				if(chk==1){
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents have same Supplier!'              
					});
			        return false;
				}
				if(cpudoc>0){  
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Purchase is already created in some of selected documents!'                      
					});
			        return false;
				}
					createCPU($('#hidhotelrowno').val(),invno,invdate,postdate2,type,nonvatamt,taxamt,vatamt);           
			}
			});  
		}
    /* function funCreateNiPurchaseTicket(){  
            var type="Ticket";     
            var invno=$('#invno').val();
            var invdate=$('#invdate').jqxDateTimeInput('val');     
            var postdate2=$('#postdate2').jqxDateTimeInput('val'); 
	        var rows = $("#jqxTicketGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxTicketGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'            
					});
			  return false;
			}
			$.messager.confirm('Message', 'Do you want to create Ni Purchase?', function(r){         
			 if(r==false)
			  {
			   return false; 
			  }
			 else
			 {
				var i=0,chk=0,cpudoc=0;   
				var j=0;
				var temptrn=""; 
				var fvnddocno,lvnddocno;   
				for (i = 0; i < selectedrows.length; i++) {        
				if(i==0){
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
					fvnddocno= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					temptrn=tranid;
					}
				else{
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					temptrn=temptrn+","+tranid;
					lvnddocno= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc=cpudoc + $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					if(fvnddocno!=lvnddocno){
					  chk=1;
					  break;    
					}
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidticketrowno').val(temptrn1);
				if(chk==1){
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents have same Supplier!'               
					});
			        return false;
				}
				if(cpudoc>0){  
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Purchase is already created in some of selected documents!'                         
					});
			        return false;
				}
				createCPU($('#hidticketrowno').val(),invno,invdate,postdate2,type);  
			}
			});    
		} */
	function createCPU(rowno,invno,invdate,postdate,type,nonvatamt,taxamt,vatamt){                                                                           
				var x=new XMLHttpRequest();  
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
				var items=x.responseText.trim().split('###');                  
				   if(parseInt(items[0])>=1)              
					{  
					   swal({
							type: 'success',
							title: 'Success',
							text: 'CPU -'+items[1]+'  Created Successfully'                    
						});
						 $('#modalpurchase').modal('toggle');       
						 $('#invdate').val(new Date()); 
						 $('#postdate2').val(new Date());    
						 $('#invno').val(''); 
						 $('#hidticketrowno').val('');  
						 $('#hidhotelrowno').val('');
						 funload();                     
					}  
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'                 
						});
					}
				}   
				}   
				x.open("GET","createCPU.jsp?rowno="+rowno+"&invno="+invno+"&invdate="+invdate+"&postdate="+postdate+"&type="+type+"&nonvatamt="+nonvatamt+"&taxamt="+taxamt+"&vatamt="+vatamt+"&brhid="+$('#cmbbranch').val(),true);                                                  
				x.send();  
			}
          function funinvoice(){  
         	if($('#cmbtype').val()=="T"){  
		        funinvoiceTicket();
		    }else{  
		        funinvoiceHotel();     
		    }	
		  }
		  
		  function funinvoiceTicket(){  
            var type="ticket";       
            var postdate=$('#postdate1').jqxDateTimeInput('val'); 
	        var rows = $("#jqxTicketGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxTicketGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'          
					});
			  return false;
			}
			$.messager.confirm('Message', 'Do you want to Travel Invoice?', function(r){           
			 if(r==false)
			  {
			   return false; 
			  }
			 else
			 {
				var i=0;    
				var j=0;
				var temptrn=""; 
				for (i = 0; i < selectedrows.length; i++) {          
				if(i==0){
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					temptrn=tranid;
					}
				else{
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
					temptrn=temptrn+","+tranid;
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidticketrowno').val(temptrn1);
				  createInvoice($('#hidticketrowno').val(),postdate,type);    
			}
			});  
		}
		
		function funinvoiceHotel(){  
            var type="hotel";       
            var postdate=$('#postdate1').jqxDateTimeInput('val'); 
	        var rows = $("#jqxHotelGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxHotelGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'          
					});
			  return false;  
			}
			$.messager.confirm('Message', 'Do you want to Travel Invoice?', function(r){           
			 if(r==false)
			  {
			   return false; 
			  }
			 else
			 {
				var i=0;    
				var j=0;
				var temptrn=""; 
				for (i = 0; i < selectedrows.length; i++) {        
				if(i==0){
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					temptrn=tranid;
					}
				else{
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					temptrn=temptrn+","+tranid;
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidhotelrowno').val(temptrn1); 
				createInvoice($('#hidhotelrowno').val(),postdate,type);
			}
			});  
		}
    function createInvoice(rowno,postdate,type){
				var x=new XMLHttpRequest();  
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
				var items=x.responseText.trim().split('###');                  
				   if(parseInt(items[0])>=1)              
					{    
					   swal({
							type: 'success',
							title: 'Success',
							text: 'TINV -'+ items[1] +'  Created Successfully'                    
						});
						 $('#modalinvoice').modal('toggle');       
						 $('#postdate1').val(new Date());    
						 $('#hidticketrowno').val('');  
						 $('#hidhotelrowno').val('');                               
						 funload();                        
					}  
					else
					{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Created'                 
						});
					}
				}     
				}   
				x.open("GET","createInvoice.jsp?rowno="+rowno+"&postdate="+postdate+"&type="+type+"&brhid="+$('#cmbbranch').val(),true);                                                                       
				x.send();  
			}  
			
	function funpurchasehotelcount(){       
	        var rows = $("#jqxHotelGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxHotelGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'            
					});
			  return false;
			}
				var i=0,chk=0,cpudoc=0,j=0;   
				var temptrn="",supplier=""; 
				var fvnddocno,lvnddocno;   
				var supptot=0.0,nonvatamt=0.0,vatamt=0.0,taxamt=0.0;
				for (i = 0; i < selectedrows.length; i++) {        
				if(i==0){
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
					fvnddocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					supplier=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vendor"); 
					supptot=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "suptotal"); 
					nonvatamt=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "nonvatamt"); 
					vatamt=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vatamt"); 
					taxamt=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt");
					temptrn=tranid;  
					}
				else{
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					temptrn=temptrn+","+tranid;
					lvnddocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vnddocno");
					cpudoc=cpudoc + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cpudoc");
					supptot=supptot + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "suptotal"); 
					nonvatamt=nonvatamt + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "nonvatamt"); 
					vatamt=vatamt + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "vatamt");  
					taxamt=taxamt + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt");                   
					if(fvnddocno!=lvnddocno){            
					  chk=1;
					  break;    
					}
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidticketrowno').val(temptrn1);   
				if(chk==1){
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents have same Supplier!'               
					});
			        return false;
				}
				if(cpudoc>0){  
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Purchase is already created in some of selected documents!'                         
					});
			        return false;
				}
				var description=supplier+"   -   "+j;          
				$('#clientref1').text(description); 
				funRoundAmt(supptot,"suppamt");
				funRoundAmt(nonvatamt,"nonvatamt");
				funRoundAmt(vatamt,"vatamt");
				funRoundAmt(taxamt,"taxamt");
				$('#modalpurchase').modal('toggle');        
			}  
	 
	 function funinvoicehotelcount(){    
	        var rows = $("#jqxHotelGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxHotelGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'          
					});
			  return false;
			}
				var i=0,chk=0,invtrno=0,j=0,spchk=0;    
				var sprice=0.0;  
				var temptrn="",customer=""; 
				var fcldocno,lcldocno; 
				for (i = 0; i < selectedrows.length; i++) {        
				if(i==0){
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					fcldocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					invtrno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "invtrno");
					customer= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "customer");
					sprice=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "sprice");
					temptrn=tranid;
					if(sprice==0){
					   spchk=1;
					   break;
					}
					}
				else{
					var tranid= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					lcldocno= $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno"); 
					invtrno= invtrno + $('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "invtrno");  
					temptrn=temptrn+","+tranid;
					sprice=$('#jqxHotelGrid').jqxGrid('getcellvalue', selectedrows[i], "sprice");
					if(sprice==0){  
					   spchk=1;
					   break;
					}
					if(fcldocno!=lcldocno){              
					  chk=1;
					  break;    
					 }
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidhotelrowno').val(temptrn1); 
				if(chk==1){
					 swal({
						type: 'warning',
						title: 'Warning',  
				        text: 'Please select documents have same customer!'                            
					});
			        return false;
				} 
				if(spchk==1){   
					 swal({
						type: 'warning',
						title: 'Warning',  
				        text: 'Some of the select documents do not have selling price!'                                                             
					});
			        return false;
				}  
				if(invtrno>0){  
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Invoice is already created in some of selected documents!'                           
					});
			        return false;
				}
				var description=customer+"   -   "+j;       
				$('#clientref2').text(description);   
				$('#modalinvoice').modal('toggle');
			}
			
	function funinvoiceTicketCount(){
	        var rows = $("#jqxTicketGrid").jqxGrid('getrows');  
			var selectedrows=$("#jqxTicketGrid").jqxGrid('selectedrowindexes');   
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
			  swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select documents..'          
					});
			  return false;
			}
				var i=0,chk=0,invtrno=0,spchk=0,j=0;      
				var sprice=0.0;    
				var temptrn="",customer=""; 
				var fcldocno,lcldocno; 
				for (i = 0; i < selectedrows.length; i++) {          
				if(i==0){
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");  
					fcldocno= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					invtrno= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "invtrno");
					customer= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "customer"); 
					sprice= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "sprice");      
					temptrn=tranid;
					if(sprice==0){
					   spchk=1;
					   break;
					}
					}
				else{
					var tranid= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "rowno");
					lcldocno= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno"); 
					invtrno= invtrno + $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "invtrno");
					sprice= $('#jqxTicketGrid').jqxGrid('getcellvalue', selectedrows[i], "sprice");      
					temptrn=temptrn+","+tranid;
					if(sprice==0){
					   spchk=1;
					   break;
					}
					if(fcldocno!=lcldocno){            
					  chk=1;
					  break;    
					 }
					} 
				temptrn1=temptrn+",";  
				j++;   
				}
				$('#hidticketrowno').val(temptrn1);  
				if(chk==1){
					 swal({
						type: 'warning',
						title: 'Warning',  
						text: 'Please select documents have same client!'                         
					});
			        return false;
				}
				if(spchk==1){   
					 swal({
						type: 'warning',
						title: 'Warning',  
				        text: 'Some of the select documents do not have selling price!'                                                             
					});
			        return false;
				}
				if(invtrno>0){  
					 swal({
						type: 'warning',
						title: 'Warning',
						text: 'Invoice is already created in some of selected documents!'                           
					});
			        return false;
				}
				var description=customer+"   -   "+j;           
				$('#clientref2').text(description);   
				$('#modalinvoice').modal('toggle');       
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
  </script>
</body>
</html>