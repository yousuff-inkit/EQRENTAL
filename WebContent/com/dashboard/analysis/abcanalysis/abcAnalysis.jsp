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
<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
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
    width: 280px; 
    flex: 0 0 280px; 
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;             
    padding: 2px 8px;         
    border: 1px solid #ccd6e0;
    border-radius: 4px;       
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Textarea styling */
.search-textarea {
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    padding: 6px;
    font-size: 11px;
    background-color: #f3f6f9;
    resize: none;
    margin-top: 10px;
    font-family: 'Segoe UI', Tahoma, sans-serif;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled,
select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="fromdate"],
.release-filter-table div[id^="todate"] {
    width: 100%;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    font-size: 12px;
    color: #333;
    padding: 5px 0 10px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-weight: 600;
}
.radio-group input[type="radio"] {
    margin-right: 4px;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

/* Inline action flex */
.inline-action-row {
    display: flex;
    gap: 5px;
}
.inline-action-row select {
    flex: 1;
}
.btn-icon {
    width: 30px;
    height: 24px;
    line-height: 24px;
    padding: 0;
    text-align: center;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
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

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
		   
		 $('#clientSearchWindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientSearchWindow').jqxWindow('close');
		 
		 $('#clientCategorySearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientCategorySearchWindow').jqxWindow('close');
		
		 $('#salesmanSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#salesmanSearchWindow').jqxWindow('close');
		
		 $('#clientStatusSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Status Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientStatusSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     document.getElementById("rdall").checked=true;
	});
	
	function funExportBtn(){
	   /*  JSONToCSVConvertor(dataExcelExport, 'ClientAnalysis', true); */
	    $("#analysisDiv").excelexportjs({
			containerid: "analysisDiv",   
			datatype: 'json',
			dataset: null,
			gridId: "abcAnalysisGrid",
			columns: getColumns("abcAnalysisGrid") ,   
			worksheetName:"Client Analysis"  
		});   
	} 
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
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
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		        	  var summarytype = $('#cmbsummarytype').val();
		        	  var hidclientcat=document.getElementById("hidclientcat").value;
		        	  var hidclient=document.getElementById("hidclient").value;
		        	  var hidclientslm=document.getElementById("hidclientslm").value;
					  var hidclientstatus=document.getElementById("hidclientstatus").value;
		        	  
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  if(document.getElementById("rdall").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }else if(document.getElementById("rdsummary").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function summaryDisable(){
		if(document.getElementById("rdall").checked==true){
			$('#cmbsummarytype').attr('disabled', true);
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false);
		}
	}
	
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
         }
		 
		 getGridColumnCalculation(fromdate,todate);
	}
	
	function clientSearchContent(url) {
	    $('#clientSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientSearchWindow').jqxWindow('setContent', data);
		$('#clientSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientCategorySearchContent(url) {
	    $('#clientCategorySearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientCategorySearchWindow').jqxWindow('setContent', data);
		$('#clientCategorySearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesmanSearchWindow').jqxWindow('setContent', data);
		$('#salesmanSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientStatusSearchContent(url) {
	    $('#clientStatusSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientStatusSearchWindow').jqxWindow('setContent', data);
		$('#clientStatusSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(){
	 	 clientSearchContent('clientSearch.jsp');
	}

	function getClientCategory(){
		 clientCategorySearchContent('clientCategorySearch.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}

	function getClientStatus(){
		clientStatusSearchContent('clientStatusSearch.jsp?id=3');
	}
	
	function setSearch(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="clientslm"){
			getClientSalesman();
		}
		else if(value=="clientstatus"){
			getClientStatus();
		}
		else{}
	}
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientcat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientcat").value="";
			document.getElementById("hidclientcat").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientslm").value="";
			document.getElementById("hidclientslm").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientstatus"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientstatus").value="";
			document.getElementById("hidclientstatus").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
		}
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		
		document.getElementById("rdall").checked=true;		
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("clientslm").value="";document.getElementById("hidclientslm").value="";document.getElementById("clientstatus").value="";
		document.getElementById("hidclientstatus").value="";
		summaryDisable();
	}
	
</script>
</head>
<body onload="getBranch();summaryDisable();">

<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- Sidebar / Filter Section -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                        </tr>
                    </table>

                    <div class="radio-group" style="padding-top: 15px;">
                        <label>
                            <input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall">
                            All
                        </label>
                        <label>
                            <input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary">
                            Summary
                        </label>
                    </div>

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbsummarytype" name="cmbsummarytype" onchange="clearAccountInfo();" value='<s:property value="cmbsummarytype"/>'>
                                    <option value="">--Select--</option>
                                    <option value="CRM">Client</option>
                                    <option value="CAT">Client Category</option>
                                    <option value="PCASE">Client Status</option>
                                    <option value="SLM">Salesman</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Search By</td>
                            <td>
                                <div class="inline-action-row">
                                    <select name="searchby" id="searchby">
                                        <option value="">--Select--</option>
                                        <option value="client">Client</option>
                                        <option value="clientcat">Client Category</option>
                                        <option value="clientstatus">Client Status</option>
                                        <option value="clientslm">Salesman</option>
                                    </select>
                                    <button type="button" name="btnadditem" id="additem" class="btn-submit btn-icon" onClick="setSearch();">+</button>
                                    <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-submit btn-icon" onclick="setRemove();">-</button>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <textarea id="searchdetails" name="searchdetails" rows="8" readonly class="search-textarea"><s:property value="searchdetails"></s:property></textarea>

                    <div class="release-actions">
                        <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">Clear</button>
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="client" id="client">
                    <input type="hidden" name="hidclient" id="hidclient">
                    <input type="hidden" name="clientcat" id="clientcat">
                    <input type="hidden" name="hidclientcat" id="hidclientcat">
                    <input type="hidden" name="clientstatus" id="clientstatus">
                    <input type="hidden" name="hidclientstatus" id="hidclientstatus">
                    <input type="hidden" name="clientslm" id="clientslm">
                    <input type="hidden" name="hidclientslm" id="hidclientslm">

                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="analysisDiv"><jsp:include page="abcAnalysisGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="clientSearchWindow">
        <div></div><div></div>
    </div>
    <div id="clientCategorySearchWindow">
        <div></div><div></div>
    </div>
    <div id="salesmanSearchWindow">
        <div></div><div></div>
    </div>
    <div id="clientStatusSearchWindow">
        <div></div><div></div>
    </div>

</div>
</body>
</html>