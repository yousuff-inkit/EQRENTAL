 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

	function loadSearchs() {
		 
 		var fleetno=document.getElementById("searchfleetno").value;
 		var regno=document.getElementById("regno").value;
 		var flnames=document.getElementById("flname").value;
 		var color=document.getElementById("color").value;
 		var group=document.getElementById("group").value;
 		var masterrefno=$('#masterrefno').val();
 		var flname = flnames.replace(/ /g, "%20");
		var branch=$('#cmbbranch').val();
	    var aa="1";
		getdata(fleetno,regno,flname,color,group,aa,masterrefno,branch);
	}
	function getdata(fleetno,regno,flname,color,group,aa,masterrefno,branch){
		
		 $("#refreshdivs").load('fleetSearchGrid.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&id='+aa+'&masterrefno='+masterrefno+'&branch='+branch);

		}
function loadSearchSelect(){
		
		var rows = $("#jqxfleetsearch").jqxGrid('getrows');
		
		/* if($('#hidbalqty').val()<rows.length){
			 $.messager.alert('Warning','Selected number of vehicles is greater than balance quantity');
			 return false;
		 } */
		
		var selectedrows=$("#jqxfleetsearch").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var fleetno="",fleetno1="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==0){
						fleetno=rows[i].fleet_no;
					}
					else{
						fleetno=fleetno+","+rows[i].fleet_no;
					}
					fleetno1=fleetno;
				k++;	
				j++; 
			  }
            }
	    $('#fleetid').val(fleetno1);
	    $('#fleet').val(fleetno1);
	    $('#fleetToWindow').jqxWindow('close'); 
	}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="6%"><span class="branch" style="background:transparent;">Fleet</span></td> 
    <td align="left" ><input type="text" name="searchfleetno" id="searchfleetno"  style="width:90%;height:18px;" value='<s:property value="searchfleetno"/>'></td>
    <td align="right" width="14%"><span class="branch" style="background:transparent;">Reg No</span></td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>' style="height:18px;"></td>
    
   <td align="right"  width="14%"><span class="branch" style="background:transparent;">Name</span></td>
    <td align="left"  width="30%"><input type="text" name="flname" style="width:90%;height18px;" id="flname" value='<s:property value="flname"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table >
  <tr>
   <td align="right" width="6%"><span class="branch" style="background:transparent;">Color</span></td>
    <td align="left" ><input type="text" name="color"  style="width:90%;height:18px;" id="color" value='<s:property value="color"/>'>
    <td align="right" width="14%"><span class="branch" style="background:transparent;">Group</span></td>
    <td align="left"><input type="text" name="group" id="group" value='<s:property value="group"/>'  style="height:18px;"></td>
    <td align="left"  width="14%"></td>
    <td align="left"  width="30%">
    	<input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();">&nbsp;&nbsp;
    	<input type="button" name="btnok" id="btnok" class="myButton" value="OK"  onclick="loadSearchSelect()">
    </td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="fleetSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>