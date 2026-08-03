

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

<style type="text/css">
    .master-container {
        display: flex;
        height: 100%;
        width: 100%;
        box-sizing: border-box;
    }
    .sidebar-filters {
        flex: 0 0 330px;
        width: 330px;
        height: 100%;
        background: #fff;
        box-sizing: border-box;
        overflow-y: auto;
    }
    .sidebar-scroll-content {
        padding: 12px;
        box-sizing: border-box;
    }
    .filter-card {
        background: #ffffff;
        border: 1px solid #e1e8ed;
        border-radius: 6px;
        padding: 12px;
        margin-bottom: 12px;
        box-sizing: border-box;
    }
    .filter-table {
        width: 100%;
        border-collapse: collapse;
    }
    .filter-table td {
        padding: 4px 6px;
        box-sizing: border-box;
    }
    .label-cell {
        font-size: 12px;
        font-weight: 600;
        color: #4e5e71;
        text-align: right;
        white-space: nowrap;
    }
    .filter-table input[type="text"],
    .filter-table select {
        width: 100%;
        height: 24px;
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 12px;
        box-sizing: border-box;
    }
    .main-content-wrapper {
        flex: 1 1 auto;
        height: 100%;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
        min-width: 0;
    }
    .top-toolbar-container {
        width: 100%;
        padding: 10px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e1e8ed;
        box-sizing: border-box;
        flex-shrink: 0;
    }
    .scrollable-grid-area {
        flex: 1 1 auto;
        overflow-y: auto;
        box-sizing: border-box;
        padding: 10px 15px;
    }
    .button-row {
        text-align: center;
        padding: 4px 6px;
    }
    .btn-submit,
    .myButton {
        height: 30px;
        padding: 0 12px;
        border-radius: 4px;
        font-size: 13px;
        line-height: 30px;
        background: #2563eb;
        color: #fff;
        border: none;
        cursor: pointer;
    }
    .btn-submit:hover,
    .myButton:hover {
        background: #1d4ed8;
    }
    .hidden-fields {
        display: none;
    }
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	 $("#dateDue").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});

});

function funExportBtn(){
	JSONToCSVCon(garagefolupexcel, 'Garage Followup Details', true);
	 }
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}


function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	
 
	  $("#duedatediv").load("mainGrid.jsp?barchval="+barchval);
		 $("#duedetailsgrid").jqxGrid('clear');
	
	}
	


function funchangeinfo()
{
	
	
	
  if($('#cmbinfo').val()==25)
	  {
	 
	 $('#dateDue').jqxDateTimeInput({ disabled: false});
	
		$('#dateDue').jqxDateTimeInput('focus'); 
	 
	  }
  else if($('#cmbinfo').val()==26)
  {
 
 $('#dateDue').jqxDateTimeInput({ disabled: false});
 
	$('#dateDue').jqxDateTimeInput('focus'); 
  }
  else
	  {
	  
	  }
	 
	
	}
function disitems()
{
	
	 $('#dateDue').jqxDateTimeInput({ disabled: true});
	 
	 
	 
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	

	
}
	function funupdate()
	{
		
		
		 if(document.getElementById("cmbinfo").value=="")
		 {
			 $.messager.alert('Message','Select Process ','warning');   
						 
			 return 0;
		 }
		
		 if($('#remarks').val()=="")
		 {
			 $.messager.alert('Message','Enter Remarks ','warning');   
			
			 
			
			 return 0;
		 }
		 
		 var remarkss = document.getElementById("remarks").value;
		 var nmax = remarkss.length;
			
			
	      if(nmax>99)
	   	   {
	   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
	   	
				return false; 
	   	   
	   	 
	   	 
	   	   } 
	      
	    var fleetno=document.getElementById("fleetno").value;
    	var grgid=document.getElementById("grgid").value;
	      
	       var rentaldocno = document.getElementById("rentaldoc").value;
		 var branchids = document.getElementById("branchids").value;
		 var remarks = document.getElementById("remarks").value;
		 var cmbinfo = document.getElementById("cmbinfo").value;
		 var exdate =  $('#dateDue').val();
		
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid);	
		     	}
			     });
		
		
		
	}
	function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid)
	{
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
	     			
				var items=x.responseText;
				 document.getElementById("fleetno").value="";
				 document.getElementById("rentaldoc").value="";
				 document.getElementById("branchids").value="";
				 document.getElementById("remarks").value="";
				 document.getElementById("cmbinfo").value="";
				  document.getElementById("fleetno").value="";
	        	  document.getElementById("grgid").value="";
				  $('#dateDue').val(new Date());
				 
				
				 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			   
			     });
				 funreload(event); 
				 $("#duedetailsgrid").jqxGrid('clear');
				 disitems();
				 
				
				}
			
		}
			
	x.open("GET","savemaint.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&fleetno="+fleetno+"&grgid="+grgid,true);

	x.send();
			
	}
	
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- Sidebar filters (Bug 2: no <table> wrapper, flex: 0 0 330px) -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Fleet NO</td>
                        <td align="left"><input type="text" id="fleetno" name="fleetno" value='<s:property value="fleetno"/>' readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Process</td>
                        <td align="left">
                            <select name="cmbinfo" id="cmbinfo" value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td align="left"><div id='dateDue' name='dateDue' value='<s:property value="dateDue"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td align="left"><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="button-row">
                            <input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="UPDATE" onclick="funupdate()">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Main content: heading.jsp moved to top toolbar (Bug 1) -->
    <div class="main-content-wrapper">
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
        <div class="scrollable-grid-area">
            <div id="duedatediv"><jsp:include page="mainGrid.jsp"></jsp:include></div>
            <div id="detaildiv"><jsp:include page="detailgrid.jsp"></jsp:include></div>
        </div>
    </div>

</div>

<!-- Hidden fields pulled out of layout flow (Bug 6) -->
<div class="hidden-fields">
    <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>'>
    <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>'>
    <input type="hidden" name="grgid" id="grgid" value='<s:property value="grgid"/>'>
    <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
</div>

</div>
</div>
</body>
</html>
