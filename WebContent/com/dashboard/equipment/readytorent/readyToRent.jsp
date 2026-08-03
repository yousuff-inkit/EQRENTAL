<%@page import="com.dashboard.equipment.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../../includeso.jsp"></jsp:include>    
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
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript">

$(document).ready(function () {
  $("#chart").show();
  $("#branchwisediv").hide();
  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	  
	  $("#grid1").hide();
	
	  $("#grid2").hide();
	 var data  =<%=cvd.firstchart()%>;
     
     var dataStatCounter = data;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'On Hire',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme07',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#fleetStatus' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data1  =<%=cvd.Secondchart()%>;
     
     var dataStatCounter1 = data1;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter1 }
     ];
     for (var i = 0; i < charts.length; i++) {
    	 var chartSettings = {
                 source: charts[i].dataSource,
                 title: 'Available',
                 description: charts[i].title,
                 enableAnimations: false,
                 showLegend: true,
                 showBorderLine: true,
                 padding: { left: 5, top: 30, right: 5, bottom: 5 },
                 titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
                 colorScheme: 'scheme05',
                 seriesGroups: [
                     {
                         type: 'pie',
                         showLegend: true,
                         enableSeriesToggle: true,
                         series:
                             [
                                 {
                                     dataField: 'per',
                                     displayText: 'tran_code',
                                     showLabels: true,
                                     labelRadius: 200,
                                     labelLinesEnabled: true,
                                     labelLinesAngles: true,
                                     labelsAutoRotate: false,
                                     initialAngle: 0,
                                     radius: 180,
                                     minAngle: 0,
                                     maxAngle: 180,
                                     centerOffset: 0,
                                     offsetY: 180,
                                  formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#sec' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data2  =<%=cvd.Thirdchart()%>;
     
     var dataStatCounter2 = data2;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter2 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'Garage',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme02',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#thr' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
     var data4=<%=cvd.Fourthchart()%>;
     
     var dataStatCounter4 = data4;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter4 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'All',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme01',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#four' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
   
});

function funreload(event)
{
	
	  $("#chart").show();
	  $("#grid1").hide();
	  $("#grid2").hide();

	 var barchval = document.getElementById("cmbbranch").value;
	$('#chart').hide();
	$('#branchwisediv').show();
	  $("#Readygrid").load("vehDetailsgrid.jsp?barchval="+barchval);
	  $("#branchwisediv").load("branchwiseGrid.jsp?check=1");
	}
	

	
function funExportBtn()
{
	
	
  	if(document.getElementById("chkgrid").value=="chkgrids")
	
	
		{
		 JSONToCSVConvertor(vehicleexceldata, 'Availability', true);
		}
	else
		{  
	 	 
		
	 	JSONToCSVConvertor(exceldata, 'Availability', true);
		
		  }
	  
	
	 
	
	
	
	
	}
	
	function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		   

		   $('#vehiclelist').jqxGrid('showcolumn', 'rdocno');
		   $('#vehiclelist').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			   
			   $('#vehiclelist').jqxGrid('hidecolumn', 'rdocno');
			   $('#vehiclelist').jqxGrid('hidecolumn', 'empname');
			  }
		  
		  
		 /*    if(document.getElementById("chkdatails").value=="search")
			{
			   $('#vehdetails').jqxGrid('showcolumn', 'rdocno');
			   $('#vehdetails').jqxGrid('showcolumn', 'empname');
			}
		else
			{
		   $('#vehdetails').jqxGrid('hidecolumn', 'rdocno');
		   $('#vehdetails').jqxGrid('hidecolumn', 'empname');

			} */
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
 
	 function funPrintBtn(){
		 
			   var url=document.URL;
			   //alert(url);
	    	   var reurl=url.split("readyToRent.jsp");
	    	   var companyname='<%=session.getAttribute("COMPANYNAME").toString()%>';
	    	   //alert(companyname);
			   var win= window.open(reurl[0]+"printReadyToRentJrxml?brhid="+document.getElementById("cmbbranch").value+"&company="+companyname+"&print=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
		       win.focus(); 
		    	     
		}
	 function funSendingEmail() {  
		 var companyname='<%=session.getAttribute("COMPANYNAME").toString()%>';	
		    
	 		alert("inside mail");
			    $("#overlay, #PleaseWait").show();
			   
		 		$.ajaxFileUpload ({  
		    	    	
		    	    	  url:"printReadyToRentJrxml?brhid="+document.getElementById("cmbbranch").value+"&company="+companyname+"&print=0",  
		    	          secureuri:false,//false  
		    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
		    	          dataType: 'string',// json  
		    	          success: function (data, status) {  
		
		    	             if(status=='success'){
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','E-Mail Send Successfully');
		    	              }
		    	             if(status=='error'){
		    	            	 $("#overlay, #PleaseWait").hide();
		    	            	 $.messager.alert('Message','E-Mail Sending failed');
		    	             }
		    	             
		    	              $("#testImg").attr("src",data.message);
		    	              if(typeof(data.error) != 'undefined')  
		    	              {  
		    	                  if(data.error != '')  
		    	                  {  
		    	                      alert(data.error);  
		    	                  }else  
		    	                  {  
		    	                      alert(data.message);  
		    	                  }  
		    	              }  
		    	          },  
		    	           error: function (data, status, e)
		    	          {  
		    	              alert(e);  
		    	          }  
		    	      }) 
		    	     return false;
	      }
</script>

<style type="text/css">

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
    width: 300px; 
    flex: 0 0 300px; 
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

/* Checkbox specific layout */
.checkbox-row {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    margin-bottom: 15px;
}

.checkbox-row input[type="checkbox"] {
    margin-left: 8px;
    vertical-align: middle;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit, .myButton {
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
}

.btn-submit:hover, .myButton:hover {
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
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <div class="checkbox-row">
                    <label class="branch">Detail</label>
                    <input type="checkbox" id="det_chk" name="det_chk" value="0" onclick="funsetaval()">
                </div>

                <div id="Readygrid">
                    <jsp:include page="vehDetailsgrid.jsp"></jsp:include>
                </div>
            </div>

            <div style="display:none;">
                <input type="button" class="btn-submit" id="btnprint" name="btnprint" value="Overall Status" onclick="funPrintBtn();">
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
            
            <table width="100%" id="grid1">
                <tr>
                    <td>
                        <div id="fleetdiv"><jsp:include page="readyToRentGrid.jsp"></jsp:include></div>
                    </td>
                </tr>
            </table>

            <table width="100%" id="grid2">
                <tr>
                    <td>
                        <div id="fleetdiv1"><jsp:include page="vehiclelistgrid.jsp"></jsp:include></div>
                    </td>
                </tr>
            </table>

            <table width="100%" id="chart">
                <tr>
                    <td width="50%">
                        <div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
                        <div id='sec1' style="width: 100%; height: 250px;"></div>
                    </td>
                    <td>  
                        <div id='thr1' style="width: 100%; height: 250px;"></div>
                        <div id='four1' style="width: 100%; height: 250px;"></div>
                    </td>
                </tr>
            </table>

            <div id="branchwisediv">
                <jsp:include page="branchwiseGrid.jsp"></jsp:include>
            </div>

        </div>

    </div>

</div>

<!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
<div style="display:none;">
    <input type="hidden" id="chkgrid" name="chkgrid" value='<s:property value="chkgrid"/>'>
    <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>
</div>

</div>
</div>

</body>
</html>