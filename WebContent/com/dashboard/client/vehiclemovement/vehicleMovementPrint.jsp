<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.taleveh {
    border: 1px solid black;
    border-collapse: collapse;
    font-size: 9px;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleMov" action="printVehicleMov" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table  width="65%" align="center" >
    <tr><td>
  	
   <fieldset><legend><b>Client Details</b></legend>
   
        <table  width="98%"  align="center" cellspacing="3">
        
    <tr>
      <td width="10%" align="left"><b>Code</b></td>
    <td width="10%" colspan="4" ><b>: </b><s:property value="lblcode"/></td>
    <td width="10%">&nbsp;</td>
      <td width="12%" align="left"><b>Name </b></td>
      
    <td width="30%" colspan="4"><b>: </b><s:property value="lblname"/> </td>
    
    </tr>    
        
    
    <tr>
    <td width="10%" align="left"><b>Mob No </b></td>
    <td width="10%" colspan="4"><b>: </b><s:property value="lblmobno"/></td>
   
	<td width="10%">&nbsp;</td>
    <td width="12%" align="left"><b>Mail </b></td>
    <td width="30%" colspan="4"><b>: </b><s:property value="lblmail"/></td>
    </tr>
    
    </table>
 </fieldset>
</td>
    </tr>
    
    </table>
</br>

<table width="98%" class=taleveh align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="4%" align="left" class=taleveh><b>Type</b></td>
    <td width="4%" align="left" class=taleveh><b>Ref NO</b></td>
    <td width="15%" align="left" class=taleveh><b>Name</b></td>
    <td width="5%" align="left" class=taleveh><b>Reg No</b></td>
    
    <td width="5%" align="left" class=taleveh><b>Date</b></td>
    <td width="5%" align="left" class=taleveh><b>Repl No</b></td>
    
    <td width="3%" align="left" class=taleveh><b>Status</b></td>
    <td width="9%" align="left" class=taleveh><b>Trancode</b></td>
    <td width="6%" align="left" class=taleveh><b>Branch Out</b></td>
    <td width="6%" align="left" class=taleveh><b>Date Out</b></td>
    <td width="6%" align="left" class=taleveh><b>Time Out</b></td>
    <td width="4%" align="left" class=taleveh><b>KM Out</b></td>
    <td width="5%" align="left" class=taleveh><b>Fuel Out</b></td>
    <td width="5%" align="left" class=taleveh><b>Branch In</b></td>
    <td width="5%" align="left" class=taleveh><b>Date In</b></td>
    <td width="4%" align="left" class=taleveh><b>Time In</b></td>
    <td width="4%" align="left" class=taleveh><b>KM In</b></td>
    <td width="13%" align="left" class=taleveh><b>Fuel In</b></td>
  </tr>
  
  <s:iterator var="stat" value='#request.printingarray' >
	<tr height="20" class='taleveh'>   
	<%int i=1; %>
			<s:iterator status="arr" value="#stat.split('::')" var="des">  
			<%if (i<=18) {%>
				<td class='taleveh' align="left">
				  <s:property value="#des"/>
		  		</td> 
			<%i++;}%>
    		
  		</s:iterator>
	</tr>
	</s:iterator>
 
 </table>
 
 
 <br/><br/>
<fieldset width="98%"><legend><b>Summary</b></legend>
<table width="100%" class='taleveh' align="center">
<tr height="25" style="background-color: #F6CECE;">
    <td width="15%" align="left" class='taleveh'><b>Type</b></td>
    <td width="30%" align="left" class='taleveh'><b>Tran Code</b></td>
    <td width="15%" align="left" class='taleveh'><b>Total Hours</b></td>
    <td width="15%" align="left" class='taleveh'><b>Total Fuel</b></td>
    <td width="15%" align="left" class='taleveh'><b>Total Km</b></td>
    </tr>
  
  <s:iterator var="stat1" value='#request.vehsumarray' >
	<tr height="20" class='taleveh'>   
			<s:iterator status="arr" value="#stat1.split('::')" var="des1">   
    		<td class='taleveh' align="left">
		  <s:property value="#des1"/>
  		</td>
  		</s:iterator>
	</tr>
	</s:iterator>
 
 </table>
 </fieldset>
 
 
 
 
 
 
 <br/>

<br/>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>