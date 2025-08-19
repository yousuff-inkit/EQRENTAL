        	<%@page import="com.operations.marketing.leasepricerequestalmariah.ClsLeasepriceRequestDAO" %>


            <%
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
            ClsLeasepriceRequestDAO viewDAO=new ClsLeasepriceRequestDAO();
           	  %> 
<script type="text/javascript">

           	var driverlist=["Yes","No"];
           	var securitylist=["Yes","No"];
           	var fuellist=["Yes","No"];
           	var saliklist=["Yes","No"];
           	var safetylist=["Yes","No"];
           	var fleettypelist=["Ex-Fleet","New"];
           	//Security pass (Yes/No/NA) , Fuel(Yes/No) ,Salik(Yes/No) ,Safety accessories(Yes/No)
           	
           	
           	
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	 var reqdata1= '<%=viewDAO.searchrelode(enqrdocno)%>';
          	   hide=2; 
          	 } 
            else
          	 { 
            	var reqdata1;
            	
        
          	 } 
  
  
        $(document).ready(function () { 	
//         	driverlist.push("yes");driverlist.push("no");
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brand', type: 'string'  },
     						{name : 'brdid', type: 'int'   },
     						{name : 'model', type: 'string'   },
     						{name : 'modid', type: 'string'   },
     						{name : 'specification', type: 'string'  },
     						
     						{name : 'Group', type: 'string'   },
     						{name : 'grpid', type: 'int'   },
     						
     						{name : 'ldur', type: 'number'  },
     						{name : 'kmusage', type: 'number' },
     					
     						{name : 'qty', type: 'number'  },
     						{name : 'sr_no', type: 'int'  },
     						
     						{name : 'driver', type: 'string'   },
     						{name : 'security', type: 'string'   },
     						{name : 'fuel', type: 'string'   },
     						{name : 'salik', type: 'string'   },
     						{name : 'safety', type: 'string'   },
     						{name : 'yom',type:'string'},
     						{name : 'yomid',type:'number'},
     						{name : 'fleettype',type:'string'}
     											
                 ],
                 localdata: reqdata1,
                
                
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
            
                disabled:true,
                editable: true,
                altRows: true,
             
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#jqxEnquiry').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'brand') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	brandinfoSearchContent('enqbrandSearch.jsp');
                        	 $('#jqxEnquiry').jqxGrid('render');
                        }
                        }
                   
               	 
           
                 	 if (cell1 != undefined && cell1.datafield == 'model') {  
                 
             
		                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                    if (key == 114) {  
		                    	 document.getElementById("rowindex").value = cell1.rowindex;
		                  	  var  brandval=document.getElementById("brandval").value;
		                  	
		                  	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
		                  	 $('#jqxEnquiry').jqxGrid('render');
		                    }
                    }
              
                 	if (cell1 != undefined && cell1.datafield == 'yom') {  
                        
                        
	                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
	                    if (key == 114) {  
	                    	document.getElementById("rowindex").value = cell1.rowindex;
	                  		yominfoSearchContent('yomSearch.jsp');
	                  	 	$('#jqxEnquiry').jqxGrid('render');
	                    }
                }
                  }, 
              
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            
							{ text: 'Brand', datafield: 'brand', width: '12%' },	
							{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true },
							{ text: 'Model', datafield: 'model', width: '12%' },
							{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true },
							{ text: 'YoM',datafield:'yom',width:'4%'},
							{ text: 'YoM Id',datafield:'yomid',width:'8%',hidden:true},
							{ text: 'Type',  datafield: 'fleettype',  width: '5%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: fleettypelist });
							  }
							},
							{ text: 'Special Notes', datafield: 'specification', width: '20%' },	
							{ text: 'Lease Duration(Months)', datafield: 'ldur', width: '9%'},
													
							{ text: 'KM Usage', datafield: 'kmusage', width: '5%'},
							{ text: 'Qty', datafield: 'qty', width: '3%'},
							
							{ text: 'Driver',  datafield: 'driver',  width: '4%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: driverlist });
							  }
							},
							{ text: 'Security pass',  datafield: 'security',  width: '4%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: securitylist });
							  }
							},
							{ text: 'Fuel',  datafield: 'fuel',  width: '4%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: fuellist });
							  }
							},
							{ text: 'Salik',  datafield: 'salik',  width: '4%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: saliklist });
							  }
							},
							{ text: 'Safety Accessories',  datafield: 'safety',  width: '10%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                        editor.jqxDropDownList({ autoDropDownHeight: true, source: safetylist });
							  }
							},
							
							
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true}
			              ]
               
            });
           
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
            
            	
           
            $("#jqxEnquiry").on('cellclick', function (event) 
             		{
         
         	   var rowindextemp2 = event.args.rowindex;
                document.getElementById("rowindex").value = rowindextemp2;
               
                if(event.args.columnindex ==1)
             	   {
             	
                $("#jqxEnquiry").jqxGrid('clearselection');
             	   }
                if(event.args.columnindex ==3)
         	   {
         	
                $("#jqxEnquiry").jqxGrid('clearselection');
         	   }
			}); 

            $('#jqxEnquiry').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var dataField = args.datafield;
            	if(dataField=="yom"){
            		var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#jqxEnquiry').jqxGrid('clearselection');
              	yominfoSearchContent('yomSearch.jsp');
            	}
              	  if(columnindex1 == 1)
              		  { 
            		
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#jqxEnquiry').jqxGrid('clearselection');
              	brandinfoSearchContent('enqbrandSearch.jsp');
              	
              		  }
					  if(columnindex1 == 3)
         		  { 

         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         		  $('#jqxEnquiry').jqxGrid('clearselection');
         	   var  brandval=document.getElementById("brandval").value;
         
         	modelinfoSearchContent('modelSearch.jsp?brandval='+brandval);
         	
         		  } 
         	 }); 
            
            $("#jqxEnquiry").on('cellvaluechanged', function (event) 
         		   {
         		        		  
         		       var rowBoundIndex = args.rowindex;
         		       
         		       var datafield = event.args.datafield;
         		       
          		      
         		   
         		       
         		  }); 
        });
    </script>
    <div id="jqxEnquiry"></div>
  <input type="hidden" id="rowindex"/> 