<%@page import="com.equipment.equippurchasedirect.ClsEquipPurchaseDirectDAO" %>
<%ClsEquipPurchaseDirectDAO cpd=new ClsEquipPurchaseDirectDAO(); %>
<%
String masterdoc = request.getParameter("masterdoc")==null || request.getParameter("masterdoc").equalsIgnoreCase("")?"0":request.getParameter("masterdoc").trim();
String refdoc = request.getParameter("refdoc")==null || request.getParameter("refdoc").equalsIgnoreCase("")?"0":request.getParameter("refdoc").trim();
Double taxperc = request.getParameter("taxperc")==null || request.getParameter("taxperc").equalsIgnoreCase("")?0:Double.parseDouble(request.getParameter("taxperc").trim());
ClsEquipPurchaseDirectDAO pdao=new ClsEquipPurchaseDirectDAO();
int method=pdao.getTaxMethod();

%>

<script type="text/javascript">
var vahreqdata;
var meth='<%=method%>';
var temp2='<%=masterdoc%>';
var reftemp='<%=refdoc%>';   
var aa=0;
if(parseInt(temp2)>0) {
	  vahreqdata='<%=cpd.gridsearchrelode(masterdoc)%>'; 
 } else if(parseInt(reftemp)>0) {   
	  vahreqdata='<%=cpd.purDetailsLoad(refdoc,taxperc)%>';       
} else {
      vahreqdata;
      aa=1;   	
	}
  
   $(document).ready(function () { 	
       var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
       } 
       var rendererstring1=function (aggregates){
          	var value=aggregates['sum1'];
          	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
          }      
    // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brand', type: 'string'  },
     						{name : 'brdid', type: 'int'   },
     						{name : 'model', type: 'string'   },
     						{name : 'modid', type: 'string'   },
     						{name : 'color', type: 'string'   },
     						{name : 'clrid', type: 'string'   },
     				     //	{ name: 'price', type: 'number' },         /* select prch_cost,add1,tval  from gl_vehmaster */
     				      	{ name: 'prch_cost', type: 'number' },  
     				      	{ name: 'addicost', type: 'number' },  
     				     	{ name: 'price', type: 'number' },  
     						{name : 'chaseno', type: 'string'   },
     						{name : 'enginno', type: 'string'   },
     						{name : 'fleet_no', type: 'string'   },
     						{name : 'taxperc', type: 'number'   },
     						{name : 'taxamt', type: 'number'   },
     						{name : 'nettotal', type: 'number'   },
     						{name : 'puchdate', type: 'string'   }
     						
                 ],
                 localdata: vahreqdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#vehpurchasedirgrid").on("bindingcomplete", function (event) { 
            	if($("#mode").val()!="view"){     
            		setTax();   
            	}
            }); 
            
            $("#vehpurchasedirgrid").jqxGrid(
            {
            	width: '100%',
                height: 272,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
               //disabled:true,
               localization: {thousandsSeparator: ""},
                statusbarheight: 20,
                selectionmode: 'singlecell',
                pagermode: 'default',
                //Add row method
                
              
                          handlekeyboardnavigation: function (event) {
					        	 if($('#mode').val()=="A")
					             {  
					                	  var cell2 = $('#vehpurchasedirgrid').jqxGrid('getselectedcell');
					                      if (cell2 != undefined && cell2.datafield == 'fleet_no') {
					                      	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
					                       document.getElementById("rowindex").value =cell2.rowindex;
					                    
					                      	if (key == 114) { 
					                      	   fleetSearchContent('fleetsearch.jsp'); 
					                          	 $('#vehpurchasedirgrid').jqxGrid('render');
					               	           
					                            }
					                      	}
					             }
                                                                             },

                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                              }  
                            },	
                        	{ text: 'Fleet', datafield: 'fleet_no', width: '9%',editable: false},
							{ text: 'Brand', datafield: 'brand', width: '10%',editable: false,
                            	
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								  }
							},	
							{ text: 'Model', datafield: 'model', width: '13%',editable: false,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								  }
							},
						 	
							{ text: 'Color', datafield: 'color', width: '9%',editable: false,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								  }
							    },
							{ text: 'Chassis No', datafield: 'chaseno', width: '10%',editable: true, 
							    	cellbeginedit: function (row) {
								var temp=$('#mode').val();
								 if (temp =="view")
									 {
								       return false;
									 }
							  }
							    },
							{ text: 'Engine No', datafield: 'enginno', width: '10%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,editable: true,
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								  }
							    },
								{ text: 'Purchase Cost', datafield: 'prch_cost', width: '6%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
									
									cellbeginedit: function (row) {
										var temp=$('#mode').val();
										 if (temp =="view")
											 {
										       return false;
											 }
									  }
								},
								
								{ text: 'Additional Cost', datafield: 'addicost', width: '6%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
									cellbeginedit: function (row) {
										var temp=$('#mode').val();
										 if (temp =="view")
											 {
										       return false;
											 }
									  }
								},
							    
						 /*      	{ name: 'prch_cost', type: 'number' },  
	     				      	{ name: 'addicost', type: 'number' },  
	     				     	{ name: 'totcost', type: 'number' },  	    
							     */
							    
							{ text: 'Price', datafield: 'price', width: '6%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
							{ text: 'VAT %', datafield: 'taxperc', width: '6%',cellsformat: 'd2',editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								  }
							},
							{ text: 'VAT Amt', datafield: 'taxamt', width: '6%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellsformat: 'd2',cellsalign: 'right', align: 'right',							},
							{ text: 'Net Total', datafield: 'nettotal', width: '6%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellsformat: 'd2',cellsalign: 'right', align: 'right',							},
							
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
							{ text: 'puchdate', datafield: 'puchdate', width: '10%',hidden:true }
				              ]
              
   });
   
           
          //   $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
			
    		if (parseInt(aa)==1) {
    			$("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
          //  $("#vehpurchasedirgrid").jqxGrid({ disabled: false});
    		}
    		   $('#vehpurchasedirgrid').on('celldoubleclick', function (event) { 
    			   var datafield = event.args.datafield;
    				var temp=$('#mode').val();
					 if (temp =="view")
						 {
					       return false;
						 }
    			   
    			   
    			   
          	if(datafield == "fleet_no")
  		      { 
				                	 var rowindextemp = event.args.rowindex;
				              	    document.getElementById("rowindex").value = rowindextemp;  
				              	    fleetSearchContent('fleetsearch.jsp'); 
  		      }
          	
               });
    		
    		   if(parseInt(document.getElementById("docno").value)>0)
    	          {
    			   setTax();
    	          }
    	          //}
     
       
            $("#vehpurchasedirgrid").on('cellclick', function (event) 
                    {
                		document.getElementById("errormsg").innerText="";
                    		 
                   });
            $("#vehpurchasedirgrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
            		    var rowBoundIndex = event.args.rowindex;
            		    
                    		if(datafield=="prch_cost" || datafield=="addicost" || datafield=="price" || datafield=="taxperc"){
                    			valchange(rowBoundIndex);
                    		}
                    });
            
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#vehpurchasedirgrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#vehpurchasedirgrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#vehpurchasedirgrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#vehpurchasedirgrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#vehpurchasedirgrid").jqxGrid('getrowid', rowindex);
                       $("#vehpurchasedirgrid").jqxGrid('deleterow', rowid);
                   }
               });
               $("#vehpurchasedirgrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#vehpurchasedirgrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
          
        });
   
   
   
   function valchange(rowBoundIndex)
   {
   	var puchcost= $('#vehpurchasedirgrid').jqxGrid('getcellvalue', rowBoundIndex, "prch_cost");	
   	var addrcost=$('#vehpurchasedirgrid').jqxGrid('getcellvalue', rowBoundIndex, "addicost");	
   	var taxperc=$('#vehpurchasedirgrid').jqxGrid('getcellvalue', rowBoundIndex, "taxperc");	
   	
   		if(!$.isNumeric(puchcost)){
   			puchcost=0;	
		}
   		
   		if(!$.isNumeric(addrcost)){
   			addrcost=0;	
		}
   		
   		if(!$.isNumeric(taxperc)){
   			taxperc=0;	
		}
   		
      	var total = parseFloat(puchcost)+parseFloat(addrcost);
      	
      	var taxamt = 0;
      	if(meth!=0){
      		taxamt = total*(taxperc/100);
      	}
      	
      	var nettotal = total+taxamt;
      
		$('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowBoundIndex, "price",total);
		$('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamt",taxamt);
		$('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
		
		if($("#mode").val()!="view"){     
    		setTax();   
    	}
   }
   
   
    function setTax()
   {
     		var txttaxamount= $("#vehpurchasedirgrid").jqxGrid('getcolumnaggregateddata', 'taxamt', ['sum'],true);
     		var txtnetotal= $("#vehpurchasedirgrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
     
     		funRoundAmt(txttaxamount.sum,"txttaxamount");
	 		funRoundAmt(txtnetotal.sum,"txtnetotal");     
     }    
    
    
    </script>
    
     
      <div id='jqxWidget'>
    <div id="vehpurchasedirgrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
    
    
  <input type="hidden" id="rowindex"/> 
