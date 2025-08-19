<%@page import="com.dashboard.operations.tariffmanagementlist.ClsTariffManagementListDAO" %>
<%ClsTariffManagementListDAO cod=new ClsTariffManagementListDAO(); %>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
        .salesManClass
        {
            background-color: #FFEBEB;
        }
        .salesAgentClass
        {
            background-color: #FFFFD1;
        }
        .rentalAgentClass
        {
           background-color: #FFFAFA;
        }
         .driverClass
        {
           background-color: #F0FFFF;
        }
         .staffClass
        {
           background-color: #F8E0F7;
        }
         .checkInClass
        {
           background-color: #F7F2E0;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">
	  	var data1,dataExcel;  
	  	var temp='<%=check%>';
	  	
	  	if(temp=='1'){
	  		data1='<%=cod.FirstListGridLoading(check,fromdate,todate)%>';
	  		dataExcel='<%=cod.FirstListExcelLoading(check,fromdate,todate)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'docno', type: 'String' },
						{ name: 'clientid', type: 'String' },
						{ name: 'clientname', type: 'String' },
						{ name: 'currentdate', type: 'date' },
						{ name: 'tariftype', type: 'String' },
	                    { name: 'tariffor', type: 'String' },
	                    { name: 'validfrm', type: 'date' },
                    	{ name : 'validto', type: 'date' }, 
   						{ name : 'chk', type: 'String' },
   						{ name : 'notes', type: 'String' }
   						
	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#tariffList").jqxGrid(
            {
                width: '98%',
                height: 200,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                enabletooltips:true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Doc No', datafield: 'docno', width: '5%' },
						{ text: 'Date', datafield: 'currentdate', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
						{ text: 'Tariff Type', datafield: 'tariftype', width: '5%' },
						{ text: 'Clientid ', datafield: 'clientid',hidden:true },
						{ text: 'Tariff Type Corporate ', datafield: 'clientname', width: '10%' },
	                    { text: 'Tariff For', datafield: 'tariffor', width: '5%' },
	                    { text: 'Valid From', datafield: 'validfrm', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
	                    { text: 'Valid To', datafield: 'validto', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
	                    { text: 'Delivery Charge', datafield: 'chk', width: '5%' },
					    { text: 'Notes', datafield: 'notes' },
					   
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
             $('#tariffList').on('rowdoubleclick', function (event) 
              {
              var row2=event.args.rowindex;
              var doc=$('#tariffList').jqxGrid('getcellvalue', row2, "docno");
               $("#detailDiv").load("detailgrid.jsp?docno="+doc+"&check="+1);
              });
            
            
        });

</script>
<div id="tariffList"></div>
