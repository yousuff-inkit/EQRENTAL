<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 <link href="../../../../css/body.css" rel="stylesheet" type="text/css"> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> -->

<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
</style>
<script type="text/javascript">
$(document).ready(function () {

$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
$("#startdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
$("#enddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
$('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientinfowindow').jqxWindow('close');
$('#searchwindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
$('#searchwindow').jqxWindow('close');
$('#cldocno').dblclick(function(){
	$('#clientinfowindow').jqxWindow('open');
    $('#clientinfowindow').jqxWindow('focus');
    clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));
});
$('#date,#startdate,#enddate').on('change', function (event) {
	if($(this).attr('id')=='date'){
		var maindate = $('#date').jqxDateTimeInput('getDate');
	  	if ($("#mode").val() == "A") {   
	    	funDateInPeriod(maindate);
	  	}	
	}
	else if($(this).attr('id')=='startdate'){
		var maindate = $('#startdate').jqxDateTimeInput('getDate');
	  	if ($("#mode").val() == "A") {   
	    	funDateInPeriod(maindate);
	  	}	
	}
	else if($(this).attr('id')=='enddate'){
		var maindate = $('#enddate').jqxDateTimeInput('getDate');
	  	if ($("#mode").val() == "A") {   
	    	funDateInPeriod(maindate);
	  	}	
	}
});
});
function dataSearchContent(url) {
	$.get(url).done(function (data) {
		$('#searchwindow').jqxWindow('setContent', data);
    }); 
}
function  funReadOnly(){
	
	$('#docno').attr('disabled', true);
	$('#date,#startdate,#enddate').jqxDateTimeInput({ disabled: true});
	$('#frmMasterLeaseAgmt input').attr('disabled', true );
	$('#frmMasterLeaseAgmt select').attr('disabled', true);
	
}


function getclientinfo(event){
	var x= event.keyCode;
    if(x==114){
    	$('#clientinfowindow').jqxWindow('open');
        clieninfoSearchContent('clientINgridsearch.jsp');  	 }
    else{
    }
}
            	 
function clieninfoSearchContent(url) {
	$.get(url).done(function (data) {
		$('#clientinfowindow').jqxWindow('setContent', data);
    }); 
}

function funRemoveReadOnly(){	
	$('#frmMasterLeaseAgmt input').attr('disabled', false );
	$('#frmMasterLeaseAgmt select').attr('disabled', false);
	$('#date,#startdate,#enddate').jqxDateTimeInput({ disabled: false});
	if($('#mode').val()=='A'){
		$('#masterLeaseGrid').jqxGrid('clear');
		$('#masterLeaseGrid').jqxGrid('addrow', 0, {});
	}
	else if($('#mode').val()=='E'){
		var rows=$('#masterLeaseGrid').jqxGrid('getrows');
		$('#masterLeaseGrid').jqxGrid('addrow', rows.length+1, {});
	}
}    

function funFocus(){
	document.getElementById("cldocno").focus();  
}
function funNotify(){
	var maindate = $('#date').jqxDateTimeInput('getDate');
	var validdate=funDateInPeriod(maindate);
	if(validdate==0){
		return 0; 
	}
	
	if(document.getElementById("cldocno").value=="")
	{
		document.getElementById("errormsg").innerText=" Select Client";
		document.getElementById("cldocno").focus();  
		return 0;
	}
	var startdate=$('#startdate').jqxDateTimeInput('getDate');
	if(startdate==null || startdate==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Start Date is Mandatory";
		return 0;
	}
	var enddate=$('#enddate').jqxDateTimeInput('getDate');
	if(enddate==null || enddate==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="End Date is Mandatory";
		return 0;
	}
	startdate=new Date($('#startdate').jqxDateTimeInput('getDate'));
	startdate.setHours(0,0,0,0);
	enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
	enddate.setHours(0,0,0,0);
	if(enddate<startdate){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="End Date cannot be less than Start Date";
		return 0;
	}
	var validdesc=document.getElementById("description").value;
	if(validdesc!="")
		{
			 var nmaxs = validdesc.length;
	         if(nmaxs>99)
	       	 {
	       	 	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
				document.getElementById("description").focus(); 
				return 0;
			}
			else{
				document.getElementById("errormsg").innerText="";
			}
		}
	
	//$('#gridlength').val(selectedrows.length);
    var rows=$('#masterLeaseGrid').jqxGrid('getrows');
    
    var z=0;
	for(var i=0;i< rows.length; i++) {
		if(rows[i].brand!="" && rows[i].brand!="undefined" && rows[i].brand!=null && typeof(rows[i].brand)!="undefined"){
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "gridarray"+z)
		    .attr("name", "gridarray"+z)
		    .attr("hidden","true");
			newTextBox.val(rows[i].brandid+"::"+rows[i].modelid+"::"+rows[i].specid+"::"+rows[i].leaseduration+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].gps+"::"+rows[i].childseat+"::"+rows[i].kmrestrict+"::"+rows[i].excesskmrate);
			newTextBox.appendTo('form');
			z++;			
		}
	}
	if(z==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="please type in valid vehicle details";
		return 0;
	}
	
	$('#gridlength').val(z);
	return 1;
  }
  
function setValues() {
  	if($('#msg').val()!=""){
  		$.messager.alert('Message',$('#msg').val());
  	}
  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; 
  	if($('#docno').val()!=''){
  		$('#masterleasegriddiv').load('masterLeaseGrid.jsp?id=1&docno='+$('#docno').val());
  	}
  }
function fundescvalidate()
{
	var validdesc=document.getElementById("description").value;
	
	
	if(validdesc!="")
		{
	
	 var nmaxs = validdesc.length;
		
		
      if(nmaxs>99)
   	   {
   	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
	document.getElementById("description").focus(); 
   	   
	return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
	
		}
	
}
function funSearchLoad(){
	changeContent('mainSearch.jsp', $('#window'));
}


function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
    	document.getElementById("errormsg").innerText="Enter Numbers Only";  
        return false;
     }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function funPrintBtn(){
	if (($("#mode").val() != "A") && $("#docno").val()!="") {
		var url=document.URL;
	    var reurl=url.split("saveLeaseAgreement");
	    $("#docno").prop("disabled", false);                
	    /* var win= window.open(reurl[0]+"Leasemainprint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes"); */
    	win.focus(); 
	} 
	else {
 		$.messager.alert('Message','Select a Document....!','warning');
 	    return false;
 	}
}  
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMasterLeaseAgmt" action="saveMasterLeaseAgmt" method="post" autocomplete="off">
	<jsp:include page="../../../../header.jsp" /><br/>

	<div class='hidden-scrollbar'>
		<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="13%" align="right">PO</td>
    <td width="14%"><input type="text" name="po" id="po" value='<s:property value="po"/>'></td>
    <td width="9%" align="right">Ref No</td>
    <td colspan="2"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td width="12%" align="right">Doc No</td>
    <td width="15%"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' readonly tabindex="-1"></td>
    <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
  </tr>
  <tr>
    <td align="right">Client</td>
    <td><input type="text" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' readonly placeholder="Press F3 to Search"></td>
    <td colspan="7"><input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>' readonly style="width:90%;"></td>
    </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="4"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:99%;"></td>
    <td width="7%" align="right">Start Date</td>
    <td width="9%"><div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div></td>
    <td align="right">End Date</td>
    <td><div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div></td>
  </tr>
  <tr>
    <td colspan="9"><fieldset><div id="masterleasegriddiv"><jsp:include page="masterLeaseGrid.jsp" /></div></fieldset></td>
    </tr>
</table>

	</div>
	<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
	<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
	<input type="hidden" id="gridlength" name="gridlength"  value='<s:property value="gridlength"/>'/>
</form>
<div id="clientinfowindow">
   <div ></div>
</div>
<div id="searchwindow">
   <div></div>
</div>
</div>

</body>
</html>