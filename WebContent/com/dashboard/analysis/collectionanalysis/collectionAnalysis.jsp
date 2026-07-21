<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String group=request.getParameter("group")==null?"":request.getParameter("group");
     String distribution=request.getParameter("distribution")==null?"":request.getParameter("distribution");
     String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
     String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
     String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
     String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
     String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
     String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
     String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom"); 
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
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

.summary-footer {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px 15px;
    background: #f8fafc;
    border-top: 1px solid #e1e8ed;
    font-size: 13px;
    font-weight: 600;
    gap: 10px;
}

.summary-footer input {
    width: 150px;
    text-align: right;
    font-weight: bold;
    color: #1e293b;
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
		 
		 $('#brandSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#brandSearchWindow').jqxWindow('close');
		   
		 $('#modelSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#modelSearchWindow').jqxWindow('close');
		   
		 $('#groupSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#groupSearchWindow').jqxWindow('close');
		  
		 $('#yomSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#yomSearchWindow').jqxWindow('close');
		
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 		
	});
	
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
	
	function brandSearchContent(url) {
	    $('#brandSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#brandSearchWindow').jqxWindow('setContent', data);
		$('#brandSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function modelSearchContent(url) {
	    $('#modelSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#modelSearchWindow').jqxWindow('setContent', data);
		$('#modelSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupSearchWindow').jqxWindow('setContent', data);
		$('#groupSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function yomSearchContent(url) {
	    $('#yomSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#yomSearchWindow').jqxWindow('setContent', data);
		$('#yomSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
		$("#collectionDiv").load("collectionGrid.jsp?branchval="+$('#cmbbranch').val()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&hidclientcat="+$('#hidclientcat').val()+"&hidclient="+$('#hidclient').val()+"&hidsalesman="+$('#hidsalesman').val()+"&hidbrand="+$('#hidbrand').val()+"&hidmodel="+$('#hidmodel').val()+"&hidgroup="+$('#hidgroup').val()+"&hidyom="+$('#hidyom').val()+"&excelexport=EXCEL");
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
		        	  
		        	  var branch = $('#cmbbranch').val();
		     		  var fromdate = $('#fromdate').val();
		     		  var todate = $('#todate').val();
		     		  var group = $('#cmbgroup').val();
		     		  var distribution = $('#cmbdistribution').val();
		     		  var hidclientcat = $('#hidclientcat').val();
		     	      var hidclient = $('#hidclient').val();
		     	      var hidsalesman = $('#hidsalesman').val();
		     	      var hidbrand = $('#hidbrand').val();
		     	      var hidmodel = $('#hidmodel').val();
		     	      var hidgroup = $('#hidgroup').val();
		     	      var hidyom = $('#hidyom').val();
		        	  
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  $("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&distribution="+distribution+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=2");
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function funreload(event){
		 var branch = $('#cmbbranch').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var group = $('#cmbgroup').val();
		 var hidclientcat = $('#hidclientcat').val();
	     var hidclient = $('#hidclient').val();
	     var hidsalesman = $('#hidsalesman').val();
	     var hidbrand = $('#hidbrand').val();
	     var hidmodel = $('#hidmodel').val();
	     var hidgroup = $('#hidgroup').val();
	     var hidyom = $('#hidyom').val();

	     if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }

	     if($('#cmbgroup').val()!='' && $('#cmbdistribution').val()==''){
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		$("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=1");
	    		
	    } 
	     
	     else if($('#cmbdistribution').val()!=''){
	    		if($('#cmbdistribution').val()=='quarterwise'){
	    			var d1=$('#fromdate').jqxDateTimeInput('getDate');
	       		 	var d2=$('#todate').jqxDateTimeInput('getDate');
	       		 	months = (d2.getFullYear() - d1.getFullYear()) * 12;
	       		    months -= d1.getMonth() + 1;
	       		    months += d2.getMonth();
	       		    months=months <= 0 ? 0 : months;
	       		    
	       		    if(months<3){
	       		    	$.messager.alert('Message','Quarterwise Must Contain Minimum 3 Months.','warning');
	       		    	return false;
	       		    }
	    		}
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		getGridColumnCalculation(fromdate,todate);
	    		
	    	 }
	    	 else{
	    		 $("#overlay, #PleaseWait").show();$('#collectionDiv').show();$('#analysisDiv').hide();
	    		 
	    		 $("#collectionDiv").load("collectionGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom);	 
	    	 }
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

	function getBrand(){
		brandSearchContent('brandSearch.jsp?id=1');
	}

	function getModel(){
		modelSearchContent('modelSearch.jsp?id=1');
	}

	function getGroup(event){
		 groupSearchContent('groupSearch.jsp?id=1');
	}
	
	function getYom(event){
		 yomSearchContent('yomSearch.jsp?id=1');
	}
	
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="salesman"){
			getClientSalesman();
		}
		else if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else{}
	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			document.getElementById("searchdetails").value="";document.getElementById("clientcat").value="";document.getElementById("hidclientcat").value="";
			document.getElementById("searchdetails").value=document.getElementById("client").value;
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
		}
		else if(value=="client"){
			document.getElementById("searchdetails").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
		}
		else if(value=="salesman"){
			document.getElementById("searchdetails").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
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
		  
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("group").value="";document.getElementById("hidgroup").value="";document.getElementById("model").value="";
		document.getElementById("hidmodel").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";
		document.getElementById("yom").value="";document.getElementById("hidyom").value="";document.getElementById("brand").value="";
		document.getElementById("hidbrand").value="";
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
                            <td class="label-cell">Grouping</td>
                            <td>
                                <select name="cmbgroup" id="cmbgroup">
                                    <option value="">--Select--</option>
                                    <option value="clientcat">Client Category</option>
                                    <option value="client">Client</option>
                                    <option value="salesman">Salesman</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Distribution</td>
                            <td>
                                <select name="cmbdistribution" id="cmbdistribution">
                                    <option value="">--Select--</option>
                                    <option value="1">Branchwise</option>
                                    <option value="2">Monthwise</option>
                                    <option value="3">Quarterwise</option>
                                    <option value="4">Yearwise</option>
                                    <option value="5">Client Category</option>
                                    <option value="6">Salesman</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Search by</td>
                            <td>
                                <div class="inline-action-row">
                                    <select name="searchby" id="searchby">
                                        <option value="">--Select--</option>
                                        <option value="client">Client</option>
                                        <option value="clientcat">Client Category</option>
                                        <option value="salesman">Salesman</option>
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
                    <input type="hidden" name="clientcat" id="clientcat">
                    <input type="hidden" name="hidclientcat" id="hidclientcat">
                    <input type="hidden" name="client" id="client">
                    <input type="hidden" name="hidclient" id="hidclient">
                    <input type="hidden" name="group" id="group">
                    <input type="hidden" name="hidgroup" id="hidgroup">
                    <input type="hidden" name="model" id="model">
                    <input type="hidden" name="hidmodel" id="hidmodel">
                    <input type="hidden" name="salesman" id="salesman">
                    <input type="hidden" name="hidsalesman" id="hidsalesman">
                    <input type="hidden" name="yom" id="yom">
                    <input type="hidden" name="hidyom" id="hidyom">
                    <input type="hidden" name="brand" id="brand">
                    <input type="hidden" name="hidbrand" id="hidbrand">

                </div>
            </div>
        </div>

        <!-- Main Grid / Data Section -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="collectionDiv"><jsp:include page="collectionGrid.jsp"></jsp:include></div>
                <div id="analysisDiv" hidden="true"><jsp:include page="collectionAnalysisGrid.jsp"></jsp:include></div>
            </div>

            <div class="summary-footer">
                <label>Net Amount :</label>
                <input type="text" id="txtnetamount" name="txtnetamount" value='<s:property value="txtnetamount"/>'/>
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
    <div id="brandSearchWindow">
        <div></div><div></div>
    </div>
    <div id="modelSearchWindow">
        <div></div><div></div>
    </div>
    <div id="groupSearchWindow">
        <div></div><div></div>
    </div>
    <div id="yomSearchWindow">
        <div></div><div></div>
    </div>

</div>
</body>
</html>