 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>


	<script type="text/javascript">
	$(document).ready(function () {
 		document.getElementById("txtcosttype").value=$('#cmbcosttype').val();
 		if(($("#cmbcosttype option:selected").text().trim()=='Fleet')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Reg No";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='AMC')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='SJOB')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='Ticket No')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Site";
 		} else if(($("#cmbcosttype option:selected").text().trim()=='Job card')){
 			$('#txtregno').attr('readonly', false );
 			document.getElementById("lblregnositename").innerText="Reg No";
 		}else {
 			$('#txtregno').attr('readonly', true );
 			document.getElementById("lblregnositename").innerText="Reg No";
 		}
	}); 

 	function loadSearch() {

 		var costCode=document.getElementById("txtcostcodes").value;
 		var RegNo=document.getElementById("txtregno").value;
 		var type=document.getElementById("txtcosttype").value;
 		var costCodeName=document.getElementById("txtcostcodesname").value;
 		var check = 1;
 		//alert(type);
 		//alert($("#cmbcosttype option:selected").text().trim());
		getdata(type,costCode,costCodeName,RegNo,check);
	}
 	
	function getdata(type,costCode,costCodeName,RegNo,check){
		 $("#refreshdiv").load('costCodeDetailsSearchGrid.jsp?type='+type+'&costCode='+costCode+'&costCodeName='+costCodeName.replace(/ /g, "%20")+'&RegNo='+RegNo.replace(/ /g, "%20")+'&check='+check);
		}

	</script>
<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table>

            <tr>

                <td align="right" width="8%">Cost Code</td>
                <td width="27%">
                    <input type="text"
                           name="txtcostcodes"
                           id="txtcostcodes"
                           style="width:100%;"
                           value='<s:property value="txtcostcodes"/>'>
                </td>

                <td align="right" width="8%">
                    <label name="lblregnositename" id="lblregnositename"></label>
                </td>

                <td width="27%">
                    <input type="text"
                           name="txtregno"
                           id="txtregno"
                           style="width:100%;"
                           value='<s:property value="txtregno"/>'>

                    <input type="hidden"
                           name="txtcosttype"
                           id="txtcosttype"
                           value='<s:property value="txtcosttype"/>'>
                </td>

                <td width="20%" align="left" style="padding-left:8px;">
                    <input type="button"
                           name="btnsearch"
                           id="btnsearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <tr>

                <td align="right">Name</td>

                <td colspan="4">
                    <input type="text"
                           name="txtcostcodesname"
                           id="txtcostcodesname"
                           style="width:100%;"
                           value='<s:property value="txtcostcodesname"/>'>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="costCodeDetailsSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>