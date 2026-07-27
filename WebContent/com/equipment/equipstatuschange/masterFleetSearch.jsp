 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		getGroup();
		getColor();
	
	}); 
function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#searchgroup").html(optionsgroup);
				
				
			} else {
			}
		}
		x.open("GET", "../../../com/controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#searchcolor").html(optionscolor);
			} else {
			}
		}
		x.open("GET", "../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
		x.send();
	}
 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		var color=document.getElementById("searchcolor").value;
		var group=document.getElementById("searchgroup").value;
 		var branch=document.getElementById("brchName").value;
		getdata(searchdate,fleetno,docno,regno,color,group,branch);
 

	}

	 function getdata(searchdate,fleetno,docno,regno,color,group,branch){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('fleetSearch.jsp?searchdate='+searchdate+'&fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&color='+color+'&group='+group+'&branch='+branch);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style>
html,body{
    margin:0;
    padding:0;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
}

#search{
    padding:10px;
    background:#fff;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
}

.search-panel table{
    width:100%;
    border-collapse:collapse;
}

.search-panel td{
    padding:6px;
    vertical-align:middle;
    white-space:nowrap;
}

.lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:500;
    color:#333;
}

.search-input{
    height:26px;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
}

.small-input{
    width:130px;
}

.medium-input{
    width:170px;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
}
</style>

<body>

<div id="search">

    <div class="search-panel">

        <table>

            <tr>

                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text"
                           id="searchdocno"
                           name="searchdocno"
                           class="search-input small-input">
                </td>

                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>

                <td class="lbl-right">Color</td>
                <td>
                    <select id="searchcolor"
                            name="searchcolor"
                            class="search-input medium-input">
                        <option value="">--Select--</option>
                    </select>
                </td>

            </tr>

            <tr>

                <td class="lbl-right">Fleet No</td>
                <td>
                    <input type="text"
                           id="searchfleetno"
                           name="searchfleetno"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">Asset Id</td>
                <td>
                    <input type="text"
                           id="searchregno"
                           name="searchregno"
                           class="search-input medium-input">
                </td>

                <td class="lbl-right">Group</td>
                <td>
                    <select id="searchgroup"
                            name="searchgroup"
                            class="search-input medium-input">
                        <option value="">--Select--</option>
                    </select>
                </td>

                <td align="center">

                    <button
                        type="button"
                        id="btnSearchExt"
                        class="myButton"
                        onclick="mainloadSearch();"
                        style="
                            width:100px;
                            height:28px;
                            background:#205fd3;
                            color:#fff;
                            border:1px solid #205fd3;
                            border-radius:4px;
                            font-size:12px;
                            font-weight:600;
                            cursor:pointer;">
                        Search
                    </button>

                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="srefreshdiv">
            <jsp:include page="fleetSearch.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>