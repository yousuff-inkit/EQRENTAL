<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<% 
    String contextPath=request.getContextPath();
    ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO();
    String method=cvp.getMethod();
%>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
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

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
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

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
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
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }
form label.error { color:red; font-weight:bold; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Original Custom Button Styles (Retained for specific element references) */
.myButtonss {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #7892c2), color-stop(1, #476e9e));
	background:-moz-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-webkit-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-o-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:-ms-linear-gradient(top, #7892c2 5%, #476e9e 100%);
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#7892c2', endColorstr='#476e9e',GradientType=0);
	background-color:#7892c2;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 7px;
	text-decoration:none;
    height: 24px;
    line-height: 20px;
    border-radius: 3px;
}
.myButtonss:hover { background-color:#476e9e; }
.myButtonss:active { position:relative; top:1px; }

.myButtonp {
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
	font-family:Arial;
	font-size:12px;
	padding:2px 10px;
	text-decoration:none;
    height: 24px;
    line-height: 20px;
    border-radius: 3px;
}
.myButtonp:hover { background-color:#6c7c7c; }
.myButtonp:active { position:relative; top:1px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		getNonTaxableEntity();		
		getTaxPer($('#vehpurorderDate').val());
		
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		$("#vehpurorderDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		$("#jqxStartDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true, theme: 'energyblue'});
		$("#uptoDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true, theme: 'energyblue'});
		$("#vehpurinvDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		$("#vehpurorderdelDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});

        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#vehpurorderDate, #jqxStartDate, #uptoDate, #vehpurinvDate, #vehpurorderdelDate").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#vehpurorderDate, #jqxStartDate, #uptoDate, #vehpurinvDate, #vehpurorderdelDate").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);

		$('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	    $('#brandsearchwndow').jqxWindow('close'); 

	    $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
	    $('#modelsearchwndow').jqxWindow('close');
	    $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 400, y:60 }, keyboardCloseKey: 27});
	    $('#colorsearchwndow').jqxWindow('close');
	    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		     
		$('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		$('#refnosearchwindow').jqxWindow('close'); 
		$('#fleetwindow').jqxWindow({ width: '50%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 600, y: 60 }, keyboardCloseKey: 27});
		$('#fleetwindow').jqxWindow('close');
				     
		$('#slnosearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sl NO Search' ,position: { x: 250, y:100 }, keyboardCloseKey: 27});
		$('#slnosearchwindow').jqxWindow('close');	     
				     
		$("#btnEdit").attr('disabled', true );
		$("#btnDelete").attr('disabled', true );
			  
		$('#vehrefno').dblclick(function(){
            if($('#mode').val()=="A") {
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
            }
		}); 
				    
		$('#financeaccid').dblclick(function(){
			$('#accountSearchwindow').jqxWindow('open');
			commenSearchContent('finaccountSearch.jsp?');
		}); 
			   
		$('#bankaccid').dblclick(function(){
			$('#accountSearchwindow').jqxWindow('open');
			commenSearchContent('bankaccountsearch.jsp?');
		}); 

	    $('#interestaccid').dblclick(function(){
			$('#accountSearchwindow').jqxWindow('open');
			commenSearchContent('inetestaccsearch.jsp?');
		}); 

	    $('#loanaccid').dblclick(function(){
		    $('#accountSearchwindow').jqxWindow('open');
		    commenSearchContent('loanaccount.jsp?');
	    }); 
		  
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	if ($("#mode").val() == "A"  ) {   
	            funDateInPeriod(maindate);
	    	}
	    });  
		    
	    $('#accid').dblclick(function(){
	    	if($('#mode').val()=="A") {
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	    accountSearchContent('accountsDetailsSearch.jsp?');
		    }
	    }); 
	});
			   
    function commenSearchContent(url) {
        $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('open');
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    } 	
			   
    function getloanacc(event){
        var x= event.keyCode;
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('loanaccount.jsp?');
        }
    }    
    
    function getInterestacc(event){
        var x= event.keyCode;
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('inetestaccsearch.jsp?');
        }
    }   
    
    function getbankacc(event){
        var x= event.keyCode;
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('bankaccountsearch.jsp?');
        }
    }    
			   
    function getfinacc(event){
        var x= event.keyCode;
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            commenSearchContent('finaccountSearch.jsp?');
        }
    }     
			   
	function slnoSearchContent(url) {
        $.get(url).done(function (data) {
            $('#slnosearchwindow').jqxWindow('open');
            $('#slnosearchwindow').jqxWindow('setContent', data);
        }); 
	} 
	
    function fleetSearchContent(url) {
        $.get(url).done(function (data) {
            $('#fleetwindow').jqxWindow('open');
            $('#fleetwindow').jqxWindow('setContent', data);
        }); 
	} 
	
	function getrefDetails(event){
        var x= event.keyCode;
        if(x==114){
            if($('#mode').val()=="A") {
                $('#refnosearchwindow').jqxWindow('open');
                refsearchContent('vehOrderRefnoSearch.jsp?headacccode='+document.getElementById("headacccode").value);
            }
        }
    }  

    function refsearchContent(url) {
        $.get(url).done(function (data) {
            $('#refnosearchwindow').jqxWindow('setContent', data);
        }); 
    }

	function getaccountdetails(event){
        var x= event.keyCode;
        if(x==114){
            if($('#mode').val()=="A") {
                $('#accountSearchwindow').jqxWindow('open');
                accountSearchContent('accountsDetailsSearch.jsp?'); 
            }
        }
    }  

    function accountSearchContent(url) {
        $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
    }

    function brandinfoSearchContent(url) {
        $.get(url).done(function (data) {
            $('#brandsearchwndow').jqxWindow('open');
            $('#brandsearchwndow').jqxWindow('setContent', data);
        }); 
    } 

    function modelinfoSearchContent(url) {
        $.get(url).done(function (data) {
            $('#modelsearchwndow').jqxWindow('open');
            $('#modelsearchwndow').jqxWindow('setContent', data);
        }); 
    } 

    function colorinfoSearchContent(url) {
        $.get(url).done(function (data) {
            $('#colorsearchwndow').jqxWindow('open');
            $('#colorsearchwndow').jqxWindow('setContent', data);
        }); 
    } 
        
	 function funReadOnly(){
        $('#frmpurchase input').attr('readonly', true );
        $('#frmpurchase select').attr('disabled', true);
        
        $('#vehpurorderDate').jqxDateTimeInput({disabled: true});
        $('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
        $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
        $("#vehoredergrid").jqxGrid({ disabled: true});
        $("#editss").prop("disabled", false);
        $('#vehrefno').attr('disabled', true);
        
        $("table#finance input").prop("disabled", true);
        $("table#finance select").prop("disabled", true);
        
        $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
        $('#uptoDate').jqxDateTimeInput({disabled: true});  
        $("#updatebtn").prop("disabled", true);
        $("#btnsearch").prop("disabled", true);   
        
        $("#editss").prop("disabled", true);
        $("#btnCalculate").prop("disabled", true);
        $("#updateposting").prop("disabled", true);
        $('#invno').attr('readonly', true);
        
        $('#updatefleet').show();
        $('#updateposting').show();
	 }

	 function funRemoveReadOnly(){
        $('#frmpurchase input').attr('readonly', false );
        $('#frmpurchase select').attr('disabled', false);
        $("#vehoredergrid").jqxGrid({ disabled: false});
        $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
        $('#vehpurinvDate').jqxDateTimeInput({disabled: true});
        $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
        $('#vehrefno').attr('disabled', true);
        $('#docno').attr('readonly', true);
        $('#accid').attr('readonly', true);
        $('#vehrefno').attr('readonly', true);
        $("#btnsearch").prop("disabled", true);   
        $('#vehpuraccname').attr('readonly', true);
        
        if ($("#mode").val() == "A") {
            $('#vehpurorderdelDate').val(new Date());
            $('#vehpurorderDate').val(new Date());
            $('#vehpurinvDate').val(new Date());
            $("#vehoredergrid").jqxGrid('clear');
            $("#vehoredergrid").jqxGrid('addrow', null, {});
            
            $("table#finance input").prop("disabled", true);
            $("table#finance select").prop("disabled", true);
            $('#jqxStartDate').jqxDateTimeInput({disabled: true});  
            $('#uptoDate').jqxDateTimeInput({disabled: true});
            $('#invno').attr('readonly', true);
            $('#updatefleet').hide();
            $('#updateposting').hide();
            $("#editss").prop("disabled", true);
            $("#btnCalculate").prop("disabled", true);
            $("#updateposting").prop("disabled", true);
            
            $("#jqxDistributionGrid").jqxGrid('clear');
            $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
            $("#postgrid").jqxGrid('clear');
            $("#postgrid").jqxGrid('addrow', null, {});
            $("#postgrid").jqxGrid('addrow', null, {});
        }
	 }
	 
    function funrefdisslno() {
        if($('#vehtype').val()=="VPO") {
            $('#vehrefno').attr('disabled', false);
            $("#vehoredergrid").jqxGrid('clear');
            $("#vehoredergrid").jqxGrid('addrow', null, {});
        } else {
            $('#vehrefno').val("");
            $('#vehrefno').attr('disabled', true);
            $("#vehoredergrid").jqxGrid('clear');
            $("#vehoredergrid").jqxGrid('addrow', null, {});
        }
    }
	 
	function funSearchLoad(){
		changeContent('vehPurchaseMastersearch.jsp'); 
	}
		
	function funChkButton() {
	}
	 
    function funFocus() {
        $('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
    }
	   
    function funNotify(){
        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
        var validdate=funDateInPeriod(maindate);
        if(validdate==0){
            return 0; 
        }
        
        if ($("#brchName").val() == ""||$("#brchName").val() == "null" || typeof($("#brchName").val()) == "undefined" ) { 
            document.getElementById("errormsg").innerText="Your Secure Session Has Expired";
            return 0;
        }
        
        var purid= document.getElementById("accid").value;
        if(purid=="") {
            document.getElementById("errormsg").innerText=" Select An Account";
            document.getElementById("accid").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        } 
		
        if($('#vehtype').val()=="VPO") {
            var vehrefno= document.getElementById("vehrefno").value; 
            if(vehrefno=="") {
                document.getElementById("errormsg").innerText=" Select Refno";
                document.getElementById("vehrefno").focus();
                return 0;
            } else {
                document.getElementById("errormsg").innerText="";
            }
        }
			   
        var rows = $("#vehoredergrid").jqxGrid('getrows');
        for(var i=0 ; i < rows.length ; i++){
            if(parseInt(rows[i].brdid)>0) {
                if(rows[i].price=="" ||typeof(rows[i].price)=="undefined"||typeof(rows[i].price)=="NaN") {
                    document.getElementById("errormsg").innerText="Enter Price";  
                    return 0;
                }
            } 
        }
		   
        var rows = $("#vehoredergrid").jqxGrid('getrows');   
        $('#vehpurchasegridlenght').val(rows.length);
        for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
                .attr("type", "dil")
                .attr("id", "vehpurchasetest"+i)
                .attr("name", "vehpurchasetest"+i) 
                .attr("hidden", "true"); 
            newTextBox.val(rows[i].srno+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
                    +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].price+" :: "+rows[i].tempval+" :: "+rows[i].diff+" :: "
                    +rows[i].chaseno+" :: "+rows[i].enginno+" :: ");
            newTextBox.appendTo('form');
        }   
        $('#vehpurinvDate').jqxDateTimeInput({disabled: false});	 
        return 1;
    } 
	  
    function calculate() {
        if(document.getElementById("downpayment").value=="") {
            document.getElementById("errormsg").innerText="Enter Down Payment";  
            document.getElementById("downpayment").focus();
            return 0;
        }
        if(document.getElementById("perinterest").value=="") {
            document.getElementById("errormsg").innerText="Enter Percentage Interest";  
            document.getElementById("perinterest").focus();
            return 0; 
        }
        if(document.getElementById("instnos").value=="") {
            document.getElementById("errormsg").innerText="Enter Number Of Installments";  
            document.getElementById("instnos").focus();
            return 0;
        }
        if(document.getElementById("paymentmethod").value=="") {
            document.getElementById("errormsg").innerText="Select Payment Method";  
            document.getElementById("paymentmethod").focus();
            return 0;
        }  
			 
        var calcumethod= $('#calcumethod option:selected').text();
        $.messager.confirm('Message', 'Do you want to calculate with '+calcumethod, function(r){
            if(r==false) {
                return false; 
            } else { 
                $("#jqxDistributionGrid").jqxGrid('clear');
                $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
            
                var install=document.getElementById("instnos").value;
                var payment=document.getElementById("paymentmethod").value;
                for(var i=0;i<parseInt(install);i++) {
                    var dtval=$("#jqxStartDate").val();
                    var aa1="yes";
                    var ss=i;
                    
                    var x=new XMLHttpRequest();
                    x.onreadystatechange=function(){
                        if (x.readyState==4 && x.status==200) {
                            var items = x.responseText;
                            items = items.split('::');
                            for (var i = 0; i < install; i++) {
                                var data=items[i];
                                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
                            }
                        }
                    }
                    x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);
                    x.send();
                            
                    var loanval=document.getElementById("loanamount").value;
                    var perint=document.getElementById("perinterest").value;
                    var instnos=document.getElementById("instnos").value;
                    
                    var priamount=(parseFloat(loanval)/(parseFloat(instnos))).toFixed(2); 
                    var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))).toFixed(2); 
                    
                    var amount=(parseFloat(priamount)+parseFloat(interest)).toFixed(2);
                    if(parseInt(payment)==2) {
                        $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+""+"-"+document.getElementById("docno").value);
                    }
                                
                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest);
                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
                    
                    if(i<(parseInt(install)-1)) {
                        $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                    }
                }
            }
        }); 
    }
	  
    function getNonTaxableEntity(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                $('#txtnontaxableentity').val(items);
                if(parseInt($('#txtnontaxableentity').val().trim())==1){
                    getTaxPer($('#vehpurorderDate').val());
                }
            }
        }
        x.open("GET", "getNonTaxableEntity.jsp", true);
        x.send();
    }
	  
    function getTaxPer(date){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                $('#txttaxpercentage').val(items);
            }
        }
        x.open("GET", "getTaxper.jsp?date="+date+"&accid="+$('#accid').val(), true);
        x.send();
    }
	  
    function funUpdate() {
        if(document.getElementById("updatebtn").value=="Edit") {
            var taxamount=0;
            var taxper=$('#txttaxpercentage').val();
            var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
            
            taxamount=parseFloat(summaryData.sum*(parseFloat(taxper)/100));
            var totalvalue=parseFloat(taxamount)+parseFloat(summaryData.sum);
            funRoundAmt(taxamount,"taxamount");
            funRoundAmt(totalvalue,"totalamt");
            
            $('#hidtaxamount').val(taxamount);
            $('#hidtotalamt').val(totalvalue);
            
            $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
            $('#uptoDate').jqxDateTimeInput({disabled: false}); 
            
            $("table#finance input").prop("disabled", false);
            $("table#finance select").prop("disabled", false);
            $("table#finance input").prop("readonly", false);
            $("table#finance select").prop("readonly", false);
            
            $("#loanamount").prop("readonly", true);
            $("#financeaccname").prop("readonly", true);
            $("#bankaccname").prop("readonly", true);
            $("#intaccname").prop("readonly", true);
            $("#loanaccname").prop("readonly", true);
            $("#financeaccid").prop("readonly", true);
            $("#bankaccid").prop("readonly", true);
            $("#interestaccid").prop("readonly", true);
            $("#loanaccid").prop("readonly", true);
            $("#btnsearch").prop("disabled", false); 
            $("#taxamount").attr('readonly', true);
            $("#totalamt").attr('readonly', true);
            
            document.getElementById("perinterest").value="";
            document.getElementById("instnos").value="";
            document.getElementById("dealno").value="";
            
            $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
            $('#uptoDate').jqxDateTimeInput({disabled: false}); 
            document.getElementById("updatebtn").value="Save";
            return 0;
        } else if(document.getElementById("updatebtn").value=="Save") {
            var rows1 = $("#jqxDistributionGrid").jqxGrid('getrows');
            for(var i=0 ; i < rows1.length ; i++){
                var sr_no=rows1[0].sr_no;
                if(parseInt(sr_no)!=1) {
                    document.getElementById("errormsg").innerText="Calculate Process ";  
                    document.getElementById("calculatebtn").focus();
                    return 0;
                }
            }	
            
            if(document.getElementById("financeaccid").value=="") {
                document.getElementById("errormsg").innerText="Search Financier Account ";  
                document.getElementById("financeaccid").focus();
                return 0;
            }
            if(document.getElementById("bankaccid").value=="") {
                document.getElementById("errormsg").innerText="Search Bank Account ";  
                document.getElementById("bankaccid").focus();
                return 0; 
            }
            if(document.getElementById("interestaccid").value=="") {
                document.getElementById("errormsg").innerText="Search Interest Account ";  
                document.getElementById("interestaccid").focus();
                return 0;
            }  
            if(document.getElementById("loanaccid").value=="") {
                document.getElementById("errormsg").innerText="Search Loan Account ";  
                document.getElementById("loanaccid").focus();
                return 0;
            }  
            if(document.getElementById("secchaqueno").value=="") {
                document.getElementById("errormsg").innerText="Enter Security Cheque NO";  
                document.getElementById("secchaqueno").focus();
                return 0;
            }
            if(document.getElementById("chqamount").value=="") {
                document.getElementById("errormsg").innerText="Enter Amount ";  
                document.getElementById("chqamount").focus();
                return 0; 
            }
            if(document.getElementById("dealno").value=="") {
                document.getElementById("errormsg").innerText="Enter Deal No";  
                document.getElementById("dealno").focus();
                return 0;
            } 
            if(document.getElementById("nameincheque").value=="") {
                document.getElementById("errormsg").innerText="Enter Name In Cheque";  
                document.getElementById("nameincheque").focus();
                return 0;
            }  
            if(document.getElementById("txtdescription").value=="") {
                document.getElementById("errormsg").innerText="Enter Description";  
                document.getElementById("txtdescription").focus();
                return 0;
            }  
            if(parseFloat(document.getElementById("priamounts").value)!=parseFloat(document.getElementById("loanamount").value)) {
                document.getElementById("errormsg").innerText="Net Principal Amount Should Be Equal To Loan Amount";  
                return 0;
            }  
					   
            $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                if(r==false) {
                    return false; 
                } else {		
                    var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
                    $('#distributionlenght').val(rows.length);
                    for(var i=0 ; i < rows.length ; i++){
                        newTextBox = $(document.createElement("input")) 
                            .attr("type", "dil")       
                            .attr("id", "dettest"+i)   
                            .attr("name", "dettest"+i)  
                            .attr("hidden", "true");    
                        newTextBox.val(rows[i].priamount+"::"+rows[i].date+" :: "+rows[i].interest+" :: "+rows[i].amount+" :: "+rows[i].chqno+" :: ");
                        newTextBox.appendTo('form');
                    }
                    $("table#finance input").prop("disabled", false);
                    $("table#finance select").prop("disabled", false);
                    $("table#finance input").prop("readonly", false);
                    $("table#finance select").prop("readonly", false);  
                    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                    $('#frmpurchase input').attr('readonly', false );
                    $('#frmpurchase select').attr('disabled', false);
                    $("#vehoredergrid").jqxGrid({ disabled: false});
                    $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                    $('#vehrefno').attr('disabled', false);
                    document.getElementById("mode").value="ADD";
                    document.getElementById("fleetupdateval").value="";
                    document.getElementById("msg").value="";
                    document.getElementById("detval").value="";
                    $('#frmpurchase').submit();
                }
            });
        }
    }
	  
    function changeval() {
        if($('#vehtypeval').val()!="") {
            $('#vehtype').val($('#vehtypeval').val());
        }
        if($('#vehtypeval').val()=="VPO") {
            $('#vehrefno').attr('disabled', false);
            $('#vehrefno').attr('readonly', true);
        }
    }

    function setValues() {
        if($('#restructure').val()!="" && $('#restructure').val()!=null && $('#restructure').val()=="1"){
            document.getElementById("errormsg").innerText="Loan Restructured";
        }
        if($('#hidvehpurorderDate').val()){
            $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
        }
        if($('#hidvehpurorderdelDate').val()){
            $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
        }
        if($('#hidvehpurinvDate').val()){
            $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
        }
		  
        var indexVa5 = document.getElementById("masterdoc_no").value;
        if(parseInt(indexVa5)>0){
            $("#updatebtn").attr("disabled", false);	 
            $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);
        }  
	       
        if(parseInt(document.getElementById("detval").value)==10) {
            if($('#hidjqxStartDate').val()){
                $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
            }
            if($('#hiduptoDate').val()){
                $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
            }
            $('#calcumethod').val($('#calcuval').val());
            $('#paymentmethod').val($('#paymentval').val());
            $("#detailsdiv").load("distributionGrid.jsp?docnos="+document.getElementById("masterdoc_no").value+'&detval='+document.getElementById("detval").value);  
            if((parseInt(document.getElementById("clstatus").value)!=1) && (parseInt(document.getElementById("fleetupdateval").value)<1)) {
                $.messager.alert('Message','Successfully Saved'); 
            }
            document.getElementById("detval").value="";
            document.getElementById("msg").value="";
            document.getElementById("updatebtn").value="Edit";	 
            
            $("table#finance input").prop("disabled", true);
            $("table#finance select").prop("disabled", true);
            $("table#finance input").prop("readonly", true);
            $("table#finance select").prop("readonly", true);
        } else if(parseInt(document.getElementById("detval").value)==11) {
            $("table#finance input").prop("disabled", false);
            $("table#finance select").prop("disabled", false);
            $("table#finance input").prop("readonly", false);
            $("table#finance select").prop("readonly", false);
            
            if($('#hidjqxStartDate').val()){
                $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
            }
            if($('#hiduptoDate').val()){  
                $("#uptoDate").jqxDateTimeInput('val', $('#hiduptoDate').val());
            }    
            
            $("#loanamount").prop("readonly", true);
            $("#financeaccname").prop("readonly", true);
            $("#bankaccname").prop("readonly", true);
            $("#intaccname").prop("readonly", true);
            $("#loanaccname").prop("readonly", true);
            $("#financeaccid").prop("readonly", true);
            $("#bankaccid").prop("readonly", true);
            $("#interestaccid").prop("readonly", true);
            $("#loanaccid").prop("readonly", true);
            
            $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
            $('#uptoDate').jqxDateTimeInput({disabled: false});  
            
            $("#jqxDistributionGrid").jqxGrid('clear');
            $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
            var install=document.getElementById("instnos").value;
            var payment=document.getElementById("paymentval").value;
            
            for(var i=0;i<parseInt(install);i++) {
                var dtval=$("#jqxStartDate").val();
                var aa1="yes";
                var ss=i;
                
                var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                    if (x.readyState==4 && x.status==200) {
                        var items = x.responseText;
                        items = items.split('::');
                        for (var i = 0; i < install; i++) {
                            var data=items[i];
                            $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "date" ,data);   
                        }
                    }
                }
                x.open("GET","gatedate.jsp?jqxStartDate="+dtval+"&ival="+ss+"&chk="+aa1+"&install="+install,true);
                x.send();    
                                
                var loanval=document.getElementById("loanamount").value;
                var perint=document.getElementById("perinterest").value;
                var instnos=document.getElementById("instnos").value;
                var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
                var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
                var amount=parseFloat(priamount)+parseFloat(interest);
                
                if(parseInt(payment)==2) {
                    $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "chqno" ,i+1+" "+" - "+document.getElementById("docno").value);
                }
                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "sr_no" ,i+1);
                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "priamount" ,priamount);
                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "interest" ,interest );
                $('#jqxDistributionGrid').jqxGrid('setcellvalue',i, "amount" ,amount);
                
                if(i<(parseInt(install)-1)) {
                    $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                }
            }
            document.getElementById("updatebtn").value="Save";	 
            $('#calcumethod').val($('#calcuval').val());
            $('#paymentmethod').val($('#paymentval').val()); 	 
            $.messager.alert('Message','Not Saved');
            document.getElementById("detval").value="";
            document.getElementById("msg").value="";
            return 0;
        }
	         
        if(parseInt(document.getElementById("fleetupdateval").value)==1) {
            $.messager.alert('Message','Fleet Updated Successfully'); 
            document.getElementById("fleetupdateval").value="";
        } else if(parseInt(document.getElementById("fleetupdateval").value)==2) {
            $.messager.alert('Message','Fleet Not Updated');
            document.getElementById("fleetupdateval").value="";
        }
        if(parseInt(document.getElementById("fleetupdateval").value)==3) {
            $.messager.alert('Message','Posting Updated Successfully'); 
            document.getElementById("fleetupdateval").value="";
        } else if(parseInt(document.getElementById("fleetupdateval").value)==4) {
            $.messager.alert('Message','Posting Not Updated');
            document.getElementById("fleetupdateval").value="";
        } else {
            if($('#msg').val()!=""){
                $.messager.alert('Message',$('#msg').val());
            }
            document.getElementById("fleetupdateval").value="";
        }
 	         
        if(parseInt(document.getElementById("tranno").value)>0) {
            $("#postingdiv").load("postinggrid.jsp?srno="+document.getElementById("tranno").value);  
        } 
        if(parseInt(document.getElementById("masterstatus").value)>0) {
            $("#editss").prop("disabled", false);
        }
	         
        changeval();
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        
        if($('#mode').val().trim()=="view" && parseInt(document.getElementById("clstatus").value)==1) {
            $("#editdeal").show();
            $("#editdeal").prop("disabled", false);
        }
    }
	  
    $(function(){
        $('#frmpurchase').validate({
            rules: { 
                vehdesc:{maxlength:200},
            },
            messages: {
                vehdesc: {maxlength:"  Max 200 chars"}
            }
        });
    });
	  
    function calculateval() {
        if(parseInt(document.getElementById("calcumethod").value)==1) {
            var downpayment=document.getElementById("downpayment").value;
            var totalamt=document.getElementById("totalamt").value;
            var loanamount=parseFloat(totalamt)-parseFloat(downpayment);
            var aa="loanamount";
            funRoundAmt(loanamount,aa);
        }
    }

	function funupdatefleet() {
		if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
			var rows2 = $("#vehoredergrid").jqxGrid('getrows');
			var fleetval=0;
            for(var i=0 ; i < rows2.length ; i++){
                var brdid=rows2[i].brdid;
                if(parseInt(brdid)>=0) {
                    var flstatuss=rows2[i].fleet_no;
                    if(parseInt(flstatuss)>0) {
                        fleetval=10;
                        break;
                    }
                }
            }
			 
            if(parseInt(fleetval)==0) {
                $.messager.alert('Message','Minimum One Fleet Required','warning');
                return 0;
            }
			
			var rows1 = $("#vehoredergrid").jqxGrid('getrows');
			var aa=0;
            for(var i=0 ; i < rows1.length ; i++){
                var brdid=rows1[i].brdid;
                if(parseInt(brdid)>=0) {
                    var flstatus=rows1[i].flstatus;
                    if(parseInt(flstatus)==1) {
                    } else {
                        aa=1;
                        break;
                    }
                }
            }
			   
            if(parseInt(aa)==0) {
                $.messager.alert('Message','All Fleets Are Updated','warning');
                return 0;
            }
			   
            $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                if(r==false) {
                    return false; 
                } else {	
                    var rows = $("#vehoredergrid").jqxGrid('getrows');
                    $('#vehpurchasegridlenght').val(rows.length);
                    for(var i=0 ; i < rows.length ; i++){
                        newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "vehpurchasetest"+i)
                            .attr("name", "vehpurchasetest"+i) 
                            .attr("hidden", "true"); 
                        newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].totper+" :: "+rows[i].clrid+" :: ");
                        newTextBox.appendTo('form');
                    }
                    $("table#finance input").prop("disabled", false);
                    $("table#finance select").prop("disabled", false);
                    $("table#finance input").prop("readonly", false);
                    $("table#finance select").prop("readonly", false);  
                    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                    $('#frmpurchase input').attr('readonly', false );
                    $('#frmpurchase select').attr('disabled', false);
                    $("#vehoredergrid").jqxGrid({ disabled: false});
                    $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                    $('#frmpurchase input').attr('disabled', false );
                    $('#vehrefno').attr('disabled', false);
                    document.getElementById("mode").value="UPD";
                    document.getElementById("fleetupdateval").value="";
                    document.getElementById("msg").value="";
                    $('#frmpurchase').submit();
                }
            });
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return 0;
		}
	}
	
    function funpostcalcu() {
        var taxper=parseFloat($('#txttaxpercentage').val());
        var venacc=$("#headacccode").val();
        var deldate= $("#vehpurorderDate").val();
        var nettotal=parseFloat($("#totalamount").val());
        var loanaccdocno=$("#loanaccdocno").val();
        var downpaymnt=$("#downpayment").val();
        var dealno=$('#dealno').val();
        var taxmethod=parseInt($('#txtnontaxableentity').val().trim());
        var tax, total, loanamount;
        if(taxmethod==1){
            tax=parseFloat(nettotal*(taxper/100));
            total=parseFloat(nettotal+tax);
            loanamount=parseFloat(total)-parseFloat(downpaymnt);
        } else {
            tax=parseFloat(0);
            total=parseFloat(nettotal);
            loanamount=parseFloat(nettotal)-parseFloat(downpaymnt);
            document.getElementById("taxlabel").style.display='none';
            document.getElementById("taxbox").style.display='none';
        }
		
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items=x.responseText;
                var chkstatus=items.trim();
                if(parseInt(chkstatus)>0) {
                    document.getElementById("tranno").value=chkstatus; 
                    document.getElementById("validatepostcalu").value=1;
                    $("#postingdiv").load("postinggrid.jsp?srno="+chkstatus);  
                    return 0;
                }
            }
        } 
        if(taxmethod==1){
            x.open("GET","jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+total+"&nettotal="+nettotal+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount+"&tax="+tax+"&dealno="+dealno,true);
        } else {
            x.open("GET","jurnsave.jsp?vocno="+ document.getElementById("docno").value+"&deldate="+deldate+"&total="+nettotal+"&nettotal="+nettotal+"&venacc="+venacc+"&masterdocno="+document.getElementById("masterdoc_no").value+"&invno="+document.getElementById("invno").value+"&vehpurinvDate="+document.getElementById("vehpurinvDate").value+"&loanaccdocno="+loanaccdocno+"&loanamount="+loanamount+"&tax=0&dealno="+dealno,true);
        }
        x.send();
    }

	function funeditpost() {
		if (($("#mode").val() == "view") && parseInt(document.getElementById("masterdoc_no").value)>0) {
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                    var items=x.responseText;
                    var chkstatus=items.trim();
                    if(parseInt(chkstatus)==1) {
                        $.messager.alert('Message','Posting Already Done ','warning');   
                        return 0;
                    } else {
                        var rows1 = $("#vehoredergrid").jqxGrid('getrows');
                        for(var i=0 ; i < rows1.length ; i++){
                            var brdid=rows1[i].brdid;
                            if(parseInt(brdid)>=0) {
                                var flstatus=rows1[i].flstatus;
                                if(parseInt(flstatus)!=1) {
                                    document.getElementById("errormsg").innerText="Update All Fleet Before Posting";  
                                    return 0;
                                }
                            }
                        }
                        $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                        document.getElementById("invno").value="";
                        $('#invno').attr('readonly', false);
                        $("#btnCalculate").prop("disabled", false);
                        $("#updateposting").prop("disabled", false);
                    }
                }
			}
			x.open("GET","checkUpdate.jsp?masterdocno="+ document.getElementById("masterdoc_no").value,true);
			x.send();
		} else {
            $.messager.alert('Message','Select a Document....!','warning');
            return 0;
        }
	}
 
	function funupdateposting() {
        if(document.getElementById("invno").value=="") {
            document.getElementById("errormsg").innerText="Enter Inv No";  
            document.getElementById("invno").focus();
            return 0;
        }
        if(parseInt(document.getElementById("validatepostcalu").value)==1) {
            $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                if(r==false) {
                    return false; 
                } else {
                    var rows = $("#vehoredergrid").jqxGrid('getrows');
                    $('#vehpurchasegridlenght').val(rows.length);
                    for(var i=0 ; i < rows.length ; i++){
                        newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "vehpurchasetest"+i)
                            .attr("name", "vehpurchasetest"+i) 
                            .attr("hidden", "true"); 
                        newTextBox.val(rows[i].fleet_no+"::"+rows[i].rowno+" :: "+rows[i].price+" :: ");
                        newTextBox.appendTo('form');
                    }
                    $("table#finance input").prop("disabled", false);
                    $("table#finance select").prop("disabled", false);
                    $("table#finance input").prop("readonly", false);
                    $("table#finance select").prop("readonly", false);  
                    $('#jqxStartDate').jqxDateTimeInput({disabled: false});  
                    $('#uptoDate').jqxDateTimeInput({disabled: false}); 
                    $('#frmpurchase input').attr('disabled', false );
                    $('#frmpurchase input').attr('readonly', false );
                    $('#frmpurchase select').attr('disabled', false);
                    $("#vehoredergrid").jqxGrid({ disabled: false});
                    $('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurinvDate').jqxDateTimeInput({disabled: false});
                    $('#vehpurorderDate').jqxDateTimeInput({disabled: false});
                    $('#vehrefno').attr('disabled', false);
                    document.getElementById("mode").value="POS";
                    document.getElementById("fleetupdateval").value="";
                    document.getElementById("msg").value="";
                    $('#frmpurchase').submit();
                }
            });
        } else {
            document.getElementById("errormsg").innerText="Calculate Before Posting";  
            return 0;
        }
	}
	  
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            document.getElementById("errormsg").innerText=" Enter Numbers Only";  
            return false;
        }
	    document.getElementById("errormsg").innerText="";  
	    return true;
	}  
	
	function funcheckaccinvendor() {
		if(document.getElementById("accid").value=="") {
            document.getElementById("errormsg").innerText="Search Vendor";  
            document.getElementById("accid").focus();
            return 0;
		}
	}
	
	function paymtchg() {
		document.getElementById("errormsg").innerText="";  
	}
	
    function funPrintBtn(){
        if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
            var url=document.URL;
            var reurl=url.split("savePurchase");
            $("#docno").prop("disabled", false);                
            var dtype=$('#formdetailcode').val();
            var win= window.open(reurl[0]+"printPurchase?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        } else {
            $.messager.alert('Message','Select a Document....!','warning');
            return false;
        }
    } 
	 
    function funchkunique() {
        var x =new XMLHttpRequest();
        x.onreadystatechange=function() {
            if(x.readyState==4 && x.status==200) {
                var items=x.responseText;
                var chk=items.trim();
                if(parseInt(chk)==1) {
                    document.getElementById("errormsg").innerText="Deal No "+document.getElementById("dealno").value+" Already Exists ";  
                    document.getElementById("dealno").value="";
                    return 0;
                } else {
                    document.getElementById("errormsg").innerText="";
                }
            }
        }
        x.open("GET","checkdealno.jsp?dealno="+document.getElementById("dealno").value+"&masterdoc="+document.getElementById("masterdoc_no").value);
        x.send();
    }

    function saveExcelDataData(docNo){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items=x.responseText.trim();
                if(items==1){
                    $("#detailsdiv").load("distributionGrid.jsp?docNo="+docNo);
                    $.messager.alert('Message', ' Successfully Imported.', function(r){});
                }
            }
        }
        x.open("GET","saveData.jsp?docNo="+docNo,true);
        x.send();
    }
		
    function getAttachDocumentNo(){
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items=x.responseText.trim();
                if(items>0){
                    var path=document.getElementById("file").value;
                    var fsize = $('#file')[0].files[0].size;
                    var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
                    
                    if((extn=='xls') || (extn=='csv')){ 
                        ajaxFileUpload(items);	
                    }else{
                        $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                        return;
                    } 
                }
            }
        }
        x.open("GET","getAttachDocumentNo.jsp",true);
        x.send();
    }
		
    function upload(){
        $('#txtexcelvalidation').val(1);
        getAttachDocumentNo();
    }
		
    function ajaxFileUpload(docNo) {  
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            var fsize = $('#file')[0].files[0].size;
            if(fsize>1048576) {
                $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); 
                return;
            }
        }else{
            $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
            }); 
            return;
        }
        $.ajaxFileUpload({  
            url:'fileAttachAction.action?formCode=VPUE&doc_no='+docNo+'&descpt=Excel Import' ,
            secureuri:false,  
            fileElementId:'file',    
            dataType: 'json', 
            success: function (data, status) {  
                if(status=='success'){
                    saveExcelDataData(docNo);
                    $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                        style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                    }); 
                }
                if(typeof(data.error) != 'undefined') {  
                    if(data.error != '') {  
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }else {  
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }  
                }  
            },  
            error: function (data, status, e){  
                $.messager.alert('Message',e);
            }  
        });  
        return false;  
    }
	
    function funeditdeal() {
        if(document.getElementById("editdeal").value.trim()=="Edit") {
            $("#dealno").prop("disabled", false);
            $("#dealno").prop("readonly", false);
            document.getElementById("editdeal").value="Save";
        } else if(document.getElementById("editdeal").value.trim()=="Save" && document.getElementById("errormsg").innerText=="") {
            var dealno=document.getElementById("dealno").value;
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
                if (x.readyState==4 && x.status==200) {
                    var items=x.responseText.trim();
                    if(items==1){
                        $.messager.alert('Message', ' Deal No Successfully Updated.');
                        document.getElementById("editdeal").value="Edit";
                        $("#dealno").prop("disabled", true);
                        $("#dealno").prop("readonly", true);
                    }
                }
            }
            x.open("GET","updateDealNo.jsp?dealno="+dealno+"&masterdoc="+document.getElementById("masterdoc_no").value,true);
            x.send();
        }
    }
</script>
</head>

<body onload="setValues();getNonTaxableEntity();">
<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    
    <div class='modern-ui hidden-scrollbar'>
        <form id="frmpurchase" action="savePurchase" method="post" autocomplete="off">
            
            <div class="middle-panel">
                <span class="middle-panel-title">Document Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Date</label>
                    <div style="width: 125px;">
                        <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
                    
                    <label class="lbl-right" style="width:80px;">Type</label>
                    <select id="vehtype" name="vehtype" style="width:120px;" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="VPO">VPO</option>
                    </select>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                    <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly />
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Vendor</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="accid" name="accid" placeholder="Press F3" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)" />
                        <svg class="magnifier-icon" onclick="$('#accid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="vehpuraccname" name="vehpuraccname" value='<s:property value="vehpuraccname"/>' style="flex:1;" tabindex="-1" readonly />

                    <label class="lbl-right" style="width:80px;">Ref No</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="vehrefno" name="vehrefno" placeholder="Press F3" value='<s:property value="vehrefno"/>' onfocus="funcheckaccinvendor();" onkeydown="getrefDetails(event)" />
                        <svg class="magnifier-icon" onclick="$('#vehrefno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Exp. Delivery</label>
                    <div style="width: 125px;">
                        <div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/>

                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" id="vehdesc" name="vehdesc" value='<s:property value="vehdesc"/>' style="flex:1;" />
                    
                    <button type="button" class="myButton" name="updatefleet" id="updatefleet" onclick="funupdatefleet()" style="margin-left:10px;">Fleet Update</button>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Purchase Details</span>
                <div id="vehpuchase" class="grid-container">
                    <jsp:include page="vehpurchaseDetails.jsp"></jsp:include>
                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Finance Details & Distribution</span>
                <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                    
                    <!-- Left Side: Finance -->
                    <div style="flex: 0 0 45%;">
                        <table id="finance" style="width: 100%; border-collapse: collapse; display: block;">
                            <tbody>
                                <tr>
                                    <td style="width: 100%;">
                                        <div class="field-row" style="justify-content: flex-end;">
                                            <label class="lbl-right" style="width:100px;" id="taxlabel">Tax Amount</label>
                                            <div id="taxbox" style="display:inline-block;">
                                                <input type="text" id="taxamount" name="taxamount" style="width:100px; text-align:right;" readonly value='<s:property value="taxamount"/>' />
                                            </div>

                                            <label class="lbl-right" style="width:100px;">Total Amount</label>
                                            <input type="text" id="totalamt" name="totalamt" style="width:100px; text-align:right;" readonly value='<s:property value="totalamt"/>' />
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Down Payment</label>
                                            <input type="text" id="downpayment" name="downpayment" style="width:100px; text-align:right;" onblur="funRoundAmt(this.value,this.id);calculateval();" onkeypress="javascript:return isNumber(event)" value='<s:property value="downpayment"/>'/>
                                            
                                            <label class="lbl-right" style="width:100px; margin-left:auto;">Loan Amount</label>
                                            <input type="text" id="loanamount" name="loanamount" tabindex="-1" style="width:100px; text-align:right;" value='<s:property value="loanamount"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Start Date</label>
                                            <div style="width: 125px;">
                                                <div id="jqxStartDate" name="jqxStartDate" value='<s:property value="jqxStartDate"/>'></div>
                                            </div>
                                            <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                                            
                                            <label class="lbl-right" style="width:100px; margin-left:auto;">% Of Interest</label>
                                            <input type="text" id="perinterest" name="perinterest" style="width:100px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="perinterest"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Calcu. Method</label>
                                            <select id="calcumethod" name="calcumethod" style="width:125px;">
                                                <option value=1>Flat Rate</option>
                                                <option value=2>Diminishing rate</option>
                                            </select>
                                            
                                            <label class="lbl-right" style="width:100px; margin-left:auto;">Number Of Inst</label>
                                            <input type="text" id="instnos" name="instnos" style="width:100px;" onkeypress="javascript:return isNumber(event)" value='<s:property value="instnos"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Acc(Financier)</label>
                                            <div class="input-search-container" style="width: 125px;">
                                                <input type="text" id="financeaccid" name="financeaccid" placeholder="Press F3" value='<s:property value="financeaccid"/>' onkeydown="getfinacc(event);" />
                                                <svg class="magnifier-icon" onclick="$('#financeaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                            </div>
                                            <input type="text" id="financeaccname" name="financeaccname" tabindex="-1" style="flex:1;" value='<s:property value="financeaccname"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Bank A/C</label>
                                            <div class="input-search-container" style="width: 125px;">
                                                <input type="text" id="bankaccid" name="bankaccid" placeholder="Press F3" value='<s:property value="bankaccid"/>' onkeydown="getbankacc(event);" />
                                                <svg class="magnifier-icon" onclick="$('#bankaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                            </div>
                                            <input type="text" id="bankaccname" name="bankaccname" tabindex="-1" style="flex:1;" value='<s:property value="bankaccname"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Interest A/C</label>
                                            <div class="input-search-container" style="width: 125px;">
                                                <input type="text" id="interestaccid" name="interestaccid" placeholder="Press F3" value='<s:property value="interestaccid"/>' onkeydown="getInterestacc(event);" />
                                                <svg class="magnifier-icon" onclick="$('#interestaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                            </div>
                                            <input type="text" id="intaccname" name="intaccname" tabindex="-1" style="flex:1;" value='<s:property value="intaccname"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Loan A/C</label>
                                            <div class="input-search-container" style="width: 125px;">
                                                <input type="text" id="loanaccid" name="loanaccid" placeholder="Press F3" value='<s:property value="loanaccid"/>' onkeydown="getloanacc(event);" />
                                                <svg class="magnifier-icon" onclick="$('#loanaccid').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                            </div>
                                            <input type="text" id="loanaccname" name="loanaccname" tabindex="-1" style="flex:1;" value='<s:property value="loanaccname"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Sec. Cheque NO</label>
                                            <input type="text" id="secchaqueno" name="secchaqueno" style="flex:1;" value='<s:property value="secchaqueno"/>' />
                                            
                                            <label class="lbl-right" style="width:60px;">Amount</label>
                                            <input type="text" id="chqamount" name="chqamount" style="width:100px; text-align:right;" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="chqamount"/>' />
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Upto Date</label>
                                            <div style="width: 125px;">
                                                <div id="uptoDate" name="uptoDate" value='<s:property value="uptoDate"/>'></div>
                                            </div>
                                            <input type="hidden" id="hiduptoDate" name="hiduptoDate" value='<s:property value="hiduptoDate"/>'/>
                                            
                                            <button type="button" class="myButton" name="editdeal" id="editdeal" onclick="funeditdeal()" style="display:none; margin-left:auto; margin-right:5px;">Edit</button>
                                            <label class="lbl-right" style="width:60px;">Deal No</label>
                                            <input type="text" id="dealno" name="dealno" style="width:100px;" onblur="funchkunique()" value='<s:property value="dealno"/>'>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Name In Cheque</label>
                                            <input type="text" id="nameincheque" name="nameincheque" style="flex:1;" value='<s:property value="nameincheque"/>'/>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Payment Method</label>
                                            <select id="paymentmethod" name="paymentmethod" style="width:125px;" onchange="paymtchg()">
                                                <option value="">--Select--</option>
                                                <option value=1>Cheque</option> 
                                                <option value=2>Direct Debit</option> 
                                            </select>
                                        </div>

                                        <div class="field-row">
                                            <label class="lbl-right" style="width:100px;">Description</label>
                                            <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
                                        </div>

                                        <div class="field-row" style="justify-content: center; margin-top: 15px;">
                                            <button type="button" class="myButton" id="calculatebtn" name="calculatebtn" onclick="calculate();">Calculate</button>
                                            <button type="button" class="myButton" id="updatebtn" name="updatebtn" onclick="funUpdate();">Edit</button>
                                        </div>

                                        <div class="field-row" style="justify-content: flex-end; margin-top: 5px;">
                                            <button class="icon myButton" style="background:transparent; border:none; box-shadow:none; padding:0; height:auto!important;" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
                                                <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
                                            </button>
                                            <input type="file" id="file" name="file" style="margin-left:10px; font-size:11px;" />
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Right Side: Distribution -->
                    <div style="flex: 1; min-width: 300px;">
                        <div id="detailsdiv" class="grid-container" style="height: 100%;">
                            <jsp:include page="distributionGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>
            </div>

            <div class="middle-panel">
                <span class="middle-panel-title">Posting</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Inv No</label>
                    <input type="text" id="invno" name="invno" style="width:120px;" value='<s:property value="invno"/>'/>
                    
                    <label class="lbl-right" style="width:100px;">Purchase Date</label>
                    <div style="width: 125px;">
                        <div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
                    </div>
                    <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
                    
                    <div style="margin-left: auto; display:flex; gap:10px; align-items:center;">
                        <button type="button" class="icon" style="background:transparent; border:none; cursor:pointer;" id="btnCalculate" title="Calculate" onclick="funpostcalcu();">
                            <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
                        </button> 
                        <button type="button" class="myButton" name="updateposting" id="updateposting" onclick="funupdateposting()">Posting</button>
                        <button type="button" class="myButton" name="editss" id="editss" onclick="funeditpost()">Edit</button>
                    </div>
                </div>

                <div id="postingdiv" class="grid-container" style="min-height: 150px;">
                    <jsp:include page="postinggrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Fields (Retained explicitly for JS functionality) -->
            <div style="display:none;">
                <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>   
                <input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                <input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
                <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
                <input type="hidden" id="pricetottal" name="pricetottal" value='<s:property value="pricetottal"/>'/>
                <input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
                <input type="hidden" id="hidtaxamount" name="hidtaxamount" value='<s:property value="hidtaxamount"/>'/>
                <input type="hidden" id="hidtotalamt" name="hidtotalamt" value='<s:property value="hidtotalamt"/>'/>
                <input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght" value='<s:property value="vehpurchasegridlenght"/>'/>
                <input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>
                <input type="hidden" id="dimqty" name="dimqty" value='<s:property value="dimqty"/>'/>
                <input type="hidden" id="fleetupdateval" name="fleetupdateval" value='<s:property value="fleetupdateval"/>'/> 
                <input type="hidden" id="detval" name="detval" value='<s:property value="detval"/>'/>
                <input type="hidden" id="calcuval" name="calcuval" value='<s:property value="calcuval"/>'/>
                <input type="hidden" id="paymentval" name="paymentval" value='<s:property value="paymentval"/>'/> 
                <input type="hidden" id="distributionlenght" name="distributionlenght" value='<s:property value="distributionlenght"/>'/>
                <input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>
                <input type="hidden" id="totalamount" name="totalamount" value='<s:property value="totalamount"/>'/>
                <input type="hidden" id="validatepostcalu" name="validatepostcalu" value='<s:property value="validatepostcalu"/>'/>
                <input type="hidden" id="bankcurrency" name="bankcurrency" value='<s:property value="bankcurrency"/>'/>
                <input type="hidden" id="bankrate" name="bankrate" value='<s:property value="bankrate"/>'/>
                <input type="hidden" id="intercurrency" name="intercurrency" value='<s:property value="intercurrency"/>'/>
                <input type="hidden" id="interrate" name="interrate" value='<s:property value="interrate"/>'/>
                <input type="hidden" id="loancurrecy" name="loancurrecy" value='<s:property value="loancurrecy"/>'/>
                <input type="hidden" id="loanrate" name="loanrate" value='<s:property value="loanrate"/>'/>
                <input type="hidden" id="vendorcurr" name="vendorcurr" value='<s:property value="vendorcurr"/>'/>
                <input type="hidden" id="vendorrate" name="vendorrate" value='<s:property value="vendorrate"/>'/>
                <input type="hidden" id="finaccdocno" name="finaccdocno" value='<s:property value="finaccdocno"/>'/>
                <input type="hidden" id="banckaccdocno" name="banckaccdocno" value='<s:property value="banckaccdocno"/>'/>  
                <input type="hidden" id="interestaccdocno" name="interestaccdocno" value='<s:property value="interestaccdocno"/>'/>
                <input type="hidden" id="loanaccdocno" name="loanaccdocno" value='<s:property value="loanaccdocno"/>'/>
                <input type="hidden" id="clstatus" name="clstatus" value='<s:property value="clstatus"/>'/>
                <input type="hidden" id="masterstatus" name="masterstatus" value='<s:property value="masterstatus"/>'/>
                <input type="hidden" id="tranno" name="tranno" value='<s:property value="tranno"/>'/>
                <input type="hidden" id="priamounts" name="priamounts" value='<s:property value="priamounts"/>'/> 
                <input type="hidden" id="dealver" name="dealver" value="0"/>
                <input type="hidden" id="restructure" name="restructure" value='<s:property value="restructure"/>'/>
                <input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
                <input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>
            </div>

        </form>

        <div id="colorsearchwndow"><div></div></div>
        <div id="modelsearchwndow"><div></div></div>
        <div id="brandsearchwndow"><div></div></div>
        <div id="accountSearchwindow"><div></div></div>
        <div id="refnosearchwindow"><div></div></div>
        <div id="fleetwindow"><div></div></div>
        <div id="slnosearchwindow"><div></div></div>
        
    </div>
</div>
</body>
</html>