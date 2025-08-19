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
  		width:600px;   
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
  </style>   
</head>       
<body onload="getBranch();">         
  <form autocomplete="off">  
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
      <div class="branchpanel custompanel" >
		<table>
		<tr> 
		<td align="right"><label class="branch" id="branchlabel" style="font-size: 11px">Branch</label></td>   
		<td align="left" ><div class="styled-select" id="branchdiv"><select id="cmbbranch" name="cmbbranch" onchange="getLocation();" value='<s:property value="cmbbranch"/>' style="width: 140px">  
		<option value="">--Select--</option></select></div>  
		<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
		<td align="right"><label class="branch" id="loclabel" style="font-size: 11px">Location</label></td>   
		<td align="left" ><div class="styled-select" id="locdiv"><select id="cmblocation" name="cmblocation" onchange="funbranch();" value='<s:property value="cmblocation"/>' style="width: 140px"></select></div>
		      <input type="hidden" id="hidcmblocation" name="hidcmblocation" value='<s:property value="hidcmblocation"/>'/></td>
		</tr>   
		</table> 
</div> 
       <div class="todatepanel custompanel">
      <table>
      <tr>                      
      <td  align="right" ><label class="branch" style="font-size: 11px">Up To &nbsp;&nbsp;</label></td>  
      <td align="left"><div id='todate' name='todate'></div></td></tr>                              
	 </table>   
      </div>        
        <div class="primarypanel custompanel">            
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btnconfirm" data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-square " aria-hidden="true"></i></button>
        </div>       
	      <div class="textpanel custompanel" >
				<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>
	        </div>      
      </div>    
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                 
        <div id="traveldiv"><jsp:include page="travelGrid.jsp"></jsp:include></div>
      </div>
    </div>    

     <input type="hidden" name="hidrowno" id="hidrowno">  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){       
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$("#todate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});

    	$('[data-toggle="tooltip"]').tooltip(); 
        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();
        
        function SearchContent(url,id) 
        {
		    
		    $.get(url).done(function (data) {
		  	$('#'+id).jqxWindow('setContent', data);
			}); 
		}
        $('#btnconfirm').click(function(){   
        	var docno=$('#hidrowno').val();   
        	if(docno==''){ 
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'  
				});
				 return 0;
			 }  
        	validateconfirm();                    
        });  
        $('#btnsubmit').click(function(){ 
        	 $('#hidrowno').val('');  
		     $('.textpanel p').text('');
		     funload();
        });  
        $('#btnexcel').click(function(){                
        JSONToCSVCon(dataexcel, 'Travel details', true);      
        });
         $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#TravelGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
      
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
    	$("#TravelGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.        
    	$("#TravelGrid").jqxGrid('applyfilters');
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
				/* if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} */
				getLocation();
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
		x.send();
	}
	
	function getLocation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {  
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				brchIdItems = items[0].split(",");
				brchItems = items[1].split(",");
				var optionsbrch;// = '<option value="">--Select--</option>';
				for (var i = 0; i < brchItems.length; i++) {
					optionsbrch += '<option value="' + brchIdItems[i] + '">'
							+ brchItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsbrch);
				
			} else {
				//alert("Error");
			}     
		}
		x.open("GET","getLocation.jsp?brhid="+$('#cmbbranch').val(), true);   
		x.send();
	}
			
	 function funbranch(){  
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{   
				var items=x.responseText.trim();
				if(items>0){  
					$('#cmbbranch').val(items);    
				}
				else{
				}   
			}  
			else    
			{       
			}            
		}
		x.open("GET","getBranch.jsp?locid="+$('#cmblocation').val(),true);         
		x.send();  
	 }
	 function funload(){   
		 $("#overlay, #PleaseWait").show();  
      	 var brhid=document.getElementById("cmbbranch").value; 
    	 var locid=document.getElementById("cmblocation").value;
    	 var todate=$('#todate').jqxDateTimeInput('val');   
         $('#traveldiv').load('travelGrid.jsp?check=1'+'&brhid='+brhid+'&locid='+locid+'&todate='+todate);   
	 }
	 function validateconfirm(){
		   $.messager.confirm('Message', 'Do you want to confirm?', function(r){       
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		     		funConfirm();         
		     	}  
		 });
	 }
		function funConfirm(){  
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText;     
			   if(parseInt(items)>=1)
				{
				   swal({
						type: 'success',
						title: 'Success',
						text: 'Successfully Confirmed'
					});
				   funload();  
				} 
				else
				{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Confirmed'          
					});
				}
			}                
			}      
			x.open("GET","saveConfirm.jsp?rowno="+$('#hidrowno').val(),true);                                               
			x.send();
		}
	 
  </script>
	</div> 
</div>       
</form>
</body>
</html>
