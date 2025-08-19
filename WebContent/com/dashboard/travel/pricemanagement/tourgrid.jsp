<%@ page import="com.dashboard.travel.pricemanagement.ClsPriceManagementDAO" %>  
<%ClsPriceManagementDAO DAO=new ClsPriceManagementDAO(); %> 
 <%
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");   
 %> 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
</style>    
 <script type="text/javascript">
 var data3,data3excel;
 data3='<%=DAO.tourgriddata(docno,id)%>';
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
                         	{name : 'offer', type: 'bool'  }, 
                         	{name : 'days', type: 'String'  },  
                         	{name : 'fdate', type: 'date'},    
     						{name : 'tdate', type: 'date'},
							{name : 'rowno', type: 'String'  },
                         	{name : 'tour', type: 'String'  },         
                 			{name : 'tourid', type: 'String'  },  
                 			{name : 'spadult', type: 'number'  },
                 			{name : 'spchild', type: 'number'  },
                 			{name : 'adult', type: 'number'  },
                 			{name : 'child', type: 'number'  },   
                 			{name : 'terms', type: 'String'  },
                 			{name : 'rowdelete', type: 'String'  },
                 			{name : 'adultdismax', type: 'number'  },          
                 			{name : 'childdismax', type: 'number'  },
                 			{name : 'admarginval', type: 'number'  },   
                 			{name : 'chmarginval', type: 'number'  },  
                 			{name : 'admarginper', type: 'number'  },   
                 			{name : 'chmarginper', type: 'number'  },
                 			{name : 'copadultdismax', type: 'number'  },          
                 			{name : 'copchilddismax', type: 'number'  },
                          	],
                          	localdata: data3,   
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            var cellclassname = function (row, column, value, data) {
        		 if (data.rowdelete==1) {
                    return "redClass";
                };
            };   
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );      
            $("#jqxtourgrid").jqxGrid(
            { 
            	width: '100%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                enabletooltips: true,
                filtermode:'excel',
                filterable: true,
                columnsresize:true,  
                showfilterrow: true,
                sortable:true,
                selectionmode: 'singlecell',
                pagermode: 'default',  
                editable:true,  
                
                handlekeyboardnavigation: function (event) {
                   	
                 	 var cell1 = $('#jqxtourgrid').jqxGrid('getselectedcell');
                 	 if (cell1 != undefined && cell1.datafield == 'tour') {  
                 	
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {  
                     	     document.getElementById("rowindex3").value = cell1.rowindex;
                     	     tourSearchContent('tourTypeSearch.jsp');  
                         	 $('#jqxtourgrid').jqxGrid('render');  
                         }    
                         }
                    }, 
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,         
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }     
							  },
							{ text: 'Doc No', datafield: 'rowno', editable: false, width: '5%',cellclassname:cellclassname },
                            { text: 'Tour Type', datafield: 'tour', editable: false, width: '20%',cellclassname:cellclassname }, 
                            { text: 'Tour ID', datafield: 'tourid', width: '10%',hidden:true,cellclassname:cellclassname}, 
                            { text: 'From Date', datafield: 'fdate', width: '7%',cellclassname:cellclassname,cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
							{ text: 'To Date', datafield: 'tdate', width: '7%',cellclassname:cellclassname,cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
								 editor.jqxDateTimeInput({ showCalendarButton: true});
					           }},
					        { text: 'Day', datafield: 'days', width: '7%' ,cellclassname:cellclassname,columntype:'dropdownlist',  
	    							createeditor: function (row, column, editor) {      
	    	                           billmodelist = ["","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY"];      
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
	    							},
	    					 	 initeditor: function (row, cellvalue, editor) {      
	    							var terms = $('#jqxtourgrid').jqxGrid('getcellvalue', row, "days");      
	    								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });    
	    	                        }, 
	    			           },   
	    			        { text: 'Offer', datafield: 'offer',width:'4%',cellclassname:cellclassname,columntype: 'checkbox'},    
							{ text: 'Adult', datafield: 'adult', width: '6%' ,cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right', columngroup: 'costprice'},
							{ text: 'Child', datafield: 'child', width: '6%' ,cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right', columngroup: 'costprice'},
							{ text: 'Adult', datafield: 'admarginper', width: '6%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'mp' },
							{ text: 'Child', datafield: 'chmarginper', width: '6%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'mp' },
							{ text: 'Adult', datafield: 'admarginval', width: '6%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'marval' },
							{ text: 'Child', datafield: 'chmarginval', width: '6%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'marval' },
							{ text: 'Adult', datafield: 'spadult',cellclassname:cellclassname, width: '6%', editable: false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'sp'},
							{ text: 'Child', datafield: 'spchild',cellclassname:cellclassname, width: '6%', editable: false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, columngroup: 'sp' },
							{ text: 'Adult', datafield: 'adultdismax',cellclassname:cellclassname, width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'maxdisval'},
							{ text: 'Child', datafield: 'childdismax',cellclassname:cellclassname, width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, columngroup: 'maxdisval' },
							{ text: 'Adult', datafield: 'copadultdismax',cellclassname:cellclassname, width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , columngroup: 'copmaxdisval'},
							{ text: 'Child', datafield: 'copchilddismax',cellclassname:cellclassname, width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, columngroup: 'copmaxdisval' },
							{ text: 'Terms', datafield: 'terms',width: '34%',cellclassname:cellclassname },        
							{ text: 'rowdelete', datafield: 'rowdelete',width: '34%',hidden:true,cellclassname:cellclassname },   
					],  
					columngroups: [                               
									{ text: 'Cost Price', align: 'center', name: 'costprice' },        
									{ text: 'Margin Percentage', align: 'center', name: 'mp' },  
									{ text: 'Selling Price', align: 'center', name: 'sp' },        
									{ text: 'Margin Value', align: 'center', name: 'marval' },   
									{ text: 'Max Discount Value', align: 'center', name: 'maxdisval' },
									{ text: 'Cooperate Max Discount Value', align: 'center', name: 'copmaxdisval' },      
					]   
            });    
            $("#jqxtourgrid").jqxGrid('addrow', null, {}); 
            if($('#btnupdate').val()=="Edit"){  
            	$("#jqxtourgrid").jqxGrid({ disabled: true}); 
            }
            $('#jqxtourgrid').on('celldoubleclick', function (event) {           
  		        var datafield = event.args.datafield;  
              	if(datafield == "tour"){   
     	            var rowindextemp = event.args.rowindex;     
		       	    document.getElementById("rowindex3").value = rowindextemp;  
		       	    tourSearchContent('tourTypeSearch.jsp');
		            $("#jqxtourgrid").jqxGrid('addrow', null, {});     
     		      }
                  }); 
            $('#jqxtourgrid').on('cellvaluechanged', function (event) {                                            
 		         var datafield = event.args.datafield;
 		         var rowindextemp = event.args.rowindex;            
 		       	 var adult=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "adult");
 		         var child=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "child");  
 		    	 var admarginper=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "admarginper");
 		         var chmarginper=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "chmarginper"); 
 		    	 var admarginval=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "admarginval");
 		         var chmarginval=$('#jqxtourgrid').jqxGrid('getcellvalue', rowindextemp, "chmarginval");
 		         var spadult=0.0,spchild=0.0;
 		        
 		         if(datafield=="adult"){         
		        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spadult",adult); 
		        	 if(typeof(admarginper) != "undefined" && typeof(admarginper) != "NaN" && admarginper != "" && admarginper != "0"){
		        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "admarginval",((parseFloat(adult)*parseFloat(admarginper))/100)); 
	 		        	 spadult=((parseFloat(adult)*parseFloat(admarginper))/100)+parseFloat(adult);  
	 		        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spadult",spadult);
		        	 }else if(typeof(admarginval) != "undefined" && typeof(admarginval) != "NaN" && admarginval != "" && admarginval != "0"){
		        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spadult",(parseFloat(admarginval)+parseFloat(adult)));
		        	 }else{}    
			         }
	 		        if(datafield=="admarginper"){ 
	 		        	if(typeof(adult) != "undefined" && typeof(adult) != "NaN" && adult != "" && adult != "0"){   
	 		        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "admarginval",((parseFloat(adult)*parseFloat(admarginper))/100)); 
	 	 		        	 spadult=((parseFloat(adult)*parseFloat(admarginper))/100)+parseFloat(adult);  
	 	 		        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spadult",spadult);
	 		        	}
	 		        } 
	 		       if(datafield=="admarginval"){ 
			        	if(typeof(adult) != "undefined" && typeof(adult) != "NaN" && adult != "" && adult != "0"){          
			        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spadult",(parseFloat(admarginval)+parseFloat(adult)));  
			        	}
			        } 
	 		      if(datafield=="child"){            
			        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spchild",child); 
			        	 if(typeof(chmarginper) != "undefined" && typeof(chmarginper) != "NaN" && chmarginper != "" && chmarginper != "0"){
			        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "chmarginval",((parseFloat(child)*parseFloat(chmarginper))/100)); 
				        	 spchild=((parseFloat(child)*parseFloat(chmarginper))/100)+parseFloat(child);
				        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spchild",spchild);   
			        	 }else if(typeof(chmarginval) != "undefined" && typeof(chmarginval) != "NaN" && chmarginval != "" && chmarginval != "0"){
			        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spchild",(parseFloat(chmarginval)+parseFloat(child))); 
			        	 }else{}    
				         }
		 		        if(datafield=="chmarginper"){ 
		 		        	if(typeof(child) != "undefined" && typeof(child) != "NaN" && child != "" && child != "0"){   
		 		        		$('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "chmarginval",((parseFloat(child)*parseFloat(chmarginper))/100)); 
					        	 spchild=((parseFloat(child)*parseFloat(chmarginper))/100)+parseFloat(child);
					        	 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spchild",spchild);   
		 		        	}
		 		        } 
		 		       if(datafield=="chmarginval"){     
				        	if(typeof(child) != "undefined" && typeof(child) != "NaN" && child != "" && child != "0"){          
				        		 $('#jqxtourgrid').jqxGrid('setcellvalue', rowindextemp, "spchild",(parseFloat(chmarginval)+parseFloat(child)));  
				        	}
				        }
            }); 
  
            $("#compopupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#comMenu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxtourgrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#comMenu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxtourgrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxtourgrid").offset();
                       $("#compopupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxtourgrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#compopupWindow2").jqxWindow('show');
                   }
                   else {
                	   var val=1;
                       var rowid = $("#jqxtourgrid").jqxGrid('getrowid', rowindex);     
                       $('#jqxtourgrid').jqxGrid('setcellvalue', rowid, "rowdelete" ,val);  
                       
                   }
               });  $("#jqxtourgrid").on('rowclick', function (event) {
                    if (event.args.rightclick) {
        		
                       $("#jqxtourgrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                  
        		   } 
               });  
            
        });
    </script>
     <div id='jqxWidget'> 
   <div id="jqxtourgrid"></div>   
    <div id="compopupWindow2">
 
 <div id='comMenu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
       <input type="hidden" id="rowindex3"/> 