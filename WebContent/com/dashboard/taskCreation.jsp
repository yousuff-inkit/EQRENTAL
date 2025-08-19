<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link rel="stylesheet" href="toDoStyle.css" />
<title>GatewayERP(i)</title>

<style type="text/css">
.toDoHead{
    color: blue;
	/*background-color: #ECF8E0; */
	width: 100%;
	/* height: 28px; */
	font-family: Myriad Pro;
	font-weight: bold;
	font-size: 14px;
}

.styled-button-5 {
	background-color: #ed8223;
	color: #fff;
	font-family: 'Helvetica Neue',sans-serif;
	font-size: 14px/* 18px */;
	line-height: 24px/* 30px */;
	border-radius: 16px/* 20px */;
	-webkit-border-radius: 16px/* 20px */;
	-moz-border-radius: 16px/* 20px */;
	border: 0;
	text-shadow: #C17C3A 0 -1px 0;
	width: 120px;
	height: 28px/* 32px */
}  

#tbheight{
	height:20px;
}

.branch{
   font-size:10px;
}       
</style>

<script type="text/javascript">
$(document).ready(function() {
	 $("#jqxExpDateComp").jqxDateTimeInput({ width: '110px', height: '22px', formatString:"dd.MM.yyyy"});  
	 getTaskType();
});

function funCreateTask(){ 
	var type = $("#cmbtype").val();
	var userid = $("#hiduser").val();
	var edcdate = $("#jqxExpDateComp").val();
	var remarks = $("#txtremarks").val();
	var refno = $("#txtrefno").val();
	var currentDate = new Date();
	var createduser = '<%= session.getAttribute("USERID").toString()%>';  
	var stdate = currentDate.getFullYear() + '-' + ('0' + (currentDate.getMonth() + 1)).slice(-2) + '-' + ('0' + currentDate.getDate()).slice(-2);
	var sttime = ('0' + currentDate.getHours()).slice(-2) + ':' + ('0' + currentDate.getMinutes()).slice(-2) + ':' + ('0' + currentDate.getSeconds()).slice(-2);
	$.messager.confirm('Message', 'Do you want to create Task?', function(r){
	     	if(r==false){
	     		return false; 
	     	}else{
	     		CreateTask(type, userid, edcdate, remarks, refno, stdate, sttime, createduser);	
	     	}
	 }); 
}

function CreateTask(type, userid, edcdate, remarks, refno, stdate, sttime, createduser){          
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim(); 
			if(parseInt(items)>0){
				funClearTask(); 
				$.messager.alert('success','Successfully Created');
				return false;
			}else{
				$.messager.alert('warning','Not Created');    
				return false;  
			}
		} else {}  
	}
	x.open("GET", "saveTask.jsp?reftype="+type+"&hiduser="+userid+"&userid="+createduser+"&sdate="+stdate+"&stime="+sttime+"&edcdate="+edcdate+"&desc="+encodeURIComponent(remarks)+"&refno="+encodeURIComponent(refno), true);          
	x.send();  
} 

function getTaskType() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var yearItems = items[1].split(",");
			var yearIdItems = items[0].split(",");   
			var optionsyear = '<option value="">--Select--</option>';
			for (var i = 0; i < yearItems.length; i++) {
				optionsyear += '<option value="' + yearIdItems[i].trim() + '">'
						+ yearItems[i].trim() + '</option>';
			}
			$("select#cmbtype").html(optionsyear);
		} else {
		}
	}
	x.open("GET", "getTaskType.jsp", true);
	x.send();
}
</script>
</head>
<body style="background-color:#FFF8B3;font-size:10px;"> 
<div style="background-color:#FFF8B3;">   
 <table width="100%">   
  <tr>
    <td width="80%" align="right" class="detail" colspan="3"><label class="branch">Expected Date of Completion</label></td>
    <td width="20%" align="left"><div id="jqxExpDateComp"></div></td>
  </tr>
 <tr>
    <td width="10%" align="right" class="detail"><label class="branch">Ref No</label></td>
    <td width="40%"><input type="text" id="txtrefno" name="txtrefno" style="width:99%;height:20%" value='<s:property value="txtrefno"/>'/></td> 
    <td width="10%" align="right" class="detail"><label class="branch">Type</label></td>
    <td width="10%"><select id="cmbtype" name="cmbtype" style="width:110px;height:18px"></select>        
    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>     
  </tr> 
  <tr>
    <td width="10%" align="right" class="taskuser"><label class="branch">User</label></td>   
    <td width="90%" colspan="3"><div id="taskuser" onkeydown="return (event.keyCode!=13);"><jsp:include page="taskuserSearch.jsp"></jsp:include></div>    
                    <input type="hidden" name="hiduser" id="hiduser"></td>   
  </tr>
   <tr>
    <td width="10%" align="right" class="detail"><label class="branch">Remarks</label></td>   
    <td width="90%" colspan="3"><textarea id="txtremarks" name="txtremarks" style="width:99%;" rows="8" cols="50"></textarea></td>    
  </tr>
  <tr>
    <td width="90%" colspan="4" align="center"><input type="button" class="styled-button-5" onclick="funCreateTask();" value="Create Task" /></td>
  </tr>  
  <tr id="tbheight"><td colspan="4">&nbsp;</td></tr>     
</table>  
   <br/>
	<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>'/>
</div>
</body>
</html>  