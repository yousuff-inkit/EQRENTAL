<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.Sales.deliverynotewithprice.ClsDeliveryNoteWithPriceDAO"%>
<% ClsDeliveryNoteWithPriceDAO DAO= new ClsDeliveryNoteWithPriceDAO();%>
<%

String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
String griddepartment = request.getParameter("griddepartment")==null?"0":request.getParameter("griddepartment");
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();


String date=request.getParameter("date")==null?"0":request.getParameter("date").trim();
%>
 
       <script type="text/javascript">
  
			 var prodsearchdata= '<%=DAO.searchProduct(session,prodsearchtype,rrefno,location,reftype,date,productname,brandname,gridunit,gridprdname,gridcategory,gridssubcategory,griddepartment,id)%>';
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
                            {name : 'unitprice', type: 'number'  },
                            {name : 'costprice', type: 'number'  },
                            
                            {name : 'brandname', type: 'string'  },
                            {name : 'department', type: 'string'  },
                            {name : 'taxper', type: 'number'  },
                            {name : 'taxdocno', type: 'string'    },
                            
                       //     munit
     						
                        ],
         
                		//  url: url1,
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
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
                              { text: 'Product Name', datafield: 'productname' },
                             
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'Quantity', datafield: 'qty', width: '10%',hidden:true },
                              { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
                              { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true },
                              { text: 'stockid', datafield: 'stkid', width: '10%',hidden:true },
                              
                              { text: 'Brand', datafield: 'brandname', width: '10%'},
                              { text: 'Department', datafield: 'department', width: '10%'},
                              { text: 'Stock Qty', datafield: 'balqty', width: '10%'},
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'taxper', datafield: 'taxper', width: '10%',hidden:true},
                              { text: 'taxdocno', datafield: 'taxdocno', width: '10%', hidden:true}, 
                             
						
	             
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
        	
        	   $('#jqxInvoiceGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
            	
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
                funRoundAmt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "taxper"),"taxpers");
                
                 
               
               
               // $('#datas').val("1"); 
                document.getElementById("hidpsrno").value=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno");
                
               // $('#datas').val("1"); 
                var bal=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty");
                var cprice=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "costprice");
               // $('#datas').val("1"); 
               
                getSaleDet();
                document.getElementById("stockmsg").innerText="Qty:"+bal+" "+"CP:"+cprice;
                
               
               var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
            /*   if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  { */
            	  
          		var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
        	    	
        	    	 
         if(parseInt(rows[i].prodoc)==parseInt(prodocs))
        			   {
        			   var munit=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno");
      				 if((parseInt(document.getElementById("multimethod").value)==1))
          				{	
		        			   if(parseInt(rows[i].unitdocno)==parseInt(munit))
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
        		   else{
        			   
        			   aa=0;
        		       } 

        	 
        	                         }
        	   
        	   
        	   
        	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText="You have already select this product";
        		   
        		   return 0;
        		   
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   }
        	   
          	  
          	 /*  } */
            	  
            	  
            	
            /*   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
               
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "brandname")); 
              
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "balqty"));
              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "totqty"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "stkid"));
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitprice"));
        	  
        	  
        	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "valorderqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
 
                
    	          
     	        if($('#mode').val()=="E"){
            		
            		 
            		if($('#cmbreftype').val()!="DIR") 
     	          {
            			
            	 $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "oldqty" ,0 );
            	 
            	 
            	 $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "valorderqty" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "qty"));
            			
     	         $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "ordout_qty", $('#prosearch').jqxGrid('getcellvalue', rowindex2, "outqty"));
     	          }
            		}  */
     	          
        	   
        	   
              /* var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#jqxInvoiceGrid").jqxGrid('ensurerowvisible', rowlength); */
              $('#sidesearchwndow').jqxWindow('close'); 
              //document.getElementById("quantity").focus();
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearch"></div>
    
    