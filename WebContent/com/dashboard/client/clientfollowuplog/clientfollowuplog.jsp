
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style>
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 320px; 
    flex: 0 0 320px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 70px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: text;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton, .myButtons {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
    margin-bottom: 8px;
}

.btn-submit:hover, .myButton:hover, .myButtons:hover {
    background: #1d4ed8 !important;
}

/* ===== RIGHT CONTENT AREA (Horizontally Aligned Heading) ===== */
.main-content-wrapper {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	  
	$("#cmbbranch").attr('hidden',true); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	  
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 $('#clientname').dblclick(function(){
	  	    
		   $('#clientwindow').jqxWindow('open');
		       		clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
	       });
	 
});

function funreload(event)
{

	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
	   {
	

var fromdate= $("#fromdate").val();
var todate= $("#todate").val(); 
var cldocno=$("#cldocno").val();
var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&cldocno="+cldocno+'&check=1');



  //$("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+'&check=1');
 }

	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

function getclinfo(event){
	 var x= event.keyCode;
	if(x==114){
 		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
	else{}
} 

function clientSearchContent(url) {
	 	$.get(url).done(function (data) {
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('setContent', data);
}); 
} 
	
function funExportBtn(){
    

	   JSONToCSVConvertor(clientexceldata, 'Client Followup Log List', true);
	   }
	  
	  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {

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

	  function  funcleardata()
	  {
		  $("#userdetails").jqxGrid('clear');
		    $("#userdetails").jqxGrid('addrow', null, {});
	  	document.getElementById("cldocno").value="";
	    	document.getElementById("clientname").value="";
	   	
	  	
	  	 if (document.getElementById("clientname").value == "") {
	  			
	  		 
	  	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	  	    }
	  		  		
	  	}

	  function  funPrint()
	  {
		 var client=$('#clientname').val();
		  if(client==''){
				 $.messager.alert('Message','Please Select a Client.','warning');
				 return 0;
			 }
	   			
		 	    if ($("#cldocno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("clientfollowuplog.jsp");
			        var win= window.open(reurl[0]+"printclientfollowup?&cldocno="+document.getElementById("cldocno").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Please Select a Client.','warning');
					return;
				}
			   }
	  
	
	 
</script>
</head>
<body onload="getBranch();hiddenbrh()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td>
                            <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td>
                            <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' " value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Subgrid nested inside the sidebar -->
            <div class="filter-card">
                <div id="Readygrid">
                    <jsp:include page="subgrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="filter-card">
                <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funcleardata()">
                <input type="button" class="btn-submit" name="btnPrint" id="btnPrint" value="Print" onclick="funPrint();">
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-wrapper">
        
        <!-- Horizontally Aligned Heading Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            <div id="grid1">
                <label name="user" id="user"></label>
                <div id="fleetdiv">
                    <jsp:include page="detailsgrid.jsp"></jsp:include>
                </div> 
            </div>
            
            <!-- Hidden original chart wrappers kept to preserve logic -->
            <div style="display:none;">
                <!-- <table width="100%" id="chart">
                    <tr>
                         <td width="50%">
                        <div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
                          <div id='sec1' style="width: 100%; height: 250px;"></div>
                           </td><td>  <div id='thr1' style="width: 100%; height: 250px;"></div>
                           <div id='four1' style="width: 100%; height: 250px;"></div></td></tr>
                </table> -->
            </div>
        </div>

    </div>

</div>

<!-- Popups Maintained Outside the Layout -->
<div id="clientwindow">
   <div></div>
</div>

</div>
</div>

</body>
</html>