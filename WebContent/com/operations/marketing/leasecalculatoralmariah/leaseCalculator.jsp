<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 <style>
 .hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	
	$('#reqsearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Lease Price Request Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#reqsearchwindow').jqxWindow('close');
	
	$('#authoritywindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Authority Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#authoritywindow').jqxWindow('close');
	   
	$('#leasereqdoc').dblclick(function(){
		 $('#reqsearchwindow').jqxWindow('open');
			$('#reqsearchwindow').jqxWindow('focus');
			 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);
		});
	
});

function funReadOnly(){
	$('#frmLeaseCalculatoralmariah input').attr('readonly', true );
	$('#leasereqdoc').attr('disabled', true );
	$('#date').jqxDateTimeInput({disabled:true});
	
	
}
function funRemoveReadOnly(){
	$('#frmLeaseCalculator input').attr('readonly', false );
	$('#date').jqxDateTimeInput({disabled:false});
	$('#leasereqdoc').attr('disabled', false );
	if(document.getElementById("mode").value=="A"){
		  /* document.getElementById("btnleasesave").style.display="none";
		  document.getElementById("btncalculate").style.display="none"; */
		   document.getElementById("hidleasereqdoc").value="";
		  document.getElementById("reqgridlength").value="";
		  document.getElementById("hiddealer").value="";
		  document.getElementById("hidauthority").value="";
		  document.getElementById("authid").value="";
		  document.getElementById("leasemonths").value="";
		  document.getElementById("kmpermonth").value="";
		  document.getElementById("srno").value="";
		  document.getElementById("totalvalue").value="";
		  document.getElementById("savestatus").value="";
		  document.getElementById("confirmstatus").value="";
		  
		  
		  $('#leaseReqGrid').jqxGrid('clear');
		  $('#calculatorGrid').jqxGrid('clear');
		  $('#detailGrid').jqxGrid('clear');
		  $('#date').jqxDateTimeInput('setDate',new Date());
		}
		$('#docno').attr('readonly', true);
		$('#leasereqdoc').attr('readonly', true);
		$('#leasereqclient').attr('readonly', true);
		$('#clientmob').attr('readonly', true);
}

function getLeaseReq(event){
	var x= event.keyCode;
	if(x==114){
		 $('#reqsearchwindow').jqxWindow('open');
			$('#reqsearchwindow').jqxWindow('focus');
			 reqSearchContent('masterLeaseRequest.jsp?branch='+document.getElementById("brchName").value);	 
	}
}
function reqSearchContent(url) {
    $.get(url).done(function (data) {
    $('#reqsearchwindow').jqxWindow('setContent', data);
}); 
}

function getDealer(event){
	var x= event.keyCode;
	if(x==114){
		 $('#dealerWindow').jqxWindow('open');
			$('#dealerWindow').jqxWindow('focus');
			 dealerSearchContent('../../../search/masterssearch/dealerMSearch.jsp');	 
	}
}


function getAuthority(event){
	var x= event.keyCode;
	if(x==114){
		 $('#authoritywindow').jqxWindow('open');
			$('#authoritywindow').jqxWindow('focus');
			 authoritySearchContent('authoritySearch.jsp');	 
	}
 	 
}
function dealerSearchContent(url) {
    $.get(url).done(function (data) {
    $('#dealerWindow').jqxWindow('setContent', data);
}); 
}

function authoritySearchContent(url) {
    $.get(url).done(function (data) {
    $('#authoritywindow').jqxWindow('setContent', data);
}); 
}
function funSearchLoad(){
	 changeContent('masterSearch.jsp');  
}
	
function funChkButton() {
		/* funReset(); */
	}

function funFocus()
   {
   	//document.getElementById("txtvehicle").focus(); 	    		
   }

  
 function funNotify(){	
		 				 
	  var rows = $("#leaseReqGrid").jqxGrid('getrows');
		if(rows[0].brand=="undefined" || rows[0].brand==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Select a valid document";
			return 0;	
		}
	
	  $('#reqgridlength').val(rows.length);
	  var  valid=0;	
	  for(var i=0 ; i < rows.length ; i++){
		  	  
			var brand=rows[i].brand;
			var model=rows[i].model;
			var group=rows[i].gname;
			if(group=="" || group=="undefined" || typeof(group)=="undefined" || group==null){
					valid=-1;
					$.messager.alert('warning','Cost Group of '+brand+' '+model+' not updated');
					break;
				}
			newTextBox = $(document.createElement("input"))
			.attr("type", "dil")
		    .attr("id", "testreq"+i)
		    .attr("name", "testreq"+i)
		    .attr("hidden", "true");
			var leasefromdate = $('#leaseReqGrid').jqxGrid('getcelltext', i, "leasefromdate");
			newTextBox.val(leasefromdate+"::"+rows[i].brdid+"::"+rows[i].modelid+"::"+rows[i].leasemonths+"::"+rows[i].kmpermonth+"::"+rows[i].driver+"::"+rows[i].security_pass+"::"+rows[i].fuel+"::"+rows[i].salik+"::"+rows[i].safetyaccessories);
			newTextBox.appendTo('form');
		
			//alert("ddddd"+$("#test"+i).val());
		}
	  if(valid==-1){
		  
		  return 0;
	  }
    	return 1;;
	} 
 
 function setValues(){
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  
	  	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  	funSetlabel();
	
	  	//$("#calculatorGrid").load("leaseCalculatorGrid.jsp");
	  	if(document.getElementById("docno").value!="" && document.getElementById("leasereqdoc").value!=""){
		  	$('#leasereqdiv').load('leaseRequestGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
		  	/* document.getElementById("btncalculate").style.display="none";
       		document.getElementById("btnleasesave").style.display="none"; */
  			/* document.getElementById("btnleaseedit").style.display="block";
  			document.getElementById("btnleaseedit").disabled=true; */
	  	}
	  	
	}       
 
 function funLoadCalculation(){
	  if(document.getElementById("srno").value==""){
	    	 $.messager.alert('warning','Please select a valid document');
	    	 return false;
	     }
	  if($('#frmLeaseCalculatoralmariah').valid()) { 
		    
		   	 var authority=document.getElementById("hidauthority").value;
		     var leasemonths=document.getElementById("leasemonths").value;
		     var kmpermonth=document.getElementById("kmpermonth").value;
		     var grpid=document.getElementById("grpid").value;
		     var authid=document.getElementById("authid").value;
		     var leasereqdocno=document.getElementById("leasereqdoc").value;
		     var srno=document.getElementById("srno").value;
		     var docno=document.getElementById("docno").value;
		     
		     var rows = $("#detailGrid").jqxGrid('getrows');
				if(rows[0].details=="undefined" || rows[0].details==""){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Please Select a valid document";
					return 0;	
				}
			
			  $('#detgridlength').val(rows.length);
			  var aa=0;
			  var list = new Array();
			   for(var i=0 ; i < rows.length-1 ; i++){
				   var amount=0.0;
				   if(rows[i].amount=="undefined" || rows[i].amount=="" || rows[i].amount==null || typeof(rows[i].amount)=="undefined"){
					   amount=0.0;
				   }
				   else{
					   amount=rows[i].amount;
				   }
				   //alert(rows[i].doc_no+"::"+amount+"::"+aa);
				   list.push(rows[i].doc_no+"::"+amount+"::"+aa);
				   
			   }	
			   
			 ajaxcall(list,srno,leasereqdocno,docno,leasemonths,kmpermonth,grpid,leasereqdoc);
		     
	  }
	  }

	  function ajaxcall(list,srno,leasereqdocno,docno,leasemonths,kmpermonth,grpid,leasereqdoc) {
		  
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(parseInt(items)==1){
						//$.messager.alert('message','Successfully Saved');
						$('#calculatordiv').load('leaseCalculatorGrid.jsp?srno='+srno+'&id=1'+'&leasemonths='+leasemonths+'&kmpermonth='+kmpermonth+'&grpid='+grpid+'&leasereqdoc='+leasereqdocno+'&docno='+docno);
						//$.messager.alert('message','Successfully Calculated');
					}
					else{
						$.messager.alert('message','Calculation Failed');
					}
					
				} else {
				}
			}
			//alert(list);
			x.open("GET", "saveDetails.jsp?list="+list+"&srno="+srno+"&leasereqdocno="+leasereqdocno+"&docno="+docno, true);
			
			x.send();
		}
  
 $(function(){
	  if(document.getElementById("docno").value!=""){
		  $('#frmLeaseCalculatoralmariah').validate({
                rules: {
                purchcost: {
               	required:true
               }
                },
                messages: {
               	purchcost:{
               	  required:" *"
                }
                }
       });  
	  }
       
 });
 
 function funDetailSave(){
	  if(document.getElementById("srno").value==""){
		  $.messager.alert('warning','Please select a valid document');
		  return false;
	  }
	  var rowscalc=$('#calculatorGrid').jqxGrid('getrows');
	  if(rowscalc.length==0){
		  $.messager.alert('warning','Please Calculate');
		  return false;
	  }
	  

	  var rowsreq = $("#leaseReqGrid").jqxGrid('getrows');
	  $('#reqgridlength').val(rowsreq.length);
	  var  valid=0;
	  var ddiw=0,dhpd=0,rateperexhour=0,exkmcharge=0,totalcostmargin=0,drivercostmargin=0,drivercosttotal=0,securitypassmargin=0,securitypasstotal=0,accessoriesmargin=0,accessoriestotal=0;
	  
	  var listreq = new Array();
	  var listcalc = new Array();
	  for(var i=0 ; i < rowsreq.length ; i++){
		  	if(rowsreq[i].srno==document.getElementById("srno").value)  
				{ 
		  		var driver=rowsreq[i].driver;
		  		if(driver=="Yes"){
		  			ddiw=rowsreq[i].ddiw;
					dhpd=rowsreq[i].dhpd;
					rateperexhour=rowsreq[i].rateperexhour;
					
					if(ddiw=="" || ddiw=="undefined" || typeof(ddiw)=="undefined" || ddiw==null){
							valid=-1;
							$.messager.alert('warning','DIW is mandatory');
							break;
					}
					if(dhpd=="" || dhpd=="undefined" || typeof(dhpd)=="undefined" || dhpd==null){
						valid=-1;
						$.messager.alert('warning','HPD is mandatory');
						break;
					}
					if(rateperexhour=="" || rateperexhour=="undefined" || typeof(rateperexhour)=="undefined" || rateperexhour==null){
						valid=-1;
						$.messager.alert('warning','Rate/ex. Hour is mandatory');
						break;
					}
					
		  		}
		  		exkmcharge=rowsreq[i].exkmcharge;
		  		if(exkmcharge=="" || exkmcharge=="undefined" || typeof(exkmcharge)=="undefined" || exkmcharge==null){
					valid=-1;
					$.messager.alert('warning','Excess KM Charges is mandatory');
					break;
				}	
				//listreq.push(rowsreq[i].srno+"::"+rowsreq[i].ddiw+"::"+rowsreq[i].dhpd+"::"+rowsreq[i].rateperexhour+"::"+rowsreq[i].exkmcharge);
			}
	  }
	  
	  var leasemonths=document.getElementById("leasemonths").value;
	  var ratepermonth=0,salik=0,fuelcost=0,netcostotal=0;
	  var totalcostpermonth=0.0;
	  var drivercostpermonth=0.0;
	  
	  for(var i=0 ; i < rowscalc.length ; i++){
	  	  
			var detaildocno=rowscalc[i].detaildocno;
			
			if(detaildocno==37){
				 totalcostmargin=rowscalc[i].margin;
				 totalcosttotal=rowscalc[i].total;
				//alert("totalcost "+totalcostmargin+" "+totalcosttotal);
			}
			if(detaildocno==89){
				 drivercostmargin=rowscalc[i].margin;
				 drivercosttotal=rowscalc[i].total;
				//alert("drivercost "+drivercostmargin+" "+drivercosttotal);
			}
			if(detaildocno==92){
				 securitypassmargin=rowscalc[i].margin;
				 securitypasstotal=rowscalc[i].total;
				//alert("securitypass "+securitypassmargin+" "+securitypasstotal);
			}
			if(detaildocno==93){
				 accessoriesmargin=rowscalc[i].margin;
				 accessoriestotal=rowscalc[i].total;
				//alert("accessorie "+accessoriesmargin+" "+accessoriestotal);
			}
			if(detaildocno==94){
				netcostotal=rowscalc[i].total;
				ratepermonth=rowscalc[i].total/leasemonths;
				//alert("ratepermonth "+ratepermonth);
			}
			if(detaildocno==90){
				 fuelcost=rowscalc[i].amount;
				//alert("totalcost "+accessoriesmargin+" "+accessoriestotal);
			}
			if(detaildocno==91){
				 salik=rowscalc[i].amount;
				//alert("salik "+accessoriesmargin+" "+accessoriestotal);
			}
			if(detaildocno==118){
				totalcostpermonth=rowscalc[i].total;
			}
			if(detaildocno==116){
				drivercostpermonth=rowscalc[i].total;
			}			
	  }
	  
	  	
	     var docno=document.getElementById("docno").value;
	     var leasereqdocno=document.getElementById("leasereqdoc").value;
	     var srno=document.getElementById("srno").value;
	     //alert(valid);
	     if(valid==0){
	     	var rows=$('#calculatorGrid').jqxGrid('getrows');
	     	var list = new Array();
			   for(var i=0 ; i < rows.length ; i++){
				   var amount=0.0,margin=0.0,total=0.0;
				   if(rows[i].amount=="undefined" || rows[i].amount=="" || rows[i].amount==null || typeof(rows[i].amount)=="undefined"){
					   amount=0.0;
				   }
				   else{
					   amount=rows[i].amount;
				   }
					if(rows[i].margin=="undefined" || rows[i].margin=="" || rows[i].margin==null || typeof(rows[i].margin)=="undefined"){
					   margin=0.0;
				   }
				   else{
					   margin=rows[i].margin;
				   }
				   if(rows[i].total=="undefined" || rows[i].total=="" || rows[i].total==null || typeof(rows[i].total)=="undefined"){
					   total=0.0;
				   }
				   else{
					   total=rows[i].total;
				   }
				   list.push(rows[i].doc_no+"::"+amount+"::"+rows[i].detaildocno+"::"+margin+"::"+total);
				   
			   }	
	  	 	saveDetail(docno,leasereqdocno,srno,ddiw,dhpd,rateperexhour,exkmcharge,totalcostmargin,drivercostmargin,drivercosttotal,
	  	 			securitypassmargin,securitypasstotal,accessoriesmargin,accessoriestotal,ratepermonth,salik,fuelcost,netcostotal,
	  	 			totalcostpermonth,drivercostpermonth,list);
	     }
}
 function saveDetail(docno,leasereqdocno,srno,ddiw,dhpd,rateperexhour,exkmcharge,totalcostmargin,drivercostmargin,drivercosttotal,securitypassmargin,
		 securitypasstotal,accessoriesmargin,accessoriestotal,ratepermonth,salik,fuelcost,netcostotal,totalcostpermonth,drivercostpermonth,list){
	  var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="1"){
					$.messager.alert('message','Successfully Saved');
					  document.getElementById("btnconfirm").disabled=false;
					  $('#leasereqdiv').load('leaseRequestGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
				}
				else{
					$.messager.alert('message','Not Saved');
				}
				}
			else {
				
			}
		}
		
		x.open("GET", "detailSave.jsp?docno="+docno+"&leasereqdocno="+leasereqdocno+"&srno="+srno+"&ddiw="+ddiw+"&dhpd="+dhpd+"&rateperexhour="+rateperexhour+"&exkmcharge="+exkmcharge+"&ratepermonth="+ratepermonth+"&salik="+salik+"&fuelcost="+fuelcost+"&totalcostmargin="+totalcostmargin+
				"&totalcosttotal="+totalcosttotal+"&drivercostmargin="+drivercostmargin+"&drivercosttotal="+drivercosttotal+"&securitypassmargin="+securitypassmargin+"&securitypasstotal="+securitypasstotal+"&accessoriesmargin="+accessoriesmargin+"&accessoriestotal="+accessoriestotal+"&netcostotal="+netcostotal+"&totalcostpermonth="+totalcostpermonth+"&drivercostpermonth="+drivercostpermonth+"&list="+list, true);
		x.send();
 }
 function funConfirm(){
	  var docno=document.getElementById("docno").value;
	  var leasereqdocno=document.getElementById("leasereqdoc").value;
	  var srno=document.getElementById("srno").value;
	  var savestatus=document.getElementById("savestatus").value;
	  var confirmstatus=document.getElementById("confirmstatus").value;
	  
	  if(docno=="" || docno==null || leasereqdocno=="" || leasereqdocno==null || srno=="" || srno==null){
		  $.messager.alert('warning','Please select a valid document');
		  return false;
	  }
	  else{
		  if(savestatus=="0"){
			  $.messager.alert('warning','Please save the document');
			  return false;
		  }
		  if(confirmstatus=="1"){
			  $.messager.alert('warning','Already Confirmed');
			  return false;
		  }
		  confirmStatus(docno,leasereqdocno,srno);
	  }
 }
 
 function confirmStatus(docno,leasereqdocno,srno){
	  var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="1"){
					$.messager.alert('message','Successfully Confirmed');
					$('#leasereqdiv').load('leaseReqGrid.jsp?reqdocno='+document.getElementById("leasereqdoc").value+'&docno='+document.getElementById("docno").value+'&id=1');
					document.getElementById("btnleaseedit").style.display="none";
					document.getElementById("btnconfirm").style.display="none";
				}
				else{
					$.messager.alert('message','Not Confirmed');
				}
				}
			else {
				}
		}
		x.open("GET", "confirm.jsp?docno="+docno+"&leasereqdocno="+leasereqdocno+"&srno="+srno, true);
		x.send();
 }
 <%-- function funPrintBtn() {
		var url=document.URL;
		var reurl="";
		if(document.getElementById("submitstatus").value=="1"){
			reurl=url.split("saveLeaseCalculator");
		}
		else{
			reurl=url.split("leaseCalculator.jsp");
		}
		
		var branch='<%=request.getParameter("branch")%>'; 
	    var win= window.open(reurl[0]+"printLeaseCalculatorNormal?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
} --%>
 function clearData(){
	 document.getElementById("hidleasereqdoc").value="";
	  document.getElementById("reqgridlength").value="";
	  document.getElementById("hiddealer").value="";
	  document.getElementById("hidauthority").value="";
	  document.getElementById("authid").value="";
	  document.getElementById("leasemonths").value="";
	  document.getElementById("kmpermonth").value="";
	  document.getElementById("srno").value="";
	  document.getElementById("totalvalue").value="";
	  document.getElementById("savestatus").value="";
	  document.getElementById("driver").value=""; 
	  document.getElementById("fuel").value="";
	  document.getElementById("salik").value="";
	  document.getElementById("securitypass").value="";
	  document.getElementById("safetyaccess").value="";
	  document.getElementById("confirmstatus").value="";
	  
	  $('#leaseReqGrid').jqxGrid('clear');
	  $('#calculatorGrid').jqxGrid('clear');
	  $('#detailGrid').jqxGrid('clear');
 }
 
 function funPrintBtn(){
		if (($("#mode").val() == "view") && $("#docno").val()!="" && $("#driver").val()!="") {
			var url=document.URL;
			if( url.indexOf('saveAlmariah') >= 0){
		    	var reurl=url.split("saveAlmariah");
			}
			else{
				reurl=url.split("leaseCalculator.jsp");
			}
		    $("#docno").prop("disabled", false);
		   // alert("driver :"+$("#driver").val()+" security :"+$("#security_pass").val()+" fuel :"+$("#fuel").val());
		    if(($("#driver").val()=='Yes') && ($("#securitypass").val()=='Yes') && ($("#fuel").val()=='Yes'))
		    {
		    	
//		    	alert("with driver");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah1?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	}
		    else if(($("#driver").val()=='Yes') && ($("#securitypass").val()=='Yes') && ($("#fuel").val()=='No'))
		    {
		    	
	//	    	alert("without fuel");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah2?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=2","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	} 
		    else if(($("#driver").val()=='Yes') && ($("#securitypass").val()=='No') && ($("#fuel").val()=='No'))
		    {
		    	
		//    	alert("only driver");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah3?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=3","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	}
		    else if(($("#driver").val()=='No') && ($("#securitypass").val()=='No') && ($("#fuel").val()=='No'))
		    {
		    	
		//    	alert("no values");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah4?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=4","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	}
		    else if(($("#driver").val()=='No') && ($("#securitypass").val()=='Yes') && ($("#fuel").val()=='Yes'))
		    {
		//    	alert("no driver");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah5?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=5","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	}
		    else if(($("#driver").val()=='No') && ($("#securitypass").val()=='Yes') && ($("#fuel").val()=='No'))
		    {
		//    	alert("only sec");
		    	var win= window.open(reurl[0]+"printLeaseCalcAlmariah6?docno="+document.getElementById("docno").value+"&formdetailcode=LEC &code=6","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		   	}
		    else
		    {
		//   	alert("print");
		    var win= window.open(reurl[0]+"printLeaseCalcAlmariah?docno="+document.getElementById("docno").value+"&formdetailcode=LEC","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		    }
	    	win.focus(); 
		}
		else{
	 		$.messager.alert('Message','Select a Document....!','warning');
	 	    return false;
	 	}
	}
 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmLeaseCalculatoralmariah" action="saveAlmariah" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<div class="hidden-scrollbar">
	<fieldset>
		<table width="100%">
		  <tr>
		    <td width="3%" align="right">Date</td>
		    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
		    <td width="10%" align="right">Lease Req Doc</td>
		    <td width="12%"><input type="text" id="leasereqdoc" name="leasereqdoc" value='<s:property value="leasereqdoc"/>' placeholder="Press F3 to Search" onkeydown="getLeaseReq(event);"/></td>
		    <td width="7%" align="right">Client</td>
		    <td width="21%" align="left"><input type="text" name="leasereqclient" id="leasereqclient" style="width:99%;" readonly value='<s:property value="leasereqclient"/>'></td>
		    <td width="17%" align="left"><input type="text" name="clientmob" id="clientmob" readonly value='<s:property value="clientmob"/>'></td>
		    <td width="7%" align="right">Doc No</td>
		    <td width="12%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/></td>
		  </tr>
		</table>
	 </fieldset><br/>
	 <table width="100%"><tr><td><div id="leasereqdiv"><jsp:include page="leaseRequestGrid.jsp"></jsp:include></div></td></tr></table>
	<br/>
	
				<table width="100%">
					 <tr>
				     <td align="center"><button style="width:100px;" type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funLoadCalculation();">Calculate</button>
				     <button style="width:100px;" type="button" name="btnleasesave" id="btnleasesave" class="myButton" onclick="funDetailSave();">Save</button>
				     <button style="width:100px;" type="button" name="btnconfirm" id="btnconfirm" class="myButton" onclick="funConfirm();">Confirm</button></td>
				     </tr>
				</table>
			
	<table width="100%">
		<tr>
			<td width="50%"><div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
			<td width="50%"><div id="calculatordiv"><jsp:include page="leaseCalculatorGrid.jsp"></jsp:include></div></td>
		</tr>	
	</table>

</div>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="hidleasereqdoc" name="hidleasereqdoc"  value='<s:property value="hidleasereqdoc"/>'/>
<input type="hidden" id="reqgridlength" name="reqgridlength" value='<s:property value="reqgridlength"/>'/>
<input type="hidden" id="detgridlength" name="detgridlength" value='<s:property value="detgridlength"/>'/>
<input type="hidden" id="hiddealer" name="hiddealer" value='<s:property value="hiddealer"/>'/>
<input type="hidden" id="hidauthority" name="hidauthority" value='<s:property value="hidauthority"/>'/>
<input type="hidden" id="authid" name="authid" value='<s:property value="authid"/>'/>
<input type="hidden" id="leasemonths" name="leasemonths" value='<s:property value="leasemonths"/>'/>
<input type="hidden" id="kmpermonth" name="kmpermonth" value='<s:property value="kmpermonth"/>'/>
<input type="hidden" id="grpid" name="grpid" value='<s:property value="grpid"/>'/>
<input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>'/>
<input type="hidden" id="totalvalue" name="totalvalue" value='<s:property value="totalvalue"/>'/>
<input type="hidden" id="savestatus" name="savestatus" value='<s:property value="savestatus"/>'/>
<input type="hidden" id="submitstatus" name="submitstatus" value='<s:property value="submitstatus"/>'/>
<input type="hidden" id="confirmstatus" name="confirmstatus" value='<s:property value="confirmstatus"/>'/>
<input type="hidden" id="rowindex" name="rowindex" value='<s:property value="rowindex"/>'/>
<input type="hidden" id="detaildata" name="detaildata" value='<s:property value="detaildata"/>'/>

<input type="hidden" id="driver" name="driver" value='<s:property value="driver"/>'/>
<input type="hidden" id="securitypass" name="securitypass" value='<s:property value="securitypass"/>'/>
<input type="hidden" id="fuel" name="fuel" value='<s:property value="fuel"/>'/>
<input type="hidden" id="salik" name="salik" value='<s:property value="salik"/>'/>
<input type="hidden" id="safetyaccess" name="safetyaccess" value='<s:property value="safetyaccess"/>'/>

<div id="reqsearchwindow">
<div></div>
</div>
<div id="authoritywindow">
<div></div>
</div>
</form>
</div>
</body>
</html>