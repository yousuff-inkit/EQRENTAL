<%@ page import="com.dashboard.travel.visapricemanagement.ClsVisaPriceManagementDAO" %>  
<%ClsVisaPriceManagementDAO DAO=new ClsVisaPriceManagementDAO(); %> 
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchVisa() %>';   
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
            
            $("#jqxvisatypeSearch").jqxGrid(   
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
                          { text: 'Visa Type', datafield: 'name', width: '100%' }	             
						]
            });
            $('#jqxvisatypeSearch').on('rowdoubleclick', function (event) {        
                var rowindex2 = event.args.rowindex;
                var rowIndex =$('#rowindex').val();  
                $('#jqxvisagrid').jqxGrid('setcellvalue', rowIndex, "vtype" ,$('#jqxvisatypeSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                $('#jqxvisagrid').jqxGrid('setcellvalue', rowIndex, "visaid" ,$('#jqxvisatypeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#visasearchwndow').jqxWindow('close');   
            });  
        });
    </script>
    <div id="jqxvisatypeSearch"></div>