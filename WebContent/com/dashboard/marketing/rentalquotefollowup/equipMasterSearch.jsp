 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
	body{
		font-size:11px;
	}
	.equipsearch .form-control{
		height:21px;
	}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '20px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		var fleetno=document.getElementById("searchfleet").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		var fleetname=document.getElementById("searchfleetname").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var engine=document.getElementById("searchengine").value;
		var chassis=document.getElementById("searchchassis").value;
		getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis);
	}
	function getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis){
		var subcatid=$('#approvalGrid').jqxGrid('getcellvalue',$('#fleetindex').val(),'subcatid');
		 $("#equipsearchgriddiv").load('equipSearchGrid.jsp?subcatid='+subcatid+'&fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&fleetname='+fleetname+'&searchdate='+searchdate+'&id=1&engine='+engine+'&chassis='+chassis);
		 

		}
 
	</script>
<body>
<div class="container-fluid equipsearch">
	<div class="row" style="margin-bottom:5px;">
		<div class="col-xs-1 text-right" style="padding-right:0;">Equip No</div>
		<div class="col-xs-2"><input type="text" name="searchfleet" id="searchfleet" value='<s:property value="searchfleet"/>' class="form-control"></div>
		<div class="col-xs-1 text-right" style="padding-right:0;">Equip Name</div>
		<div class="col-xs-2"><input type="text" name="searchfleetname" id="searchfleetname" value='<s:property value="searchfleetname"/>'  class="form-control"></div>
		<div class="col-xs-1 text-right" style="padding-right:0;">Engine No</div>
		<div class="col-xs-2"><input type="text" name="searchengine" id="searchengine" value='<s:property value="searchengine"/>' class="form-control"></div>
		<div class="col-xs-1 text-right" style="padding-right:0;">Chassis No</div>
		<div class="col-xs-2"><input type="text" name="searchchassis" id="searchchassis" value='<s:property value="searchchassis"/>' class="form-control"></div>
	</div>
	<div class="row" style="margin-bottom:5px;">
		<div class="col-xs-1 text-right" style="padding-right:0;">Doc No</div>
		<div class="col-xs-2"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>' class="form-control"></div>
		<div class="col-xs-1 text-right" style="padding-right:0;">Date</div>
		<div class="col-xs-2"><div id="searchdate" name="searchdate"></div></div>
		<div class="col-xs-1 text-right" style="padding-right:0;">Asset Id</div>
		<div class="col-xs-2"><input type="text" name="searchregno" id="searchregno" value='<s:property value="searchregno"/>' class="form-control"></div>
		<div class="col-xs-3 text-center"><button class="btn btn-default" type="button" name="btninvsearch" id="btninvsearch" class="myButton"  onClick="mainloadSearch();">Search</button></div>
	</div>
	<div class="row">
		<div class="col-xs-12"><div id="equipsearchgriddiv"><jsp:include  page="equipSearchGrid.jsp"></jsp:include></div></div>
	</div>
</div>
</body>
</html>