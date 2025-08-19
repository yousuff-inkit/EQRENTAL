<%@ page import="com.dashboard.travel.hoteloffer.ClsHotelOfferDAO" %>  
<%ClsHotelOfferDAO DAO=new ClsHotelOfferDAO(); %>   
 <%
   String id = request.getParameter("id")==null?"0":request.getParameter("id");
   String hotel = request.getParameter("hotel")==null?"0":request.getParameter("hotel");
 %>
 <script type="text/javascript">
 var data,Exceldata; 
	  data='<%=DAO.pricegriddata(id,hotel)%>';  
	  Exceldata='<%=DAO.pricegridExceldata(id,hotel)%>';   
	  $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json", 
                datafields: [
                 			{name : 'docno', type: 'number'  },
                 			{name : 'code', type: 'String'  },
     						{name : 'fdate', type: 'date'},
     						{name : 'tdate', type: 'date'  },
     						{name : 'name', type: 'String'  },  
     						{name : 'desc1', type: 'String'  },
     						{name : 'room', type: 'String'  },  
     						{name : 'roomid', type: 'String'  },
     						{name : 'type', type: 'String'  }, 
     						{name : 'per', type: 'number'  },        
     						{name : 'amount', type: 'number'  }, 
     						      
                          	],
                          	localdata: data,  
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
            $("#jqxpricegrid").jqxGrid(
            { 
            	width: '100%',
                height: 580,
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
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                            
                            { text: 'Doc No', datafield: 'docno', width: '7%',editable:false,hidden:true}, 
                            { text: 'Code', datafield: 'code', width: '7%',editable:true},
                            { text: 'Name', datafield: 'name', width: '18%',editable:true},
                            { text: 'Description', datafield: 'desc1', width: '19%',editable:true},
							{ text: 'From Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
							{ text: 'To Date', datafield: 'tdate', width: '7%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
					        { text: 'Room', datafield: 'room', width: '15%',editable: false },
					        { text: 'Room ID', datafield: 'roomid', width: '10%',hidden:true },
					   		{ text: 'Applied On', datafield: 'type', width: '7%' ,columntype:'dropdownlist',
	    							createeditor: function (row, column, editor) {   
	    	                           billmodelist = ["Basic",  "Total"];   
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist,selectedIndex: 0 });
	    							},
	    					 	 initeditor: function (row, cellvalue, editor) {  
	    							var terms = $('#jqxpricegrid').jqxGrid('getcellvalue', row, "type");  
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist,selectedIndex: 0 });
	    	                        }, 
	    			             },
	    			        { text: 'Per', datafield: 'per', width: '7%',editable:true},
	    			        { text: 'Amount', datafield: 'amount', width: '10%',cellsalign:'right',align:'right',editable:true},
	    			                    
					]
            });
            $("#jqxpricegrid").jqxGrid('addrow', null, {});            
           /*  $('#jqxpricegrid').on('cellclick', function (event)       
              		{ 
  		            	var rowindex1=event.args.rowindex;
  		            	var datafield = event.args.datafield;
  		            	if(datafield=="save" || datafield=="edit"){   
  		            		funSave(rowindex1);   
 		            	}
              		 }); */
            $('#jqxpricegrid').on('celldoubleclick', function (event) {  
  		        var datafield = event.args.datafield; 
  		        var rowindextemp = event.args.rowindex;
  		     
           	 if(datafield == "room")
    		      {   
    	           
		       	    document.getElementById("rowindex2").value = rowindextemp;       
		       	    roomSearchContent('roomTypeSearch.jsp?hotel='+$('#hidhotel').val()); 
		       	    $("#jqxpricegrid").jqxGrid('addrow', null, {}); 
    		      }
           	document.getElementById("docno").value=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "docno");
          	funload();      
            var chks=$('#jqxpricegrid').jqxGrid('getcellvalue', 0, "roomid");  
            if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
              	$('#btnupdate').attr('disabled', false); 
            }
            }); 
        });
    </script>
    <div id="jqxpricegrid"></div>
       <input type="hidden" id="rowindex2"/>     