<%@page import="com.dashboard.analysis.equipassetregister.ClsEquipAssetRegister" %>
<%ClsEquipAssetRegister cva=new ClsEquipAssetRegister(); %>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();%>

<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
    
    .textbox {
	    border: 0;
	    height: 25px;
	    width: 20%;
	    border-radius: 5px;
	    -moz-border-radius: 5px;
	    -webkit-border-radius: 5px;
	    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-background-clip: padding-box;
	    outline: 0;
    }
        
</style>

<script type="text/javascript"> 
var branchval='<%=branchval%>';
var fleetno='<%=fleetno%>';
var fromDate='<%=fromDate%>';
var toDate='<%=toDate%>';
var name='<%=name%>';
	  	
        $(document).ready(function (){ 
    		 funreload();
         	$("#excelExport").click(function () {
                 /* $("#detailedAsset").jqxDataTable('exportData', 'xls'); */
                  funExportBtn();
             }); 
         });
        function funreload(){
      		 
  			 $("#detailedAssetdiv").load("equipDetailedAssetGrid.jsp?name="+name+"&branchval="+branchval+'&fleetno='+fleetno+'&fromdate='+fromDate+'&todate='+toDate);
  		  
  		}
       
       function funExportBtn(){
       	 
           $("#detailedAssetdiv").excelexportjs({
				containerid: "detailedAssetdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "detailedAsset",
				columns: getColumns("detailedAsset") ,   
				worksheetName:"Equipment Asset Register"  
			}); 
           
          }
</script>
    
    </head>
<body class='default'>
 <button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button> 
        <table width="100%">
		<tr>
			 <td><div id="detailedAssetdiv"><jsp:include page="equipDetailedAssetGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
	
	</body>
</html>
 