<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.Sales.deliverynotereturn.ClsDeliverynoteReturnDAO"%>
<%ClsDeliverynoteReturnDAO DAO= new ClsDeliverynoteReturnDAO();%>
<% 
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String locaid=request.getParameter("locaid")==null?"0":request.getParameter("locaid").trim();
String conf=request.getParameter("psconf")==null?"0":request.getParameter("psconf").trim();

%>
 
       <script type="text/javascript">
       var chkconf='<%=conf%>';
			 var prodsearchdata= '<%=DAO.searchProduct(session,prodsearchtype,rrefno,locaid)%>';
		$(document).ready(function () { 	
        	/* var url=""; */

            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'productname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'unitdocno', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'specid', type: 'string'  },
                            {name : 'method', type: 'string'  },
                            {name : 'qty', type: 'number'  },
                            {name : 'outqty', type: 'number'  },
                            {name : 'balqty', type: 'number'  },
                            {name : 'totqty', type: 'number'  },
                            {name : 'stkid', type: 'number'  },
                            
                            {name : 'brandname', type: 'string'  },
                              {name : 'rdocno', type: 'number'  },
                            {name : 'detdocno', type: 'number'  },
                            {name : 'jdeno', type: 'string'  },
                            {name : 'bhno', type: 'string'  },
                            
                            
                       //     munit
     						
                        ],
         
                		//  url: url1,
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            $("#prosearch").on("bindingcomplete", function (event) {
                //var psearch= $('#hidpsconf').val();
            
             
                if(parseInt(chkconf)==1){
               	   // alert("conf=="+chkconf);
               	 $('#prosearch').jqxGrid('hidecolumn', 'brandname');
                     	//$('#prosearch').jqxGrid('hidecolumn', 'department');
                	$('#prosearch').jqxGrid('showcolumn', 'bhno');
                	$('#prosearch').jqxGrid('showcolumn', 'jdeno'); 
                }
                 if(parseInt(chkconf)==0){
               	    //alert("conf=="+chkconf);
               	  
                     	$('#prosearch').jqxGrid('hidecolumn', 'bhno');
                     	$('#prosearch').jqxGrid('hidecolumn', 'jdeno'); 
                 } 
               });
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#prosearch").jqxGrid(
            {
                width: '100%',
                height: 530,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow:true,
                filterable: true, 
                enabletooltips:true,
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname'  },
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'JDE', datafield: 'jdeno', width: '10%' },
                              { text: 'BH No', datafield: 'bhno', width: '10%' },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'qty', width: '10%',hidden:true },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
                              { text: 'stockid', datafield: 'stkid', width: '10%' ,hidden:true  },
                              
                              { text: 'brandname', datafield: 'brandname', width: '10%' ,hidden:true  },
             
						       
                              { text: 'detdocno', datafield: 'detdocno', width: '10%' ,hidden:true  },
                              { text: 'rdocno', datafield: 'rdocno', width: '10%' ,hidden:true },
                              
             
                              
	             
						]
            })
             
            
        /*     $('#prosearch').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#prosearch').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearch').on('rowdoubleclick', function (event) {
        	
        	   $('#jqxDeliveryNoteReturn').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
     
                var rowindex2 = event.args.rowindex;
   
                
                
              	 var doc_no=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
              	 var rdocno=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rdocno");
                   
                   
              	  var rowindex2 = event.args.rowindex;
                  document.getElementById("jqxInput").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no");
                  document.getElementById("jqxInput1").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname");
                  document.getElementById("temppsrno").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno");
                  document.getElementById("tempspecid").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid");
                  //getunit($('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                  $("select#unit").html('<option value="' + $('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno") + '">' + $('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit") + '</option>');
                  document.getElementById("unit").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
                  document.getElementById("brand").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname");
                  $("#totalstock").val($('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
                  
                  
                  
                  document.getElementById("quantity").focus();
                 
                 // $('#datas').val("1"); 
                  document.getElementById("hidpsrno").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno");
       
        		var rows1 = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
      	     var aa=0;
      	    for(var i=0;i<rows1.length;i++){
      	   
      		   if(parseInt(rows1[i].rdocno)==parseInt(rdocno))
      			   {
      		   if(parseInt(rows1[i].prodoc)==parseInt(doc_no))
   			   { 
      		     
      			 var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
      			   
        		  // var munit=rows[0].unitdocno;
   				 if((parseInt(document.getElementById("multimethod").value)==1))
      				{	
   					   
          			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
          			   {
          				   
          				   aa=1;
              			   break;
          			   }
      				}
   				 else
   					 {
      			   
      			   
      			   
      			   
      			   aa=1;
      			   break;
   					 }
   			   }
      			   }
      		   else{
      			   
      			   aa=0;
      		       } 

      	 	     }
      	   
            
   
            
                   
 
/*               	if($('#mode').val()=="A"){
	            		
               var stkids=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid");
   
          		var rows = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
        	     
        	    	 
        		   if(parseInt(rows[i].stkid)==parseInt(stkids))
        			   {
        			   aa=1;
        			   
        			  
        			   break;
        			   }
        		   else{
        			   
        			   aa=0;
        		       } 

        	  
        	   
        	    }
              	} */
              	
              	
          /*     	if($('#mode').val()=="E"){
              		
              	   var stkids=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid");
              	   
             		var rows = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
           	    var aa=0;
           	    for(var i=0;i<rows.length;i++){
           	 
           	     var refstockid=rows[i].refstkid;
           	     
           	     if(parseInt(refstockid)>0)
           	    	 {
           	    	
           	    	 }
           	     else
           	    	 {
           	    	 
           	    	refstockid=rows[i].stkid;
           	    	 }
           	     
           	    	 
           		   if(parseInt(refstockid)==parseInt(stkids))
           			   {
           			   aa=1;
           			   
           			  
           			   break;
           			   }
           		   else{
           			   
           			   aa=0;
           		       } 

           	  
           	   
           	    }
              		
              	} */
              	
        	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText="You have already select this product";
        		   
        		   return 0;
        		   
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   }
        	   
          	  
          	 
            	  
            	  
            	
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
              
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
              
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
               $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
              
                  $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "detdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "detdocno"));
        	  $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "rdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "rdocno"));
                
             /*  var rows = $('#jqxDeliveryNoteReturn').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxDeliveryNoteReturn").jqxGrid('ensurerowvisible', rowlength); */
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    