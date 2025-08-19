<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link rel="stylesheet" href="toDoStyle.css" />   
<link href="<%=contextPath%>/vendors/bootstrap-v3/css/bootstrap.min.css" rel="stylesheet">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<style>
.icon {
	width: 2em;
	height: 1.2em;
	border: none;
	background-color: #FFF8B3;
}
.buttonBG{
    background-color: #fff8b3;  
    border: 0px;
}
.custom-modal .modal-content {
    border: none;
    border-radius: 15px;
    box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
    background-color: #ffffff;
  }
  .custom-modal .modal-header {
    border-bottom: none;
    background-color: #f8f9fa;  
    color: #000000;  
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    text-align: center;  
    padding: 10px 20px;  
  }
  .custom-modal .modal-body {
    padding: 20px;
  }
  .custom-modal .modal-footer {
    border-top: none;
    background-color: #f8f9fa;
    border-bottom-left-radius: 15px;
    border-bottom-right-radius: 15px;
    padding: 10px 20px;  
  }
  
  .padclass{
      padding-top: 3px;
  }
</style>
<script type="text/javascript">
$(document).ready(function() {
	funChangeStatus();
	$("#btnNextTab").show();   
 	$("#btnPreviousTab").hide(); 
    $("#btnNextTab").click(function() {
    	funNextTab();
    });
    $("#btnPreviousTab").click(function() {
    	funPreviousTab();
    });
    $("#btnRefreshTab").click(function() {
    	funLoadCount();pendingLoad();
    });
    $("#btnHistoryTab").click(function() { 
    	 var userid = '<%= session.getAttribute("USERID").toString()%>';  
    	 $("#taskhisdiv").load("taskListGrid.jsp?userid="+userid+"&id="+1);      
    	 $("#historyModal").modal('show');
    });
    $("#btnPendingTab").click(function() { 
    	pendingLoad();
    	funChangeStatus();
    	$("#modalpendingtask").modal('show');
    });
});

function pendingLoad(){
	var userid = '<%= session.getAttribute("USERID").toString()%>';  
	 $("#pnddiv").load("pendingtaskGrid.jsp?userid="+userid+"&id="+1); 
}

function subLoad(){
	var docno = $("#txtpendocno").val();  
	$('#flwupdiv').load("taskfollowupGrid.jsp?docno="+docno+"&id="+1);   
}

function funNextTab(){
	 $("#pendDiv").prop("hidden", true); 
  	 $("#taskMgmtDiv").prop("hidden", false);
  	 $("#btnNextTab").hide();   
  	 $("#btnPendingTab").hide();
  	 $("#btnHistoryTab").hide();
  	 $("#btnRefreshTab").hide();
  	 $("#btnPreviousTab").show();  
  	 $('#jqxExpDateComp').val(new Date());    
  	 $("#txtremarks").val('');
  	 $("#hiduser").val('');
 	 $("#jqxInputUser").val('');  
}

function funPreviousTab(){
	 $("#pendDiv").prop("hidden", false); 
 	 $("#taskMgmtDiv").prop("hidden", true);
 	 $("#btnNextTab").show();   
 	 $("#btnPreviousTab").hide();
 	 $("#btnRefreshTab").show();
 	 $("#btnPendingTab").show();
 	 $("#btnHistoryTab").show();  
 	 funLoadCount();
}

function funClearTask(){
	$("#txtrefno").val('');
	$('#jqxExpDateComp').val(new Date());
 	$("#txtremarks").val('');
 	$("#hiduser").val('');
 	$("#jqxInputUser").val('');
}

function funLoadCount(){  
	 var userid = '<%= session.getAttribute("USERID").toString()%>';  
	 $("#pendDiv").load("countofTaskGrid.jsp?userid="+userid+"&id="+1);  
}
 
function funstatusval(){         
	 var crtuserid = document.getElementById("txtasgnuser").value;     
	 var sesuserid = "<%= session.getAttribute("USERID").toString() %>";  
	 var optionref = "";  
	 if(crtuserid==sesuserid){   
		  optionref += '<option value="Assigned">Assign</option>';
		  optionref += '<option value="Accepted">Accepted</option>';
		  optionref += '<option value="Completed">Completed</option>';
		  optionref += '<option value="Confirmed">Confirmed</option>';                 
	      $("select#assgntask").html(optionref); 
	 }else{
		  optionref += '<option value="Assigned">Assign</option>';
		  optionref += '<option value="Accepted">Accepted</option>';
		  optionref += '<option value="Completed">Completed</option>';
	      $("select#assgntask").html(optionref);  
	 }
}  

function pendingUpdate(docno, status, asgnuser){                         
	var crtuser = $('#txtcrtuser').val(); 
	var oldstat = document.getElementById("txtoldstatus").value;  
	var userid ="";
  	var oldassuser = document.getElementById("txtasgnuser").value;     
	var userid = asgnuser; 
	var remarks = $('#remarks').val();  
	var x = new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{ 
			var items=x.responseText.trim();
			if(parseInt(items)>0){
				//document.getElementById("txtcrtuser").value="";    
				document.getElementById("hidpenduser").value="";
				//document.getElementById("txtpendocno").value="";  
				document.getElementById("jqxInputPendingUser").value="";   
				$('#remarks').val('');$("#assgntask").val('');
				$("#taskfollowupGrid").jqxGrid('clear'); 
				pendingLoad(); 
				$.messager.alert('success','Status Updated');
			}else{    
				$.messager.alert('warning','Not Updated');   
			}    
		}else
		{
		}    
	}
	x.open("GET","penStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+encodeURIComponent(status)+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+encodeURIComponent(remarks),true);           
	x.send();
}

function funpendingUpdate(){ 
	var docno = $('#txtpendocno').val(); 
	var assgntask = $("#assgntask").val();
	var penduser ="";
	var oldstat = document.getElementById("txtoldstatus").value;  
	if(assgntask=="Accepted" || assgntask=="Completed" || assgntask=="Confirmed"){   
		 penduser = '<%= session.getAttribute("USERID").toString()%>'; 
	}else{
		 penduser = $('#hidpenduser').val(); 
	}
	if(docno=="" || docno==null){
		$.messager.alert('warning','Please Select a Document');    
		return false;
	}
	if(penduser=="" || penduser==null){  
		$.messager.alert('warning','Please Select a User');    
		return false;
	}
	if(assgntask=="Confirmed" && oldstat!="Completed"){  
		$.messager.alert('warning','Task is not completed');    
		return false;  
	}
	
	$.messager.confirm('Message', 'Do you want to create Task?', function(r){ 
	     	if(r==false){
	     		return false; 
	     	}else{
	     		pendingUpdate(docno, assgntask, penduser);	
	     	}
	 }); 
}

function funChangeStatus(){   
	var assgntask = $("#assgntask").val()  
	if(assgntask=="Accepted" || assgntask=="Completed" || assgntask=="Confirmed"){           
		//$("#remrklbl").hide()
		//$("#remarks").hide()
		$("#asgntolbl").hide()
		$("#penduserdiv").hide()
	}else{
		//$("#remrklbl").show()
		//$("#remarks").show()
		$("#asgntolbl").show()
		$("#penduserdiv").show()  
	}
}
</script>
</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">

<div style="background-color:#FFF8B3;">

<table width="100%">  
  <tr>
    <td align="left"><button type="button" class="btn btn-default buttonBG" id="btnPreviousTab"  data-toggle="tooltip" title="Back" data-placement="bottom"><i class="fa fa-arrow-circle-left" aria-hidden="true"></i></button></td>
    <td class="toDoHead" align="center"><label onclick="funClearTask();">Task Management</label></td>  
   <%--  <td align="right"><button type="button" class="icon" id="btnHide" title="Hide">
							<img alt="Hide" src="<%=contextPath%>/icons/icon-up.png">        
						</button></td> --%>  
	<td align="right"><button type="button" class="btn btn-default buttonBG" id="btnRefreshTab"  data-toggle="tooltip" title="Refresh" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button></td>	
	<td align="right"><button type="button" class="btn btn-default buttonBG" id="btnHistoryTab"  data-toggle="tooltip" title="Task History" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button></td>					
    <td align="right"><button type="button" class="btn btn-default buttonBG" id="btnPendingTab"  data-toggle="tooltip" title="Pending Task" data-placement="bottom"><i class="fa fa-hourglass-half" aria-hidden="true"></i></button></td>  
    <td align="right"><button type="button" class="btn btn-default buttonBG" id="btnNextTab"  data-toggle="tooltip" title="Create Task" data-placement="bottom"><i class="fa fa-plus-square" aria-hidden="true"></i></button></td>
  </tr>
</table>
<div id="pendDiv"><jsp:include page="countofTaskGrid.jsp"></jsp:include></div>     
<div id="taskMgmtDiv" hidden="true"><jsp:include page="taskCreation.jsp"></jsp:include></div>    
</div>

<!-- Modal -->
<div class="modal fade custom-modal" id="historyModal" tabindex="-1" role="dialog" aria-labelledby="dataModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#CDFDFA">
        <h5 class="modal-title" id="dataModalLabel">Task History</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table width="100%">  
 				 <tr> 
   				 <td><div id="taskhisdiv"><jsp:include page="taskListGrid.jsp"></jsp:include></div></td>
  				</tr> 
        </table>
      </div>
      <div class="modal-footer" style="background-color:#CDFDFA">   
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="background-color:#f44336;color: white;">Close</button>
      </div>
    </div>
  </div>
</div>

 <!-- Pending Modal-->           
      <div id="modalpendingtask" class="modal fade custom-modal" role="dialog">     
      <div class="modal-dialog modal-lg">    
        <div class="modal-content">
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Pending Task</h4>      
          </div>
          <div class="modal-body">
		    	<div class="container-fluid">
						<table width="100%">  
		 				 <tr>  <td colspan="6"><div id="pnddiv"><jsp:include page="pendingtaskGrid.jsp"></jsp:include></div></td> </tr> 
		  				 <tr>  <td colspan="6" class="padclass"><div id="flwupdiv"><jsp:include page="taskfollowupGrid.jsp"></jsp:include></div></td> </tr>   
		  			<tr>  
					    <td width="7%" align="right"><label class="branch" id="asgnlbl">Select Status</label></td>        
					    <td width="9%"><select id="assgntask" style="width:100%;height: 20px;position: static;" onchange="funChangeStatus();"></select></td>
					    <td width="4%" align="right"><label class="branch" id="asgntolbl">Assign To</label></td>              
						<td width="7%"><div id="penduserdiv" onkeydown="return (event.keyCode!=13);"><jsp:include page="pendingUserSearch.jsp"></jsp:include></div>
						<input type="hidden" name="hidpenduser" id="hidpenduser">              
						                </td>     
						<td width="5%" align="right"><label class="branch" id="remrklbl">Remarks</label></td>                  
						<td width="25%"><input type="text" style="width:100%;height:20px;" id="remarks"/></td>                              
			       </tr>       
			     </table> 
			   </div>   
          </div>
          <div class="modal-footer" style="background-color:#CDFDFA">   
          <button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default" style="background-color: #04AA6D;color: white;">Update</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:#f44336;color: white;">Close</button>
          </div>
        </div>
      </div>
    </div>

</div>
<input type="hidden" id="txtpendocno" name="txtpendocno" value='<s:property value="txtpendocno"/>'/>
<input type="hidden" id="txtasgnuser" name="txtasgnuser" value='<s:property value="txtasgnuser"/>'/>
<input type="hidden" id="txtcrtuser" name="txtcrtuser" value='<s:property value="txtcrtuser"/>'/>
<input type="hidden" id="txtoldstatus" name="txtoldstatus" value='<s:property value="txtoldstatus"/>'/>   
<script src="<%=contextPath%>/vendors/bootstrap-v3/js/bootstrap.min.js"></script>
</body>
</html>