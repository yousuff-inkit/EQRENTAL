<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:include page="notification.jsp"></jsp:include>
<link href="https://fonts.googleapis.com/css?family=Rubik:400,500,700" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loading.css">
<style>

   body {
       font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
       background: #f6f8fa;
       margin: 0;
       color: #253858;
   }

.HeadIcons {
   font: 12px Tahoma;
   margin-top: 0px;
	line-height: 30px;
	background-color: #E0ECF8;
	height: 27px;
	width: 100%;
}
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
label.branch{
  font-size: 12px;
  font-family: Tahoma;
  font-style: normal; 
  padding-left: 1%;
}
label.currency{
  font-size: 12px;
  font-family: Tahoma;
  font-style: normal;
  padding-left: 1%;
}

#errormsg {
 -moz-animation-duration: 1s;
 -moz-animation-name: blink;
 -moz-animation-iteration-count: infinite;
 -moz-animation-direction: alternate;
 
 -webkit-animation-duration: 2s;
 -webkit-animation-name: blink;
 -webkit-animation-iteration-count: infinite;
 -webkit-animation-direction: alternate;
 
 animation-duration: 1s;
 animation-name: blink;
 animation-iteration-count: infinite;
 animation-direction: alternate;
}

@-moz-keyframes blink {
 from {
   opacity: 1;
 }
 
 to {
   opacity: 0;
 }
}

@-webkit-keyframes blink {
 from {
   opacity: 1;
 }
 
 to {
   opacity: 0;
 }
}

@keyframes blink {
 from {
   opacity: 1;
 }
 
 to {
   opacity: 0;
 }
}
button.icon:disabled { opacity: 0.5; };
.icon-text {
   color: #007bff;
   font-weight: 500;
   cursor: pointer;
   margin-right: 18px;
   padding: 4px 10px;
   border-radius: 6px;
   transition: background 0.2s, color 0.2s;
   font-size: 1rem;
   display: inline-block;
}
.icon-text:hover {
   background: #eaf4ff;
   color: #0056b3;
   text-decoration: underline;
}

.HeadIcons {
   display: flex;
   justify-content: flex-end;
   align-items: center;
   gap: 24px;
   background: #FFFFFF;
   border-radius: 12px;
   padding: 18px 32px;
   width: 95%;
   font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
   font-size: 1rem;
}

.HeadIcons label.branch,
.HeadIcons label.currency {
   font-weight: 500;
   color: #333;
   margin-right: 8px;
   min-width: 80px;
   text-align: right;
}

.HeadIcons select,
.HeadIcons input[type="text"] {
   border: 1px solid #d1d5db;
   border-radius: 6px;
   padding: 6px 10px;
   font-size: 1rem;
   background: #ffffff;
   transition: border-color 0.2s;
   min-width: 120px;
   height: auto;
   font-size: 10px;
}

.HeadIcons select:focus,
.HeadIcons input[type="text"]:focus {
   border-color: #007bff;
   outline: none;
}

#savemsg {
   color: #22c55e;
   font-weight: bold;
   margin-left: 16px;
}

#errormsg {
    color: red;
    font-weight: bold;
    font-size: 14px;
    display: block;
    margin-bottom: 5px;
    font-family: 'Segoe UI', 'Roboto', Arial, sans-serif !important;

    width: 100%;
    min-width: 300px;
    white-space: normal;
    word-wrap: break-word;
    overflow-wrap: break-word;
    line-height: 1.4;
}

.action-bar {
   display: flex;
   gap: 10px;
   padding: 0.4% 2%;
   flex-wrap: wrap;
}

.action-btn {
   background: #e4e7ed;
   border: none;
   color: #000;
   padding: 4px 12px;
   border-radius: 20px;
   font-size: 13px;
   font-weight: 600;
   cursor: pointer;
   display: inline-flex;
   align-items: center;
   gap: 6px;
   transition: background 0.2s ease;
}

.action-btn:hover {
   background: #c3ccd8;
}

.action-btn:active {
   background: #b6bfcc;
}
#btnSave[hidden], #btnCancel[hidden] {
   display: none !important;
}
/* SVG ICON SIZE */
.action-btn svg {
   width: 14px;
   height: 14px;
   fill: currentColor;   
}

input:-webkit-autofill,
input:-webkit-autofill:focus {
   -webkit-box-shadow: 0 0 0 1000px white inset !important;
   box-shadow: 0 0 0 1000px white inset !important;
   -webkit-text-fill-color: #1f3b70 !important;
}

/* Target only Branch & Currency labels */
#full label.branch,
#full label.currency {
   font-weight: 700 !important;
   font-size: 14px;
   color: #253858;
}

/* Target only Branch & Currency dropdowns */
#full select#brchName,
#full select#currency {
   height: 34px !important;
   padding: 4px 10px;
   font-size: 14px;
   font-weight: 600;
   border: 1px solid #b8c7e0;
   border-radius: 6px;
   background: #ffffff;
   width: 150px;
   box-sizing: border-box;
}

/* Improve spacing ONLY inside this section */
#full {
   display: flex;
   align-items: center;
   gap: 20px;
   padding: 6px 15px;
}

/* Increase visible dropdown list width */
#brchName,
#currency {
   width: 180px !important;
}

/* Increase dropdown OPTION list width */
#brchName option,
#currency option {
   padding: 6px 10px;
   font-size: 14px;
   min-width: 180px !important;
}

/* For browsers that override list width */
#brchName:focus,
#currency:focus {
   width: 200px !important;
}

/* Heading Style */
#formdet {
   font-size: 22px;
   font-weight: 800;
   color: #1f2937;
   display: block;
}

/* Arrange heading & top button row with spacing */
.HeadIcons {
   display: flex;
   align-items: center;
   justify-content: space-between;
   margin-bottom: 12px;
}

/* Make ONLY Branch & Currency labels bold */
.HeadIcons label.branch,
.HeadIcons label.currency {
   font-weight: 700 !important;
}

/* Enlarge branch & currency dropdown */
#brchName,
#currency {
   height: 38px;
   padding: 0 10px;
   font-weight: 600;
   border-radius: 6px;
   min-width: 120px;
}

/* Reduce space between Heading and Buttons */
#formdet {
   margin-bottom: 0 !important;
   padding-bottom: 0 !important;
}

.HeadIcons {
   margin-bottom: 4px !important;
   padding-bottom: 4px !important;
}

.action-bar {
   margin-top: 2px !important;
   padding-top: 4px !important;
}

/* REMOVE unwanted ERP padding/margin at top */
#mainBG.homeContent {
   padding-top: 2px !important;
   margin-top: 2px !important;
}

/* Also remove top space from the first HeadIcons bar */
#full.HeadIcons {
   margin-top: 2px !important;
   padding-top: 2px !important;
}

html, body {
   padding: 0 !important;
   margin: 0 !important;
}
</style>
<script type="text/javascript">
var APP_PATH='<%=contextPath%>';
var exefolio='<%=request.getParameter("exefolio")%>';
$(document).ready(function () { 

   if(exefolio==1){
	doformsubmit();
   }
   
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	  $("#brchName").show();  $("#brchNames").hide(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
	  $("#currency").show();  $("#currencys").hide(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
	
		 $('body').keydown(function (evt) {
			  if (evt.keyCode == 8) {
				  var d = event.srcElement || event.target;
			        if ((d.tagName.toUpperCase() === 'INPUT' && 
			             (
			                 d.type.toUpperCase() === 'TEXT' ||
			                 d.type.toUpperCase() === 'PASSWORD' || 
			                 d.type.toUpperCase() === 'FILE' || 
			                 d.type.toUpperCase() === 'EMAIL' || 
			                 d.type.toUpperCase() === 'SEARCH' || 
			                 d.type.toUpperCase() === 'DATE' )
			             ) || 
			             d.tagName.toUpperCase() === 'TEXTAREA') {
			            doPrevent = d.readOnly || d.disabled;
			        }
			        else {
			            doPrevent = true;
			        }
			    }
			    if (doPrevent) {
			        event.preventDefault();
				}
		}); 
	
	if(window.parent.formName.value!="000"){
	funChkButtonchk();
	}
	    $("input").not($(":button")).keypress(function (evt) {
	        if (evt.keyCode == 13) {
	            iname = $(this).val();
	            if (iname !== 'Submit') {
	                var fields = $(this).parents('form:eq(0),body').find('button, input, textarea, select');
	                var index = fields.index(this);
	                if (index > -1 && (index + 1) < fields.length) {
	                    fields.eq(index + 1).focus();
	                }
	                return false;
	            }
	        }
	    });
		
		$("input").keyup(function (evt) {
	    	if (($(this).val()).includes('$')) { $(this).val($(this).val().replace('$', ''));};if (($(this).val()).includes('%')) { $(this).val($(this).val().replace('%', ''));};
	    	if (($(this).val()).includes('^')) { $(this).val($(this).val().replace('^', ''));};if (($(this).val()).includes('`')) { $(this).val($(this).val().replace('`', ''));};
	    	if (($(this).val()).includes('~')) { $(this).val($(this).val().replace('~', ''));};if ($(this).val().indexOf('\'')  >= 0 ) { $(this).val($(this).val().replace(/'/g, ''));};
	    	if ($(this).val().indexOf('"') >= 0) { $(this).val($(this).val().replace(/["']/g, ''));};if (($(this).val()).match(/\\/g)) { $(this).val($(this).val().replace(/\\/g, ''));};
	    });

	if(window.parent.formName.value!="000"){
	    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
	}
	 		
	 $("input").click(function (evt) {
			this.placeholder = '' ;
		});
  
		$('#btnSave').mousedown(function () {
	   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
		if (r){
		  var formId=$('form').attr('id');
		  
		  if($('#'+formId).valid()) {
		   var temp=funNotify();
		   if(temp>0){
			   funSetlabel();
			   $("#overlay, #PleaseWait").show();
			   $('#brchName').attr('disabled', false);$('#currency').attr('disabled', false);
			   $('#'+formId).submit();
		   }
		  }
		 }
	   });
	   });
			
 			 getBrchCurr();		
 			
	$("#mode").val("view");		funReadOnly();
    initViewButtons(); // New function for cleaner UI state management
	
	if(!($("#msg").val()=="Successfully Saved" || $("#msg").val().trim()=="" || $("#msg").val()=="Updated Successfully" || $("#msg").val()=="Successfully Deleted" || $("#msg").val()=="Not Deleted" || $("#msg").val()=="Successfully Released" ) ) {
		 $.messager.alert('Message',$('#msg').val());
		
		if($('#msg').val()=="Not Updated" || $('#chkstatus').val()=="2"){
			$("#mode").val("E");	
		}
		
		if($('#msg').val()=="Not Saved"  || $('#chkstatus').val()=="1"){
			$("#mode").val("A");	
		}
		
		funNotSaved();
	}
	
	 $('#btnDelete').mousedown(function () {
			if (($("#mode").val() == "view") && ($("#docno").val() !="")) {
			$.messager.confirm('Confirm', 'Do you want to delete?', function(r){
				if (r){
					funSetlabel();
					var formId=$('form').attr('id');
					$("#mode").val("D");
					funRemoveReadOnly();
					$('#'+formId).submit();
				}
			});
			}
			else{
				$.messager.alert('Message','Select a Document....!','warning');
	    return;
		}
	}); 
	 if(window.parent.branchid.value!=""){
			$('#brchName').val(window.parent.branchid.value); 
		} 
		
 }); 

 function initViewButtons() {
    $("#btnSave").attr('hidden', true).hide();
    $("#btnCancel").attr('hidden', true).hide();
    
    $("#btnApproval").show();
    $("#btnClose").show();
    $("#btnCreate").show();
    $("#btnEdit").show();
    $("#btnPrint").show();
    $("#btnExcel").show();
    $("#btnDelete").show();
    $("#btnSearch").show();
    $("#btnAttach").show();
    $("#btnCosting").show();
    $("#btnGuideLine").show();
    $("#btnSendmail").show();
    $("#btnTerms").show();
 }
 
 function getMessengerCount() {
		var x=new XMLHttpRequest();
		var msgcnt;
		var user;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
					items= x.responseText;
					items=items.trim().split('####');
					user=items[0];
					msgcnt=items[1];
						if(msgcnt>0){
							window.parent.document.getElementById("iconnm").style.display = 'none';
							window.parent.document.getElementById("iconym").style.display = 'inline-block';
						}
						else{
							window.parent.document.getElementById("iconym").style.display = 'none';
							window.parent.document.getElementById("iconnm").style.display = 'inline-block';
						}
				}
		}
		x.open("GET",<%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp",true);
		x.send();
	}

  
 function funCreateBtn(){
	 funReset();
 	 $("#mode").val("A");
	 $("#msg").val("");
	 funRemoveReadOnly();
	 $("#btnSendmail").hide();
	 $("#status").val(1);	 
     $("#btnSave").removeAttr('hidden').show();		 
     $("#btnCancel").removeAttr('hidden').show();
	 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
	 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
	 $("#btnSearch").hide(); 		 $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
	 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
	 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
	 document.getElementById("errormsg").innerText="Selected Branch is "+$("#brchNames").val();
 }
 
 function funCloseBtn(){
	 if($("#status").val()==1){
		 $("#msg").val("");    $("#mode").val("view");
		 $("#btnSendmail").show();
		 $("#btnApproval").show();		 $("#btnCreate").show();		 $("#btnEdit").show(); 		 $("#btnPrint").show();
		 $("#btnExcel").show();		 $("#btnDelete").show();		 $("#btnSearch").show();	 $("#status").val(0);	
		 $("#btnSave").attr('hidden', true).hide();		 
         $("#btnCancel").attr('hidden', true).hide();		 
         funReadOnly();      $("#btnAttach").show();  $("#btnCosting").show(); $("#btnTerms").show(); $("#btnGuideLine").show();
		 $('#brchName').attr('disabled', false);                     $('#currency').attr('disabled', false);
		 document.getElementById("errormsg").innerText="";         document.getElementById("savemsg").innerText="";
		 $("#brchName").show(); $("#brchNames").hide();  $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
		 $("#currency").show();  $("#currencys").hide(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
		}
	 else{
		 return;
	 }
 }

 	function funEditBtn() {
			if(exefolio==1){
 			$.messager.alert('Message','Edit Not Possible...!!','warning');
 			return;
 		}
		
		if (($("#mode").val() == "view") && ($("#docno").val()!="") && ($("#deleted").val() =="")) {
			$("#mode").val("E");	$("#msg").val("");
			funRemoveReadOnly();
			$("#btnSendmail").hide();
			$('#brchName').attr('disabled', true);             $('#currency').attr('disabled', true);
			$("#status").val(1);			$("#btnApproval").hide();			$("#btnCreate").hide();
			$("#btnEdit").hide();			$("#btnPrint").hide();			$("#btnExcel").hide();				$("#btnDelete").hide();
			$("#btnSearch").hide();			
            $("#btnSave").removeAttr('hidden').show();		 
            $("#btnCancel").removeAttr('hidden').show();                
            $("#btnAttach").hide();   $("#btnCosting").hide(); $("#btnTerms").hide();  $("#btnGuideLine").hide();
			$("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
			$("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
			} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
 	function funSearchBtn() {
        document.getElementById("termstatus").value=0;
			$("#msg").val("");
			$("#deleted").val("");  $("#mode").val("view");  funReadOnly();
			$('#brchName').attr('disabled', false);   $('#currency').attr('disabled', false);
			$("#brchName").show();  $("#brchNames").hide(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
			$("#currency").show();  $("#currencys").hide(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
			funSearchLoad();
	}
	function funCancelBtn() {
		funReset();
	}
	
	function getBrchCurr()
		{
		var x=new XMLHttpRequest();
		var items,brchItems,currItems,mcloseItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		        items= x.responseText;
		        items=items.split('####');
		        brchIdItems=items[0].split(",");
		        brchItems=items[1].split(",");
		        currIdItems=items[2].split(",");
		        currItems=items[3].split(",");
		        mcloseItems=items[4].split(",");
		        curTypeItems=items[5].split(",");
		        	var optionsbrch = '';
		        	var optionscurr = '';
		       for ( var i = 0; i < brchItems.length; i++) {
		    	   optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
		        }
		       for ( var j = 0; j < currItems.length; j++) {
		    	   optionscurr += '<option value="' + currIdItems[j] + '">' + currItems[j] + '</option>';
		        }
		        	$("select#brchName").html(optionsbrch); 	
		        	$("select#currency").html(optionscurr);
		        	window.parent.monthclosed.value=mcloseItems[0];
		        	window.parent.formcurrencytype.value=curTypeItems[0];
					if(brchItems.length==1){
		        		getCurr($('#brchName').val());
		        	}
		        	if(window.parent.branchid.value!=""){
		 				$('#brchName').val(window.parent.branchid.value); 
		 			}
		        }
		}
		x.open("GET",<%=contextPath+"/"%>+"getBranch.jsp?menubrch="+window.parent.branchid.value,true);
		x.send();
	}
	
	function getCurr(brch) {
		  var x=new XMLHttpRequest();
		  x.onreadystatechange=function(){
		  if (x.readyState==4 && x.status==200)
		   {
		     items= x.responseText;
		     items=items.split('####');
		          var currIdItems=items[0];
		          var mcloseItems=items[1];
		          var currCodeItems=items[2];
		          var curtypeItems=items[3];
		          var multiItems=items[4];
		          var optionscurr = '';
		          
		     if(currCodeItems.indexOf(",")>=0){
		           var currencyid=currIdItems.split(",");
		           var currencycode=currCodeItems.split(",");
		           var currencytype=curtypeItems.split(",");
		           mcloseItems.split(",");
		           multiItems.split(",");
		         
		         for ( var i = 0; i < currencycode.length; i++) {
		          optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
		          }
		        
		           $("select#currency").html(optionscurr);
		           window.parent.monthclosed.value=mcloseItems[0];
		           window.parent.formcurrencytype.value=curtypeItems[i];
		      }
		         else{
		          optionscurr += '<option value="' + currIdItems + '"selected>' + currCodeItems + '</option>';
		          
		         $("select#currency").html(optionscurr);
		         window.parent.monthclosed.value=mcloseItems;
		         window.parent.formcurrencytype.value=curtypeItems;
		         }
		       
		       window.parent.branchid.value=brch;
		        }
		      }
		       x.open("GET",<%=contextPath+"/"%>+"getCurrency.jsp?branch="+brch,true);
		      x.send();
		     
		    }
	
	
	function funDtype(){
		 var dtype=document.getElementById("formdetailcode").value;
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var item=x.responseText.trim();
		    var count = item[0];
		    if(count==0){
		    	 $("#btnApproval").attr('disabled', true );
		    }
		   }
		  }
		  x.open("GET", <%=contextPath+"/"%>+"getDtype.jsp?dtype="+dtype, true);
		  x.send();  
		 }

		   function apprCheck(){
		   var dtype=document.getElementById('formdetailcode').value;
		   if(!(dtype=='FRO' || dtype=='OPN' || dtype=='LEC' || dtype=='FPP'|| dtype=='PREP'|| dtype=='BRCN'|| dtype=='MAPP'|| dtype=='UCPP' || dtype=='SAT' || dtype=='CUR' || dtype=='STE' )){
			   getapprcount();
	   }
	}


		function funReset() {
				funSetlabel();
				$('input[type=text],[type=email],[type=hidden],[type=password], textarea').val('');
				$('select').find('option').prop("selected", false);
				$('input[type=radio]').prop("checked", false);
				$('input:checkbox').removeAttr('checked');
				
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
				if(window.parent.branchid.value!=""){
					$('#brchName').val(window.parent.branchid.value); 
				}
				if(window.parent.mode.value!=""){
					$('#mode').val(window.parent.mode.value); 
				}
				$("#status").val("1");
		   }
			
			function funSetlabel(){
				if(window.parent.formName.value!="000"){
							window.parent.formName.value=document.getElementById("formdetail").value;
							window.parent.formCode.value=document.getElementById("formdetailcode").value;
				}
				funDtype();
				getformbranch();
				if(!($('#brchName').val()==null)){
					window.parent.branchid.value=$('#brchName').val();
				}
				window.parent.mode.value=$('#mode').val();
			}
		  
			function funDateInPeriod(value){
				   var periodStartDate=window.parent.txtaccountperiodfrom.value;
			       periodStartDate=periodStartDate.split("-");
			       var newDateStartYear=periodStartDate[1]+","+periodStartDate[0]+","+periodStartDate[2];
			   	   var styear=new Date(newDateStartYear);
				   
			   	   var periodEndDate=window.parent.txtaccountperiodto.value;
			       periodEndDate=periodEndDate.split("-");
			       var newDateEndYear=periodEndDate[1]+","+periodEndDate[0]+","+periodEndDate[2];
			   	   var edyear=new Date(newDateEndYear);
				   
			   	   var mCloseDate=window.parent.monthclosed.value;
			       periodMonthCloseDate=mCloseDate.split("-");
			       var newDateMonthClose=periodMonthCloseDate[0]+","+periodMonthCloseDate[1]+","+periodMonthCloseDate[2];
			   	   var mclose=new Date(newDateMonthClose);
				   
			       mclose.setHours(0,0,0,0);
			       edyear.setHours(0,0,0,0);
			       styear.setHours(0,0,0,0);
			       var currentDate = new Date(new Date());
				   
			       if(value<styear || value>edyear){
			        document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       }
			        if(value>currentDate){
			        document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       } 
			       if(value<=mclose){
			        document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted. ";
			        $('#txtvalidation').val(1);
			        return 0;
			       }
			       document.getElementById("errormsg").innerText="";
			       $('#txtvalidation').val(0);
			        return 1;
			    }

			function funIBDateInPeriod(date,branch){
		  		var x = new XMLHttpRequest();
		  		x.onreadystatechange = function() {
		  			if (x.readyState == 4 && x.status == 200) {
		  				var items = x.responseText;
		  				 items = items.split('***');
		  			     var monthCloseDate = items[0];
		  			     var monthClose = items[1];
		  			     var Date = items[2].trim();
		  			   
		  			   if(parseInt(monthClose)==1){
		  				 document.getElementById("errormsg").innerText="Closing Done on "+Date+", Transaction Restricted. ";
		  				 $('#txtibvalidation').val(1);
		  				 return 0;
		  		   }
		  			   
		  			 document.getElementById("errormsg").innerText="";
		  			 $('#txtibvalidation').val(0);
					 return 1;
		  	   }
	  		}
	  		x.open("GET", <%=contextPath+"/"%>+"getIBMonthClose.jsp?date="+date+"&branch="+branch, true);
	  		x.send();
	    }
		
		function funBackDate(value){
				if(window.parent.backdateallowed.value==1){
				  if($("#mode").val()=="A"){
					var currentDate = new Date(new Date());
					currentDate.setHours(0,0,0,0);
					if(value<currentDate){		
						document.getElementById("errormsg").innerText="Past Date, Transaction Restricted.";
						$('#txtbackdatevalidation').val(1); 
						return 0;
					}else{
						document.getElementById("errormsg").innerText="";
					    $('#txtbackdatevalidation').val(0);
					    return 1;
					}
				  }
				} 
				document.getElementById("errormsg").innerText="";
			    $('#txtbackdatevalidation').val(0);
			    return 1;  
			}
		
		function funPDCDate(chckpdc,formDate,chequeDate){
				if(window.parent.pdcascdcdateallowed.value==0){
					if(chckpdc=='1'){
						if(chequeDate<=formDate){		
							document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
							$('#txtpdcdatevalidation').val(1); 
							return 0;
						}
					}else if(chckpdc=='0'  || chckpdc==''){
						if(chequeDate>formDate){		
							document.getElementById("errormsg").innerText="Future Cheque Date, Transaction Restricted.";
							$('#txtpdcdatevalidation').val(1); 
							return 0;
						}
					}  
				} 
				document.getElementById("errormsg").innerText="";
			    $('#txtpdcdatevalidation').val(0);
			    return 1;  
			}
		
			function funNotSaved(){
				 $("#msg").val("");
				 funRemoveReadOnly();
				 $("#btnSendmail").hide();
				 $("#status").val(1);	 
                 $("#btnSave").removeAttr('hidden').show();		 
                 $("#btnCancel").removeAttr('hidden').show();
				 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
				 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
				 $("#btnSearch").hide();  $("#btnAttach").hide(); 	$("#btnCosting").hide(); $("#btnTerms").hide();  $("#btnGuideLine").hide();	 
				 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
				 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
			 }
			
			function funRoundAmt(value,id){
				  var res=parseFloat(value).toFixed(window.parent.amtdec.value);
				  var res1=(res=='NaN'?"0":res);
				  document.getElementById(id).value=res1;  
				 }
				 
			function funRoundRate(value,id){
			  	var res=parseFloat(value).toFixed(window.parent.curdec.value);
			  	var res1=(res=='NaN'?"0":res);
			 	document.getElementById(id).value=res1;  
			}
			
			function funAttachBtn(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+document.getElementById("formdetailcode").value
							 +"&docno="+document.getElementById("docno").value+"&brchid="+document.getElementById("brchName").value+"&frmname="+document.getElementById("formdetail").value,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
							  myWindow.focus();
				
				}else {         
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
			function funCostingBtn(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {					
					changeCostingContent("<%=contextPath%>/com/common/costing.jsp?dtype="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value);					
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
			function funApproveBtn(){
				
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					$("#windowapprove").jqxWindow('setTitle',document.getElementById("formdetailcode").value+" - "+document.getElementById("docno").value);
					var brch=document.getElementById("brchName").value;
					var userid='<%=session.getAttribute("USERID")%>';
				 changeApproveContent("<%=contextPath%>/com/common/ApprovalForm.jsp?brch="+brch+"&userid="+userid+"&docno="+document.getElementById("docno").value+"&dtype="+document.getElementById("formdetailcode").value+"&aprstatus="+document.getElementById("apprstatus").value+"&isfirstappr="+document.getElementById("isfirstappr").value);
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
			function funGuideLineBtn() {
				
				 $('#windowGuideline').jqxWindow('setContent', '');
				 $('#windowGuideline').jqxWindow('open'); 
				
					changeGuidelineContent("<%=contextPath%>/com/GuideLine/viewGuideline.action?formName="+document.getElementById("formdetail").value+"&formCode="+document.getElementById("formdetailcode").value); 
		    }
			
			function funChkButtonchk(){
				var FormNamechk=window.parent.formName.value;
				var dtype=window.parent.formCode.value.trim();
				var doc_no=0;
				var branchval = $("#brchName").val();
				 
				if(!(dtype=='FRO' || dtype=='LEC' || dtype=='OPN' || dtype=='FPP'|| dtype=='PREP'|| dtype=='BRCN'|| dtype=='MAPP'|| dtype=='UCPP' || dtype=='SAT'  || dtype=='CUR'  || dtype=='STE' )){  
					doc_no=document.getElementById('docno').value;
			    }
			   
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						items = items.split('##');
						
				 			var add  = items[0].split(",");
							var edit = items[1].split(",");
							var del  = items[2].split(",");
							var print = items[3].split(",");
							var attach = items[4].split(",");
							var excel  = items[5].split(",");
							var email  = items[6].split(",");
							var costing = items[7].split(",");
                            var terms  = items[8].split(",");
                            var other  = items[9].split(",");
                            var bankreconcile  = items[10].split(",");   
                            if(parseInt(other)==1) {                
           
								if(parseInt(add)==0) {		
									$("#btnCreate").attr('disabled', true ); 
								}

								if(parseInt(edit)==0) {
									$("#btnEdit").attr('disabled', true );
								}else if(parseInt(bankreconcile)>0){  
									$("#btnEdit").attr('disabled', true );  
								}else{}
								
								if(parseInt(del)==0) {  
									$("#btnDelete").attr('disabled', true );
								}else if(parseInt(bankreconcile)>0){
									$("#btnDelete").attr('disabled', true );  
								}else{}     
								
								if(parseInt(print)==0) {
									$("#btnPrint").attr('disabled', true );
								}
								
								if(parseInt(attach)==0) {
									$("#btnAttach").attr('disabled', true );
								}	
								
								if(parseInt(excel)==0) {
									$("#btnExcel").attr('disabled', true );
								}
								
								if(parseInt(email)==0) {
									$("#btnSendmail").attr('disabled', true );
								}
								
								if(parseInt(costing)==0) {
					        		$("#btnCosting").attr('hidden', true );
					   			}
								
								if(parseInt(terms)==0) {
								    $("#btnTerms").attr('hidden', true );
							    }
                            }
						
					 }else {}
				}
				
				x.open("GET",<%=contextPath+"/"%>+"chkmenubuttons.jsp?formdetail="+FormNamechk+"&docno="+doc_no+"&dtype="+dtype+"&brhid="+branchval,true);  
				x.send();
			
			}
			
		function getCurrencyType(c){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 		
			 		var typeItems = items[0].split(",");
			 		var rateItems  = items[1].split(",");
					window.parent.formcurrencytype.value=typeItems;
			    }
	     }
	      x.open("GET", <%=contextPath+"/"%>+"getCurrencyType.jsp?curr="+c,true);
	     x.send();
	    
	   }
	   
	   function cardnumber(cardno) {
		if(cardno.length<=16){
			document.getElementById("errormsg").innerText="Invalid Card Number.";
			 $('#txtheadercardnumbervalidrestrict').val(1);
			 return 0;
		}
		
		if(cardno.charAt(0)=="0") {
			document.getElementById("errormsg").innerText="Invalid Card Number.";
			 $('#txtheadercardnumbervalidrestrict').val(1);
			 return 0;
		}
		
		var digits = new Array();
		for (var i = 0; i < cardno.length; i++) {
			digits.push(cardno.charAt(i));
		}
		
		for (var i = cardno.length - 2; i >= 0; i = i - 2) {
			var j = digits[i];
			j = j * 2;
			if (j > 9) {
				j = j % 10 + 1;
			}
			digits[i] = j;
		}
		var sum = 0;
		for (var i = 0; i < cardno.length; i++) {
			sum += parseInt(digits[i]);
		}
		if (sum % 10 == 0) {
				document.getElementById("errormsg").innerText="";
				$('#txtheadercardnumbervalidrestrict').val(0);
				return 1;
		} else {
			document.getElementById("errormsg").innerText="Invalid Card Number.";
			 $('#txtheadercardnumbervalidrestrict').val(1);
			 return 0;
		}
	}
	     
function getapprcount(){
	var docno=document.getElementById('docno').value;
	var dtype=document.getElementById('formdetailcode').value;
	var brch='<%=session.getAttribute("BRANCHID")%>';
	var usrid='<%=session.getAttribute("USERID")%>';
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	items = items.split('####');
		 		var count = items[0];
		 		var isfirstappr = items[2];
		 		document.getElementById('apprstatus').value=count;
		 		document.getElementById('isfirstappr').value=isfirstappr;
		 		
				if(count>=1){
					
					if(docno>=1){
						funApproveBtn();
					}
					}
		    }
     }
      x.open("GET", <%=contextPath+"/"%>+"getApprCount.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid,true);
     x.send();
   }

function setapprbrch(branchval){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText.trim();
		     }
			}
		      x.open("GET", <%=contextPath+"/"%>+"apprsessionset.jsp?sessionbrch="+branchval,true);
		     x.send();
		   }
		
		function getCurrencyId(date){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var currateItems=items[2];
			        var curtypeItems=items[3];
			        var multiItems=items[4];
			        var optionscurr = '';
			        if(curcodeItems.indexOf(",")>=0){
			        	var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	var currencyrate=currateItems.split(",");
			        	var currencytype=curtypeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
			       
			       if($('#txtforsearch').val()==2){
			    	
			    	 $("select#cmbcurrency").html(optionscurr);
			       
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
			         if($('#mode').val()=="A"){
			         	funRoundRate(currencyrate[0],"txtrate");
			         	$('#hidcurrencytype').val(currencytype[0]);
			         }
				     $('#txtbaseamount').attr('readonly', true);
				     
			       }else{
				         $("select#cmbfromcurrency").html(optionscurr);
				         if ($('#hidcmbfromcurrency').val() != null && $('#hidcmbfromcurrency').val() != "") {
				       		 $('#cmbfromcurrency').val($('#hidcmbfromcurrency').val()) ;
				         } 
				        
					     $("select#cmbtocurrency").html(optionscurr);
					     if ($('#hidcmbtocurrency').val() != null && $('#hidcmbtocurrency').val() != "") {
					     	$('#cmbtocurrency').val($('#hidcmbtocurrency').val()) ;
					     }
					     
					     if($('#mode').val()=="A"){
					    	funRoundRate(currencyrate[0],"txtfromrate");
					        $('#hidfromcurrencytype').val(currencytype[0]);
					     	funRoundRate(currencyrate[0],"txttorate");
					     	$('#hidtocurrencytype').val(currencytype[0]);
					     }
					     $('#txtfrombaseamount').attr('readonly', true);
					     $('#txttobaseamount').attr('readonly', true);
			            }
				     }
			       else
				  {
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   
			    	   if($('#txtforsearch').val()==2){
					    	 $("select#cmbcurrency").html(optionscurr);
					         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
					       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
					         }
					         if($('#mode').val()=="A"){
					         	funRoundRate(currateItems,"txtrate");
					        	$('#hidcurrencytype').val(curtypeItems);
					         }
					       }else{
						    	   $("select#cmbfromcurrency").html(optionscurr);
						    	   if ($('#hidcmbfromcurrency').val() != null && $('#hidcmbfromcurrency').val() != "") {
						    	   		$('#cmbfromcurrency').val($('#hidcmbfromcurrency').val()) ;
						    	   } 
								     $("select#cmbtocurrency").html(optionscurr);
								     if ($('#hidcmbtocurrency').val() != null && $('#hidcmbtocurrency').val() != "") {
										  $('#cmbtocurrency').val($('#hidcmbtocurrency').val()) ;
									     } 
								     if($('#mode').val()=="A"){
								    	funRoundRate(currateItems,"txtfromrate");
							    	    $('#hidfromcurrencytype').val(curtypeItems);
								     	funRoundRate(currateItems,"txttorate");
								     	$('#hidtocurrencytype').val(curtypeItems);
								     }
								     $('#txtfrombaseamount').attr('readonly', true);
								     $('#txttobaseamount').attr('readonly', true);
					       }
				      }
				}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getCurrencyId.jsp?date="+date,true);
		     x.send();
		   }
		
		function getRatevalue(a,date){
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var ratesItems  = items[0].split(",");
						var typesItems = items[1].split(",");
						if($('#txtforsearch').val()==2){
							funRoundRate(ratesItems,"txtrate");
							$('#hidcurrencytype').val(typesItems);
							getBaseAmountFrom();
						}else{
							funRoundRate(ratesItems,"txttorate");
							$('#hidtocurrencytype').val(typesItems);
							getBaseAmountTo();
						}
				    }
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getRateTo.jsp?currs="+a+"&date="+date,true);
		     x.send();
		   }

		function doformsubmit(){  
			var docno='<%=request.getParameter("docno")%>';
			var mode='<%=request.getParameter("mode")%>';
			var brch='<%=request.getParameter("brch")%>';
			window.parent.branchid.value=brch;
			setapprbrch(brch);
			 
			document.getElementById('docno').value=docno;
			document.getElementById('mode').value=mode;
			var names = [];
			$("form").each(function() {
			   names.push(this.id);
			}); 
			var form=names[0];
			   document.forms[form].submit();
	      }
		
		function getRate(b,date){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
						var rateItems  = items[0].split(",");
						var typeItems = items[1].split(",");
						funRoundRate(rateItems,"txtfromrate");
						$('#hidfromcurrencytype').val(typeItems);
						getBaseAmountFrom();
				    }
		     }
		      x.open("GET", <%=contextPath+"/"%>+"getRateFrom.jsp?curr="+b+"&date="+date,true);
		     x.send();
		   }
		
		function getBaseAmountFrom(){
			 var currencytype ="";	
			 var fromrate = ""; 
			 var fromamount = "";
			    
			if($('#txtforsearch').val()==2){			
		    		fromrate = $('#txtrate').val(); 
            		fromamount = $('#txtamount').val();
		    	   	currencytype = $('#hidcurrencytype').val().trim();
		    }else{ 
		    	    fromrate = $('#txtfromrate').val(); 
		            fromamount = $('#txtfromamount').val();
			    	currencytype = $('#hidfromcurrencytype').val().trim();
			    }
		    if(!isNaN(fromamount)){
			    if(currencytype=="M"){
			    	if($('#txtforsearch').val()==2){	
			    		var result = parseFloat(fromamount) * parseFloat(fromrate);
					    funRoundAmt(result,"txtbaseamount");
			    	}else{
				    	var result = parseFloat(fromamount) * parseFloat(fromrate);
				    	funRoundAmt(result,"txtfrombaseamount");
			    	}
			    }else{
			    	if($('#txtforsearch').val()==2){	
			    		var result = parseFloat(fromamount) / parseFloat(fromrate);
					    funRoundAmt(result,"txtbaseamount");
			    	}else{
				    	var result = parseFloat(fromamount) / parseFloat(fromrate);
						funRoundAmt(result,"txtfrombaseamount");
			    	}
			    }
		    }
		    else if(isNaN(fromamount)){
		    	if($('#txtforsearch').val()==2){	
		    	 	 $('#txtbaseamount').val(0.00);
		    	 	 $('#txtamount').val(0.00);
		    	}else{ 
		    		 $('#txtfrombaseamount').val(0.00);
			    	 $('#txtfromamount').val(0.00);
		    	 }
		    }
		}
		
		function getBaseAmountTo(){
		    var torate = $('#txttorate').val(); 
		    var toamount = $('#txttoamount').val();
		    var currencytype = $('#hidtocurrencytype').val().trim();
		    if(!isNaN(toamount)){
		    	if(currencytype=="M"){
				    var toresult = parseFloat(toamount) * parseFloat(torate);
				    funRoundAmt(toresult,"txttobaseamount");
			    }else{
				    var toresult = parseFloat(toamount) / parseFloat(torate);
					funRoundAmt(toresult,"txttobaseamount");
			    }
		    }
		    else if(isNaN(toamount)){
		    	 $('#txttobaseamount').val(0.00);
		    	 $('#txttoamount').val(0.00);
		    }
		}
		
		function getBaseAmountInGrid(amount,rate,type){
			var baseamount = "";
			 if(!isNaN(amount)){
			    	if(type=="M"){
			    		baseamount = parseFloat(amount) * parseFloat(rate);
				    }else{
				    	baseamount = parseFloat(amount) / parseFloat(rate);
				    }
			    }
			    else if(isNaN(amount)){
			    	baseamount="0.00";
			    }
			 return baseamount;
		}

	function getformbranch(){
			$('#brchName').attr('disabled',false);
			$('#formdetailcode').attr('disabled',false);
			var branchval=document.getElementById('brchName').value;
			var formCode=document.getElementById('formdetailcode').value;
			var sessionbr='<%=session.getAttribute("BRANCHID")%>';
			if($('#brchName').val()!=null){
				window.parent.branchid.value=$('#brchName').val();	
				$('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
				$('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
			}
			if($('#formdetailcode').val()!=null){
				window.parent.formCode.value=$('#formdetailcode').val();	
			}
			if($('#formdetail').val()!=null){
				window.parent.formName.value=$('#formdetail').val();	
			}
			if(sessionbr==""||sessionbr=="null"||sessionbr==null||branchval.trim()=="")
				{
				}
			if(branchval=="null" || branchval=="" )
			{
			branchval=sessionbr;
			}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText.trim();
				 	if(parseInt(items)==0)
			 		{
			 		$.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
						if (r){
							window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
						}
					});				 		 
			 		Exit();
			 		return 0;
			 		}
				 	if($('#mode').val=='E')
				 		{
						$('#brchName').attr('disabled',true);
				 		}
		     }
			}
		      x.open("GET", <%=contextPath+"/"%>+"sessionset.jsp?sessionbrch="+branchval+"&formCode1="+formCode,true);
		     x.send();
		   }

		   function funSendMail(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					funSendmail();
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
			
			function funTermsCond(){
				if (($("#mode").val() == "view") && $("#docno").val()!="") {
					document.getElementById("termstatus").value=1;
					$("#windowterms").jqxWindow('setTitle',document.getElementById("formdetailcode").value+" - "+document.getElementById("docno").value);
					changeTermsContent("<%=contextPath%>/com/common/termsForm.jsp?formCode="+document.getElementById("formdetailcode").value+"&docno="+document.getElementById("docno").value);		
				} else {
					$.messager.alert('Message','Select a Document....!','warning');
					return;
				}
			}
		  
		  function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {
				var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
				var CSV = '';    
				
				CSV += ReportTitle + '\r\n\n';
				if (ShowLabel) {
					var row = "";
					for (var index in arrData[0]) {
						row += index + ',';
					}
					row = row.slice(0, -1);
					CSV += row + '\r\n';
				}
				for (var i = 0; i < arrData.length; i++) {
					var row = "";
					for (var index in arrData[i]) {
						row += '"' + arrData[i][index] + '",';
					}
					row.slice(0, row.length - 1);
					CSV += row + '\r\n';
				}
				if (CSV == '') {        
					alert("Invalid data");
					return;
				}   
				
				var fileName = "";
				fileName += ReportTitle.replace(/ /g,"_");   
				var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
				var link = document.createElement("a");    
				link.href = uri;
				
				link.style = "visibility:hidden";
				link.download = fileName + ".csv";
				
				document.body.appendChild(link);
				link.click();
				document.body.removeChild(link);
			}
			function getBankReconciled(docno, dtype){   
		  }
			
</script>
</head>
<body onload="funChkButton();"  onclick="getformbranch();">

<div id="mainBG" class="homeContent" data-type="background">
    <!-- Top Configuration Header -->
    <div class="HeadIcons" id="full">
        <font size="5px" style="width: 100%"><label id="formdet" name="formdet"></label></font>

        <label class="branch">Branch</label>
        <select name="brchName" id="brchName" onChange="getCurr(this.value)"></select>
        <input type="text" name="brchNames" id="brchNames" readonly="readonly" value='<s:property value="brchNames"/>' />

        <label class="currency">Currency</label>
        <select name="currency" id="currency" onchange="getCurrencyType(this.value);"></select>
        <input type="text" name="currencys" id="currencys" readonly="readonly" value='<s:property value="currencys"/>' />

        <label id="savemsg" name="savemsg"></label>
        <label id="errormsg" name="errormsg"><s:property value="errormsg"/></label>
        
        <!-- Hidden Inputs -->
        <input type="hidden" id="status" />
        <input type="hidden" id="apprstatus" />
        <input type="hidden" id="isfirstappr" />
        <input type="hidden" name="formdetail" id="formdetail" value='<s:property value="formdetail"/>' />
        <input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>' />
        <input type="hidden" name="chkstatus" id="chkstatus" value='<s:property value="chkstatus"/>' />
        <input type="hidden" name="txtheadercardnumbervalidrestrict" id="txtheadercardnumbervalidrestrict" value='<s:property value="txtheadercardnumbervalidrestrict"/>' />
        <input type="hidden" id="termstatus" />
    </div>

    <!-- Interactive Action Bar -->
    <div class="action-bar">
        
        <button type="button" class="action-btn" id="btnApproval" title="Document Status" onclick="funApproveBtn()">
            <svg viewBox="0 0 20 20"><path d="M7.629 15.314l-4.71-4.71 1.414-1.415 3.296 3.296 8.042-8.042 1.414 1.414z"/></svg>
            Approval
        </button>

        <button type="button" class="action-btn" id="btnClose" title="Close Form" onclick="funCloseBtn()">
            <svg viewBox="0 0 20 20"><path d="M14.348 5.652l-1.414-1.414L10 7.172 7.066 4.238 5.652 5.652 8.586 8.586 5.652 11.52l1.414 1.414L10 10l2.934 2.934 1.414-1.414L11.414 8.586z"/></svg>
            Close
        </button>

        <button type="button" class="action-btn" id="btnCreate" title="Create a new Document" onclick="funCreateBtn()">
            <svg viewBox="0 0 20 20"><path d="M9 3h2v14H9zM3 9h14v2H3z"/></svg>
            Create
        </button>

        <button type="button" class="action-btn" id="btnEdit" title="Change current Document" onclick="funEditBtn()">
            <svg viewBox="0 0 20 20"><path d="M3 14.25V17h2.75l8.06-8.06-2.75-2.75L3 14.25zm12.71-7.04a1 1 0 0 0 0-1.41l-1.5-1.5a1 1 0 0 0-1.41 0l-1.29 1.29 2.75 2.75 1.45-1.13z"/></svg>
            Edit
        </button>

        <button type="button" class="action-btn" id="btnPrint" title="Print current Document" onclick="funPrintBtn()">
            <svg viewBox="0 0 20 20"><path d="M6 2h8v4H6V2zm10 5H4c-1.1 0-2 .9-2 2v5h4v4h8v-4h4v-5c0-1.1-.9-2-2-2z"/></svg>
            Print
        </button>

        <button type="button" class="action-btn" id="btnExcel" title="Export current Document to Excel" onclick="funExcelBtn()">
            <svg viewBox="0 0 20 20"><path d="M4 3h12a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm1 2v10h10V5H5zm2 2h2v2H7V7zm4 0h2v2h-2V7zm-4 4h2v2H7v-2zm4 0h2v2h-2v-2z"/></svg>
            Excel
        </button>

        <button type="button" class="action-btn" id="btnDelete" title="Delete current Document">
            <svg viewBox="0 0 20 20"><path d="M6 8h1v9H6V8zm3 0h1v9H9V8zm3 0h1v9h-1V8zm2-5h-3l-1-1h-4L8 3H5v2h10V3z"/></svg>
            Delete
        </button>

        <button type="button" class="action-btn" id="btnSave" title="Save Changes" hidden>
            <svg viewBox="0 0 20 20"><path d="M17 3H3v14h14V3zm-4 12H7v-2h6v2zm0-4H7V7h6v4z"/></svg>
            Save
        </button>

        <button type="button" class="action-btn" id="btnCancel" title="Cancel Changes" onclick="funCancelBtn()" hidden>
            <svg viewBox="0 0 20 20"><path d="M14.348 5.652l-1.414-1.414L10 7.172 7.066 4.238 5.652 5.652 8.586 8.586 5.652 11.52l1.414 1.414L10 10l2.934 2.934 1.414-1.414L11.414 8.586z"/></svg>
            Cancel
        </button>

        <button type="button" class="action-btn" id="btnSearch" title="Search a Document" onclick="funSearchBtn()">
            <svg viewBox="0 0 20 20"><path d="M12.9 14.32a7 7 0 1 1 1.41-1.41l4.39 4.39-1.41 1.41-4.39-4.39zM9 14A5 5 0 1 0 9 4a5 5 0 0 0 0 10z"/></svg>
            Search
        </button>

        <button type="button" class="action-btn" id="btnAttach" title="Attachment" onclick="funAttachBtn()">
            <svg viewBox="0 0 20 20"><path d="M7 13.5V6a3 3 0 1 1 6 0v7.5a4.5 4.5 0 1 1-9 0V7h2v6.5a2.5 2.5 0 1 0 5 0V6a1 1 0 1 0-2 0v7.5"/></svg>
            Attach
        </button>

        <button type="button" class="action-btn" id="btnCosting" title="Costing" onclick="funCostingBtn()">
            <svg viewBox="0 0 20 20"><path d="M10 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16zm0 14a6 6 0 1 1 0-12 6 6 0 0 1 0 12zm-1-9a1 1 0 0 1 2 0v1h1a1 1 0 0 1 0 2h-1v2a1 1 0 0 1-2 0v-1H8a1 1 0 0 1 0-2h1V7z"/></svg>
            Costing
        </button>

        <button type="button" class="action-btn" id="btnGuideLine" title="Guideline" onclick="funGuideLineBtn()">
            <svg viewBox="0 0 20 20"><path d="M4 3a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2H4zm0 2h12v4H4V5zm0 6h12v4H4v-4z"/></svg>
            Guideline
        </button>

        <button type="button" class="action-btn" id="btnSendmail" title="Send Document to Client" onclick="funSendMail()">
            <svg viewBox="0 0 20 20"><path d="M2 5a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5zm2 0v.01L10 9l6-3.99V5H4zm0 2v8h12V7l-6 4-6-4z"/></svg>
            Sendmail
        </button>

        <button type="button" class="action-btn" id="btnTerms" title="Terms and Conditions" onclick="funTermsCond()">
            <svg viewBox="0 0 20 20"><path d="M10 2l1.6 3.2L15 6.4l-2.4 2.4L13.2 12 10 10.4 6.8 12l.6-3.2L5 6.4l3.4-1.2L10 2zm3.8 12.8a2.2 2.2 0 1 1 2.2-2.2 2.2 2.2 0 0 1-2.2 2.2zm-7.6 0A2.2 2.2 0 1 1 8.4 12.6 2.2 2.2 0 0 1 6.2 14.8z"/></svg>
            Terms
        </button>

    </div>
</div>

</body>
</html>