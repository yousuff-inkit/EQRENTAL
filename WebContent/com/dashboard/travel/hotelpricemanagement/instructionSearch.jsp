<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
       <script type="text/javascript">
       var insdata;
       insdata= '<%=DAO.searchInstruction() %>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],     
                		
                		//  url: url1,
                 localdata: insdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxinsSearch").jqxGrid(   
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
                          { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                          { text: 'Instruction', datafield: 'name', width: '100%' },    
						]  
            });
            $('#jqxinsSearch').on('rowdoubleclick', function (event) {                  
                var rowindex2 = event.args.rowindex;  
                var rowIndex =$('#rowindex5').val();  
                $('#jqxcount').jqxGrid('setcellvalue', rowIndex, "doc_no" ,$('#jqxinsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxcount').jqxGrid('setcellvalue', rowIndex, "name" ,$('#jqxinsSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                $('#inssearchwndow').jqxWindow('close');                      
            });  
        });
    </script>
    <div id="jqxinsSearch"></div>