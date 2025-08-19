<%@page import="com.dashboard.client.bulksms.ClsBulkSMSDAO"%>
<% ClsBulkSMSDAO DAO= new ClsBulkSMSDAO(); %>
<% 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>    
       
<script type="text/javascript">
  var id='<%=id%>';
  var salesmandata=[];
  if(id=="1"){
  	salesmandata='<%=DAO.getSalesmanData(id)%>';                
  }
  else{    
  	salesmandata=[];
  }  
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'name', type: 'string'  }
                        ],
                 	localdata: salesmandata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesmanSearchGrid").jqxGrid(
            {
                width: '100%',    
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Salesman', datafield: 'name', width: '100%' },
						]
            });
            
          $('#salesmanSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtsalesman").value=$('#salesmanSearchGrid').jqxGrid('getcellvalue', rowindex2, "name");    
                document.getElementById("hidsalesman").value=$('#salesmanSearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
                
                $('#salesmanwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="salesmanSearchGrid"></div>