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

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

	function loadFillSearch() {

 		var driverName=document.getElementById("txtfillpartyname").value;
 		var contactNo=document.getElementById("txtfillcontactno").value;
 		
		getdata(driverName,contactNo);
	}
	function getdata(driverName,contactNo){
		 $("#refreshdiv").load('driverDetailsMultiSearchGrid.jsp?drivername='+driverName.replace(/ /g, "%20")+'&contactno='+contactNo+'&id=1');
		}
	
	function loadSearchSelect(){
		
		var rows = $("#driverDetailsMultiSearch").jqxGrid('getrows');
		
		var selectedrows=$("#driverDetailsMultiSearch").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var tempdrivername="",tempdrid="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==0){
						tempdrivername=rows[i].name;
						tempdrid=rows[i].dr_id;
					}
					else{
						tempdrivername=tempdrivername+","+rows[i].name;
						tempdrid=tempdrid+","+rows[i].dr_id;
					}
					tempdrivername1=tempdrivername;
					tempdrid1=tempdrid;
				k++;	
				j++; 
			  }
            }
	    $('#txtselecteddrname').val(tempdrivername1);
	    $('#txtselecteddrdocno').val(tempdrid1);
	    
	    $('#driverDetailsWindow').jqxWindow('close'); 
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right" style="font-size:9px;">Name</td>
    <td colspan="2"><input type="text" name="txtfillpartyname" id="txtfillpartyname" style="width:100%;height:20px;" value='<s:property value="txtfillpartyname"/>'></td>
    <td  align="right" style="font-size:9px;">Contact No.</td>
    <td  ><input type="text" name="txtfillcontactno" id="txtfillcontactno" style="height:20px;" value='<s:property value="txtfillcontactno"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadFillSearch();">&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btnsearchselectok" id="btnsearchselectok" class="myButton" value="OK"  onclick="loadSearchSelect();"></td>
  </tr>
  <tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include page="driverDetailsMultiSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>