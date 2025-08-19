<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
 <%
  String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
  String docno = request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
 %>
       <script type="text/javascript">
       var cntdata;
       cntdata='<%=DAO.countGridLoad(id,docno)%>';      
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [  
                             {name : 'room', type: 'string'  },
                             {name : 'roomid', type: 'string'  },
                             {name : 'rowno', type: 'string'  },
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                             {name : 'fdate', type: 'date'  },
                             {name : 'tdate', type: 'date'  },
                             {name : 'days', type: 'number'  },
                        ],
                		
                		//  url: url1,
                 localdata: cntdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcount").jqxGrid(   
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,  
                altRows: true,
                //showfilterrow: true, 
                filterable: true,  
                selectionmode: 'singlecell',
                editable:true,  
                handlekeyboardnavigation: function (event) {
                 	 var cell1 = $('#jqxcount').jqxGrid('getselectedcell');
                 	 if (cell1 != undefined && cell1.datafield == 'name') {  
                 	
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {  
                     	     document.getElementById("rowindex5").value = cell1.rowindex;
                      	     insSearchContent('instructionSearch.jsp');        
                         	 $('#jqxcount').jqxGrid('render');  
                         }    
                         }
                 	if (cell1 != undefined && cell1.datafield == 'room') {  
                     	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                    	     document.getElementById("rowindex5").value = cell1.rowindex;
                    	     rmSearchContent('roomSearch.jsp');           
                        	 $('#jqxcount').jqxGrid('render');  
                        }    
                        }
                    },
                columns: [ 
                          { text: 'Instruction', datafield: 'name', editable: false},    
                          { text: 'Instruction ID', datafield: 'doc_no',hidden:true, editable: false},
                          { text: 'Room', datafield: 'room', editable: false, width: '20%'},                  
                          { text: 'Room ID', datafield: 'roomid',hidden:true, editable: false},
                          { text: 'rowno', datafield: 'rowno',hidden:true, editable: false},
                          { text: 'From', datafield: 'fdate', width: '8%', editable: true,cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput', createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
   			               editor.jqxDateTimeInput({ showCalendarButton: true});  
   			               } },  
   			              { text: 'To', datafield: 'tdate', width: '8%', editable: true,cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput', createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
			               editor.jqxDateTimeInput({ showCalendarButton: true});   
			               } },
                          { text: 'Days', datafield: 'days', width: '8%', editable: true,cellsformat: 'd2',cellsalign:'right',align:'right'} , 
						]    
            });
            $("#jqxcount").jqxGrid('addrow', null, {}); 
            $('#jqxcount').on('celldoubleclick', function (event) {   
  		        var datafield = event.args.datafield;  
              	 if(datafield == "name"){   
       	            var rowindextemp = event.args.rowindex;
		       	    document.getElementById("rowindex5").value = rowindextemp;       
		       	    insSearchContent('instructionSearch.jsp'); 
		       	    $("#jqxcount").jqxGrid('addrow', null, {});     
       		      }
              	if(datafield == "room"){   
       	            var rowindextemp = event.args.rowindex;             
		       	    document.getElementById("rowindex5").value = rowindextemp;       
		       	    rmSearchContent('roomSearch.jsp?docno='+$('#hidhotel').val()); 
		       	    $("#jqxcount").jqxGrid('addrow', null, {});        
       		      }     
             }); 
        });
    </script>
    <div id="jqxcount"></div>
       <input type="hidden" id="rowindex5"/> 