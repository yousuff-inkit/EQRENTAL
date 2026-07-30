 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />


<script type="text/javascript">
	$(document).ready(function () {
/* 		 if(document.getElementById("txtforsearch").value=="2"){
		   document.getElementById("txtatypes").value=document.getElementById("cmbtype").value;
		}
		else if(document.getElementById("txtforsearch").value=="3"){
			   document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;
		}else{
			document.getElementById("txtatypes").value=document.getElementById("cmbtotype").value;
		}
		 document.getElementById("txtdocumenttypes").value=document.getElementById("formdetailcode").value;
		 document.getElementById("txtcreditdebit").value=document.getElementById("txtforsearch").value; */
		 document.getElementById("txtnewdate").value=$('#masterdate').val();
	}); 
	
	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			/* var accounttype=document.getElementById("txtatypes").value;
			var code=document.getElementById("txtdocumenttypes").value;
			var debitcredit=document.getElementById("txtcreditdebit").value; */
			var date=document.getElementById("txtnewdate").value;
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,date,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,date,checked){
		 $("#refreshClientAccountDiv").load("accountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&date='+date+'&check='+checked);
	}

</script>
<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body{
    margin:0;
    background:#fff;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
}

.modern-ui{
    font-size:12px;
    color:#333;
    padding:10px;
    width:100%;
    box-sizing:border-box;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    background:#fff;
    color:#333;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    border-color:#007bff;
    outline:none;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff;
    border:1px solid #BDBDBD;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
    width:100%;
    box-sizing:border-box;
}

/* Table */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px 10px;
    table-layout:fixed;
}

.modern-ui td{
    vertical-align:middle;
}

.modern-ui .lbl-right{
    text-align:right;
    font-weight:600;
    color:#222;
    font-size:12px;
    white-space:nowrap;
    padding-right:6px;
}

/* Button */
.modern-ui .myButton{
    height:26px;
    padding:0 20px;
    background:#0056b3;
    color:#fff;
    border:none;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    transition:all .2s;
}

.modern-ui .myButton:hover{
    background:#004494;
}

/* Grid */
.modern-ui .grid-container{
    border:1px solid #BDBDBD;
    background:#fff;
    overflow:hidden;
    width:100%;
}
</style>

<body style="background:#fff;margin:0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table border="0" cellspacing="0" cellpadding="0">

            <!-- Dynamic widths because Account Name is longer -->
            <colgroup>
                <col width="11%">
                <col width="25%">

                <col width="9%">
                <col width="18%">

                <col width="9%">
                <col width="28%">
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text"
                           name="accountsno"
                           id="accountsno"
                           value='<s:property value="accountsno"/>'>
                </td>

                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text"
                           name="txtcurrencies"
                           id="txtcurrencies"
                           value='<s:property value="txtcurrencies"/>'>

                    <input type="hidden"
                           name="txtatypes"
                           id="txtatypes"
                           value='<s:property value="txtatypes"/>'>

                    <input type="hidden"
                           name="txtdocumenttypes"
                           id="txtdocumenttypes"
                           value='<s:property value="txtdocumenttypes"/>'>
                </td>

                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text"
                           name="clientmobileno"
                           id="clientmobileno"
                           value='<s:property value="clientmobileno"/>'>

                    <input type="hidden"
                           name="txtcreditdebit"
                           id="txtcreditdebit"
                           value='<s:property value="txtcreditdebit"/>'>

                    <input type="hidden"
                           name="txtnewdate"
                           id="txtnewdate"
                           value='<s:property value="txtnewdate"/>'>
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">Account Name</td>

                <td colspan="3">
                    <input type="text"
                           name="accountsname"
                           id="accountsname"
                           value='<s:property value="accountsname"/>'>
                </td>

                <td></td>

                <td align="center">
                    <input type="button"
                           name="btnClientAccountSearch"
                           id="btnClientAccountSearch"
                           class="myButton"
                           value="Search"
                           onclick="loadClientAccountSearch();">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshClientAccountDiv">

            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>