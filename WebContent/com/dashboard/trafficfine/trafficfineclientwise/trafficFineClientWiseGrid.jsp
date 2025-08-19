<%@page import="com.dashboard.trafficfine.trafficfineclientwise.*" %>
<%ClsTrafficFineClientWiseDAO ctd=new ClsTrafficFineClientWiseDAO();
 String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
 String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
 String clientcat = request.getParameter("clientcat")==null?"":request.getParameter("clientcat").trim();
 String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
%>
<style>

 .redClass
   		{
   		   /* background:#FFEBEB; */
   		   background:#F16F6F;
   		}
 </style>

 <script type="text/javascript">
 
var data1;
var id='<%=id%>';
var exceldata;
if(id=='1'){ 
	data1='<%=ctd.invoicedGridLoading(branch,fromdate, todate, cldocno, clientcat, id)%>';
	exceldata='<%=ctd.invoicedGridLoadingExcel(branch,fromdate, todate, cldocno, clientcat, id)%>';
}

        $(document).ready(function () { 	
     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [

							{name : 'rano', type: 'string'},
							{name : 'dtypedesc', type: 'string'},
							{name : 'invno', type: 'string'},
							{name : 'refname', type: 'string'},
     						{name : 'regno', type: 'string'},
     						{name : 'fleetno', type: 'string'},
     						{name : 'location', type: 'string'},
     						{name : 'source', type: 'string'},
     						{name : 'ticket_no', type: 'string'},
     						{name : 'amount', type: 'string'},
     						{name : 'trafficcount',type:'number'}
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
    		$("#trafficFinesGrid").on("bindingcomplete", function (event) {
    			$("#overlay, #PleaseWait").hide();
	    	});
    
    		var cellclassname = function (row, column, value, data) {
     			if(parseInt(data.trafficcount)>=3){
	            	return "redClass";
    	        }
       		};
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#trafficFinesGrid").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize:true,
                columns: [
							
							{ text: 'Client/Employee', datafield: 'refname', width: '30%',cellclassname: cellclassname },		
							{ text: 'Ticket No.', datafield: 'ticket_no', width: '25%',cellclassname: cellclassname },
							{ text: 'Inv No', datafield: 'invno', width: '25%' ,cellclassname: cellclassname},
							{ text: 'Traffic Count',datafield:'trafficcount',width:'10%',cellclassname: cellclassname},
							{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right',cellclassname: cellclassname },
														
	              ]
            });
            
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="trafficFinesGrid"></div>
