<%@ page import="com.dashboard.leaseagreement.laduedate.ClslaDueDateDAO"%>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
  
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();
  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();
  	ClslaDueDateDAO clad=new ClslaDueDateDAO();
 
 %> 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var laduedata;
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 
	 	  laduedata='<%=clad.detailsgrid(barchval,uptodate,cldocno,fleet)%>';
	 	 dataildata='<%=clad.exceldetailsgrid(barchval,uptodate,cldocno,fleet)%>';
	
 aa=0;
 }
  
  
  else
	  {
	  laduedata;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
     						{name : 'refname', type: 'String'},     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'vehdetails', type: 'String'}, 
     						
     						{name : 'outdate', type: 'date'  },
     						{name : 'outtime', type: 'String'  },
     						
     					
     					
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						
     						{name : 'drname', type: 'String'  },
     						{name : 'mrno', type: 'String'  },
     						
						{name : 'sal_name', type: 'string'  },
						{name : 'duedate', type: 'date'  },
						{name : 'rate', type: 'string'  },
						{name : 'sum', type: 'string'  },			
     						
                          	],
                          	localdata: laduedata,
                          	       
          
				
                
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
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '99%',
                height: 540,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:true,
                columnsresize:true,
     					
                columns: [
                          
      
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                          
							{ text: 'LA NO', datafield: 'doc_no', width: '4%',hidden:true, editable: false }, 
							{ text: 'LA NO', datafield: 'voc_no', width: '7%' , editable: false},             
							{ text: 'Fleet', datafield: 'fleet_no', width: '4%', editable: false },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '12%', editable: false },
							{ text: 'Reg NO', datafield: 'reg_no', width: '6%' , editable: false},
							{ text: 'Client Name', datafield: 'refname', width: '16%' , editable: false},
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%', editable: false},
							{ text: 'Driver', datafield: 'drname', width: '10%', editable: false},
							{ text: 'Mob NO', datafield: 'per_mob', width: '7%', editable: false},
							{ text: 'Out Date', datafield: 'outdate', width: '6%',cellsformat:'dd.MM.yyyy', editable: false},
							 { text: 'Out Time', datafield: 'outtime', width: '5%' , editable: false},
							 { text: 'Due Date', datafield: 'duedate', width: '6%',cellsformat:'dd.MM.yyyy',editable:true,columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
	 						        editor.jqxDateTimeInput({ showCalendarButton: true });
	 						    }
							 },
							{ text: 'Manual LA', datafield: 'mrno', width: '6%', editable: false},
								
							{ text: 'Salesman', datafield: 'sal_name', width: '12%', editable: false},
							{ text: 'Rate', datafield: 'rate', width: '8%', editable: false},
							{ text: 'Credit_balance', datafield: 'sum', width: '8%', editable: false},
							{ text: 'Action',datafield:'action',width:'8%',columntype:'button',cellsrenderer: function () {
			                     return "Update";
			                  }}
							
					
					]
            });


     	   $("#overlay, #PleaseWait").hide();
     	   
     	   
     	   
       
        });
        
        $("#detailsgrid").on("cellclick", function (event) 
        		{
        		    // event arguments.
        		    var args = event.args;
        		    // row's bound index.
        		    var rowBoundIndex = args.rowindex;
        		    // row's visible index.
        		    var rowVisibleIndex = args.visibleindex;
        		    // right click.
        		    var rightclick = args.rightclick; 
        		    // original event.
        		    var ev = args.originalEvent;
        		    // column index.
        		    var columnindex = args.columnindex;
        		    // column data field.
        		    var dataField = args.datafield;
        		    // cell value
        		    var value = args.value;
        		    
        		    if(dataField=="action"){
        		    	var duedate=$('#detailsgrid').jqxGrid('getcelltext',rowBoundIndex,'duedate');
        		    	var docno=$('#detailsgrid').jqxGrid('getcelltext',rowBoundIndex,'doc_no');
        		    	funUpdateDueDate(duedate,docno);
        		    }
        		    
        		});    
				       
        function funUpdateDueDate(duedate,docno){
        	var x = new XMLHttpRequest();
        	x.onreadystatechange = function() {
        		if (x.readyState == 4 && x.status == 200) {
        			var items = x.responseText.trim();
        			if(items=="-1"){
        				$.messager.alert('Warning','Cannot update due date less than actual due date!!!');
        			}
        			else if(items=="0"){
        				$.messager.alert('Warning','Not Updated!!!');
        			}
        			else{
        				$.messager.alert('Warning','Successfully Updated');
        				funreload("");
        			}
        		} 
        		else{
        		}
        	}
        	x.open("GET", "updateDueDate.jsp?duedate="+duedate+"&docno="+docno, true);
        	x.send();
       }
    </script>
    <div id="detailsgrid"></div>
    