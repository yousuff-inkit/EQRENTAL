<%@ page import="com.dashboard.travel.hoteloffer.ClsHotelOfferDAO" %>  
<%ClsHotelOfferDAO DAO=new ClsHotelOfferDAO(); %> 
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchHotel() %>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                             {name : 'vendorid', type: 'string'  },
                             {name : 'refname', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxhotelSearch").jqxGrid(   
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
                          { text: 'DOC NO', datafield: 'doc_no', width: '6%',hidden:true},
                          { text: 'Hotel', datafield: 'name', width: '60%' },
                          { text: 'Vendor', datafield: 'refname', width: '40%' },
                          { text: 'vendorid', datafield: 'vendorid', width: '6%',hidden:true }
						]
            });
            $('#jqxhotelSearch').on('rowdoubleclick', function (event) {          
                var rowindex2 = event.args.rowindex;  
                 document.getElementById("hotel").value=$('#jqxhotelSearch').jqxGrid('getcellvalue', rowindex2, "name");
                 document.getElementById("hidhotel").value=$('#jqxhotelSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
				 document.getElementById("vendor").value=$('#jqxhotelSearch').jqxGrid('getcellvalue', rowindex2, "refname");
				 document.getElementById("vendorid").value=$('#jqxhotelSearch').jqxGrid('getcellvalue', rowindex2, "vendorid");
                $('#hotelsearchwndow').jqxWindow('close');      
            });  
        });
    </script>
    <div id="jqxhotelSearch"></div>