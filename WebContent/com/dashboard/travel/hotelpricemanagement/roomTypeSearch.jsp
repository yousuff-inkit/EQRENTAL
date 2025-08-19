<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
 <%
   String hotel = request.getParameter("hotel")==null?"0":request.getParameter("hotel");
 %>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchRoom(hotel) %>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'room', type: 'string'  },
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                             {name : 'cat', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxroomtypeSearch").jqxGrid(   
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
                          { text: 'Room Type', datafield: 'room', width: '60%' },  
                          { text: 'Category', datafield: 'cat', width: '20%' },  
                          { text: 'Name', datafield: 'name', width: '20%' },  
						] 
            });
            $('#jqxroomtypeSearch').on('rowdoubleclick', function (event) {               
                var rowindex2 = event.args.rowindex;  
                var rowIndex =$('#rowindex').val();  
                $('#jqxhotelgrid').jqxGrid('setcellvalue', rowIndex, "room" ,$('#jqxroomtypeSearch').jqxGrid('getcellvalue', rowindex2, "room"));
                $('#jqxhotelgrid').jqxGrid('setcellvalue', rowIndex, "roomid" ,$('#jqxroomtypeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxhotelgrid').jqxGrid('setcellvalue', rowIndex, "cat" ,$('#jqxroomtypeSearch').jqxGrid('getcellvalue', rowindex2, "cat"));
                $('#jqxhotelgrid').jqxGrid('setcellvalue', rowIndex, "name" ,$('#jqxroomtypeSearch').jqxGrid('getcellvalue', rowindex2, "name"));
              	var docno=$('#docno').val();
              	if(docno>0){    
              	    $('#btnupdate').attr('disabled', false); 
              	}    
              	$('#roomsearchwndow').jqxWindow('close');   
            });  
        });
    </script>
    <div id="jqxroomtypeSearch"></div>