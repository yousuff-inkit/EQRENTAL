<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../css/body.css"> 
<jsp:include page="../../../includes.jsp"></jsp:include>
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

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error {
    color:red;
    font-weight:bold;
}
</style> 
<script type="text/javascript">
     $(document).ready(function ()
    		 {
    	 $('#btnEdit').attr('disabled',true);
    	 $('#btnDelete').attr('disabled',true);
    	 
    	 getBranch();
    	 
    	 document.getElementById("deliveryfield").style.display="none";
    	 document.getElementById("collectionfield").style.display="none";
		 if(document.getElementById("hidchkgaragedelivery").value==1){
    		 document.getElementById("chkgaragedelivery").checked=true;
    		 checkGarageDelivery();
    	 }
    	 if(document.getElementById("hidchkgaragedelivery").value==0){
    		 document.getElementById("chkgaragedelivery").unchecked=true;
    		 checkGarageDelivery();
    	 }
    	 if(document.getElementById("hidchkgaragecollect").value==1){
    		 document.getElementById("chkgaragecollect").checked=true;
    		 checkGarageCollection();
    	 }
    	 if(document.getElementById("hidchkgaragecollect").value==0){
    		 document.getElementById("chkgaragecollect").unchecked=true;
    		 checkGarageCollection();
    	 }  
    	 checkStaff();
    	 
         /* Updated heights to strictly match 24px Modern UI Constraints */
    	  $("#date").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	  $("#dateout").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
    	  $("#closedate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
    	  $("#dateouthidden").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    	  $("#garagedeldate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
    	  $("#garagecollectdate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
    	  
          $("#timeout").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:null, theme: 'energyblue' });
          $("#closetime").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:null, theme: 'energyblue' });
          $("#timeouthidden").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, theme: 'energyblue' });
          $("#garagedeliverytime").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:null, theme: 'energyblue' });
          $("#garagecollecttime").jqxDateTimeInput({ width: '80px', height: 24, formatString: 'HH:mm', showCalendarButton: false, value:null, theme: 'energyblue' });
          
          $("#hiddelivery").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
          $("#hidcollect").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
              $("#date, #dateout, #closedate, #garagedeldate, #garagecollectdate, #timeout, #closetime, #garagedeliverytime, #garagecollecttime").find("input").css({
                  "margin-top": "0px",
                  "line-height": "24px",
                  "font-size": "12px", 
                  "font-family": "Arial, sans-serif", 
                  "padding": "0 6px", 
                  "box-sizing":"border-box"
              });
              $("#date, #dateout, #closedate, #garagedeldate, #garagecollectdate, #timeout, #closetime, #garagedeliverytime, #garagecollecttime").find(".jqx-action-button").css({
                  "top": "0px",
                  "height": "24px"
              });
          }, 0);

         document.getElementById("garageContainer").style.display="none";
    	 document.getElementById("staffContainer").style.display="none";
     	 document.getElementById("btnclosesave").style.display="none";
    	 document.getElementById("btndeliverysave").style.display="none"; 
    	
    	$('#dateout').on('change', function (event) {  
        	if($('#dateout').jqxDateTimeInput('getDate')!=null){
        		var date=new Date($('#dateout').jqxDateTimeInput('getDate'));
        		var status=checkfuturedatenew(date);
        		if(status){
        			document.getElementById("errormsg").innerText="";
        			return true;
        		} else{
        			$('#dateout').jqxDateTimeInput('focus');
        			return false;
        		}
        	}
    	});
    	
    	$('#closedate').on('change', function (event) {  
        	if($('#closedate').jqxDateTimeInput('getDate')!=null){
        		var date=new Date($('#closedate').jqxDateTimeInput('getDate'));
        		var status=checkfuturedatenew(date);
        		if(status){
        			document.getElementById("errormsg").innerText="";
        			return true;
        		} else{
        			$('#closedate').jqxDateTimeInput('focus');
        			return false;
        		}
        	}
    	});
    	
    	$('#garagedeldate').on('change', function (event) {  
        	if($('#garagedeldate').jqxDateTimeInput('getDate')!=null){
        		var date=new Date($('#garagedeldate').jqxDateTimeInput('getDate'));
        		var status=checkfuturedatenew(date);
        		if(status){
        			document.getElementById("errormsg").innerText="";
        			return true;
        		} else{
        			$('#garagedeldate').jqxDateTimeInput('focus');
        			return false;
        		}
        	}
    	});
    	
    	$('#garagecollectdate').on('change', function (event) {  
        	if($('#garagecollectdate').jqxDateTimeInput('getDate')!=null){
        		var date=new Date($('#garagecollectdate').jqxDateTimeInput('getDate'));
        		var status=checkfuturedatenew(date);
        		if(status){
        			document.getElementById("errormsg").innerText="";
        			return true;
        		} else{
        			$('#garagecollectdate').jqxDateTimeInput('focus');
        			return false;
        		}
        	}
    	});
    	
     	$('#timeout').on('change', function (event) {  
    	    	if($('#timeout').jqxDateTimeInput('getDate')!=null){
        	    	var date=$('#dateout').jqxDateTimeInput('getDate');
        	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
        	    		document.getElementById("errormsg").innerText="Please select a valid date";
        	    		$('#dateout').jqxDateTimeInput('focus');
        	    		return false;
        	    	} else{
        		    	var time=$('#timeout').jqxDateTimeInput('getDate');
        		    	var status=checkfuturetime(date,time);
        		    	if(status){
        		    		document.getElementById("errormsg").innerText="";
        		    		return true;	
        		    	} else{
        		    		$('#timeout').jqxDateTimeInput('focus');
        		    		return false;
        		    	}	    		
        	    	}
    	      }
     	}); 
     	
     	$('#garagecollecttime').on('change', function (event) {  
    	    	if($('#garagecollecttime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#garagecollectdate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#garagecollectdate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	} else{
	    		    	var time=$('#garagecollecttime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	} else{
	    		    		$('#garagecollecttime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	      }
     	});
     	
    	$('#garagedeliverytime').on('change', function (event) {  
    	    	if($('#garagedeliverytime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#garagedeldate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#garagedeldate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	} else{
	    		    	var time=$('#garagedeliverytime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	} else{
	    		    		$('#garagedeliverytime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	      }
     	});
    	
    	$('#closetime').on('change', function (event) {  
    	    	if($('#closetime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#closedate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#closedate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	} else{
	    		    	var time=$('#closetime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	} else{
	    		    		$('#closetime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	      }
     	});
    	
    	 if(document.getElementById("docno").value==''){
    		 $('#btnclose').prop('disabled',true);
    	 }
    	 else if((document.getElementById("closekm").value=='')||(document.getElementById("closekm").value==0.0)){
    		 $('#btnclose').prop('disabled',false);
    	 }
    	 else{
    		 $('#btnclose').prop('disabled',true);
    	 }
    	 if(document.getElementById("chkgaragedelivery").checked==true){
    		 $('#garagedeldate').jqxDateTimeInput({ disabled:false});
    		 if($('#garagedeldate').jqxDateTimeInput('getDate')==null){
    			 $('#btndeliveryupdate').prop('disabled',false);	 
    		 }
    		 $('#garagedeldate').jqxDateTimeInput({ disabled:true});
    	 }
    	 else{
    		 $('#btndeliveryupdate').prop('disabled',true);
    	 }
    	
         checkStaff();
    	 getAccidents();

       $('#fleetwindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Equipment Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	   $('#fleetwindow').jqxWindow('close');
   	   $('#driverwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#driverwindow').jqxWindow('close');
 	   $('#staffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#staffwindow').jqxWindow('close');
   	   $('#maintenancewindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Maintenance Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#maintenancewindow').jqxWindow('close');
 	   $('#garagewindow').jqxWindow({ autoOpen:false,width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#garagewindow').jqxWindow('close');
       
       $('#txtfleetno').dblclick(function(){
           if(document.getElementById("mode").value=="A"){
               $('#fleetwindow').jqxWindow('open');
               $('#fleetwindow').jqxWindow('focus');
               fleetSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
           }
       });
   	 
   	 $('#driver').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){
   			if(document.getElementById("cmbstatus").value==""){
 			   document.getElementById("errormsg").innerText="Please Select Movement Type";
 			   document.getElementById("cmbstatus").focus();
 			   return false;
 		    }
   			$('#driverwindow').jqxWindow('open');
   			$('#driverwindow').jqxWindow('focus');
   			 driverSearchContent('driverSearch.jsp?id=1&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow')); 
   		 }
	  });
      
   	 $('#staff').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){
            $('#staffwindow').jqxWindow('open');
            $('#staffwindow').jqxWindow('focus');
            staffSearchContent('staffSearch.jsp?id=1', $('#staffwindow'));
   		 }
	 });
     
   	 $('#garage').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){
            $('#garagewindow').jqxWindow('open');
            $('#garagewindow').jqxWindow('focus');
            garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
   		 }
	 });
     
   	 $('#closestaff').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){   
            $('#staffwindow').jqxWindow('open');
            $('#staffwindow').jqxWindow('focus');
            staffSearchContent('staffSearch.jsp?id=2', $('#staffwindow'));
   		 }
	 });
     
   	 $('#closedriver').dblclick(function(){
   		 if(document.getElementById("mode").value=="close"){ 
            $('#driverwindow').jqxWindow('open');
            $('#driverwindow').jqxWindow('focus');
            driverSearchContent('driverSearch.jsp?id=2&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
   		 }
	 });

      if(document.getElementById("clstatus").value=='1'){
    	 document.getElementById("btnclose").style.display="none";
     } else{
    	 document.getElementById("btnclose").style.display="block";
     }
    });
	 
     function checkfuturedatenew(date){
    	 var date1=new Date(date);
    	 date1.setHours(0,0,0,0);
    	 var currentdate=new Date();
    	 currentdate.setHours(0,0,0,0);
    	 if(date1>currentdate){
    		 document.getElementById("errormsg").innerText="Future Date Not Allowed";
    		 return false;
    	 } else{
    		 return true;
    	 }
     }
     
 	function checkfuturetime(date,time){
 		var date1=new Date(date);
 		var time1=new Date(time);
 		var currentdate = new Date(); 
 		var currenthours=currentdate.getHours();
 		var currentminutes=currentdate.getMinutes();
 		var time1hours=time1.getHours();
 		var time1minutes=time1.getMinutes();
 		date1.setHours(0,0,0,0);
 		currentdate.setHours(0,0,0,0);
 		if(date1-currentdate==0){
 			if(time1hours>currenthours){
 				document.getElementById("errormsg").innerText="Future Time Not Allowed";
 				return false;
 			}
 			else if(time1hours==currenthours){
 				if(time1minutes>currentminutes){
 					document.getElementById("errormsg").innerText="Future Time Not Allowed";
 					return false;
 				}
 			}
 		}
 		return true;
 	}
	 
     function checkfuturedate(){
 		var date1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
 		var futuredate=new Date();
 		date1.setHours(0,0,0,0);
 		futuredate.setHours(0,0,0,0);
 		if(date1>futuredate){
            document.getElementById("errormsg").innerText="Future Date Cannot be applied";
            $('#dateout').jqxDateTimeInput('focus'); 
            return false;
        }
        document.getElementById("errormsg").innerText="";
        return true;
 	}
    
     function checkStaff(){
    	 $('#cmbstatus').prop('disabled',false);
    	 var temp=document.getElementById("cmbstatus").value;
    	 if(temp=="ST"){
    		 document.getElementById("garageContainer").style.display="none";
    		 document.getElementById("staffContainer").style.display="flex";
    		 document.getElementById("driver").disabled=true;
    		 document.getElementById("closedriver").disabled=true;
    		 document.getElementById("closestaff").disabled=false;
    		 $('#chkgaragedelivery').attr('disabled', true);
    		 $('#chkgaragecollect').attr('disabled', true); 
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="none";
        	 document.getElementById("collectionfield").style.display="none";
    	 }
    	 else if(temp=='GA'||temp=='GM'||temp=='GS'){
    		 document.getElementById("staffContainer").style.display="none";
    		 document.getElementById("closestaff").disabled=true;
     		 document.getElementById("driver").disabled=false;
     		 document.getElementById("closedriver").disabled=false;
    		 document.getElementById("garageContainer").style.display="flex";
    		 $('#chkgaragedelivery').attr('disabled', false);
    		 $('#chkgaragecollect').attr('disabled', false);
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="block";
        	 document.getElementById("collectionfield").style.display="block";
    	 }
    	 else{
    		 document.getElementById("driver").disabled=false;
    		 document.getElementById("closedriver").disabled=false;
    		 document.getElementById("closestaff").disabled=true;
    		 document.getElementById("garageContainer").style.display="none";
    		 document.getElementById("staffContainer").style.display="none";
    		 $('#chkgaragedelivery').attr('disabled', true);
    		 $('#chkgaragecollect').attr('disabled', true); 
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="none";
        	 document.getElementById("collectionfield").style.display="none";
    	 }
     }
     
     function fleetSearchContent(url) {
   	    $.get(url).done(function (data) {
   	        $('#fleetwindow').jqxWindow('setContent', data);
   	    }); 
   	 }
     function driverSearchContent(url) {
        $.get(url).done(function (data) {
    	    $('#driverwindow').jqxWindow('setContent', data);
    	}); 
     }
     function staffSearchContent(url) {
 	    $.get(url).done(function (data) {
 	        $('#staffwindow').jqxWindow('setContent', data);
 	    }); 
 	 }
     function garageSearchContent(url) {
  	    $.get(url).done(function (data) {
  	        $('#garagewindow').jqxWindow('setContent', data);
  	    }); 
  	 }
     function maintenanceSearchContent(url) {
        $.get(url).done(function (data) {
    	    $('#maintenancewindow').jqxWindow('setContent', data);
    	}); 
     }
     function getFleet(event){
         var x= event.keyCode;
         if(document.getElementById("mode").value=="A"){
             if(x==114){
                 $('#fleetwindow').jqxWindow('open');
                 $('#fleetwindow').jqxWindow('focus');
                 fleetSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
             }
         }
     }
     function getGarage(event){
    	 var x= event.keyCode;
    	 if(document.getElementById("mode").value=="A"){
    	     if(x==114){
        	     $('#garagewindow').jqxWindow('open');
      		     $('#garagewindow').jqxWindow('focus');
      		     garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
             }
    	 }
     }
     function getDriver(event,value){   
    	var aa=value;
         var x= event.keyCode;
         if(x==114){
           if(aa==1){
    	       if(document.getElementById("mode").value=="A"){
    		       if(document.getElementById("cmbstatus").value==""){
    			       document.getElementById("errormsg").innerText="Please Select Movement Type";
    			       document.getElementById("cmbstatus").focus();
    			       return false;
    		       }
                   $('#driverwindow').jqxWindow('open');
      		       $('#driverwindow').jqxWindow('focus');
      		       driverSearchContent('driverSearch.jsp?id=1&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
    	       }
    	   }
           else if(aa==2){
    	       if(document.getElementById("mode").value=="close"){
    		       $('#driverwindow').jqxWindow('open');
      		       $('#driverwindow').jqxWindow('focus');
      		       driverSearchContent('driverSearch.jsp?id=2&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
    	       }
           }
         }
     }
     function getStaff(event,value){   
     	var aa=value;
        var x= event.keyCode;
        if(document.getElementById("mode").value=="A"){
          if(x==114){
            if(aa==1){
        	    $('#staffwindow').jqxWindow('open');
       		    $('#staffwindow').jqxWindow('focus');
       		    staffSearchContent('staffSearch.jsp?id=1', $('#staffwindow'));
            }
            else if(aa==2){
        	    $('#staffwindow').jqxWindow('open');
       		    $('#staffwindow').jqxWindow('focus');
       		    satffSearchContent('staffSearch.jsp?id=2', $('#staffwindow'));
            }
          }
        }
     }
     
    function funReset(){}
    
  	function funReadOnly(){
  		$('#frmEquipMovement input').attr('readonly', true );
  		$('#frmEquipMovement select').attr('disabled', true);
  		$('#frmEquipMovement checkbox').attr('disabled', true);
  		$('#frmEquipMovement textarea').attr('readonly', true );
  		if($('#date').jqxDateTimeInput('disabled')==false){
  			$('#date').jqxDateTimeInput({ disabled: true});
  		}
  		if($('#dateout').jqxDateTimeInput('disabled')==false){
  			$('#dateout').jqxDateTimeInput({ disabled: true});	
  		}
		if($('#closedate').jqxDateTimeInput('disabled')==false){
			$('#closedate').jqxDateTimeInput({ disabled: true});
		}
  		if($('#timeout').jqxDateTimeInput('disabled')==false){
  			$('#timeout').jqxDateTimeInput({ disabled: true});
  		}
  		if($('#closetime').jqxDateTimeInput('disabled')==false){
  			$('#closetime').jqxDateTimeInput({ disabled: true});
  		}
   	    checkStaff();
  	}
  	
  	function funRemoveReadOnly(){
  	 	$('#frmEquipMovement input').attr('readonly', false );
  		$('#frmEquipMovement select').attr('disabled', false);
  		$('#frmEquipMovement textarea').attr('readonly', false );
  		$('#frmEquipMovement checkbox').attr('disabled', false);
  		$('#date').jqxDateTimeInput({ disabled: false});
  		$('#dateout').jqxDateTimeInput({ disabled: false});
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		$('#timeout').jqxDateTimeInput({ disabled: false});
  		$('#closetime').jqxDateTimeInput({ disabled: false});
  		$('#docno').attr('readonly', true); 
  		var session1='<%=session.getAttribute("USERNAME")!=null?session.getAttribute("USERNAME").toString():""%>';
  		var session2='<%=session.getAttribute("USERID")!=null?session.getAttribute("USERID").toString():""%>';
  		$('#outuser').val(session1);
  		$('#outuserid').val(session2);
  		$('#txtfleetno').attr('readonly', true );
  		$('#txtfleetname').attr('readonly', true );
  		$('#staff').attr('readonly', true );
  		$('#garage').attr('readonly', true );
  		$('#driver').attr('readonly', true );
  		$('#outuser').attr('readonly', true );
  		$('#closestaff').attr('readonly', true );
  		$('#closeuser').attr('readonly', true );
  		$('#totalkm').attr('readonly', true );
  		getTestLocation();
  		
  	    if(document.getElementById("mode").value=="A" && document.getElementById("chkstatus").value!="1"){
  		    $('#date').jqxDateTimeInput({ value: new Date()});
  		    $('#dateout').jqxDateTimeInput({ value: null});
  		    $('#timeout').jqxDateTimeInput({ value:null});
  		    $('#garagedeldate').jqxDateTimeInput({ value: null});
  		    $('#garagedeliverytime').jqxDateTimeInput({ value: null});
  		    $('#garagecollectdate').jqxDateTimeInput({ value:null});
  		    $('#garagecollecttime').jqxDateTimeInput({ value: null});
  		    $('#closedate').jqxDateTimeInput({ value:null});
  		    $('#closetime').jqxDateTimeInput({ value: null}); 
  		    document.getElementById("btnclose").style.display="block";
  		    document.getElementById("accfines").value="0.0";
  		    $('#outuser').val('');
  		    document.getElementById("btndeliverysave").style.display="none";
  		    document.getElementById("btndeliveryupdate").style.display="block";
  		    document.getElementById("btndeliveryupdate").disabled=true;
 	  	    $('#cmbcloselocation').attr('disabled',true);$('#cmbclosebranch').attr('disabled',true);
		    $('#closedate').jqxDateTimeInput({ disabled: true});
		    $('#closetime').jqxDateTimeInput({ disabled: true});
		    $('#closekm').attr('disabled',true);
		    $('#cmbclosefuel').attr('disabled',true);
		    $('#closedriver').attr('disabled',true);
		    $('#closestaff').attr('disabled',true);
		    $('#cmbaccidents').attr('disabled',true);
		    $('#accdetails').attr('disabled',true);
		    $('#accfines').attr('disabled',true);
		    $('#closeuser').attr('disabled',true);
		    $('#totalkm').attr('disabled',true);
		    $('#remarks').attr('disabled',true);
  	    }
   	    getAccidents();
   	    checkStaff();
  	}
  	
  	function funenable(){
  		$('#frmEquipMovement input').attr('disabled', false );
  		$('#frmEquipMovement select').attr('disabled', false);
  		$('#frmEquipMovement textarea').attr('disabled', false );
  		$('#frmEquipMovement checkbox').attr('disabled', false);
  		$('#date').jqxDateTimeInput({ disabled: false});
  		$('#dateout').jqxDateTimeInput({ disabled: false});
  		$('#timeout').jqxDateTimeInput({ disabled: false});
  		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
  		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
  		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
  		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		$('#closetime').jqxDateTimeInput({ disabled: false});
  	}
  	
  	function getLocation(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsloc);
				if ($('#hidcmblocation').val() != null) {
					$('#cmblocation').val($('#hidcmblocation').val());
				}
			}
		}
		x.open("GET", "getLocation.jsp?branch="+value, true);
		x.send();
	}
  	
	function getCloseLocation(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
				}
				$("select#cmbcloselocation").html(optionsloc);
				if ($('#hidcmbcloselocation').val() != null) {
					$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
				}
			}
		}
		x.open("GET", "getLocation.jsp?branch="+value+"", true);
		x.send();
	}
  	
  	function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsloc);
				$("select#cmbclosebranch").html(optionsloc);
				if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				}
				if ($('#hidcmbclosebranch').val() != null) {
					$('#cmbclosebranch').val($('#hidcmbclosebranch').val());
				}
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
  	
  	function getTestLocation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsloc);
				$("select#cmbcloselocation").html(optionsloc);
			}
		}
		x.open("GET", "getTestLocation.jsp", true);
		x.send();
	}
  	
  	function getStatus() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var statusItems = items[0].split(",");
				var statusIdItems = items[1].split(",");
				var optionsstatus = '<option value="">--Select--</option>';
				for (var i = 0; i < statusItems.length; i++) {
					optionsstatus += '<option value="' + statusIdItems[i] + '">' + statusItems[i] + '</option>';
				}
				$("select#cmbstatus").html(optionsstatus);
				if ($('#hidcmbstatus').val() != null) {
					$('#cmbstatus').val($('#hidcmbstatus').val());
				}
			}
		}
		x.open("GET", "getStatus.jsp", true);
		x.send();
	}

  	function funNotify(){
  		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
  		if($('#dateout').jqxDateTimeInput('getDate')==null){
  			document.getElementById("errormsg").innerText="Out Date is Mandatory";
  			$('#dateout').jqxDateTimeInput('focus'); 
	  		return 0;	
  		}
  		if($('#timeout').jqxDateTimeInput('getDate')==null){
  			document.getElementById("errormsg").innerText="Out Time is Mandatory";
  			$('#timeout').jqxDateTimeInput('focus');
  			return 0;	
  		}
  	 	var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
  	 	var timeout1=$('#timeout').jqxDateTimeInput('getDate');
  		var dateouthidden1=new Date($('#dateouthidden').jqxDateTimeInput('getDate'));
  		var timeouthidden1=$('#timeouthidden').jqxDateTimeInput('getDate');
  		var tempstatus=document.getElementById("cmbstatus").value;
  		
  		var futuretimestatus=checkfuturetime(dateout1,timeout1);
    	if(futuretimestatus){
    		document.getElementById("errormsg").innerText="";
    	} else {
    		$('#timeout').jqxDateTimeInput('focus');
    		return false;
    	}
  		dateout1.setHours(0,0,0,0);
  		dateouthidden1.setHours(0,0,0,0);
  		if(document.getElementById("txtfleetno").value==''){
  			document.getElementById("errormsg").innerText="Fleet is Mandatory";
  			document.getElementById("txtfleetno").focus();
  			return 0;
  		}
  		
  		if(dateout1<dateouthidden1){
  			document.getElementById("errormsg").innerText="Date Should Not be Less than In Date";
  			$('#dateout').jqxDateTimeInput('focus'); 
  	  		return 0;	
  		}
  		if(dateout1-dateouthidden1==0){
	  		if(timeout1.getHours() < timeouthidden1.getHours()){
	  			document.getElementById("errormsg").innerText="Time Should Not be Less than In Time";
	  			$('#timeout').jqxDateTimeInput('focus'); 
	  			return 0;
	  		}
	  		if(timeout1.getHours() == timeouthidden1.getHours()){
	  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
	  				document.getElementById("errormsg").innerText="Time Should Not be Less than In Time";
	  				$('#timeout').jqxDateTimeInput('focus');
	  				return 0;
	  			}
	  		}
	  	}
  		
  		var x=checkfuturedate();
  		if(x==false){
  			return 0;
  		}
  		
  		if((tempstatus=='GA')||(tempstatus=='GM')||tempstatus=='GS'){
  			if(document.getElementById("garage").value==''){
  				document.getElementById("errormsg").innerText="Garage is Mandatory";
  				document.getElementById("garage").focus();
  				return 0;
  			}
  			if(document.getElementById("driver").value==''){
  				document.getElementById("errormsg").innerText="Driver is Mandatory";
  				document.getElementById("driver").focus();
  				return 0;
  			}
  			document.getElementById("chkgaragedelivery").checked=true;
  			checkGarageDelivery();
  		}
  		else if(tempstatus=='ST'){
  			if(document.getElementById("staff").value==''){
  				document.getElementById("errormsg").innerText="Staff is Mandatory";
  				document.getElementById("staff").focus();
  				return 0;
  			}
  			document.getElementById("chkgaragedelivery").checked=false;
  			checkGarageDelivery();
  		}
  		else{
  			if(document.getElementById("driver").value==''){
  				document.getElementById("errormsg").innerText="Driver is Mandatory";
  				document.getElementById("driver").focus();
  				return 0;
  			}
  			document.getElementById("chkgaragedelivery").checked=false;
  			checkGarageDelivery();
  		}
  		checkavailability('add');
 	} 
  	
  	function checkavailability(mode){
		var valfleet=document.getElementById("txtfleetno").value;
		if(mode=="add"){
			var dateout=$('#dateout').jqxDateTimeInput('val');
			var timeout=$('#timeout').jqxDateTimeInput('val');
		} else{
			var dateout=$('#closedate').jqxDateTimeInput('val');
			var timeout=$('#closetime').jqxDateTimeInput('val');
		}
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		    if (x.readyState==4 && x.status==200) {
		      var items=x.responseText;
		      var chkfleet=items.trim();
		      if(chkfleet=="1") {
		        $.messager.alert('Message','Equipment Is Not Available ','warning');   
		        return false;
		      } else {
		    	$('#cmboutfuel').prop("disabled", false);
  		        $('#outkm').prop("disabled", false);
  		        $('#cmblocation').prop("disabled", false);
  		        $('#cmbbranch').prop("disabled", false);
		    	funSetlabel();
				$("#overlay, #PleaseWait").show();
				$('#frmEquipMovement').submit();
				$('#cmboutfuel').prop("disabled", true);
			  	$('#outkm').prop("disabled", true);
			  	$('#cmblocation').prop("disabled", true);
			  	$('#cmbbranch').prop("disabled", true);
			  	$('#cmbstatus').prop("disabled", true);
		      }
		    }
		}
		x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout+"&mode="+mode,true);
		x.send();
	}
	
 	function funChkButton() {}

	function funSearchLoad(){
		 changeContent('mainSearch.jsp', $('#window')); 
	}
		
 	function funFocus(){
	   	$('#date').jqxDateTimeInput('focus'); 	    		
 	}
 	
 	function setValues(){
 		funSetlabel();
 		getTestLocation();
 		getStatus();
 		$('#date').jqxDateTimeInput({ disabled: false});
 		$('#timeout').jqxDateTimeInput({ disabled: false});
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
 		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
 		$('#closedate').jqxDateTimeInput({ disabled: false});
 		$('#closetime').jqxDateTimeInput({ disabled: false});
 		$('#frmEquipMovement select').attr('disabled',false);
 		
 	 	if($('#hidtimeout').val()){ $("#timeout").jqxDateTimeInput('val', $('#hidtimeout').val()); }
 		if($('#hidgaragedeliverytime').val()){ $("#garagedeliverytime").jqxDateTimeInput('val', $('#hidgaragedeliverytime').val()); }
 		if($('#hidgaragecollecttime').val()){ $("#garagecollecttime").jqxDateTimeInput('val', $('#hidgaragecollecttime').val()); }
 		if($('#hidclosetime').val()){ $("#closetime").jqxDateTimeInput('val', $('#hidclosetime').val()); } 
 		 
 		if ($('#hidcmbstatus').val() != null) { $('#cmbstatus').val($('#hidcmbstatus').val()); }
 		if ($('#hidcmbbranch').val() != null) { $('#cmbbranch').val($('#hidcmbbranch').val()); }
 		
 		getLocation($('#hidcmbbranch').val());
 		
 		if ($('#hidcmboutfuel').val() != null) { $('#cmboutfuel').val($('#hidcmboutfuel').val()); }
 		if ($('#hidcmbgaragedeliveryfuel').val() != null) { $('#cmbgaragedeliveryfuel').val($('#hidcmbgaragedeliveryfuel').val()); }
 		if ($('#hidcmbgaragecollectfuel').val() != null) { $('#cmbgaragecollectfuel').val($('#hidcmbgaragecollectfuel').val()); }
 		if ($('#hidcmbclosebranch').val() != null) { $('#cmbclosebranch').val($('#hidcmbclosebranch').val()); }
 		
 		getCloseLocation($('#hidcmbclosebranch').val());
 		if ($('#hidcmbcloselocation').val() != null) { $('#cmbcloselocation').val($('#hidcmbcloselocation').val()); }
 		if ($('#hidcmbclosefuel').val() != null) { $('#cmbclosefuel').val($('#hidcmbclosefuel').val()); }
 		if ($('#hidcmbaccidents').val() != null) { $('#cmbaccidents').val($('#hidcmbaccidents').val()); }
 		
 		if($('#hidcmbstatus').val()=='ST'){
 			document.getElementById("staffContainer").style.display="flex";
 			document.getElementById("garageContainer").style.display="none";
 		}
 		if(($('#hidcmbstatus').val()=='GA')||($('#hidcmbstatus').val()=='GM')||($('#hidcmbstatus').val()=='GS')){
 			document.getElementById("staffContainer").style.display="none";
 			document.getElementById("garageContainer").style.display="flex";
 		}
 		if(document.getElementById("staff").value!=''){
 			if(document.getElementById("closekm").value>0){
 		 		$('#closestaff').attr('disabled',false);
 	 			document.getElementById("closestaff").value=document.getElementById("staff").value;
 	 			$('#closestaff').attr('disabled',true);
 			}
 		}
 		
 		if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
 		
 		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 		
 		if($('#date').jqxDateTimeInput('disabled')==false){ $('#date').jqxDateTimeInput({ disabled: true}); }
 		if($('#dateout').jqxDateTimeInput('disabled')==false){ $('#dateout').jqxDateTimeInput({ disabled: true}); }
 		if($('#timeout').jqxDateTimeInput('disabled')==false){ $('#timeout').jqxDateTimeInput({ disabled: true}); }
 		if($('#garagedeldate').jqxDateTimeInput('disabled')==false){ $('#garagedeldate').jqxDateTimeInput({ disabled: true}); }
 		if($('#garagedeliverytime').jqxDateTimeInput('disabled')==false){ $('#garagedeliverytime').jqxDateTimeInput({ disabled: true}); }
 		if($('#garagecollectdate').jqxDateTimeInput('disabled')==false){ $('#garagecollectdate').jqxDateTimeInput({ disabled: true}); }
 		if($('#garagecollecttime').jqxDateTimeInput('disabled')==false){ $('#garagecollecttime').jqxDateTimeInput({ disabled: true}); }
 		if($('#closedate').jqxDateTimeInput('disabled')==false){ $('#closedate').jqxDateTimeInput({ disabled: true}); }
 		if($('#closetime').jqxDateTimeInput('disabled')==false){ $('#closetime').jqxDateTimeInput({ disabled: true}); }
 		
 		$('#frmEquipMovement select').attr('disabled',true);
 		
 		if(document.getElementById("movtempstatus").value=="OUT"){
 			document.getElementById("btnclose").style.display="block";
 			$('#btnclose').attr('disabled',false);
 		} else {
 			document.getElementById("btnclose").style.display="block";
 			$('#btnclose').attr('disabled',true);
 			$('#btndeliveryupdate').attr('disabled',true);
 		}
 		
 		$('#cmbstatus').prop('disabled',false);
 		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
 			document.getElementById("deliveryfield").style.display="block";
 	    	document.getElementById("collectionfield").style.display="block";
 		} else {
 			document.getElementById("deliveryfield").style.display="none";
 	    	document.getElementById("collectionfield").style.display="none";
 		}
 		$('#cmbstatus').prop('disabled',true);
 		
 	    if(document.getElementById("deliverystatus").value=="1"){
 		    document.getElementById("btndeliveryupdate").disabled=true;
 	    } else {
 		    document.getElementById("btndeliveryupdate").disabled=false;
 	    } 
	
 	    if ($('#hidcmblocation').val() != null || $('#hidcmblocation').val()!="") {
		    $('#cmblocation').val($('#hidcmblocation').val());
	    }
 	}
 
 	function getTotalkm(){
 		var km1=document.getElementById("outkm").value;
 		var km2=document.getElementById("closekm").value;
 		var totkm=km2-km1;
 		document.getElementById("totalkm").value=totkm;
 	}
 	
 	function closeMov(){
 	    if(document.getElementById("deliverystatus").value=="0" && ($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM")){
 		    document.getElementById("errormsg").innerText="Please Update Delivery Info";
 		    return false;
 	    }
 	
	    $('#cmbcloselocation').attr('disabled', false);
	    $('#cmbclosebranch').attr('disabled', false);
 		checkStaff();
	    $('#date').jqxDateTimeInput({ disabled: false});
	    if($('#dateout').jqxDateTimeInput('disabled')==false){
		    $('#dateout').jqxDateTimeInput({ disabled: false});
	    }
	    if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
		    document.getElementById("chkgaragecollect").checked=true;
		    checkGarageCollection();
	    } else {
		    document.getElementById("chkgaragecollect").checked=false;
		    checkGarageCollection();
	    }
	
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		$('#closetime').jqxDateTimeInput({ disabled: false});
  		$('#cmbclosefuel').attr('disabled', false);
  		$('#closekm').attr('readonly', false);
  		$('#closedriver').attr('readonly', true);
  		$('#closeremarks').attr('readonly', false);
  		$('#closeuser').attr('readonly', true);
  		$('#totalkm').attr('readonly', true);
  		document.getElementById("btnclose").style.display="none";
  		document.getElementById("btnclosesave").style.display="block";
  		$('#cmbaccidents').attr('disabled', false);
  		
  		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
  			document.getElementById("closedriver").value="";
  	  		document.getElementById("hidclosedriver").value="";
  	  	    $('#garagecollectdate').jqxDateTimeInput('focus');
  		} else {
  			document.getElementById("closedriver").value=document.getElementById("driver").value;
  	  		document.getElementById("hidclosedriver").value=document.getElementById("hiddriver").value;	
  	  	    document.getElementById("cmbclosebranch").focus();
  		}
  		
  		document.getElementById("closestaff").value=document.getElementById("staff").value;
  		document.getElementById("hidclosestaff").value=document.getElementById("hidstaff").value;
  		document.getElementById("mode").value="close";
 	}
 	
 	function closeSave(){
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		if($('#closedate').jqxDateTimeInput('getDate')==null){
				document.getElementById("errormsg").innerText="Close Date is Mandatory";
				$('#closedate').jqxDateTimeInput('focus'); 
				return false;
		}
 		
 		var closedateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(closedateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
 		if($('#closetime').jqxDateTimeInput('getDate')==null){
 	 	 		document.getElementById("errormsg").innerText="Close Time is Mandatory";
 	 	 		$('#closetime').jqxDateTimeInput('focus'); 
 	 	 		return false;
 		}
		
 		if($('#closetime').jqxDateTimeInput('getDate')!=null){
	    	var date=$('#closedate').jqxDateTimeInput('getDate');
	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    		$('#closedate').jqxDateTimeInput('focus');
	    		return false;
	    	}
	    	else{
		    	var time=$('#closetime').jqxDateTimeInput('getDate');
		    	var status=checkfuturetime(date,time);
		    	if(status){
		    		document.getElementById("errormsg").innerText="";
		    	}
		    	else{
		    		$('#closetime').jqxDateTimeInput('focus');
		    		return false;
		    	}	    		
	    	}
        }
		
 		var tempindate=new Date($('#dateout').jqxDateTimeInput('getDate'));
 		tempindate.setHours(0,0,0,0);
 		var tempintime=$('#timeout').jqxDateTimeInput('getDate');
 		var tempcollectdate=new Date($('#garagecollectdate').jqxDateTimeInput('getDate'));
 		var tempcollecttime=$('#garagecollecttime').jqxDateTimeInput('getDate');
 		var tempoutdate=new Date($('#garagedeldate').jqxDateTimeInput('getDate'));
 		var tempouttime=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		
 		var tempclosedate=new Date($('#closedate').jqxDateTimeInput('getDate'));
 		tempclosedate.setHours(0,0,0,0);
 		var tempclosetime=$('#closetime').jqxDateTimeInput('getDate');
 	 	$('#outkm').prop('disabled',false);
 		var tempoutkm=parseFloat($('#outkm').val());
 		$('#outkm').prop('disabled',true);
 		
 		var closekm=parseFloat($('#closekm').val());	
 		var closefuel=$('#cmbclosefuel').val();
 			
 		if(tempclosedate<tempindate){
 			document.getElementById("errormsg").innerText="Close Date cannot be less than Out Date";
 			$('#closedate').jqxDateTimeInput('focus'); 
 			return false;
 		} else if(tempclosedate-tempindate==0){
 			if(tempclosetime.getHours()<tempintime.getHours()){
 				document.getElementById("errormsg").innerText="Close Time cannot be less than Out Time";
 				$('#closetime').jqxDateTimeInput('focus'); 
 				return false;
 			} else if(tempclosetime.getHours()==tempintime.getHours()){
 				if(tempclosetime.getMinutes()<tempintime.getMinutes()){
 					document.getElementById("errormsg").innerText="Close Time cannot be less than Out Time";
 					$('#closetime').jqxDateTimeInput('focus'); 
 					return false;
 				}
 			}
 		}
 		if(closekm==''||closekm==0.0){
 			document.getElementById("errormsg").innerText="Close Km Cannot be less than Out Km";
 			document.getElementById("closekm").focus();
 			return false;
 		} else if(closekm<tempoutkm){
 			document.getElementById("errormsg").innerText="Close km cannot be less than Out km";
 			document.getElementById("closekm").focus();
 			return false;
 		}
 		if(document.getElementById("cmbclosefuel").value==""){
 			document.getElementById("errormsg").innerText="Please select Close Fuel";
 			document.getElementById("cmbclosefuel").focus();
 			return false;
 		}
 		document.getElementById("errormsg").value="";
 
 		/** Collection validation starts */
 		if(document.getElementById("chkgaragecollect").checked==true){
 			tempcollectdate.setHours(0,0,0,0);
 			tempoutdate.setHours(0,0,0,0);
 			tempoutkm=parseFloat($('#garagedeliverykm').val());
 			if($('#garagecollectdate').jqxDateTimeInput('getDate')==null){
 				document.getElementById("errormsg").innerText="Collection Date is Mandatory";
 				$('#garagecollectdate').jqxDateTimeInput('focus'); 
 				return false;
 			}
 			
 			var collectdateval=funDateInPeriod($('#garagecollectdate').jqxDateTimeInput('getDate'));
 			if(collectdateval==0){
 				$('#garagecollectdate').jqxDateTimeInput('focus');
 				return false;
 			}
 			if($('#garagecollecttime').jqxDateTimeInput('getDate')==null){
 		 	 	document.getElementById("errormsg").innerText="Collection Time is Mandatory";
 		 	 	$('#garagecollecttime').jqxDateTimeInput('focus'); 
 		 	 	return false;
 			}
 			if(document.getElementById("cmbgaragecollectfuel").value==""){
 				document.getElementById("errormsg").innerText="Collection Fuel is Mandatory";
 				document.getElementById("cmbgaragecollectfuel").focus();
 				return false;
 			}
 			if(tempcollectdate<tempoutdate){
 				document.getElementById("errormsg").innerText="Collection Date should Not be Less than Delivery Date";
 				$('#garagecollectdate').jqxDateTimeInput('focus');
 				return false;
 			}  
 			
 			if(tempcollectdate-tempoutdate==0){
 				if(tempcollecttime.getHours() < tempouttime.getHours()){
 					document.getElementById("errormsg").innerText="Collection Time should Not be Less than Delivery Time";
 					$('#garagecollecttime').jqxDateTimeInput('focus');
 					return false;
 				} else if(tempcollecttime.getHours()==tempouttime.getHours()){
 					if(tempcollecttime.getMinutes()<tempouttime.getMinutes()){
 	 					document.getElementById("errormsg").innerText="Collection Time should Not be Less than Delivery Time";
 	 					$('#garagecollecttime').jqxDateTimeInput('focus');
 	 					return false;
 	 				}
 				}
 			}
 			
 			if((document.getElementById("garagecollectkm").value=='')||parseFloat((document.getElementById("garagecollectkm").value)==0.0)){
 				document.getElementById("errormsg").innerText="Collection KM should not be Empty";
 				document.getElementById("garagecollectkm").focus();
 				return false;
 			}
 			if(parseFloat(document.getElementById("garagecollectkm").value)<tempoutkm){
 				document.getElementById("errormsg").innerText="Collection KM should not be less than Delivery KM";
 				document.getElementById("garagecollectkm").focus();
 				return false;
 			}
 			if(tempclosedate<tempcollectdate){
 				document.getElementById("errormsg").innerText="Close Date Cannot be less than Collection Date";
 				$('#closedate').jqxDateTimeInput('focus');
 				return false;
 			}
 			if(tempclosedate-tempcollectdate==0){
 				if(tempclosetime.getHours()<tempcollecttime.getHours()){
 					document.getElementById("errormsg").innerText="Close Time cannot be less than Collection Time";
 					$('#closetime').jqxDateTimeInput('focus');
 					return false;
 				}
 				if(tempclosetime.getHours()==tempcollecttime.getHours()){
 					if(tempclosetime.getMinutes()<tempcollecttime.getMinutes()){
 	 					document.getElementById("errormsg").innerText="Close Time cannot be less than Collection Time";
 	 					$('#closetime').jqxDateTimeInput('focus');
 	 					return false;	
 					}
 				}
 			}
 			if(parseFloat(document.getElementById("closekm").value)<parseFloat(document.getElementById("garagecollectkm").value)){
 				document.getElementById("errormsg").innerText="Close Km Cannot be less than Collection Km";
 				document.getElementById("closekm").focus();
 				return false;
 			}
 	    }
 		
 		if(document.getElementById("totalkm").value=='' || parseFloat(document.getElementById("totalkm").value)==0.0){
 			document.getElementById("errormsg").innerText="Close KM must be greater than Out KM";
 			document.getElementById("closekm").focus();
 			return false;
 		}
 		if(parseFloat(document.getElementById("totalkm").value)<0){
 			document.getElementById("errormsg").innerText="Please enter valid KM";
 			document.getElementById("closekm").focus();
 			return false;
 		}
 		if(document.getElementById("cmbclosebranch").value==''){
 			document.getElementById("errormsg").innerText="Close Branch is Mandatory";
 			document.getElementById("cmbclosebranch").focus();
 			return false;
 		}
 		if(document.getElementById("cmbcloselocation").value==''){
 			document.getElementById("errormsg").innerText="Close Location is Mandatory";
 			document.getElementById("cmbcloselocation").focus();
 			return false;
 		}
		if(document.getElementById("closekm").value=="" || parseFloat(document.getElementById("closekm").value)==0.0){
			document.getElementById("errormsg").innerText="Close KM must be greater than Out KM";
			document.getElementById("closekm").focus();
			return false;
		}
		if(parseFloat(document.getElementById("closekm").value)<parseFloat(document.getElementById("outkm").value)){
			document.getElementById("errormsg").innerText="Close Km cannot be less than out km";
			document.getElementById("closekm").focus();
			return false;
		}
 		if(document.getElementById("cmbclosefuel").value==""){
 			document.getElementById("errormsg").innerText="Close Fuel is Mandatory";
 			document.getElementById("cmbclosefuel").focus();
 			return false;
 		}
 		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
 		    if(document.getElementById("closedriver").value==""){
 			    document.getElementById("errormsg").innerText="Close Driver is Mandatory";
 			    document.getElementById("closedriver").focus();
 			    return false;
 		    }
 		}
 		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		
 		funenable();
 		$.messager.confirm('Confirm', 'Closing KM: '+$('#closekm').val()+' Driven KM: '+$('#totalkm').val(), function(r){
		    if (r){
			    checkavailability('close');
		    }
 		});
 	}
 	
 	function getAccidents(){
 		$('#cmbaccidents').prop('disabled', false );
 		if(document.getElementById("cmbaccidents").value==1){
 			document.getElementById("hidaccidents").value=1;
 			$('#accdetails').prop('disabled', false );
 			$('#accfines').prop('disabled', false );
 			$('#accdetails').prop('readonly', false );
 			$('#accfines').prop('readonly', false );
 		} else {
 			document.getElementById("hidaccidents").value=0;
 			$('#accdetails').prop('disabled', true );
 			$('#accfines').prop('disabled', true );
 		}
 	}
 	
 	function checkGarageDelivery(){
 		if(document.getElementById("chkgaragedelivery").checked==true){
 			document.getElementById("hidchkgaragedelivery").value="1";
 		 	if(document.getElementById("mode").value!="A"){
    		    $('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
    		    $('#garagedeliverykm').prop('disabled', false );
    		    $('#garagedeliverykm').prop('readonly', false );
    		    $('#cmbgaragedeliveryfuel').prop('disabled', false );
 		 	}
 		}
 		if(document.getElementById("chkgaragedelivery").checked==false){
 			document.getElementById("hidchkgaragedelivery").value="0";
 			if(document.getElementById("mode").value!="A"){
 				if($('#garagedeliverytime').jqxDateTimeInput('disabled')==false){
 					$('#garagedeliverytime').jqxDateTimeInput({ disabled: true});		
 				}
    		    $('#garagedeliverykm').prop('disabled', true );
    		    $('#cmbgaragedeliveryfuel').prop('disabled', true );
    		    $('#btndeliveryupdate').prop('disabled', true );
 			}
 		}
 	}
 	
 	function checkGarageCollection(){
 		if(document.getElementById("chkgaragecollect").checked==true){
 			document.getElementById("hidchkgaragecollect").value=1;
 			if($('#garagecollectdate').jqxDateTimeInput('disabled')==true){
 				$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 			}
    		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
    		$('#garagecollectkm').prop('readonly', false );
    		$('#garagecollectkm').prop('disabled', false );
    		$('#cmbgaragecollectfuel').prop('disabled', false );
 		}
 		if(document.getElementById("chkgaragecollect").checked==false){
 			document.getElementById("hidchkgaragecollect").value=0;
 			if($('#garagecollectdate').jqxDateTimeInput('disabled')==false){
 				$('#garagecollectdate').jqxDateTimeInput({ disabled: true});
 			}
    		$('#garagecollecttime').jqxDateTimeInput({ disabled: true});
    		$('#garagecollectkm').prop('disabled', true );
    		$('#cmbgaragecollectfuel').prop('disabled', true );
 		}
 	}
 
 	function funDeliveryUpdate(){
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverykm').prop('disabled',false);
 		$('#garagedeliverykm').prop('readonly',false);
 		$('#cmbgaragedeliveryfuel').prop('disabled',false);
 		document.getElementById("btndeliveryupdate").style.display="none";
		document.getElementById("btndeliverysave").style.display="block";
		$('#garagedeldate').jqxDateTimeInput('focus');
 	}
 	
 	function funDeliverySave(){
 		if($('#garagedeldate').jqxDateTimeInput('getDate')==null){
 	 		document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
 	 		return false;
 	 	}
 		var deliverydateval=funDateInPeriod($('#garagedeldate').jqxDateTimeInput('getDate'));
		if(deliverydateval==0){
			$('#garagedeldate').jqxDateTimeInput('focus');
			return false;
		}
 		if($('#garagedeliverytime').jqxDateTimeInput('getDate')==null){
  			document.getElementById("errormsg").innerText="Garage Delivery Time is Mandatory";
	  		return 0;	
 		}
 		var date1 = new Date($('#garagedeldate').jqxDateTimeInput('getDate'));
 		var date2=new Date($('#dateout').jqxDateTimeInput('getDate'));
 		var time1=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		var time2=$('#timeout').jqxDateTimeInput('getDate');
 		$('#outkm').prop('disabled',false);
 		$('#outfuel').prop('disabled',false);
 		var tempoutkm=parseFloat($('#outkm').val());
 		var tempoutfuel=$('#outfuel').val();
 		$('#outkm').prop('disabled',true);
 		$('#outfuel').prop('disabled',true);
		var status=checkfuturetime(date1,time1);
    	if(!status){
    		$('#garagedeliverytime').jqxDateTimeInput('focus');
    		return false;
    	}
 	 	date1.setHours(0,0,0,0);
 	 	date2.setHours(0,0,0,0);
 	 	
 		if(date1<date2){
			document.getElementById("errormsg").innerText="Delivery Date should Not be Less than Out Date";
			return false;
 		}
 	    if(date1-date2==0){
 		    if(time1.getHours()<time2.getHours()){
 			    document.getElementById("errormsg").innerText="Delivery Time should Not be Less than Out Time";
 			    return false;
 		    } else if(time1.getHours()==time2.getHours()){
 		        if(time1.getMinutes()<time2.getMinutes()){
 			        document.getElementById("errormsg").innerText="Delivery Time should Not be Less than Out Time";
 			        return false;
 		        }
 		    }
 	    }
 	
 	    if((document.getElementById("garagedeliverykm").value=='')||(parseFloat(document.getElementById("garagedeliverykm").value)==0.0)){
 		    document.getElementById("errormsg").innerText="Delivery KM is Mandatory";
 		    return false;
 	    }
 	    if(parseFloat(document.getElementById("garagedeliverykm").value)<tempoutkm){
 		    document.getElementById("errormsg").innerText="Delivery KM should Not be Less than Out KM";
 		    return false;
 	    }
 	    if(document.getElementById("cmbgaragedeliveryfuel").value==''){
 		    document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
 		    return false;
 	    }
 	    document.getElementById("errormsg").innerText="";
 	
 		var testdoc=document.getElementById("docno").value;
 		var testfleet=document.getElementById("txtfleetno").value;
 		var deliverydate=$('#garagedeldate').jqxDateTimeInput('getDate');
 		var deliverytime=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		var deliverykm=document.getElementById("garagedeliverykm").value;
 		var deliveryfuel=document.getElementById("cmbgaragedeliveryfuel").value;
 		var location=document.getElementById("cmblocation").value;
 		var branch=document.getElementById("cmbbranch").value;
 		var trancode=document.getElementById("cmbstatus").value;
		var d1=new Date(deliverytime);
		var temptime=$('#garagedeliverytime').jqxDateTimeInput('val');
		var driver=document.getElementById("hiddriver").value;
 		getDelivery(testdoc,testfleet,deliverydate,temptime,deliverykm,deliveryfuel,location,trancode,driver,branch);
 	}
 	
 	function getDelivery(testdoc,testfleet,deliverydate,temptime,deliverykm,deliveryfuel,location,trancode,driver,branch){
	    var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				if((parseInt(items))>0){
					 document.getElementById("msg").value="Successfully Saved";
					 $.messager.alert('Message',$('#msg').val());
					 document.getElementById("btndeliveryupdate").style.display="block";
					 document.getElementById("btndeliverysave").style.display="none";
					 document.getElementById("btndeliveryupdate").disabled=true;
					 document.getElementById("hidchkgaragedelivery").value="1";
					 document.getElementById("deliverystatus").value="1";
				} else {
					 document.getElementById("msg").value="Not Saved";
					 $.messager.alert('Message',$('#msg').val());
					 document.getElementById("chkstatus").value="1";
					 document.getElementById("hidchkgaragedelivery").value="0";
				}
			}
		}
		x.open("GET", "deliveryUpdate.jsp?doc="+testdoc+"&fleet="+testfleet+"&date="+$('#garagedeldate').jqxDateTimeInput('getDate')+"&time="+temptime+"&km="+deliverykm+"&fuel="+deliveryfuel+"&location="+location+"&trancode="+trancode+"&driver="+driver+"&branch="+branch, true);
		x.send();
	}
 	
 	 $(function(){
	        $('#frmEquipMovement').validate({
	                 rules: {
	                 cmblocation: { required:true },
	                 cmbbranch:{ required:true },
	                 cmbstatus:{ required:true },
	                 accdetails:{ maxlength:200 },
	                 outremarks:{ maxlength:250 },
	                 closeremarks:{ maxlength:250 }
	                 },
	                 messages: {
	                  cmblocation: { required:" *" } ,
	                  cmbbranch:{ required:" *" },
	                  cmbstatus:{ required:" *" },
		              accdetails:{ maxlength:"Max 200 chars" },
	                  outremarks:{ maxlength:"Max 250 chars" },
	                  closeremarks:{ maxlength:"Max 250 chars" }
	                 }
	        });
	  });
 	
 	  function isNumber(evt,id) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
	           $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	           return false;
	        }
	        return true;
	    }
 
		function funPrintBtn() {
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   	}
	   		var url=document.URL;
	   	    var reurl=url.split("saveEquipMovement");
	   	  	var win= window.open(reurl[0]+"printEquipMovement.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();
	   	 }
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEquipMovement" action="saveEquipMovement" autocomplete="off" >
	<script>
			window.parent.formName.value="Equipment Movement";
			window.parent.formCode.value="MOV";
	</script>
	<jsp:include page="../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">Equipment Movement Opening Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id='date' name='date' value='<s:property value="date"/>'></div>
            </div>
            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" style="width:120px;" value='<s:property value="docno"/>' readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Fleet No</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' onkeydown="getFleet(event);" readonly placeholder="Press F3" />
                <svg class="magnifier-icon" onclick="var e = $.Event('keydown'); e.keyCode=114; getFleet(e);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:80px;">Fleet Name</label>
            <input type="text" id="txtfleetname" name="txtfleetname" style="flex:1;" value='<s:property value="txtfleetname"/>' readonly />
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Branch</label>
            <select name="cmbbranch" id="cmbbranch" style="width:125px;" onchange="getLocation(this.value);">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmblocation" id="hidcmblocation" value='<s:property value="hidcmblocation"/>'/>
            
            <label class="lbl-right" style="width:80px;">Location</label>
            <select name="cmblocation" id="cmblocation" style="width:120px;">
                <option value="">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Movement Type</label>
            <select id="cmbstatus" name="cmbstatus" style="width:120px;" onchange="checkStaff();" value='<s:property value="cmbstatus"/>'>
                <option value="">-Select-</option>
            </select>
            <input type="hidden" id="hidcmbstatus" name="hidcmbstatus" value='<s:property value="hidcmbstatus"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date Out</label>
            <div style="width: 125px;">
                <div id='dateout' name='dateout' value='<s:property value="dateout"/>'></div>
            </div>
            <input type="hidden" id="hiddateout" name="hiddateout" value='<s:property value="hiddateout"/>'/>
            
            <label class="lbl-right" style="width:80px;">Time Out</label>
            <div style="width: 80px;">
                <div id='timeout' name='timeout' value='<s:property value="timeout"/>'></div>
            </div>
            <input type="hidden" id="hidtimeout" name="hidtimeout" value='<s:property value="hidtimeout"/>'/>
            
            <label class="lbl-right" style="width:50px;">KM</label>
            <input type="text" id="outkm" name="outkm" style="width:80px;" value='<s:property value="outkm"/>'/>
            
            <label class="lbl-right" style="width:50px;">Fuel</label>
            <select id="cmboutfuel" name="cmboutfuel" style="width:100px;" value='<s:property value="cmboutfuel"/>'>
                <option value="">-Select-</option>
                <option value=0.000>Level 0/8</option>
                <option value=0.125>Level 1/8</option>
                <option value=0.250>Level 2/8</option>
                <option value=0.375>Level 3/8</option>
                <option value=0.500>Level 4/8</option>
                <option value=0.625>Level 5/8</option>
                <option value=0.750>Level 6/8</option>
                <option value=0.875>Level 7/8</option>
                <option value=1.000>Level 8/8</option>
            </select>
            <input type="hidden" id="hidcmboutfuel" name="hidcmboutfuel" value='<s:property value="hidcmboutfuel"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Driver</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" id="driver" name="driver" value='<s:property value="driver"/>' onKeyDown="getDriver(event,1);" readonly placeholder="Press F3" />
                <svg class="magnifier-icon" onclick="var e=$.Event('keydown'); e.keyCode=114; getDriver(e,1);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <div id="staffContainer" style="display:none; align-items:center; gap:8px;">
                <label class="lbl-right" style="width:80px;">Staff</label>
                <div class="input-search-container" style="width: 120px;">
                    <input type="text" name="staff" id="staff" value='<s:property value="staff"/>' onKeyDown="getStaff(event,1);" placeholder="Press F3" />
                    <svg class="magnifier-icon" onclick="var e=$.Event('keydown'); e.keyCode=114; getStaff(e,1);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>

            <div id="garageContainer" style="display:none; align-items:center; gap:8px;">
                <label class="lbl-right" style="width:80px;">Garage</label>
                <div class="input-search-container" style="width: 120px;">
                    <input type="text" name="garage" id="garage" value='<s:property value="garage"/>' onKeyDown="getGarage(event);" placeholder="Select Garage" />
                    <svg class="magnifier-icon" onclick="var e=$.Event('keydown'); e.keyCode=114; getGarage(e);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            
            <input type="checkbox" name="chkgaragedelivery" id="chkgaragedelivery" onChange="checkGarageDelivery();" style="display:none;">
            <input type="hidden" name="hidstaff" id="hidstaff" value='<s:property value="hidstaff"/>'/>
            <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'/>
            <input type="hidden" name="hidgarage" id="hidgarage" value='<s:property value="hidgarage"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Remarks</label>
            <input type="text" id="outremarks" name="outremarks" style="flex:1;" value='<s:property value="outremarks"/>'/>
            
            <label class="lbl-right" style="width:80px;">User</label>
            <input type="text" id="outuser" name="outuser" style="width:120px; text-transform:uppercase;" value='<s:property value="outuser"/>' readonly />
            <input type="hidden" name="outuserid" id="outuserid" value='<s:property value="outuserid"/>'/>
        </div>
    </div>


    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        <div id="deliveryfield" class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Delivery Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:60px;">Date</label>
                <div style="width: 125px;">
                    <div id="garagedeldate" name="garagedeldate" value='<s:property value="garagedeldate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:50px;">Time</label>
                <div style="width: 80px;">
                    <div id="garagedeliverytime" name="garagedeliverytime" value='<s:property value="garagedeliverytime"/>'></div>
                </div>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px;">KM</label>
                <input type="text" name="garagedeliverykm" id="garagedeliverykm" style="width:100px;" value='<s:property value="garagedeliverykm"/>' onkeypress="javascript:return isNumber (event,id)">
                
                <label class="lbl-right" style="width:50px;">Fuel</label>
                <select name="cmbgaragedeliveryfuel" id="cmbgaragedeliveryfuel" style="width:100px;">
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option>
                    <option value=0.125>Level 1/8</option>
                    <option value=0.250>Level 2/8</option>
                    <option value=0.375>Level 3/8</option>
                    <option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option>
                    <option value=0.750>Level 6/8</option>
                    <option value=0.875>Level 7/8</option>
                    <option value=1.000>Level 8/8</option>
                </select>
                
                <div style="margin-left:auto;">
                    <input type="button" name="btndeliveryupdate" id="btndeliveryupdate" class="myButton" value="Update" onclick="funDeliveryUpdate();">
                    <input type="button" name="btndeliverysave" id="btndeliverysave" class="myButton" value="Save" onclick="funDeliverySave();" style="display:none;">
                </div>
            </div>
        </div>

        <div id="collectionfield" class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Collection Info</span>
            <input type="checkbox" name="chkgaragecollect" id="chkgaragecollect" onchange="checkGarageCollection();" style="display:none;">
            
            <div class="field-row">
                <label class="lbl-right" style="width:60px;">Date</label>
                <div style="width: 125px;">
                    <div id="garagecollectdate" name="garagecollectdate" value='<s:property value="garagecollectdate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:50px;">Time</label>
                <div style="width: 80px;">
                    <div id="garagecollecttime" name="garagecollecttime" value='<s:property value="garagecollecttime"/>'></div>
                </div>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:60px;">KM</label>
                <input type="text" name="garagecollectkm" id="garagecollectkm" style="width:100px;" value='<s:property value="garagecollectkm"/>' onkeypress="javascript:return isNumber (event,id)">
                
                <label class="lbl-right" style="width:50px;">Fuel</label>
                <select name="cmbgaragecollectfuel" id="cmbgaragecollectfuel" style="width:100px;">
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option>
                    <option value=0.125>Level 1/8</option>
                    <option value=0.250>Level 2/8</option>
                    <option value=0.375>Level 3/8</option>
                    <option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option>
                    <option value=0.750>Level 6/8</option>
                    <option value=0.875>Level 7/8</option>
                    <option value=1.000>Level 8/8</option>
                </select>
            </div>
        </div>
    </div>


    <div class="middle-panel">
        <span class="middle-panel-title">Equipment Movement Closing Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Close Branch</label>
            <select name="cmbclosebranch" id="cmbclosebranch" style="width:125px;" onchange="getCloseLocation(this.value);">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbcloselocation" id="hidcmbcloselocation" value='<s:property value="hidcmbcloselocation"/>'/>
            
            <label class="lbl-right" style="width:80px;">Location</label>
            <select name="cmbcloselocation" id="cmbcloselocation" style="width:120px;">
                <option value="">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Close Date</label>
            <div style="width: 120px;">
                <div id='closedate' name='closedate' value='<s:property value="closedate"/>'></div>
            </div>
            <input type="hidden" id="hidclosedate" name="hidclosedate" value='<s:property value="hidclosedate"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Close Time</label>
            <div style="width: 80px;">
                <div id='closetime' name='closetime' value='<s:property value="closetime"/>'></div>
            </div>
            <input type="hidden" id="hidclosetime" name="hidclosetime" value='<s:property value="hidclosetime"/>'/>
            
            <label class="lbl-right" style="width:125px;">Close KM</label>
            <input type="text" id="closekm" name="closekm" style="width:120px;" value='<s:property value="closekm"/>' onKeyPress="javascript:return isNumber (event,id)" onBlur="getTotalkm();"/>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Close Fuel</label>
            <select id="cmbclosefuel" name="cmbclosefuel" style="width:120px;" value='<s:property value="cmbclosefuel"/>'>
                <option value="">-Select-</option>
                <option value=0.000>Level 0/8</option>
                <option value=0.125>Level 1/8</option>
                <option value=0.250>Level 2/8</option>
                <option value=0.375>Level 3/8</option>
                <option value=0.500>Level 4/8</option>
                <option value=0.625>Level 5/8</option>
                <option value=0.750>Level 6/8</option>
                <option value=0.875>Level 7/8</option>
                <option value=1.000>Level 8/8</option>
            </select>
            <input type="hidden" id="hidcmbclosefuel" name="hidcmbclosefuel" value='<s:property value="hidcmbclosefuel"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Close Driver</label>
            <div class="input-search-container" style="width: 125px;">
                <input type="text" name="closedriver" id="closedriver" onKeyDown="getDriver(event,2);" value='<s:property value="closedriver"/>' readonly/>
                <svg class="magnifier-icon" onclick="var e=$.Event('keydown'); e.keyCode=114; getDriver(e,2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="hidclosedriver" name="hidclosedriver" value='<s:property value="hidclosedriver"/>'/>
            
            <label class="lbl-right" style="width:80px;">Close Staff</label>
            <div class="input-search-container" style="width: 120px;">
                <input type="text" name="closestaff" id="closestaff" value='<s:property value="closestaff"/>' onKeyDown="getStaff(event,2);" readonly/>
                <svg class="magnifier-icon" onclick="var e=$.Event('keydown'); e.keyCode=114; getStaff(e,2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" name="hidclosestaff" id="hidclosestaff" value='<s:property value="hidclosestaff"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Accidents</label>
            <select name="cmbaccidents" id="cmbaccidents" onChange="getAccidents();" style="width:125px;">
                <option value="">--Select--</option>
                <option value=1>Yes</option>
                <option value=0>No</option>
            </select>
            <input type="hidden" name="hidcmbaccidents" id="hidcmbaccidents" value='<s:property value="hidcmbaccidents"/>'/>
            <input type="hidden" name="hidaccidents" id="hidaccidents" value='<s:property value="hidaccidents"/>'/>
            
            <label class="lbl-right" style="width:80px;">Acc Details</label>
            <input type="text" name="accdetails" id="accdetails" style="flex:1;" value='<s:property value="accdetails"/>'/>
            
            <label class="lbl-right" style="width:50px;">Fines</label>
            <input type="text" name="accfines" id="accfines" style="width:100px;" value='<s:property value="accfines"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Remarks</label>
            <input type="text" id="closeremarks" name="closeremarks" style="flex:1;" value='<s:property value="closeremarks"/>'/>
            
            <label class="lbl-right" style="width:40px;">User</label>
            <input type="text" id="closeuser" name="closeuser" style="width:80px; text-transform:uppercase;" value='<s:property value="closeuser"/>' readonly />
            <input type="hidden" id="hidcloseuser" name="hidcloseuser" value='<s:property value="hidcloseuser"/>'/>
            
            <label class="lbl-right" style="width:60px;">Total KM</label>
            <input type="text" id="totalkm" name="totalkm" style="width:80px; font-weight:bold; color:#0b45a2;" value='<s:property value="totalkm"/>' readonly/>
            
            <div style="margin-left: 10px; display:flex; gap:8px;">
                <input type="button" name="btnclose" id="btnclose" class="myButton" value="Close" onclick="closeMov();">
                <input type="button" name="btnclosesave" id="btnclosesave" class="myButton" value="Save" onclick="closeSave();" style="display:none;">
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode" value='<s:property value="delete"/>'/>
        <input type="text" name="delete" id="delete" value='<s:property value="delete"/>'/>
        <input type="hidden" name="hidchkgaragedelivery" id="hidchkgaragedelivery" value='<s:property value="hidchkgaragedelivery"/>' >
        <input type="hidden" name="hidgaragedeliverydate" id="hidgaragedeliverydate" value='<s:property value="hidgaragedeliverydate"/>'>
        <input type="hidden" name="hidgaragedeliverytime" id="hidgaragedeliverytime" value='<s:property value="hidgaragedeliverytime"/>'>
        <input type="hidden" name="hidchkgaragecollect" id="hidchkgaragecollect"  value='<s:property value="hidchkgaragecollect"/>' >
        <input type="hidden" name="hidcmbgaragecollectfuel" id="hidcmbgaragecollectfuel" value='<s:property value="hidcmbgaragecollectfuel"/>' >
        <input type="hidden" name="hidcmbgaragedeliveryfuel" id="hidcmbgaragedeliveryfuel" value='<s:property value="hidcmbgaragedeliveryfuel"/>' >
        <input type="hidden" name="hidgaragecollectdate" id="hidgaragecollectdate" value='<s:property value="hidgaragecollectdate"/>'>
        <input type="hidden" name="hidgaragecollecttime" id="hidgaragecollecttime" value='<s:property value="hidgaragecollecttime"/>'>
        
        <div id="dateouthidden" name="dateouthidden"></div>
        <div id="timeouthidden" name="timeouthidden"></div>
        <div id="hiddelivery" name="hiddelivery"></div>
        <div id="hidcollect" name="hidcollect"></div>
        
        <input type="hidden" name="movtempstatus" id="movtempstatus" value='<s:property value="movtempstatus"/>'>
        <input type="hidden" name="clstatus" id="clstatus" value='<s:property value="clstatus"/>'>
        <input type="hidden" name="deliverystatus" id="deliverystatus" value='<s:property value="deliverystatus"/>'>
        <input type="hidden" name="hidcmbbranch" id="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'>
        <input type="hidden" name="hidcmbclosebranch" id="hidcmbclosebranch" value='<s:property value="hidcmbclosebranch"/>'>
        <input type="hidden" name="vehtrancode" id="vehtrancode" value='<s:property value="vehtrancode"/>'>
    </div>

</div>

<!-- Search Windows -->
<div id="fleetwindow"><div></div></div>
<div id="maintenancewindow"><div></div></div>
<div id="driverwindow"><div></div></div>
<div id="staffwindow"><div></div></div>
<div id="garagewindow"><div></div></div>
<div id="errormsg" style="color:red; font-weight:bold; margin-top:5px;"></div>

</form>
</div>
</body>
</html>