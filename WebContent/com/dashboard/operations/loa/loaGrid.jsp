<%@page import="com.dashboard.operations.loa.ClsLoaDAO" %>
<%ClsLoaDAO cod=new ClsLoaDAO(); %>

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
	  		data1='<%=cod.FirstListGridLoading(check)%>';
	  		dataExcel='<%=cod.FirstListGridExcelLoading(check)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'doc_no', type: 'String' },
						{ name: 'name', type: 'String' },
						{ name: 'description', type: 'String' },
						{ name: 'qty', type: 'number' },
						{ name: 'vqty', type: 'number' },
	                    { name: 'avail', type: 'number' },
						{ name: 'dqty', type: 'number' },
	                    { name: 'date', type: 'date' },
                    	{ name : 'enddate', type: 'date' } 
   					
   						
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
            
            $("#loaList").jqxGrid(
            {
                width: '98%',
                height: 380,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                enabletooltips:true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '3%' },
						{ text: 'Date', datafield: 'date', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
						{ text: 'Name', datafield: 'name', width: '17%' },
						{ text: 'Description', datafield: 'description', width: '30%'  },
	                    { text: 'LOA Expiry date', datafield: 'enddate', width: '8%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
	                    { text: 'Total Slots', datafield: 'qty', width: '8%' },
	                    { text: 'Driver Used Slots', datafield: 'dqty', width: '9%' },
	                    { text: 'Vehicle Used Slots', datafield: 'vqty', width: '9%' },
	                    { text: 'Available Slots', datafield: 'avail', width: '10%' },
					    
					   
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
             $('#loaList').on('rowdoubleclick', function (event) 
              {
              var row2=event.args.rowindex;
               document.getElementById("hiddoc").value=$('#loaList').jqxGrid('getcellvalue',row2,"doc_no");
              $("#detailList").jqxGrid("clear");
              
              });
            
            
        });

</script>
<div id="loaList"></div>
