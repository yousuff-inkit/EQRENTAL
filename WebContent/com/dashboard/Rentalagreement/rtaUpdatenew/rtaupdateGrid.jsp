<%@ page import="com.dashboard.rentalagreementnew.ClsrentalagreementDAO" %>
<%ClsrentalagreementDAO crad=new ClsrentalagreementDAO(); %>


<% String contextPath=request.getContextPath();%>
 <%
 
String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
 String type = request.getParameter("type")==null?"0":request.getParameter("type");
 %>
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var type='<%=type%>';
 var exceldata;
 var damagedata;
 var aa;
  if(temp4!='NA')
 { 

 
 datasssss='<%=crad.rtaupdate(barchval,type)%>';
 exceldata='<%=crad.rtaupdateExcel(barchval,type)%>';
 aa=0;
 }
  else
	  {
	  datasssss;
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
     						 {name : 'flname', type: 'String'}, 
     						 
     						{name : 'reg_no', type: 'String'},
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						{name : 'okm', type: 'number'  },
     						{name : 'ofuel', type: 'String'  },
     						
     					
     						{name : 'drid', type: 'String'  },
     						{name : 'hidfuel', type: 'string'  },
     						{name : 'btnsave', type: 'string'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'btnattach', type: 'string'  },
     						{name : 'upd', type: 'string'  },
     						{name : 'btnconfirm', type: 'string'  },
     						
     						
                          	],
                          	localdata: datasssss,
                          	       
          
				
                
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
            $("#rtaupdategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 526,
           
                source: dataAdapter,
                showaggregates:true,
                showfilterrow:true,
                enableAnimations: true,
                enabletooltips:true,
                filtermode:'excel',
                filterable: true,
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
								{ text: 'RA NO', datafield: 'voc_no', width: '5%',editable:false },
						
							{ text: 'Client Name', datafield: 'refname', width: '19%',editable:false },
							{ text: 'Fleet NO', datafield: 'fleet_no', width: '4%',editable:false },
							{ text: 'Fleet name', datafield: 'flname', width: '15%',editable:false },
						
							{ text: 'Reg NO', datafield: 'reg_no', width: '4%',editable:false},
							{ text: 'Out Date', datafield: 'odate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false},
							
							 { text: 'Time', datafield: 'otime', width: '3%',editable:false },
							
							 { text: 'KM', datafield: 'okm', width: '4%',editable:false },
							 { text: 'Fuel', datafield: 'ofuel', width: '5%',editable:false },
							 { text: 'RTA Remarks', datafield: 'upd', width: '15%',editable:true },
							 { text: ' ', datafield: 'btnsave',columntype: 'button',editable:false, filterable: false},
							 { text: ' ', datafield: 'btnconfirm',columntype: 'button',editable:false, filterable: false},
							 { text: ' ', datafield: 'btnattach',columntype: 'button',editable:false, filterable: false},
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
				
								{ text: 'RA NO', datafield: 'doc_no', width: '6%' ,hidden:true},
					
					]
            });
            $("#overlay, #PleaseWait").hide();
            if(aa==1)
        	{
        	 $("#rtaupdategrid").jqxGrid('addrow', null, {});
        	}
            
            
            $("#rtaupdategrid").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            		    
            		    
             			 if(datafield=="btnattach"){
                       	
                       		 
                       		 document.getElementById("docnoss").value=$('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "voc_no");
                       		 
                       		 document.getElementById("brh").value=$('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
                       		 
                       		
                       		 funAttachBtn();
                       		 
                       		 
             			 }
             			  		    
            if(datafield=="btnsave"){
           	 if($('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
           		
           		
           		 
           		 //for 
           		  var radocno= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
            		 var branchval= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
           		         var upd= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "upd");
           		
				    		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				    		        	  
				    	     		       
									       		        	if(r==false)
									       		        	  {
									       		        		return false; 
									       		        	  }
									       		        	else{
									        				 savegriddata(radocno,branchval,upd);
									       		        	   }
				    		                      });
           	                      }
								           	 else {
								           		 
								           	
								           	  $('#rtaupdategrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
								           	         }
								             }
								             
				 if(datafield=="btnconfirm"){
         
          if($('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "btnconfirm")=="Confirm"){
          
          
          
           var radocno= $('#rtaupdategrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
          
          
           $.messager.confirm('Message', 'Do you want to confirm?', function(r){
				    		        	  
				    	     		       
			       	if(r==false)
			       	  {
			       		return false; 
			       	  }
			       	else{
					   savedata(radocno);
					}
     });
          
         
         
         
         
         }
          else {
								           		 
								           	
	            $('#rtaupdategrid').jqxGrid('setcellvalue',rowBoundIndex, "btnconfirm","Confirm");
			   }
         
         
         }				             
            });
   		          
         }); 
        
        function savegriddata(radocno,branchval,upd)
        {
        	
        	var x=new XMLHttpRequest();
        	x.onreadystatechange=function(){
        	if (x.readyState==4 && x.status==200)
        		{
        		
             			
        			var items=x.responseText;
        			
        			if(items>0){
        			 $.messager.alert('Message', '  Record successfully Updated ', function(r){
    				     
    			     });
    			     }else{
			    			     
			    			      $.messager.alert('Message', '  Record Not Updated ', function(r){
			    				     
			    			     });
			    			     
			    			     
			    			     }
        			 funreload(event); 
        			 
        			 
        			
        			}
        		
        	}
        		
        x.open("GET","savedrtadate.jsp?radocno="+radocno+"&branchval="+branchval+"&type="+type+"&upd="+upd,true);
        
        x.send();
        		
        }
        
        function savedata(radocno){
	
	 var x=new XMLHttpRequest();
			        	x.onreadystatechange=function(){
			        	if (x.readyState==4 && x.status==200)
			        		{
			        		
			             			
			        			var items=x.responseText;
			        			
			        			if(items>0){
			        			 $.messager.alert('Message', '  Record successfully Confirmed ', function(r){
			    				     
			    			     });
			    			     }else{
			    			     
			    			      $.messager.alert('Message', '  Record Not Confirmed ', function(r){
			    				     
			    			     });
			    			     
			    			     
			    			     }
			        			 funreload(event); 
			        			 
			        			 
			        			
			        			}
			        		
			        	}
			        		
			        x.open("GET","saveconfirm.jsp?con="+radocno+"&type="+type,true);
			        
			        x.send();
	
	
	
	
	
	}
        

        function funAttachBtn(){
       
        	if(type=='rental'){
        	  $("#windowattach").jqxWindow('setTitle',"RAG - "+document.getElementById("docnoss").value);
        		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("docnoss").value+"&barchvals="+document.getElementById("brh").value);		
        	}
        	if(type=='lease'){
        	
        	 $("#windowattach").jqxWindow('setTitle',"LAG - "+document.getElementById("docnoss").value);
      		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=LAG&docno="+document.getElementById("docnoss").value+"&barchvals="+document.getElementById("brh").value);		
        	
        	
        	}
        }
   
				       
                       
    </script>
    
<input type="hidden" id="docnoss">
<input type="hidden" id="brh">
    
    <div id="rtaupdategrid"></div>