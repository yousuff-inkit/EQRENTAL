<%@page import="com.dashboard.travel.ticketvouchercreate.ClsTicketVoucherCreateDAO"%>
<%
		ClsTicketVoucherCreateDAO DAO=new ClsTicketVoucherCreateDAO();                                                                                  
%>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchAirline() %>';      
		$(document).ready(function () { 	     
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'string'  },   
                             {name : 'name', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxairlineSearch").jqxGrid(   
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
                           { text: 'Doc No', datafield: 'doc_no', width: '20%' },  
                           { text: 'Airline', datafield: 'name', width: '80%' },               
						] 
            });
            $('#jqxairlineSearch').on('rowdoubleclick', function (event) {               
                var rowindex2 = event.args.rowindex;  
                document.getElementById("airline").value=$('#jqxairlineSearch').jqxGrid('getcellvalue', rowindex2, "name");
				document.getElementById("airlineid").value=$('#jqxairlineSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
              	$('#airlinesearchwndow').jqxWindow('close');      
            });    
        });
    </script>
    <div id="jqxairlineSearch"></div>