<%@ page import="com.dashboard.travel.pricemanagement.ClsPriceManagementDAO" %>  
<%ClsPriceManagementDAO DAO=new ClsPriceManagementDAO(); %>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchTour() %>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  }
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxtourtypeSearch").jqxGrid(   
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
                          { text: 'Tour Type', datafield: 'name', width: '100%' }	             
						]
            });
            $('#jqxtourtypeSearch').on('rowdoubleclick', function (event) {        
                var rowindex2 = event.args.rowindex;       
                var rowIndex =$('#rowindex3').val();    
                $('#jqxtourgrid').jqxGrid('setcellvalue', rowIndex, "tour" ,$('#jqxtourtypeSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                $('#jqxtourgrid').jqxGrid('setcellvalue', rowIndex, "tourid" ,$('#jqxtourtypeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#toursearchwndow').jqxWindow('close');   
            });  
        });
    </script>
    <div id="jqxtourtypeSearch"></div>