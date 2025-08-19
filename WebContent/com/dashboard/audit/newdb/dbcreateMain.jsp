<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
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
</style>

<script type="text/javascript">

	$(document).ready(function () {
		   $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		     $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

		 $("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
		
		 $('#formSearch').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		 $('#formSearch').jqxWindow('close'); 
		 
		 $('#txtformname').dblclick(function(){
			 formSearchContent('formSearchGrid.jsp');
	     });
	});
	
	function getTables(){
		var db=document.getElementById("dbname").value;
		$('#tablelist').load("tablelistGrid.jsp?check=1&dbname="+db);
		$('#reqtablelist').load("reqtablelistGrid.jsp?check=1");
	}
	function truncateTables(){
		  var rows = $("#reqtablelistGrid").jqxGrid('getrows');
  		  var reqtable=[];
		  for(var i=0 ; i < rows.length ; i++){
			  	var chk=rows[i].tablename;
			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
			    	reqtable.push("'"+chk+"'");
			    }
		  }
		$("#overlay, #PleaseWait").show();
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
	
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		       
		  }
		}
			
	x.open("GET","saveData.jsp?dbname="+document.getElementById("dbname").value+"&reqtable="+reqtable,true);
	x.send();
	}

	function formSearchContent(url) {
	    $('#formSearch').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#formSearch').jqxWindow('setContent', data);
		$('#formSearch').jqxWindow('bringToFront');
	}); 
	}
	
	function getForms(event){
        var x= event.keyCode;
        if(x==114){
        	formSearchContent('formSearchGrid.jsp');
        }
        else{}
        }
	
	</script>  
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background"> 
<div >
<table>
<tr><td width=15%>Existing Database Name</td>
<td width=20%><input type="text" id="dbname" name="dbname" style="width:100%;height:100%" /></td>
<td  width=5%><input type="button" class="myButtons" value="Load" onclick="getTables();"/></td>
<td width=10%><input type="button" class="myButtons" value="Create Blank DB" onclick="truncateTables();"/></td>
<td  width=15% align="right">Add to Required list</td>
<td width=25%><input type="text" id="txtformname" name="txtformname" placeholder="Press F3 To Search"  readonly="readonly"   onkeydown="getForms(event)" style="width:100%;height:100%" />
<input type="hidden" id="hidform" name="hidform" />
</td>
<td  width=10% hidden="true"><input type="button" class="myButtons" value="Add" onclick="addReqTables();"/></td>
</tr>

</table>
<table width="100%"><tr><td>
<fieldset><legend>Existing Tables</legend><div id="tablelist"><jsp:include page="tablelistGrid.jsp"></jsp:include></div></fieldset></td>
<td><fieldset><legend>Required Tables</legend><div id="reqtablelist"><jsp:include page="reqtablelistGrid.jsp"></jsp:include></div></fieldset></td>

</tr></table>

</div></div>
<div id="formSearch"><div></div></div>
</body>
</html>