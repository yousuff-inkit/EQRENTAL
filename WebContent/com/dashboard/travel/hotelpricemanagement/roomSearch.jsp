<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
 <%
  String docno = request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
 %>
       <script type="text/javascript">
       var rrdata;
       rrdata= '<%=DAO.searchRoomName(docno) %>';            
		$(document).ready(function () { 	  
            var source =
            {  
                datatype: "json",   
                datafields: [
                             {name : 'room', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		  
                		//  url: url1,
                 localdata: rrdata,
                  
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };  
         
            var dataAdapter = new $.jqx.dataAdapter(source);      
            
            $("#jqxroomSearch").jqxGrid(   
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
                                  { text: 'Room', datafield: 'room', width: '100%' },     
        						] 
                    });
                    $('#jqxroomSearch').on('rowdoubleclick', function (event) {               
                        var rowindex2 = event.args.rowindex;  
                        var rowIndex =$('#rowindex5').val();      
                        $('#jqxcount').jqxGrid('setcellvalue', rowIndex, "room" ,$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "room"));
                        $('#jqxcount').jqxGrid('setcellvalue', rowIndex, "roomid" ,$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                      	$('#rmsearchwndow').jqxWindow('close');   
                    });  
                });
            </script>
            <div id="jqxroomSearch"></div>