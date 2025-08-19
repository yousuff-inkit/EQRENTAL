<%@ page import="com.dashboard.travel.visapricemanagement.ClsVisaPriceManagementDAO" %>  
<%ClsVisaPriceManagementDAO DAO=new ClsVisaPriceManagementDAO(); %>    
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
 
 var data1,data1excel;
 data1='<%=DAO.visagriddata(docno,id)%>';    
 data1excel='<%=DAO.visagridExcel(docno,id)%>';  
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
                         	{name : 'rowno', type: 'String'  },  
                         	{name : 'vtype', type: 'String'  },  
                 			{name : 'visaid', type: 'String'  },
                 			{name : 'marginper', type: 'number'  },
                 			{name : 'maxdisval', type: 'number'  },
                 			{name : 'sprice', type: 'number'  },
                 			{name : 'marginval', type: 'number'  },  
                 			{name : 'value', type: 'number'  },
                 			{name : 'type', type: 'String'  },
                 			{name : 'rowdelete', type: 'String'  },
                          	],
                          	localdata: data1,
                
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
            $("#jqxvisagrid").jqxGrid(   
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
                enabletooltips: true,
                selectionmode: 'singlecell',  
                pagermode: 'default',
                editable:true, 
                handlekeyboardnavigation: function (event) {
                   	
               	 var cell1 = $('#jqxvisagrid').jqxGrid('getselectedcell');
               	 if (cell1 != undefined && cell1.datafield == 'vtype') {  
               	
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                   	     document.getElementById("rowindex").value = cell1.rowindex;
                    	 visaSearchContent('visaTypeSearch.jsp');
                       	 $('#jqxvisagrid').jqxGrid('render');  
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
                            { text: 'Visa Type', datafield: 'vtype', editable: false,cellclassname:cellclassname},
                            { text: 'Rowno', datafield: 'rowno',width:'4%',hidden:true,cellclassname:cellclassname},  
                            { text: 'Visa ID', datafield: 'visaid',width:'4%',hidden:true,cellclassname:cellclassname},       
                            { text: 'Cost Price', datafield: 'value', width: '10%' ,cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right'},
                            { text: 'Margin Percentage', datafield: 'marginper', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Margin Value', datafield: 'marginval', width: '10%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Max Discount Value', datafield: 'maxdisval', width: '12%',cellclassname:cellclassname,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Selling Price', datafield: 'sprice', width: '10%',cellclassname:cellclassname, editable: false,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'rowdelete', datafield: 'rowdelete',width: '34%',cellclassname:cellclassname,hidden:true,cellclassname:cellclassname },
						],         
            });    
            $("#jqxvisagrid").jqxGrid('addrow', null, {}); 
            if($('#btnupdate').val()=="Edit"){  
            	$("#jqxvisagrid").jqxGrid({ disabled: true}); 
            }
            $('#jqxvisagrid').on('celldoubleclick', function (event) {  
  		        var datafield = event.args.datafield;
              	 if(datafield == "vtype")
       		  {   
       	       var rowindextemp = event.args.rowindex;
       	       document.getElementById("rowindex").value = rowindextemp;  
       	       visaSearchContent('visaTypeSearch.jsp');
       	    $("#jqxvisagrid").jqxGrid('addrow', null, {});  
       		  }
                  });   
            $('#jqxvisagrid').on('cellvaluechanged', function (event) {                                       
  		         var datafield = event.args.datafield;
  		         var rowindextemp = event.args.rowindex;
  		   	     var marginper=$('#jqxvisagrid').jqxGrid('getcellvalue', rowindextemp, "marginper");
  		       	 var value=$('#jqxvisagrid').jqxGrid('getcellvalue', rowindextemp, "value");
  		         var marginval=$('#jqxvisagrid').jqxGrid('getcellvalue', rowindextemp, "marginval");
  		         var sprice=0.0;
  		         
  		       if(datafield=="value"){
  		    	 $('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "sprice",value);      
  		    	 if(typeof(marginper) != "undefined" && typeof(marginper) != "NaN" && marginper != "" && marginper != "0"){     
  		    		 $('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "marginval",((parseFloat(value)*parseFloat(marginper))/100)); 
 		        	 sprice=((parseFloat(value)*parseFloat(marginper))/100)+parseFloat(value);    
 		        	 $('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "sprice",sprice);  
  		    	 }else if(typeof(marginval) != "undefined" && typeof(marginval) != "NaN" && marginval != "" && marginval != "0"){
  		    		$('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "sprice",(parseFloat(marginval)+parseFloat(value))); 
  		    	  }else{}
  		         }
	  		     if(datafield=="marginper"){
	  		    	 if(typeof(value) != "undefined" && typeof(value) != "NaN" && value != "" && value != "0"){   
	  		    		 $('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "marginval",((parseFloat(value)*parseFloat(marginper))/100)); 
	 		        	 sprice=((parseFloat(value)*parseFloat(marginper))/100)+parseFloat(value);    
	 		        	 $('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "sprice",sprice);  
	  		    	 }
	  		     }
	  		   if(datafield=="marginval"){  
	  		    	 if(typeof(value) != "undefined" && typeof(value) != "NaN" && value != "" && value != "0"){   
	  		    		$('#jqxvisagrid').jqxGrid('setcellvalue', rowindextemp, "sprice",(parseFloat(marginval)+parseFloat(value)));
	  		    	 }
	  		     }
           }); 
            
            $("#compopupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#comMenu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxvisagrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#comMenu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxvisagrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxvisagrid").offset();
                       $("#compopupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxvisagrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#compopupWindow2").jqxWindow('show');
                   }
                   else {
                	   var val=1;
                       var rowid = $("#jqxvisagrid").jqxGrid('getrowid', rowindex);     
                       $('#jqxvisagrid').jqxGrid('setcellvalue', rowid, "rowdelete" ,val);  
                       
                   }
               });  $("#jqxvisagrid").on('rowclick', function (event) {
                    if (event.args.rightclick) {
        		
                       $("#jqxvisagrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                  
        		   } 
               });  
        });
    </script>
    <div id='jqxWidget'> 
   <div id="jqxvisagrid"></div>   
    <div id="compopupWindow2">
 
 <div id='comMenu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
      <input type="hidden" id="rowindex"/> 