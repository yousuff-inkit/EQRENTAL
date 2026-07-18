<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: #ffffff !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff !important;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: none; 
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
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

/* Page Specific Original CSS */
#convformula { text-transform: uppercase; }
#normalrate { text-transform: uppercase; }
#ot { text-transform: uppercase; }
#holidayot { text-transform: uppercase; }

/* Sub-panel layout (from tables) */
.sub-panel-flex {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}
.sub-panel-flex > div {
    flex: 1;
    min-width: 300px;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Allowance(ALC)";
		document.getElementById("formdetail").value="Allowance";
		document.getElementById("formdetailcode").value="ALC";
		window.parent.formCode.value="ALC";
		window.parent.formName.value="Allowance";
		
	    $("#allowancedate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    	
		if($('#mode').val()!= "view") {
			  	 $('#accountSearchwindow').jqxWindow('open');
			  	  accountSearchContent('accountsDetailsSearch.jsp');
		    	 }
		  });   
		   
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'code', type: 'String'  },
     						{name : 'allowance', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                          	
                 ],
               		localdata: alcdata,

               	 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
                                         
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            	$("#allowancegrid").jqxGrid(
                    {
                    	width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			showfilterrow: true,
                        filterable: true,
                        
                        columns: [
									{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
									{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
									{ text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
									{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
									{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
									{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
									{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
									{ text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
            					]
                    });
            	
         $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                
            });   
        });

	function funSearchLoad(){
		 changeContent('allowancessearch.jsp'); 
	 }
 
     function accountSearchContent(url) {
        
          $.get(url).done(function (data) {
          	$('#accountSearchwindow').jqxWindow('setContent', data);
  	      }); 
      	}
  	  
	function funReadOnly() {
		$('#frmallowance input').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmallowance input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#acno').attr('readonly', true);
		$('#accname').attr('readonly', true);
		$('#allowancedate').jqxDateTimeInput({ disabled: false});
		
		if ($("#mode").val() == "A") {
			 $('#allowancedate').val(new Date());
		}
	}
 
	function setValues() {
		if($('#datehidden').val()){
			$("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
		
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	   	
	     if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	 	accountSearchContent('accountsDetailsSearch.jsp');    
	 	 }
	 	 else{}
	 		}
	 	 }
 
	     function funNotify(){
	        	if(document.getElementById("allowance").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Allowance";
        		document.getElementById("allowance").focus();
        		return 0;
        		}
	        	
	        	
	        	if(document.getElementById("acno").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Search Account";
        		document.getElementById("acno").focus();
        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    		$('#allowancedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onLoad="setValues();" > 

<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
 
<fieldset><legend>Allowance Details</legend>
<table width="100%">
		<tr><td width="7%"  align="right">Date</td>  
		<td width="12%" align="left"><div id="allowancedate" name="allowancedate" value='<s:property value="allowancedate"/>'> </div></td>
	  	<td width="9%" align="right">Allowance</td>
	  	<td width="14%"><input type="text" name="allowancecode" id="allowancecode" style="width:100%;" placeholder="Allowance Code" value='<s:property value="allowancecode"/>'></td>
        <td  width="5%" align="right">Name</td>
        <td  width="31%"><input type="text" name="allowance" id="allowance" style="width:99%;" placeholder="Allowance Name" value='<s:property value="allowance"/>'></td>
		<td width="8%" align="right">Doc No</td>
		<td width="14%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
	</tr> 
	<tr><td align="right">Account</td> 
		<td  colspan="7" ><input type="text" name="acno" id="acno" readonly   placeholder="Press F3 To Search"  onKeyDown="getaccountdetails(event);"  value='<s:property value="acno"/>' > 
		&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="accname" id="accname" style="width:61%;" readonly value='<s:property value="accname"/>' ></td></tr>
	<tr><td align="right">Remarks</td>
		<td colspan="7"><input type="text" name="remarks" id="remarks"  style="width:76%;" placeholder="Remarks" value='<s:property value="remarks"/>' ></td></tr>
</table>
	 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
<input type="hidden" name="accdocno" id="accdocno"       value='<s:property value="accdocno"/>' >
	
</fieldset> 
</form>

<table width="100%">
    <tr><td><div id="allowancegrid"></div></td></tr>
</table><br/>
		 
  <div id="accountSearchwindow">
	   <div ></div>
	</div>	

</body>
</html>