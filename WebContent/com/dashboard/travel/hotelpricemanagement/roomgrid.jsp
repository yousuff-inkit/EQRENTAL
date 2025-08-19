<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %> 
 <%
 String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 %>
 <style type="text/css">
  .AClass
  {
      background-color: #FBEFF5;
  }
  .BClass
  {
      background-color: #E0F8F1;
  }
  .CClass
  {
     background-color: #f3fab9;
  }
    .DClass
  {
     background-color: #e8fccc ;  
  }
</style>          
 <script type="text/javascript">
       var data2;
       data2='<%=DAO.roomdata(id,docno)%>';  
        $(document).ready(function () { 
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [         
							{name : 'cextra', type: 'number'  },
                         	{name : 'child', type: 'number'  },
                 			{name : 'cbasic', type: 'number'  },
     						{name : 'room', type: 'String'}, 
     						{name : 'roomid', type: 'String'  },
     						{name : 'cat', type: 'String'  },
     						{name : 'rowno', type: 'String'},   
     						{name : 'name', type: 'String'},  
     						{name : 'hbadult', type: 'number'  },      
     						{name : 'hbchild', type: 'number'  },
     						{name : 'fbadult', type: 'number'  },
     						{name : 'fbchild', type: 'number'  },
     						{name : 'inadult', type: 'number'  },
     						{name : 'inchild', type: 'number'  },
     						{name : 'marginper', type: 'number'  },
     						{name : 'maxdiscount', type: 'number'  },
     						{name : 'cost', type: 'number'  },
     						 ],  
                          	localdata: data2,
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#jqxhotelgrid").jqxGrid(
            { 
            	width: '100%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,  
                showfilterrow: true,
                sortable:true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                handlekeyboardnavigation: function (event) {
                   	
                  	 var cell1 = $('#jqxhotelgrid').jqxGrid('getselectedcell');
                  	 if (cell1 != undefined && cell1.datafield == 'room') {  
                  	
                          var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                          if (key == 114) {  
                      	     document.getElementById("rowindex").value = cell1.rowindex;
                       	     roomSearchContent('roomTypeSearch.jsp?hotel='+$('#hidhotel').val());
                          	 $('#jqxhotelgrid').jqxGrid('render');  
                          }    
                          }
                     }, 
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },  
							{ text: 'Room Type', datafield: 'room', width: '10%',editable: false },   
							{ text: 'Rowno', datafield: 'rowno', width: '10%',hidden:true },              
							{ text: 'Room ID', datafield: 'roomid', width: '10%',hidden:true },  
							{ text: 'Category', datafield: 'cat', width: '10%', editable: false },         
							{ text: 'Name', datafield: 'name', width: '10%', editable: false },  
                            { text: 'Basic', datafield: 'cbasic', columngroup: 'costprice', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
							{ text: 'Extra Bed', datafield: 'cextra',columngroup: 'costprice', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right'},
							{ text: 'Child', datafield: 'child', width: '7%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},  
							{ text: 'HB Adult', datafield: 'hbadult', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'HB Child', datafield: 'hbchild', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'FB Adult', datafield: 'fbadult', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'FB Child', datafield: 'fbchild', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'Inc.Adult', datafield: 'inadult', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'Inc.Child', datafield: 'inchild', width: '6%',columngroup: 'mp',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'DClass'},
							{ text: 'Margin%', datafield: 'marginper', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'AClass' },       
							{ text: 'Max discount allowed%', datafield: 'maxdiscount', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'BClass' },
							{ text: 'Cost to cost%', datafield: 'cost', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: 'CClass' },  
							],                                                                                 
					columngroups: [                         
									{ text: 'Cost Price', align: 'center', name: 'costprice' },        
									{ text: 'Meals plan per pax', align: 'center', name: 'mp' },
									]
            });
            $("#jqxhotelgrid").jqxGrid('addrow', null, {}); 
            $('#jqxhotelgrid').on('celldoubleclick', function (event) {   
  		        var datafield = event.args.datafield;  
              	 if(datafield == "room")
       		      {   
       	            var rowindextemp = event.args.rowindex;
		       	    document.getElementById("rowindex").value = rowindextemp;       
		       	    roomSearchContent('roomTypeSearch.jsp?hotel='+$('#hidhotel').val()); 
		       	    $("#jqxhotelgrid").jqxGrid('addrow', null, {}); 
       		      }
              	/* var docno=$('#docno').val();
              	if(docno>0){     
              	    $('#btnupdate').attr('disabled', false);      
              	} */    
                  }); 
            
        });
    </script>
    <div id="jqxhotelgrid"></div>  
   <input type="hidden" id="rowindex"/> 