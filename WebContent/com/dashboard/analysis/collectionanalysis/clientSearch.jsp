 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
.formfont {
	font: 9px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow: hidden;
}
</style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 
	 $( "#btnok_client" ).click(function() {
  	   
        	var rows = $("#jqxclientsearch").jqxGrid('selectedrowindexes');
        if(rows!=""){
     	 	if(document.getElementById("searchdetails").value==""){
	           		document.getElementById("searchdetails").value="Client";	
	           		document.getElementById("client").value="Client";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nClient";
	           		document.getElementById("client").value+="\nClient";
	           	}
        }
       
        	
        	document.getElementById("hidclient").value="";
        	
        	for(var i=0;i<rows.length;i++){
        		var dummy=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'refname');
        		var docno=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'cldocno');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("client").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidclient").value=docno;
        		}
        		else{
        			document.getElementById("hidclient").value+=","+docno;
        		}
        	}
        	$('#clientSearchWindow').jqxWindow('close');
	});


$( "#btncancel_client" ).click(function() {
		$('#clientSearchWindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
		var branch=document.getElementById("cmbbranch").value;
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientSearchGrid.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch);
	
		}

	</script>
<style type="text/css">
/* =========================================================
   SCOPED UI: Master Search UI
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa;
}

/* Main Wrapper */
#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

/* Search Panel */
#search.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 15px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Grid Panel */
#search.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table */
#search.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 4px 10px;
}

#search.modern-ui td {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    vertical-align: middle;
}

/* Labels */
#search.modern-ui td[align="right"] {
    color: #000 !important;
    font-weight: normal !important;
    white-space: nowrap;
    padding-right: 5px;
}

/* Textboxes */
#search.modern-ui input[type="text"] {
    width: 100%;
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    font-size: 12px !important;
    font-family: 'Segoe UI', Arial, sans-serif !important;
    background: #fff !important;
}

#search.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0,123,255,.10);
}

/* jqx Date Input */
#dr_DOB{
    height:24px !important;
    border:1px solid #b8c6d8;
    border-radius:3px;
    background:#fff;
}

/* Buttons */
#search.modern-ui .myButton{
    width:80px !important;
    height:24px !important;
    line-height:22px !important;
    padding:0 15px !important;
    font-size:11px !important;
    font-weight:700 !important;
    font-family:'Segoe UI',Arial,sans-serif !important;
    color:#fff !important;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%) !important;
    border:1px solid #083a8a !important;
    border-radius:3px;
    cursor:pointer;
    text-transform:uppercase;
}

#search.modern-ui .myButton:hover{
    background:linear-gradient(135deg,#083a8a 0%,#1d4ed8 100%) !important;
}

#refreshdiv{
    margin-top:5px;
}
</style>

</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <!-- ================= Row 1 ================= -->

            <tr>

                <td align="right" width="8%">Name</td>
                <td width="28%">
                    <input type="text"
                           name="Cl_name"
                           id="Cl_name"
                           value='<s:property value="Cl_name"/>'>
                </td>

                <td align="right" width="8%">License#</td>
                <td width="18%">
                    <input type="text"
                           name="dr_Licence"
                           id="dr_Licence"
                           value='<s:property value="dr_Licence"/>'>
                </td>

                <td align="right" width="8%">Passport#</td>
                <td width="18%">
                    <input type="text"
                           name="dr_Passport"
                           id="dr_Passport"
                           value='<s:property value="dr_Passport"/>'>
                </td>

                <td width="12%" align="left">
                    <input type="button"
                           id="btnrasearch"
                           name="btnrasearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <!-- ================= Row 2 ================= -->

            <tr>

                <td align="right">Nationality</td>
                <td>
                    <input type="text"
                           id="dr_Nation"
                           name="dr_Nation"
                           value='<s:property value="dr_Nation"/>'>
                </td>

                <td align="right">Mobile</td>
                <td>
                    <input type="text"
                           name="Cl_mob"
                           id="Cl_mob"
                           value='<s:property value="Cl_mob"/>'>
                </td>

                <td align="right">DOB</td>
                <td>
                    <div id="dr_DOB"
                         name="dr_DOB"
                         value='<s:property value="dr_DOB"/>'>
                    </div>

                    <input type="hidden"
                           name="hiddr_DOB"
                           id="hiddr_DOB"
                           value='<s:property value="hiddr_DOB"/>'>
                </td>

                <td align="left">
                    <button type="button"
                            id="btnok_client"
                            name="btnok"
                            class="myButton">
                        OK
                    </button>
                </td>

            </tr>

            <!-- ================= Row 3 ================= -->

            <tr>

                <td colspan="6"></td>

                <td align="left">
                    <button type="button"
                            id="btncancel_client"
                            name="btncancel"
                            class="myButton">
                        Cancel
                    </button>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="clientSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>