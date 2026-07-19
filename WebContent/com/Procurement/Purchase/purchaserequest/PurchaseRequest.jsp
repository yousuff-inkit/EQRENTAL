<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String purchasearray = request.getParameter("purchasearray") == null? "0": request.getParameter("purchasearray").toString() ;
 System.out.println("purchasearray==="+purchasearray);

%>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
 
 <%
	String contextPath=request.getContextPath();
 %>
 
<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmpurReq input[type="text"],
#frmpurReq select,
.textbox { 
    height: 24px !important; 
    width: 100% !important;
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
}

#frmpurReq input[type="text"]:focus,
#frmpurReq select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmpurReq input[readonly],
#frmpurReq input:disabled,
#frmpurReq select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.myButton, .myButtons {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-block;
    box-sizing: border-box;
}

.myButton:hover, .myButtons:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); 
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* JQX Widget Overrides for 24px Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
}
.jqx-action-button {
    height: 24px !important;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap; /* Prevent wrapping */
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; /* Keep labels from squishing */
}

.modern-ui .input-search-container {
    position: relative;
    display: flex;
    flex-shrink: 0;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
    width: 100%;
    box-sizing: border-box;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

#psearch {
    background:#FAEBD7;
    border-color: #e0d0be;
}
#psearch .middle-panel-title {
    background:#FAEBD7;
    color: #856404;
    border-left-color: #856404;
}

.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28px;
  -moz-border-radius: 28px;
  border-radius: 3px; /* Flattened slightly for modern feel */
  font-family: Arial;
  color: #ffffff;
  font-size: 11px;
  padding: 0 12px;
  text-decoration: none;
  border: none;
  cursor: pointer;
  height: 24px !important;
  line-height: 24px !important;
  box-sizing: border-box;
}
</style>

<script type="text/javascript">
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';
 $(document).ready(function () {
	 
   	 $("#reqmasterdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});   
   	 
     /* Force inner alignment for jqxDateTimeInput */
     setTimeout(function () {
         $("#reqmasterdate").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#reqmasterdate").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
     }, 0);

     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');   
     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
	   
     $('#itemdocno').dblclick(function(){
        if($("#mode").val() == "A" || $("#mode").val() == "E") {
	  	    $('#searchwindow').jqxWindow('open');
			if(document.getElementById("itemtype").value=="1") {
				refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
			}
			else if(document.getElementById("itemtype").value=="6") {
			    refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
			}
			else {
				refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
			}
		}
	}); 
});
 
 
 function getitem(event){
  	 var x= event.keyCode;
  	 if(x==114){
  		$('#searchwindow').jqxWindow('open');
  		if(document.getElementById("itemtype").value=="1") {
		    refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
		else if(document.getElementById("itemtype").value=="6") {
		    refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	    else {
		    refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
  	 }
  	 else{}
}  

function refsearchContent(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
  	}); 
}
 
function productSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sidesearchwndow').jqxWindow('open');
        $('#sidesearchwndow').jqxWindow('setContent', data);
    }); 
} 
          
    function funReset(){
		//$('#frmpurReq')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmpurReq input').attr('readonly', true );
		$('#frmpurReq textarea').attr('readonly', true );
		$('#frmpurReq select').attr('disabled', true);
		 $('#psearch').attr('disabled', true );
		 $('#setbtn').attr('disabled', true ); 
		$('#reqmasterdate').jqxDateTimeInput({ disabled: true});
		 
		$("#purchasedetails").jqxGrid({ disabled: true});
		
		 if(document.getElementById("status").value.trim()=="0" )
			{
			mod1="view";
			}
			if(mod1=="A")
				{
				 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();
				}
	
	}
	function funRemoveReadOnly(){
		 chkmultiqty();
		$('#frmpurReq input').attr('readonly', false );
		$('#frmpurReq textarea').attr('readonly', false );
		$('#frmpurReq select').attr('disabled', false);
	
		$('#reqmasterdate').jqxDateTimeInput({ disabled: false});
	 
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			$('#reqmasterdate').val(new Date());
			 $("#purchasedetails").jqxGrid('clear');
			 $("#purchasedetails").jqxGrid('addrow', null, {});
		   }
		
		 if(mod1=="A")
			{
		    	$("#vehpurcgasereq").load("purreqDetails.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
		    }
		
		 chkcostcode();
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		 chkproductconfig();
		 $('#psearch').attr('disabled', false );
		 $('#setbtn').attr('disabled', false );
	}
	 
	function funNotify(){	
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#reqgridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "reqtest"+i)
		       .attr("name", "reqtest"+i)  
		    .attr("hidden", "true"); 
		 
		    newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].specid+" :: ");
		
		   newTextBox.appendTo('form');
		   }   
		
		return 1;
	} 

	function funChkButton() {
		frmpurReq.submit();
	}

	function funSearchLoad(){
		 changeContent('mainsearch.jsp?'); 
	}
   $(function(){
        $('#frmpurReq').validate({
                rules: { 
                	purdesc:{maxlength:100}
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 100 chars"}
                 }
        });});
    
	function funFocus(){
	   	$('#reqmasterdate').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		if($('#hidreqmasterdate').val()){
			$("#reqmasterdate").jqxDateTimeInput('val', $('#hidreqmasterdate').val());
		}
		 
   	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
		 var indexVal2 = document.getElementById("masterdoc_no").value;
         $("#vehpurcgasereq").load("purreqDetails.jsp?reqdoc="+indexVal2);
			funchkforedit(); 
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	 
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
		  funSetlabel();
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;
         var reurl=url.split("savepurreqdata");
         
  var brhid=<%=session.getAttribute("BRANCHID").toString()%>
        	 var dtype=$('#formdetailcode').val();
  
   var win= window.open(reurl[0]+"printPurchaseReqLd?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 	    	
  	}

	function funchkforedit()
    {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
					}
				else
					{
					}
			} else {
			}
		}
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	}
	
	 
	 function getitemtype(){ 
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		            if($('#hideitemtype').val()!="")
					  {
					  $('#itemtype').val($('#hideitemtype').val());   
					  }
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        }
	 
     
     function chkcostcode()
     {
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
         {
           var items= x.responseText.trim();
          
           if(parseInt(items)>0)
            {
        	   document.getElementById("costcheck").value=1;
        	   $('#hcostcodes').show();
             }
               else
           { 
            	   document.getElementById("costcheck").value=0;
            	   $('#hcostcodes').hide();
           }
            }}
        x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
     	x.send();
     } 
     
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
	 }
	 function getunit(val){ 
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype;

		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#unit").html(optionstype); 	
		    }
		       }
		   x.open("GET","getunit.jsp?psrno="+val,true);
			x.send();
		        }	
		function setgrid()
		 {
			 var temppsrno=document.getElementById("temppsrno").value; 
			 var unit=document.getElementById("unit").value; 
	 
      	  
  		var rows1 = $("#purchasedetails").jqxGrid('getrows');
	    var aa=0;
	    for(var i=0;i<rows1.length;i++){
		   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
			   {
				 if((parseInt(document.getElementById("multimethod").value)==1))
				{	
  			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
  			   {
  				   aa=1;
      			   break;
  			   }
				}
				 else
					 {
			   aa=1;
			   break;
					 }
			   }
		   else{
			   aa=0;
		       } 
	    }
			 
	   if(parseInt(aa)==1)
		   {
			document.getElementById("errormsg").innerText="You have already select this product";
		    document.getElementById("jqxInput1").focus();
		    return 0;
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
			
			 var rows = $('#purchasedetails').jqxGrid('getrows');
		     var rowlength= rows.length;

		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "proid", document.getElementById("jqxInput").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "proname", document.getElementById("jqxInput1").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "brandname", document.getElementById("brand").value);
		    
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unitdocno", document.getElementById("unit").value);
		     if(document.getElementById("unit").value>0)
		     {
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());
		     }
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "psrno", document.getElementById("temppsrno").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "prodoc", document.getElementById("temppsrno").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "specid", document.getElementById("tempspecid").value);
		     $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productid" ,document.getElementById("jqxInput").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "productname", document.getElementById("jqxInput1").value);
		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "qty", document.getElementById("quantity").value);

				   document.getElementById("jqxInput").value ="";
				   document.getElementById("jqxInput1").value="";
				   document.getElementById("brand").value=""; 
		           document.getElementById("collqty").value ="";
				   document.getElementById("quantity").value ="";
				   document.getElementById("unit").value ="";
				    document.getElementById("temppsrno").value="";
				     document.getElementById("tempspecid").value="";
				      								
			 		 $("#purchasedetails").jqxGrid('addrow', null, {});
		    		 document.getElementById("jqxInput1").focus();
		 }
		function calculatedata(val)
		 {

		 }
	 
	 
</script>
</head>
<body onload="setValues();chkcostcode();getitemtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="savepurreqdata" autocomplete="OFF" >     

<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include><br/>

<div class='modern-ui hidden-scrollbar'>
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
            <div style="width: 125px; flex-shrink:0;">
                <div id='reqmasterdate' name='reqmasterdate' value='<s:property value="reqmasterdate"/>'></div> 
                <input type="hidden" id="hidreqmasterdate" name="hidreqmasterdate" value='<s:property value="hidreqmasterdate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:15px;">Ref No</label>
            <div class="input-search-container" style="width:120px; flex-shrink:0;">
                <input type="text" id="refno" name="refno" value='<s:property value="refno"/>' onkeydown="if(event.keyCode==114){ if($('#mode').val()!='view'){ $('#refnosearchwindow').jqxWindow('open'); refnoSearchContent('ordermainsearch.jsp?'); } }" placeholder="Press F3" />
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#refnosearchwindow').jqxWindow('open'); refnoSearchContent('ordermainsearch.jsp?'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <div id="hcostcodes" style="display:none; flex:1; min-width:0;">
                <div style="display:flex; align-items:center; gap:8px; width:100%;">
                    <label class="lbl-right" style="width:60px; flex-shrink:0;">Group</label>
                    <select id="itemtype" name="itemtype" style="width:100px; flex-shrink:0;" onchange="cleardata()"> 
                        <option></option>   
                    </select>
                    
                    <label class="lbl-right" style="width:60px; flex-shrink:0; margin-left:15px;">Job No</label>
                    <div class="input-search-container" style="width: 120px; flex-shrink:0;">
                        <input type="text" id="itemdocno" name="itemdocno" placeholder="Press F3" onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' />
                        <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#searchwindow').jqxWindow('open'); if($('#itemtype').val()=='1') { refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+$('#itemtype').val()); } else if($('#itemtype').val()=='6') { refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); } else { refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+$('#itemtype').val()); } }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="itemname" name="itemname" style="flex:1; min-width:0;" value='<s:property value="itemname"/>' readonly tabindex="-1" />
                </div>
            </div>
            
            <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' readonly style="width:120px; flex-shrink:0;" />
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px; flex-shrink:0;">Description</label>
            <input type="text" id="purdesc" name="purdesc" value='<s:property value="purdesc"/>' style="flex:1; min-width:0;" />
        </div>
    </div>
  
    <div class="middle-panel" id="psearch">
        <span class="middle-panel-title">Item Details</span>
        
        <div class="field-row" style="align-items:flex-end; margin-bottom:0;">
            <div style="flex:1; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#444; margin-left:2px;">Product ID</label>
                <div id="part"><jsp:include page="part.jsp"></jsp:include></div>
            </div>
            
            <div style="flex:2; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#444; margin-left:2px;">Product Name</label>
                <div id="pnames"><jsp:include page="name.jsp"></jsp:include></div>
            </div>
            
            <div style="flex:1; min-width:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#444; margin-left:2px;">Brand</label>
                <input type="text" id="brand" style="width:100%;" />
                <input type="hidden" id="collqty" />
            </div>
            
            <div style="width:120px; flex-shrink:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#444; margin-left:2px;">Unit</label>
                <select id="unit" style="width:100%;"></select>
            </div>
            
            <div style="width:80px; flex-shrink:0; display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:bold; color:#444; margin-left:2px;">Qty</label>
                <input type="text" id="quantity" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);" />
            </div>
            
            <div style="flex-shrink:0; margin-bottom:1px;">
                <input type="button" id="setbtn" class="btn" onclick="setgrid()" value="ADD" style="height:24px; line-height:12px; padding:4px 12px; border-radius:3px;" />
            </div>
            
            <!-- Hidden Fields for Item details -->
            <div style="display:none;">
                <input type="hidden" id="loads" class="myButtons" value="Load Data" onclick="loaddatass()">  
                <input type="hidden" id="focs" onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);">
                <input type="hidden" id="multi" onchange="chkmultis()" >
                <input type="hidden" id="batch" onkeydown="getbatch(event)" >
                <div id="expdate" name="expdate" value='<s:property value="expdate"/>'></div> 
                <input type="hidden" id="cleardata">
            </div>
        </div>
    </div> 

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="vehpurcgasereq" class="grid-container">
            <jsp:include page="purreqDetails.jsp"></jsp:include>
        </div>
    </div>
  
<div style="display:none;">
    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" name="reqgridlenght" id="reqgridlenght" value='<s:property value="reqgridlenght"/>' />   
    <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext"/>'  />   
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
    <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
    <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
    <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
    <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
    <input type="hidden" id="temppsrno" >  
    <input type="hidden" id="tempspecid" > 
    <input type="hidden" id="tempunitdocno" > 
</div>

</form>

<div id="sidesearchwndow">
    <div></div>
</div>
<div id="searchwindow">
    <div></div>
</div>

</div>
</body>
</html>