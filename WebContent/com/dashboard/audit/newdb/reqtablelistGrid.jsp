<%@ page import="com.dashboard.audit.newdb.NewDb" %>
<% NewDb DAO=new NewDb(); %>
<% /* String dbname = request.getParameter("dbname")==null?"":request.getParameter("dbname"); */
   
   String check = request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
	var data;
	var temp='<%=check%>';

	if(temp=='1'){ 
		 data='<%=DAO.listReqTables(check)%>';
	}
	
	$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'tablename', type: 'String'  },
					
				    ],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#reqtablelistGrid").on("bindingcomplete", function (event) {$('#overlay,#PleaseWait').hide();});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#reqtablelistGrid").jqxGrid(
    {
    	width: '99%',
        height: 425,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{ text: 'Required Tables',datafield:'tablename'},
									
					]
    
    });
    
    $('#reqtablelistGrid').on('rowdoubleclick', function (event)  { 
    	var rowindex1 = event.args.rowindex;
    	
    				
    });
    
});

</script>
<div id="reqtablelistGrid"></div>