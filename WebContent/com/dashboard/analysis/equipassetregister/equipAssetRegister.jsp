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

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
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
    flex-direction: column;
    gap: 8px;
    font-size: 12px;
    color: #333;
    padding: 2px 0;
}

.radio-row {
    display: flex;
    gap: 15px;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
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

.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
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
		 
		 $('#fleetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#fleetDetailsWindow').jqxWindow('close');
	     
		 $('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#groupDetailsWindow').jqxWindow('close');
	     
	     $('#modelDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#modelDetailsWindow').jqxWindow('close');
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdall").checked=true;
	     
	});
	
	function funExportBtn(){
	   // JSONToCSVConvertor(dataExcelExport, 'VehicleAssetRegister', true);

        $("#assetDiv").excelexportjs({
				containerid: "assetDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "equipAssetGrid",
				columns: getColumns("equipAssetGrid") ,   
				worksheetName:"Equipment Asset Register"  
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

	
	function fleetSearchContent(url) {
	    $('#fleetDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#fleetDetailsWindow').jqxWindow('setContent', data);
		$('#fleetDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupDetailsWindow').jqxWindow('setContent', data);
		$('#groupDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function modelSearchContent(url) {
	    $('#modelDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#modelDetailsWindow').jqxWindow('setContent', data);
		$('#modelDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getFleet(event){
        var x= event.keyCode;
        if(x==114){
        	fleetSearchContent('fleetSearchGrid.jsp');
        }
        else{}
        }
	
	function getGroup(event){
        var x= event.keyCode;
        if(x==114){
        	groupSearchContent('groupSearchGrid.jsp');
        }
        else{}
        }
	
	function getModel(event){
        var x= event.keyCode;
        if(x==114){
        	modelSearchContent('modelSearchGrid.jsp');
        }
        else{}
        }
	
	function funSearchdblclick(){
		  $('#txtfleet').dblclick(function(){
			  fleetSearchContent('fleetSearchGrid.jsp');
			});
		  
		  $('#txtgroup').dblclick(function(){
			  groupSearchContent('groupSearchGrid.jsp');
			});
		  
		  $('#txtmodel').dblclick(function(){
			  modelSearchContent('modelSearchGrid.jsp');
			});
	}

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var fleetno = $('#txtfleet').val();
		 var group = $('#txtgroupno').val();
		 var model = $('#txtmodelid').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			 $("#assetDiv").load("equipAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
		 	
		 }else if(document.getElementById("rdsold").checked==true){
			 $("#assetDiv").load("equipAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
			 
		 }else{
			 $("#assetDiv").load("equipAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("txtfleet").value="";
		document.getElementById("txtmodel").value="";
		document.getElementById("txtmodelid").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		
		document.getElementById("rdall").checked=true;
		
		 if (document.getElementById("txtmodel").value == "") {
		        $('#txtmodel').attr('placeholder', 'Press F3 to Search'); 
		    }
		
		 if (document.getElementById("txtgroup").value == "") {
		        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtfleet").value == "") {
		        $('#txtfleet').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		}

</script>
</head>
<body onload="getBranch();">
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
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" id="txtfleet" name="txtfleet" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtfleet"/>' ondblclick="funSearchdblclick();" onkeydown="getFleet(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Group</td>
                            <td>
                                <input type="text" id="txtgroup" name="txtgroup" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' ondblclick="funSearchdblclick();" onkeydown="getGroup(event);"/>
                                <input type="hidden" id="txtgroupno" name="txtgroupno" value='<s:property value="txtgroupno"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Model</td>
                            <td>
                                <input type="text" id="txtmodel" name="txtmodel" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtmodel"/>' ondblclick="funSearchdblclick();" onkeydown="getModel(event);"/>
                                <input type="hidden" id="txtmodelid" name="txtmodelid" value='<s:property value="txtmodelid"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Report Type</td>
                            <td>
                                <div class="radio-group">
                                    <div class="radio-row">
                                        <label><input type="radio" id="rdall" name="rdo" value="rdall">All</label>
                                        <label><input type="radio" id="rdsold" name="rdo" value="rdsold">Sold</label>
                                    </div>
                                    <label><input type="radio" id="rdadditions" name="rdo" value="rdadditions">Additions</label>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" name="clear" id="clear" onclick="funClearInfo();">Clear</button>
                    </div>

                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="assetDiv"><jsp:include page="equipAssetRegisterGrid.jsp"></jsp:include></div>
            </div>

        </div>

    </div>

    <!-- Modals -->
    <div id="fleetDetailsWindow">
        <div></div><div></div>
    </div>
    <div id="groupDetailsWindow">
        <div></div><div></div>
    </div>
    <div id="modelDetailsWindow">
        <div></div><div></div>
    </div>

</div>
</body>
</html>