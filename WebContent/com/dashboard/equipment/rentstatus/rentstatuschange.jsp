<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GatewayERP(i)</title>
        
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
            width: 80px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select, textarea,
        .filter-table input[type="text"],
        .filter-table select {
            width: 100%;
            height: 24px;             
            padding: 2px 8px;         
            border: 1px solid #ccd6e0;
            border-radius: 4px;       
            font-size: 12px;          
            background-color: #ffffff;
            box-sizing: border-box;
            color: #333;
            outline: none;
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        .filter-table input[readonly],
        .filter-table input:disabled {
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed;
            cursor: pointer;
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
            text-align: center;
        }

        .btn-submit:hover {
            background: #1d4ed8;
        }

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
            flex-wrap: wrap;
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
            background: #fff;
            display: flex;
            flex-direction: column;
        }

        /* Misc */
        .grid-wrapper {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        #pieChart1 {
            border-radius: 8px;
            overflow: hidden;
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
             $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
        });

        function funreload(event) {     
             document.getElementById("fleetno").value="";
             document.getElementById("brach").value="";
             document.getElementById("grp").value="";
             document.getElementById("docno").value="";
             document.getElementById("rentaltype").value="";
             document.getElementById("typeingrid").value="";
            
             disitems();
             var barchval = document.getElementById("cmbbranch").value;
             $("#fleetdiv").load("vehlistshowgrid.jsp?brchval="+barchval);
        }
            
        function disitems() {
             $('#btnvehicle').attr("disabled",true);
             $('#btnmove').attr("disabled",true);
             $('#btnupdate').attr("disabled",true);
             $('#rentaltype').attr("disabled",true);
             $('#fleetno').attr("disabled",true);
        }
            
        function getVehicleMov(){
              var fleetno=document.getElementById("fleetno").value;
              var vals=0;
              var ready="ready";
              $('#movementwindow').jqxWindow('setContent', '');
              $('#movementwindow').jqxWindow('open');  
              movementSearchContent("<%=contextPath%>/com/dashboard/equipment/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
         }
         
        function movementSearchContent(url) {
             $('#movementwindow').jqxWindow('focus'); 
             $.get(url).done(function (data) {
                $('#movementwindow').jqxWindow('setContent', data);
            }); 
        }
        
        function changeClientAttachContent(url) {
            $.get(url).done(function (data) {
                    $('#windowattach').jqxWindow('open');
                    $('#windowattach').jqxWindow('setContent',data);
                    $('#windowattach').jqxWindow('bringToFront');
            }); 
        }
        
        function funClientAttach(){
            if ($("#docno").val()!="") {
                  $("#windowattach").jqxWindow('setTitle',"EEM - "+document.getElementById("docno").value);
                changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=EEM&docno="+document.getElementById("docno").value);      
            } else {
                $.messager.alert('Message','Select Fleet....!','warning');
                return;
            }
        }
            
        function funsamechk() {
             if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value) {
                 $.messager.alert('Message','Rent Type Is Same','warning');   
                 document.getElementById("rentaltype").focus();
                 return 0;
             }
        }
         
        function funupdate() {
              if(document.getElementById("rentaltype").value=="") {
                     $.messager.alert('Message','Select Rent Type ','warning');   
                     return 0;
                 }
                
              if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value) {
                     $.messager.alert('Message','Rent Type Is Same','warning');   
                     document.getElementById("rentaltype").focus();
                     return 0;
                 }
                 
              var fleetno=document.getElementById("fleetno").value;
              var renttype=document.getElementById("rentaltype").value;
              savegriddata(fleetno,renttype);
        }   
                        
        function savegriddata(fleetno,renttype) {
                var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                        var items=x.responseText;
                         document.getElementById("rentaltype").value="";
                         document.getElementById("fleetno").value="";
                         document.getElementById("brach").value="";
                         document.getElementById("grp").value="";
                         document.getElementById("docno").value="";
                         document.getElementById("typeingrid").value="";
                          
                          $.messager.alert('Message', '  Record Successfully Updated ', function(r){
                         });
                         funreload(event); 
                         disitems();
                    }
                }
            x.open("GET","saverenttype.jsp?fleet="+fleetno+"&renttype="+renttype,true);
            x.send();
        }
                    
        function funExportBtn(){
            $("#movementwindow").excelexportjs({     
                containerid: "movementwindow", 
                datatype: 'json', 
                dataset: null, 
                gridId: "jqxFleetGrid",            
                columns: getColumns("jqxFleetGrid") , 
                worksheetName:"Rent Status"    
            }); 
        }           
        </script>
    </head>
    
    <body onload="getBranch();disitems();">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        
                        <!-- Rent Type Details Card -->
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Fleet</td>
                                    <td><input type="text" name="fleetno" id="fleetno" readonly="readonly" value='<s:property value="fleetno"/>' ></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Rent Type</td>
                                    <td>
                                        <select name="rentaltype" id="rentaltype" value='<s:property value="rentaltype"/>' onchange="funsamechk()">
                                            <option value="" selected>--Select--</option>
                                            <option value="R" selected>Rental</option>
                                            <option value="L">Lease</option>
                                            <option value="LM">Limousine</option>
                                            <option value="A">All</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            
                            <div class="action-buttons">
                                <button type="button" name="btnupdate" id="btnupdate" class="btn-submit" onclick="funupdate();">Update</button>
                            </div>
                        </div>
                        
                        <!-- Actions Card -->
                        <div class="filter-card">
                            <div class="action-buttons">
                                <button type="button" name="btnvehicle" id="btnvehicle" class="btn-submit" onclick="funClientAttach();">Attach</button>
                                <button type="button" name="btnmove" id="btnmove" class="btn-submit" onClick="getVehicleMov();">Movement</button>
                            </div>
                        </div>
                        
                        <!-- Pie Chart Card -->
                        <div class="filter-card" style="padding: 10px;">
                            <div id='pieChart1' style="width: 100%; height: 170px;"></div>
                        </div>

                        <!-- Hidden Data -->
                        <div style="display:none;">
                            <input type="hidden" name="brach" id="brach" value='<s:property value="brach"/>' >
                            <input type="hidden" name="grp" id="grp" value='<s:property value="grp"/>' >
                            <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
                            <input type="hidden" name="typeingrid" id="typeingrid" value='<s:property value="typeingrid"/>' >
                        </div>

			x.send();
					
			}
			
			
			function funExportBtn(){
				
				$("#movementwindow").excelexportjs({     
		       		containerid: "movementwindow", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "jqxFleetGrid",            
		       		columns: getColumns("jqxFleetGrid") , 
		       		worksheetName:"Rent Status"    
		       		}); 
				   
				   
				   
				   
					 /*if(parseInt(window.parent.chkexportdata.value)=="1")
					 {
					 JSONToCSVCon(sssss, 'Rent Status', true);
					 }
				 else
					 {
					   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Rent Status');
					 }*/
					   
					
				   
				 }			
			
			
			
			
			
</script>

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
    width: 80px;
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

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
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
    margin-bottom: 8px;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}



.button-group {
    display: flex;
    gap: 8px;
}

.button-group .btn-submit, .button-group .myButton {
    flex: 1;
    margin-bottom: 0;
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
  
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <!-- Filter Fields Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" name="fleetno" id="fleetno" readonly="readonly" value='<s:property value="fleetno"/>'>
                        </td>
                    </tr>
                    <tr> 
                        <td class="label-cell">RentType</td>
                        <td>
                            <select name="rentaltype" id="rentaltype" value='<s:property value="rentaltype"/>' onchange="funsamechk()">
                                <option value="" selected>--Select--</option>
                                <option value="R">Rental</option>
                                <option value="L">Lease</option>
                                <option value="LM">Limousine</option>
                                <option value="A">All</option>
                            </select>
                        </td>
                    </tr> 
                </table>
            </div>

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <input type="button" name="btnupdate" id="btnupdate" value="Update" class="btn-submit" onclick="funupdate();">
                <div class="button-group">
                    <input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="btn-submit" onclick="funClientAttach();">
                    <input type="button" name="btnmove" id="btnmove" value="Movement" class="btn-submit" onClick="getVehicleMov();">
                </div>
            </div>

            <!-- Chart Card -->
            <div class="filter-card">
                <div id='pieChart1' style="width: 100%; height: 170px;"></div>
            </div>

            <!-- Hidden Inputs Maintained Safely Outside Visual Layout -->
            <div style="display:none;">
                <input type="hidden" name="brach" id="brach" readonly="readonly" value='<s:property value="brach"/>' >
                <input type="hidden" name="grp" id="grp" readonly="readonly" value='<s:property value="grp"/>' >
                <input type="hidden" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' >
                <input type="hidden" name="typeingrid" id="typeingrid" readonly="readonly" value='<s:property value="typeingrid"/>' >
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
            <div id="fleetdiv">
                <jsp:include page="vehlistshowgrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups and standalone hidden labels restored perfectly -->
<label hidden="true" id="trncodeval"></label>
<label hidden="true" id="statusval"></label>

<div id="movementwindow">
    <div></div>
</div> 

</div>
</div>

        </div>
    </body>
</html>