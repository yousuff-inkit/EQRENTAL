<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<%ClspurchaseDirectDAO cpd=new ClspurchaseDirectDAO(); %>
<%
String masterdoc = request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").trim();
 
ClspurchaseDirectDAO pdao=new ClspurchaseDirectDAO();
int method=pdao.getTaxMethod();

%>

<script type="text/javascript">
var vahreqdata;
var meth='<%=method%>' ;
var temp2='<%=masterdoc%>';
var aa=0;
if(temp2>0)
	{
	  vahreqdata='<%=cpd.gridsearchrelode(masterdoc)%>'; 
	}

<%-- else if(temp1>0)
{

	vahreqdata='<%=com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO.refsearchrelode(orderdoc)%>';
} --%>
else
	{
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
     						{name : 'taxamt', type: 'string'   },
     						{name : 'nettotal', type: 'string'   },
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
            
               
            
            
            $("#vehpurchasedirgrid").jqxGrid(
            {
            	width: '100%',
                height: 272,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
              // disabled:true,
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
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                              }  
                            },	
                        	{ text: 'Fleet', datafield: 'fleet_no', width: '11%',editable: false},
							{ text: 'Brand', datafield: 'brand', width: '13%',editable: false,
                            	
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
								{ text: 'Purchase Cost', datafield: 'prch_cost', width: '10%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
									
									cellbeginedit: function (row) {
										var temp=$('#mode').val();
										 if (temp =="view")
											 {
										       return false;
											 }
									    
									  }
								},
							
								
								{ text: 'Additional Cost', datafield: 'addicost', width: '10%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: true,cellsformat: 'd2',cellsalign: 'right', align: 'right',
									
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
							    
							{ text: 'Price', datafield: 'price', width: '10%',cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellsformat: 'd2',cellsalign: 'right', align: 'right',
								
								cellbeginedit: function (row) {
									var temp=$('#mode').val();
									 if (temp =="view")
										 {
									       return false;
										 }
								    
								  }
							},
						
							
						
						
						 
						
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true },
							{ text: 'Taxamount', datafield: 'tamaxt', width: '10%',hidden:true },
							{ text: 'Nettotal', datafield: 'nettotal', width: '10%',hidden:true },
							{ text: 'puchdate', datafield: 'puchdate', width: '10%' },
				              ]
              
   });
   
           
          //   $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
          
          
       //   alert(aa);
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
    			   var summaryData= $("#vehpurchasedirgrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
    			   
    			   document.getElementById("txttaxamount").value=$('#vehpurchasedirgrid').jqxGrid('getcellvalue', 0, "taxamt");
				    document.getElementById("txtnetotal").value=$('#vehpurchasedirgrid').jqxGrid('getcellvalue', 0, "nettotal");
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
            		     
                    		if(datafield=="prch_cost")
                    		    {
                    
                    			valchange(rowBoundIndex);
                    		    }
                    		if(datafield=="addicost")
                		    {
                    			valchange(rowBoundIndex);
                		    }
                    		if(datafield=="price")
                		    {
                    			valchange(rowBoundIndex);
                		    }
                    	
                    		});
            
          
        });
   
   
   
   function valchange(rowBoundIndex)
   {
   	
   	
   	var puchcost= $('#vehpurchasedirgrid').jqxGrid('getcellvalue', rowBoundIndex, "prch_cost");	
   	
   	
   
   		if(puchcost==""||puchcost==null||puchcost=="undefined")
			{
   			puchcost=0;	
			}
   	
   	var addrcost=	$('#vehpurchasedirgrid').jqxGrid('getcellvalue', rowBoundIndex, "addicost");	
   	
   	
   	
      	var total=parseFloat(puchcost)+parseFloat(addrcost);
      	if(addrcost==""||addrcost==null||addrcost=="undefined")
			{
   				$('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowBoundIndex, "price",puchcost);
   				setTax(rowBoundIndex); 
			}
      	else{
			$('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowBoundIndex, "price",total);
			setTax(rowBoundIndex); 
	     	}
   }
   function setTax(rowBoundIndex)
   {
     var summaryData= $("#vehpurchasedirgrid").jqxGrid('getcolumnaggregateddata', 'price', ['sum'],true);
     var totalamt=0;
     
     	if(meth==0){
     		totalamt=parseFloat(summaryData.sum);
     		document.getElementById("txttaxamount").value=0;
    	    document.getElementById("txtnetotal").value=totalamt.toFixed(2); 
     	}
     	else{
     		if(document.getElementById("mode").value!='view' ){
     			var tax=document.getElementById("txttaxpercentage").value;
			    var taxamount=parseFloat(summaryData.sum)*tax*0.01;
			    var totalamt=taxamount+parseFloat(summaryData.sum);		
			    document.getElementById("txttaxamount").value=taxamount.toFixed(2);
			    document.getElementById("txtnetotal").value=totalamt.toFixed(2);
     		}
     	}
     }
      
   
    
    </script>
    <div id="vehpurchasedirgrid"></div>
  <input type="hidden" id="rowindex"/> 
