<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen"
	rel="stylesheet" type="text/css" />

<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%>

<style type="text/css">
.myButtons {
	-moz-box-shadow: inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow: inset 0px -1px 3px 0px #91b8b3;
	box-shadow: inset 0px -1px 3px 0px #91b8b3;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87
		), color-stop(1, #6c7c7c));
	background: -moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background: -webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background: -o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background: -ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87',
		endColorstr='#6c7c7c', GradientType=0);
	background-color: #768d87;
	border: 1px solid #566963;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-size: 8pt;
	padding: 3px 17px;
	text-decoration: none;
	text-shadow: 0px -1px 0px #2b665e;
}

.myButtons:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c
		), color-stop(1, #768d87));
	background: -moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background: -webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background: -o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background: -ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background: linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c',
		endColorstr='#768d87', GradientType=0);
	background-color: #6c7c7c;
}

.myButtons:active {
	position: relative;
	top: 1px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
						$('#loaddetaildata').hide();

						$('#loadgriddata').show();
						$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
						$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

						$('#txtclientname').dblclick(function() {
											accountsSearchContent('clientAccountDetailsSearch.jsp');
						});
						
						$('#accountDetailsWindow').jqxWindow({
							width : '51%',
							height : '58%',
							maxHeight : '70%',
							maxWidth : '51%',
							title : 'Accounts Search',
							position : {
								x : 300,
								y : 87
							},
							theme : 'energyblue',
							showCloseButton : true,
							keyboardCloseKey : 27
						});
						$('#accountDetailsWindow').jqxWindow('close');

						$('#printWindow').jqxWindow({
							width : '30%',
							height : '19%',
							maxHeight : '50%',
							maxWidth : '40%',
							title : 'Print',
							position : {
								x : 300,
								y : 87
							},
							theme : 'energyblue',
							showCloseButton : true,
							keyboardCloseKey : 27
						});
						$('#printWindow').jqxWindow('close');

						$("#fromdate").jqxDateTimeInput({
							width : '125px',
							height : '15px',
							formatString : "dd.MM.yyyy"
						});
						$("#todate").jqxDateTimeInput({
							width : '125px',
							height : '15px',
							formatString : "dd.MM.yyyy"
						});
						var fromdates = new Date($('#fromdate')
								.jqxDateTimeInput('getDate'));
						var onemounth = new Date(new Date(fromdates)
								.setMonth(fromdates.getMonth() - 1));

						$('#fromdate').jqxDateTimeInput('setDate',new Date(onemounth));
						$('#todate').on('change',function(event) {
							var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));

							var todates = new Date($('#todate').jqxDateTimeInput('getDate')); //del date

							if (fromdates > todates) {

								$.messager.alert('Message','To Date Less Than From Date  ','warning');
									return false;
								}
						});

						funbnkdetls();

	
		$('#cmbbranch').change(function(event){
			funreload(event);
		})
	});
	
	function funExportBtn() {
	/* 	var rds = $('#summ').val();
		if (rds == "summ") {
			JSONToCSVCon(projectlistexcel, 'Service Sale List', true);
		} else {
			JSONToCSVCon(detaillistexcel, 'Service Sale Detail List', true);
		} */
		
		var rds = $('#summ').val();
		if (rds == "summ") {
			$("#loadgriddata").excelexportjs({
				containerid: "loadgriddata", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxloaddataGrid", 
				columns: getColumns("jqxloaddataGrid") ,   
				worksheetName:"Service Sale List"
				});
			
		}else{
			$("#loaddetaildata").excelexportjs({
				containerid: "loaddetaildata", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxloaddetailGrid", 
				columns: getColumns("jqxloaddetailGrid") ,   
				worksheetName:"Service Sale Detail List"
				});
			
		}
	}

	function funreload(event) {
		var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
		// out date
		var todates = new Date($('#todate').jqxDateTimeInput('getDate')); //del date

		if (fromdates > todates) {

			$.messager.alert('Message', 'To Date Less Than From Date  ',
					'warning');

			return false;
		}

		var barchval = document.getElementById("cmbbranch").value;
		var fromdate = $("#fromdate").val();
		var todate = $("#todate").val();
		var rds = $('#summ').val();
		var clientid = $('#txtclientaccountdocno').val();

		if (rds == "summ") {
			$("#overlay, #PleaseWait").show();
			$("#loadgriddata").load("gridDetails.jsp?barchval=" + barchval + "&froms="
							+ fromdate + "&tos=" + todate + "&rds=" + rds
							+ "&clientid="+ clientid + "&zoneid=" + 1);
		} else {
			$("#overlay, #PleaseWait").show();
			$("#loaddetaildata").load("detailGrid.jsp?barchval=" + barchval + "&froms="
							+ fromdate + "&tos=" + todate + "&rds=" + rds
							+ "&clientid="+ clientid + "&zoneid=" + 1);
		}

	}

	function getClientAccount(event) {
		var rds = $('#ctype').val();
		if (rds == 'ALL') {

		}
		var x = event.keyCode;
		if (x == 114) {
			accountsSearchContent('clientAccountDetailsSearch.jsp');
		}
	}
	
	function accountsSearchContent(url) {
		$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		});
	}

	function funsumm() {
		if (document.getElementById("summ").value == "summ") {
			$('#loaddetaildata').hide();

			$('#loadgriddata').show();

			$('#btnprint').show();
		} else {
			$('#loaddetaildata').show();

			$('#loadgriddata').hide();

			$('#btnprint').hide();
		}
	}

	function funbnkdetls() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if (parseInt(items) > 0) {
					document.getElementById("hidbnk").value = 1;

				} else {
					document.getElementById("hidbnk").value = 0;
				}
			}
		}
		x.open("GET", "shwbnkdetls.jsp?", true);
		x.send();
	}

	function funPrintData(){
		var brhid = document.getElementById("cmbbranch").value;
		
		if(brhid=="a" || brhid==""){
			$.messager.alert('Warning', 'Please select a branch');
			return false;
		}
		
		var selectedrows = $('#jqxloaddataGrid').jqxGrid('selectedrowindexes');
		if (selectedrows.length == 0) {
			$.messager.alert('Warning', 'Please select valid invoice');
			return false;
		}
			
		if ($("#hidbnk").val()==1) {
			PrintContent('printVoucherWindow.jsp');
			win.focus();
		} else {
			var docnos = ""
			for (var i = 0; i < selectedrows.length; i++) {
				if (i == 0) {
					docnos += $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i], 'doc_no');
				} else {
					docnos += ":"+ $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i], 'doc_no');
				}
			}
			var url = document.URL;
			var reurl = url.split("servicesalelist.jsp");
			var win = window.open(reurl[0] + "printmultisrs?docnos="+ docnos +"&brhid="+ brhid +"&header=1&bankdocno=0", "_blank",
								"top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			win.focus();
		}
	}
	
	function PrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#printWindow').jqxWindow('setContent', data);
			$('#printWindow').jqxWindow('bringToFront');
		});
	}
	
</script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background">
		<div class='hidden-scrollbar'>

			<table width="100% ">
				<tr>
					<td width="20%">
						<fieldset style="background: #ECF8E0;">
							<table width="100%">
								<jsp:include page="../../heading.jsp"></jsp:include>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><label class="branch">From</label></td>
									<td align="left"><div id='fromdate' name='fromdate'
											value='<s:property value="fromdate"/>'></div></td>
								</tr>


								<tr>
									<td align="right"><label class="branch">To</label></td>
									<td align="left"><div id='todate' name='todate'
											value='<s:property value="todate"/>'></div></td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><label class="branch">Type</label></td>
									<td><select id="summ" name="summ" style="width: 70%;"
										onchange="funsumm()">
											<option value="summ">Summary</option>
											<option value="">Detail</option>


									</select></td>
								</tr>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><label class="branch">Client</label></td>
									<td align="left"><input style="height: 19px" ; type="text"
										id="txtclientname" name="txtclientname"
										style="width:100%;height:20px;" readonly="readonly"
										placeholder="Press F3 to Search"
										value='<s:property value="txtclientname"/>'
										onkeydown="getClientAccount(event);" /></td>
								</tr>
								<tr>
									<td colspan="2"><input type="hidden"
										id="txtclientaccountdocno" name="txtclientaccountdocno"
										value='<s:property value="txtclientaccountdocno"/>' /></td>
								</tr>

								<tr>
									<td colspan="2" style="border-top: 2px solid #DCDDDE;">
										<div style="text-align: center;">
											<input type="button" name="btnprint" id="btnprint"
												value="Print" class="myButtons" onclick="funPrintData();">
										</div>
									</td>
								</tr>



								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>

							</table>
							<table>

								<tr>
									<td><input type="hidden" id="trno" name="trno"
										value='<s:property value="trno"/>'></td>
								</tr>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>

							</table>
						</fieldset> <input type="hidden" id="acno" name="acno"
						value='<s:property value="acno"/>'> <input type="hidden"
						id="zoneid" name="zoneid" value='<s:property value="zoneid"/>'>
						
							     <input type="hidden" id="hidbnk" name="hidbnk"  value='<s:property value="hidbnk"/>'/>
					</td>
					<td width="80%">
						<table width="100%">
							<tr>
								<td><div id="loadgriddata">
										<jsp:include page="gridDetails.jsp"></jsp:include>
									</div></td>
							</tr>
							<tr>
								<td><div id="loaddetaildata">
										<jsp:include page="detailGrid.jsp"></jsp:include>
									</div></td>
							</tr>

						</table>
				</tr>
			</table>

		</div>
		<div id="accountDetailsWindow">
			<div></div>
		</div>

		<div id="printWindow">
			<div></div>
		</div>
</body>
</html>