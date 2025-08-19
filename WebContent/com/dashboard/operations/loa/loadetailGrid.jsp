<%@page import="com.dashboard.operations.loa.ClsLoaDAO" %>
<%ClsLoaDAO cod=new ClsLoaDAO(); %>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String test = request.getParameter("tst")=="" || request.getParameter("tst")==null?"0":request.getParameter("tst");%>

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
	  	var datam,detExcel;  
	  	var temp='<%=test%>';
	  	//alert(temp);
	  	//alert(datam);  
	  	if(temp=="1"){
	  		datam='<%=cod.DetailGridLoading(test,docno,type)%>';   
	  		detExcel='<%=cod.DetailGridExcelLoading(test,docno,type)%>';
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
                        { name: 'date', type: 'date' },
                        { name: 'issuedate', type: 'date' },
                        { name: 'expirydate', type: 'date' },
                        { name: 'notes', type: 'String' },
						{ name: 'type', type: 'String' },
						{ name: 'fleet_no', type: 'number' },
						{ name: 'drvid', type: 'number' },
						{ name: 'passno', type: 'number' },
						{ name: 'regno', type: 'number' },
						{ name: 'vehicle', type: 'String' },
						{ name: 'driver', type: 'String' },
						{ name: 'description', type: 'String' }
	                   
   					
   						
	            ],
                localdata: datam,
               
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
            
            $("#detailList").jqxGrid(
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
                         { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					     }   },	
                        { text: 'Doc_no', datafield: 'doc_no', width: '5%' },
                        { text: 'Date', datafield: 'date', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
						{ text: 'Type', datafield: 'type', width: '5%' },
						{ text: 'Fleet No', datafield: 'fleet_no', width: '6%' },
						{ text: 'Reg No', datafield: 'regno', width: '6%' },
						{ text: 'Vehicle', datafield: 'vehicle', width: '10%' },
						{ text: 'Driver', datafield: 'driver', width: '10%' },
						{ text: 'Driver id', datafield: 'drvid', width: '15%' ,hidden:true},
						{ text: 'Pass No', datafield: 'passno', width: '10%' },
						{ text: 'Description', datafield: 'description',width: '15%'  },
						{ text: 'Issue Date', datafield: 'issuedate', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
						{ text: 'Expiry Date', datafield: 'expirydate', width: '6%', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' },
	                    { text: 'Notes', datafield: 'notes',width: '15%'  },
					    
					   
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
             $('#detailList').on('rowdoubleclick', function (event) 
              {
              var row2=event.args.rowindex;
               
              
              
              });
            
            
        });

</script>
<div id="detailList"></div>
