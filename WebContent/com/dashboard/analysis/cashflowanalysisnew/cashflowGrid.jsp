<%@page import="com.dashboard.analysis.cashflowanalysisnew.ClsCashFlowDAO" %>
<% ClsCashFlowDAO cpla=new ClsCashFlowDAO();%>
<%   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     String freqeuncy = request.getParameter("freqeuncy")==null?"0":request.getParameter("freqeuncy").trim();
 %>
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>

 <script type="text/javascript">
 	var check='<%=check%>';  
 		$(document).ready(function () {
			var data1 ="";      
 			  
			if(check=='1'){
 				data1 = '<%=cpla.cashflowGridLoading(fromDate,toDate,freqeuncy,check)%>';
 				exceldata = '<%=cpla.cashflowExcelExport(fromDate,toDate,freqeuncy)%>';
 			}else{ 
 				data1 = '[{"columns":[{"text":"Id","datafield":"id","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Parent Id","datafield":"parentid","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","width":"75%","cellclassname":"cellclassname"},{"text":"Total","datafield":"total","cellsAlign":"right","align":"right","width":"25%","cellsFormat":"d2","cellclassname":"whiteClass"},{"text":"","datafield":"amount0","cellsAlign":"right","align":"right","width":"25%","cellsFormat":"d2","cellclassname":"whiteClass"}]},{"rows":[{"id":"1","description":"","total":"","amount0":""}]}]';   
 			}   
    
			//alert("data=="+data1);
            var obj = $.parseJSON(data1);
            var columns = obj[0].columns;  
            var	data = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: "id", type: "number" },
                    { name: 'description', type: "string" },
					{ name: 'total', type: "number" },
                    { name: "parentid", type: "number" },
                    { name: 'amount0', type: "number" },
                    { name: 'amount1', type: "number" },
                    { name: 'amount2', type: "number" },
                    { name: 'amount3', type: "number" },
                    { name: 'amount4', type: "number" },
                    { name: 'amount5', type: "number" },
                    { name: 'amount6', type: "number" },
                    { name: 'amount7', type: "number" },
                    { name: 'amount8', type: "number" },
                    { name: 'amount9', type: "number" },
                    { name: 'amount10', type: "number" },
                    { name: 'amount11', type: "number" }
                ],  
                hierarchy:  
                {
                    keyDataField: { name: "id" },
                    parentDataField: { name: "parentid" }
                },
                id: "id",
                localdata: data
            };
           
            var cellclassname = function (row, column, value, data) {
            	alert("in----");
            	if (data.description=='Opening') {
         			 return "redClass";
                 } else if (data.description=='Inflow') {
                     return "yellowClass";  
                 }   else  if (data.description=='Inflow PDC') {     
                     return "greenClass";       
                 } else if (data.description=='Outflow') {  
                 	 return "headClass";   
                 }      
                 else{
                 	return "whiteClass";    
                 };   
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#analysisGrid").jqxTreeGrid(
            {
                width: '99.5%',
                height: 520,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                ready: function() 
                {
                	var rows = $("#analysisGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#analysisGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                	}
                }, 
            });
            $("#overlay, #PleaseWait").hide();  
        });
 		
    </script>

    <div id="analysisGrid"></div>
