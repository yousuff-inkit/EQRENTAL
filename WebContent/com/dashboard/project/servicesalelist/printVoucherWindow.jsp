
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
<link href="<%=contextPath%>/css/body.css" media="screen"
	rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	$(document).ready(function() {
		getbankname();
		document.getElementById("rdheader").checked = true;
	});

	function getbankname() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var banknameItems = items[0].split(",");
				var bankIdItems = items[1].split(",");
				var optionsbanknames = '<option value="">--Select--</option>';
				for (var i = 0; i < banknameItems.length; i++) {
					optionsbanknames += '<option value="' + bankIdItems[i] + '">'
							+ banknameItems[i] + '</option>';
				}
				$("select#cmbprintbankname").html(optionsbanknames);
				$("#cmbprintbankname").val($("#cmbbranch").val().trim());
			} else {
			}
		}
		x.open("GET", "getBankName.jsp", true);
		x.send();
	}

	function printlogo() {
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
		
		var bankdocno = $('#cmbprintbankname').val();
		if ($('#cmbprintbankname').val() == '') {
			$.messager.alert('Message', 'Choose a Bank.', 'warning');
			return 0;
		}
		var header = 0;
		if (document.getElementById("rdheader").checked == true) {
			header = 1;
		} else if (document.getElementById("rdnoheader").checked == true) {
			header = 0;
		}

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
		var win = window.open(reurl[0] + "printmultisrs?docnos="+ docnos +"&brhid="+ brhid +"&header="+ header +"&bankdocno="+bankdocno, "_blank",
							"top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
		
		$('#printWindow').jqxWindow('close');
	}
</script>
<body>
	<div id=search>
		<br />
		<table width="100%" style="font-size:10px">
			<tr>
				<td width="20%" align="right">Bank</td>
				<td colspan="2"><select id="cmbprintbankname"
					name="cmbprintbankname" style="width: 65%;"
					value='<s:property value="cmbprintbankname"/>'>
						<option value="">--Select--</option>
				</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
					type="radio" id="rdheader" name="rdo" value="rdheader"><label
					for="rdheader">With Header</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" id="rdnoheader" name="rdo" value="rdnoheader"><label
					for="rdnoheader">Without Header</label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td width="57%" align="center"><input type="button"
					name="btninv" id="btninv" class="myButton" value="Print"
					onclick="printlogo();"></td>
				<td width="36%">&nbsp;</td>
			</tr>
		</table>
		&nbsp;
	</div>
</body>
</html>