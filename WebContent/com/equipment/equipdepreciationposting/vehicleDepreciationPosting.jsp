<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>
<s:head/>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body, html, #mainBG, .homeContent, form {
    background-color: #ffffff !important; /* Force complete white background */
    background-image: none !important; /* Remove any legacy gradient/image */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: none !important; 
    border: none !important;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
    background-color: #ffffff !important;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui textarea {
    height: 48px !important; 
    resize: none;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus,
.modern-ui textarea:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled,
.modern-ui textarea[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }
form label.error { color:red; font-weight:bold; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#jqxVehDepreciationPostingDate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#jqxVehDepreciationPostingDate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

	     var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	    
	});
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     
	  			     document.getElementById("errormsg").innerText="Depreciation done till "+items[2]+".";
	  			     
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					  $("#overlay, #PleaseWait").show();
	  					  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value);
	  					  $('#txtchkgridload').val('');
	  					  $('#txtgridload').val(1);
	  					  $('#btnExcelExporter').show();
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Depreciation Pending for Last-Month.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Depreciation Already Done.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Depreciation date should be Month-End.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  		}
  		}
  		x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("brchName").value, true);
  		x.send();
    }
	
	 function funReadOnly(){
			$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: true});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: true});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: false});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: false});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#jqxVehDepreciationPostingDate').val(new Date());
				var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				
				$("#jqxvehicleDetails").jqxGrid('clear'); 
				$("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				$("#jqxVehicleAccounts").jqxGrid('clear');
				$("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('vdpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {}
	 
	 function funFocus(){
	    	$('#jqxVehDepreciationPostingDate').jqxDateTimeInput('focus'); 	    		
	 }
	   
	 function funNotify(){	
        	/* Validation */
        	var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
        	if(parseInt(rows[0].acno)>0){
        		document.getElementById("errormsg").innerText="";
        	}else {
        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
        	    return 0;	
        	}
    		
			var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
	        var validdate=funDateInPeriod(paydate);
	         if(validdate==0){
		        return 0;	
	         }
	         
	        var txtdrtotal=parseFloat($('#txtdrtotal').val()==''?0.0:$('#txtdrtotal').val());
	        var txtcrtotal=parseFloat($('#txtcrtotal').val()==''?0.0:$('#txtcrtotal').val());
	        if(txtdrtotal==0.0 || txtcrtotal==0.0){
	        	document.getElementById("errormsg").innerText="";
	        	document.getElementById("errormsg").innerText="Dedit/Credit Total cannot be zero";
	        	return 0;
	        }
    	    
			 var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
			 var length=0;
			 var veharray=new Array();
			 var accarray=new Array();
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].fleet_no;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				        length=length+1;
						veharray.push(rows[i].fleet_no+"::"+rows[i].depr_amt+"::"+rows[i].frmdate+"::"+rows[i].depr+"::"+rows[i].bookvalue+"::");
					}
				}
	 		 $('#gridlength').val(length);
	 		 document.getElementById("vehdetarray").value=veharray;
 		   
	    	 var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
	    	 var journallength=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chks=rows[i].acno;
				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "journal"+journallength)
				    .attr("name", "journal"+journallength)
				    .attr("hidden", "true");
					journallength=journallength+1;
					
				var amount,id;
				if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
					 amount=rows[i].credit*-1;
					 id=-1;
				}
				
				if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
					 amount=rows[i].debit;
					 id=1;
				}
				
				newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
				newTextBox.appendTo('form');
				}
			 }
			 $('#journalgridlength').val(journallength);
    		 return 1;
	} 
	  
	  
	function setValues(){
		  if($('#hidjqxVehDepreciationPostingDate').val()){
				 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput('val', $('#hidjqxVehDepreciationPostingDate').val());
		  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
	      var indexVal = document.getElementById("txttrno").value;
		  if(indexVal>0){
             $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
		  }
         
		  var indexVal1 = document.getElementById("docno").value;
          var indexVal2 = document.getElementById("txttrno").value;
          if(indexVal1>0){
             $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
          } 
	}	
	  
	function funProcessBtn(){
	      var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#jqxVehDepreciationPostingDate').val();
		  getLastMonthDepreciation(date);
	}
	  
	function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#jqxVehDepreciationPostingDate').val();
			  var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  
			  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  
			  var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
			     $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?check=2");
			  }
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
		  }
	}
	  
	function funExcelExporter(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
		 } else {
			 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
		 }
	}
	  
	function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
			 } else {
				 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
			 }
		  }
	}
		
	function funPrintBtn() {
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			 var url=document.URL;
			 reurl=url.split("com/");
		     $("#docno").prop("disabled", false);
		     
			   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
				if (r){
					 var win= window.open(reurl[0]+"printEquipDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				     win.focus();
				 }
				else{
					var win= window.open(reurl[0]+"printEquipDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
				}
			   });
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
		
	function datechange(){
		var date = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
    <form id="frmVehicleDepreciationPosting" action="equipdepreciationposting" method="post" autocomplete="off">
        <jsp:include page="../../../header.jsp"></jsp:include>

        <div class='modern-ui hidden-scrollbar'>
            
            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="jqxVehDepreciationPostingDate" name="jqxVehDepreciationPostingDate" onchange="datechange();" value='<s:property value="jqxVehDepreciationPostingDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidjqxVehDepreciationPostingDate" name="hidjqxVehDepreciationPostingDate" value='<s:property value="hidjqxVehDepreciationPostingDate"/>'/>

                    <button type="button" class="myButton" id="btnProcessing" title="Process" onclick="funProcessBtn();" style="margin-left: 15px;">Process</button>
                    <button type="button" class="myButton" id="btnCalculate" title="Calculate" onclick="funCalculateBtn();" style="margin-left: 10px;">Calculate</button>
                    
                    <button type="button" class="myButton" id="btnExcelExporter" title="Export current Document to Excel" onclick="funExcelExporter();" style="margin-left: 10px; background:transparent; border:none; padding:0; height:24px!important; cursor:pointer; box-shadow:none;">
                        <img alt="Export Excel" src="<%=contextPath%>/icons/excel_new.png" style="height:20px; vertical-align:middle;">
                    </button>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                    <input type="text" id="docno" name="txtjvno" value='<s:property value="txtjvno"/>' tabindex="-1" style="width:120px;" readonly />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Details</span>
                <div id="vehiclesDetailsDiv" class="grid-container">
                    <jsp:include page="vehiclesDetailsGrid.jsp"></jsp:include>
                </div>
                
                <div class="field-row" style="justify-content: flex-end; margin-top: 10px;">
                    <label class="lbl-right" style="width:100px;">Depr. Total</label>
                    <input type="text" id="txtdeprtotal" name="txtdeprtotal" style="width:120px; text-align:right; font-weight:bold;" value='<s:property value="txtdeprtotal"/>' tabindex="-1" readonly />
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Accounts</span>
                <div id="accountsDetailsDiv" class="grid-container">
                    <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
                </div>
                
                <div class="field-row" style="justify-content: flex-end; margin-top: 10px;">
                    <label class="lbl-right" style="width:100px;">Dr. Total</label>
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:120px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly />

                    <label class="lbl-right" style="width:100px;">Cr. Total</label>
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:120px; text-align:right; font-weight:bold; color:#0b45a2;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly />
                </div>
            </div>

            <div style="display:none;">
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                <input type="hidden" id="gridlength" name="gridlength"/>
                <input type="hidden" id="journalgridlength" name="journalgridlength"/>
                <input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
                <input type="hidden" id="txtgridload" name="txtgridload"  value='<s:property value="txtgridload"/>'/>
                <input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
                <input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
                <input type="hidden" id="vehdetarray" name="vehdetarray"  value='<s:property value="vehdetarray"/>'/>
            </div>

        </div>
    </form>
</div>
</body>
</html>