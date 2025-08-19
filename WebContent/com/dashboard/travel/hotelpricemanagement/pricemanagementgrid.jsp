<%@ page import="com.dashboard.travel.hotelpricemanagement.ClsHotelPriceManagementDAO" %>  
<%ClsHotelPriceManagementDAO DAO=new ClsHotelPriceManagementDAO(); %>   
 <%
   String id = request.getParameter("id")==null?"0":request.getParameter("id");
   String hotel = request.getParameter("hotel")==null?"0":request.getParameter("hotel");
 %>
 <script type="text/javascript">
 var data; 
	  data='<%=DAO.pricegriddata(id,hotel)%>';  
  
	  $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json", 
                datafields: [
                 			{name : 'docno', type: 'String'  },
                 			{name : 'remarks', type: 'String'  },
     						{name : 'fdate', type: 'String'},
     						{name : 'tdate', type: 'String'  },
     						{name : 'save', type: 'String'  },  
     						{name : 'pcat', type: 'String'  },
     						{name : 'pcatid', type: 'String'  },  
     						{name : 'type', type: 'String'  }, 
     						{name : 'releaseno', type: 'number'  },        
     						{name : 'nation', type: 'String'  }, 
     						{name : 'nationid', type: 'String'  },      
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
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                            
                            { text: 'Doc No', datafield: 'docno', width: '7%',editable:false},       
							{ text: 'From Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
							{ text: 'To Date', datafield: 'tdate', width: '7%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
					   		{ text: 'Tax Type', datafield: 'type', width: '7%' ,columntype:'dropdownlist',
	    							createeditor: function (row, column, editor) {   
	    	                           billmodelist = ["INCLUSIVE",  "EXCLUSIVE"];   
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist,selectedIndex: 0 });
	    							},
	    					 	 initeditor: function (row, cellvalue, editor) {  
	    							var terms = $('#jqxpricegrid').jqxGrid('getcellvalue', row, "type");  
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist,selectedIndex: 0 });
	    	                        }, 
	    			             },
	    			        { text: 'Release', datafield: 'releaseno', width: '7%',   
	    			        	validation: function (cell, value) {   
	    			        		if (value>=0) {        
		                              return { result: true, message: "Enter Numbers Only" };
	    			        		}
		                          	return false;            
	    			        	  }
	    			             },            
							{ text: 'Price Category', datafield: 'pcat', width: '13%',editable:false},                                
							{ text: 'Price Category ID', datafield: 'pcatid', width: '13%',hidden:true},    
							{ text: 'Nationality(Exception)', datafield: 'nation', width: '13%',editable:false},  
							{ text: 'NationalityID', datafield: 'nationid', width: '13%',hidden:true}, 
							{ text: 'Remarks', datafield: 'remarks'},         
							{ text: ' ', datafield: 'save',columntype: 'button',filterable: false,editable:false, width: '6%'},             
					]
            });
            //$("#jqxpricegrid").jqxGrid('addrow', null, {});            
            $('#jqxpricegrid').on('cellclick', function (event)       
              		{ 
  		            	var rowindex1=event.args.rowindex;
  		            	var datafield = event.args.datafield;
  		            	if(datafield=="save" || datafield=="edit"){   
  		            		funSave(rowindex1);   
 		            	}
              		 });
            $('#jqxpricegrid').on('celldoubleclick', function (event) {  
  		        var datafield = event.args.datafield; 
  		        var rowindextemp = event.args.rowindex;
              	 if(datafield == "pcat") 
       		      {   
		       	    document.getElementById("rowindex2").value = rowindextemp;  
		       	    catSearchContent('categorySearch.jsp'); 
       		      }
              	if(datafield == "nation")    
     		      {   
		       	    document.getElementById("rowindex2").value = rowindextemp;  
		       	    nationSearchContent('nationSearch.jsp'); 
     		      }
              	document.getElementById("docno").value=$('#jqxpricegrid').jqxGrid('getcellvalue',rowindextemp, "docno");
              	funload();      
                var chks=$('#jqxpricegrid').jqxGrid('getcellvalue', 0, "roomid");  
                if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "" && chks != "0"){
                  	$('#btnupdate').attr('disabled', false); 
                }
            }); 
            $('#jqxpricegrid').on('cellvaluechanged', function (event) { 
            	var datafield = event.args.datafield;
       		    var rowBoundIndex = args.rowindex;
				var	fromdate=$('#jqxpricegrid').jqxGrid('getcellvalue', rowBoundIndex, "fdate");
				var	todate=$('#jqxpricegrid').jqxGrid('getcellvalue', rowBoundIndex, "tdate");
				if(datafield == "tdate" || datafield == "fdate" ){ 
					   var fromdates=fromdate;
					  // out date
					 	 var todates=todate; //del date
					   if(fromdates>todates){
						   $.messager.alert('Message','To Date Less Than From Date  ','warning');
						   $('#jqxpricegrid').jqxGrid('setcellvalue', rowBoundIndex, "tdate",fromdate);  
					  }   
				 }         
              });
          });
    </script>
    <div id="jqxpricegrid"></div>
       <input type="hidden" id="rowindex2"/>     