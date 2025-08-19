<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<% String contextPath=request.getContextPath();%>
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}

</style>
  
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $("#deliveryTime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
    
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 $('#clientSearchWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientSearchWindow').jqxWindow('close');
	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close');
	 
	 $("#clientname").dblclick(function(){
			
		 clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/nipurchase/nisalesreport/clientSearch.jsp");

		});
	 $('#acno').dblclick(function(){
	 	 
 		  
		  $('#accountDetailsWindow').jqxWindow('open');
		 commenSearchContent('accountsDetailsSearch.jsp?');
		    
		   
	  }); 
});

function searchClient(){
	var x= event.keyCode;
	if(x==114){
			clientSearchContent(<%=contextPath+"/"%>+"com/dashboard/nipurchase/nisalesreport/clientSearch.jsp");
	
	
	}
}

function clientSearchContent(url) {
 	$('#clientSearchWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientSearchWindow').jqxWindow('setContent', data);
	$('#clientSearchWindow').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{	
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var type=$('#cmbtype').val();

    $("#overlay, #PleaseWait").show();
    
		$("#griddiv").load("nisalesreportGrid.jsp?id=1&fromdate="+fromdate+"&todate="+todate+"&client="+$('#cldocno').val()+"&type="+type);
	
}
function funExportBtn(){
	
	 JSONToCSVCon(rdatas, 'NI Sales Report', true);
}

function funClearData(){
	$('input[type=text],[type=hidden]').val('');
	$('#fromdate').jqxDateTimeInput('setDate',new Date());
	$('#todate').jqxDateTimeInput('setDate',new Date());
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 

}

function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('accountsDetailsSearch.jsp?');
	 }
	 }   
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
	} 

function funCreateOutSourceJob(){
	var gridarray=new Array();
	var rowarray=new Array();
	var nwarray=new Array();
	var costtype=$('#hidcosttype').val();
	var costcode=$('#hidcostcode').val();
	var salid=$('#hidsalid').val();
	var lpono=$('#hidlpono').val();
	var acno=$('#acno').val();
	var deltime=$('#deliveryTime').val();
	var docdate=$('#outdate').val();
	$("#reportGridDiv").jqxGrid("clearfilters");
	var selectrows=$('#reportGridDiv').jqxGrid('selectedrowindexes');
	var rows=$('#reportGridDiv').jqxGrid('getrows');
	var trno ="";
	//alert("select rows====="+selectrows);
	 for( var j=0;j<selectrows.length;j++){
		var f=selectrows[j];
		//alert("rowno====="+rows[f].rowno);
		if(j==0){
			rowarray.push(rows[f].rowno+"::");
		}
		else{
			rowarray.push(rows[f].rowno+"::");
			}
	} 
	 var nwdocs="";
	//alert("rowarray====="+rowarray);
	 for( var i=0;i<selectrows.length;i++){
		 var g=selectrows[i];
		 var docs="";
		 var custrepl=rows[g].customername;
		// alert("beforereplace=="+custrepl);
		 $('#hidcomments').val(custrepl);
		 if (($(hidcomments).val()).includes('$')) { $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));};if (($(hidcomments).val()).includes('%')) { $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));};
		 if (($(hidcomments).val()).includes('^')) { $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));};if (($(hidcomments).val()).includes('`')) { $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));};
		 if (($(hidcomments).val()).includes('~')) { $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));};
		 if (($(hidcomments).val()).includes(',')) { $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));};if (($(hidcomments).val()).includes('&')) { $(hidcomments).val($(hidcomments).val().replace(/&/g, ''));};
		
		 if (($(hidcomments).val()).match(/\\/g)) { $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));};
		
			docs=","+rows[g].invno+"Serial-"+rows[g].srno;
			gridarray.push(rows[g].psrno+"::"+rows[g].unitdocno+"::"+rows[g].specid+"::"+rows[g].floor+"::"
		    		+rows[g].flatids+"::"+rows[g].width+"::"+rows[g].height+"::"+rows[g].quantity+"::"
		    		+rows[g].totsqm+"::"+rows[g].totsize+"::"+rows[g].price+"::"+rows[g].bevcode+"::"
		    		+rows[g].bevrate+"::"+rows[g].bevvalue+"::"+rows[g].polcode+"::"+rows[g].polrate+"::"
		    		+rows[g].polcharge+"::"+rows[g].temp+"::"+rows[g].amount+"::"+rows[g].productname+"::"+$('#hidcomments').val()+"::"+rows[g].docno+"::"+rows[g].srno+"::");
	
		nwdocs+=docs;
	} 
	 //document.getElementById("hiddocnos").value=nwdocs;
	 //alert("Docs======"+nwdocs);
	$.messager.confirm('Message', 'Do you want to create job?', function(r){
		if(r==false)
		{
			return false; 
		}
		else
		{
			savegriddata(costtype,costcode,salid,lpono,deltime,docdate,gridarray,acno,rowarray,nwdocs);
		}
	});
	
}

function savegriddata(costtype,costcode,salid,lpono,deltime,docdate,gridarray,acno,rowarray,nwdocs)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items=x.responseText;
		//alert("items===="+items);
		var tmp=items.split("::");
		//alert("items===="+tmp);
		var chk=tmp[0];
		var chk1=tmp[1];
		if(parseInt(chk)>0)
		{
			$.messager.alert('Message', ' Out Source Job No '+chk1+' Successfully Created ');
			/* $("#jqxloaddataGrid").jqxGrid('clear');
			$('#srvdetmtrno').val("");
			$('#audit').attr('disabled',true); */
			funreload(event); 
		}
		else
		{
			$.messager.alert('Message', ' Not Created ');
		}
	}   
	}
	x.open("GET","savedata.jsp?costtype="+costtype+"&costcode="+costcode+"&salid="+salid+"&lpono="+lpono+"&deltime="+deltime+"&docdate="+docdate+"&gridarray="+gridarray+"&acno="+acno+"&gridrowarray="+rowarray+"&hiddocs="+nwdocs,true);
	x.send();
}
</script>

</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">  
<div class='hidden-scrollbar'>                               
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0; height: 520px;">
	<table width="100%" cellspacing="5">
	<jsp:include page="../../heading.jsp"></jsp:include>
		<tr><td  width="10%">&nbsp;</td><td  width="80%">&nbsp;</td></tr>
 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left">
	  <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                    
                    
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left">
      <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>

	<tr><td align="right"><label class="branch">Client</label></td>
	 <td align="left">
	 <input type="text" id="clientname" name="clientname" value='<s:property value="clientname"/>' style="width:72%; height:20px;" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="clientname"/>' style="height: 20px;" onkeydown="searchClient(event);"/>
	 </td></tr>
	 
	 <tr>
     <td colspan="2" align="center" width="100%" >
     <fieldset><legend>Outsource Job Creation</legend>
	 <table width="100%">
	  <tr><td  align="right" ><label class="branch">Date</label></td><td align="left">
	  <div id='outdate' name='outdate' value='<s:property value="outdate"/>'></div>
      <td width="7%"><div id='deliveryTime' name='deliveryTime' style="display:none" value='<s:property value="deliveryTime"/>'></div></td>              </td></tr>
	 <tr><td align="right">
	 <label class="branch">Vendor</label></td>
	<td align="left"><input type="text" id="acno" name="acno" style="width:88%;height:20px;" placeholder="Press F3 To search" readonly="readonly" value='<s:property value="acno"/>' onkeydown="getacc(event);"/></td></tr> 
	<tr><td>&nbsp;</td> 
	<td><input type="text" id="accname" name="accname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="accname"/>' tabindex="-1"/>
     </td></tr>
	<%--  <tr>
    <td align="right"><label class="branch">Type</label></td>
    <td><select name="cmbtype" id="cmbtype" value='<s:property value="cmbtype"/>' style="width:125px;">
    <option value="ctodr">CUTING ORDER</option>
    <option value="dlnot">DELIVERY NOTE</option>
    <option value="ctinv">CUTTING INVOICE</option></select></td>
  </tr>
	 
	 <tr><td align="right"><input type="checkbox" id="chkdetail" name="chkdetail" value='<s:property value="chkdetail"/>'></td>
  <td><label for="detail" class="branch">Detail</label></td></tr> --%>
	 <tr>
	 
	<td colspan="2" align="center">
	 <div style="text-align:center;">
		<input type="button" name="btncreate" id="btncreate" value="Create" class="myButtons" onclick="funCreateOutSourceJob();">&nbsp;
	</div>
    </td> 
	 </tr>
	 </table>
	 </fieldset>
	 </td>
	 </tr>
	 <tr >
	
	<td colspan="2" style="border-top:2px solid #DCDDDE;">
	<div style="text-align:center;"><br>
		<input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">&nbsp;
		
	</div>
    </td>
</tr>
	 </table>
	 </fieldset>
	 </td>
	 <td>
	 <div id="griddiv"><jsp:include page="nisalesreportGrid.jsp"></jsp:include></div>
	 <input type="hidden" id="hidcosttype" name="hidcosttype"  value='<s:property value="hidcosttype"/>'/>
     <input type="hidden" id="hidcostcode" name="hidcostcode"  value='<s:property value="hidcostcode"/>'/>
     <input type="hidden" id="hidsalid" name="hidsalid"  value='<s:property value="hidsalid"/>'/>
	 <input type="hidden" id="hidlpono" name="hidlpono"  value='<s:property value="hidlpono"/>'/>
	<input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>
	<input type="hidden" id="hiddocnos" name="hiddocnos"  value='<s:property value="hiddocnos"/>'/>
	<input type="hidden" name="hidcomments" id="hidcomments">
	 </td></tr>
	 
	 </table>
	 
<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >	 


<div id="clientSearchWindow">
	<div></div>
</div>
<div id="accountDetailsWindow">
	<div></div> 
</div>
	 </div></div>
</body>
</html>