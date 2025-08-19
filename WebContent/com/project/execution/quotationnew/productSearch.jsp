<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.project.execution.quotationnew.ClsQuotationDAO"%> 
<%ClsQuotationDAO DAO= new ClsQuotationDAO();%>
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();

String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String estdate=request.getParameter("estdate")==null?"0":request.getParameter("estdate").trim();

String id = request.getParameter("id")==null?"0":request.getParameter("id");
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");

String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
String servicetype = request.getParameter("stypeid")==null?"0":request.getParameter("stypeid");
%>
 
       <script type="text/javascript">
  
			 var prodsearchdata= '<%= DAO.searchProduct(session,prodsearchtype,rrefno,reftype,cldocno,estdate,productname,brandname,id,gridunit,gridprdname,scope,servicetype)%>';
		// alert(prodsearchdata);
			 $(document).ready(function () { 	
        	/* var url=""; */

            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'unitdocno', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'specid', type: 'string'  },
                            {name : 'method', type: 'string'  },
                            {name : 'amount', type: 'number'  },
                            {name : 'brandid', type: 'number'  },
                            {name : 'productname', type: 'String'},
                            {name : 'stdprice', type: 'String'},
                            {name : 'lbrchg', type: 'number'},
							{name : 'scopefprice', type: 'number'},
							{name : 'scopestdcost', type: 'number'},
                            
                        ],
         
                		//  url: url1,
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#newprosearchGrid").jqxGrid(
            {
                width: 390,
                height: 560,
                source: dataAdapter,
                columnsresize: true,
                filterable: true, 
                selectionmode: 'singlerow',
                autorowheight: true,
                pageable: true,
            	pagesize: 50,
            	pagerheight: 1,
            
                       
                columns: [
							
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', minwidth: 40,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: 80 },
                              { text :'Product Name',datafield:'productname', width: 120 },
                              { text: 'Brand', datafield: 'brandname', width: 90 },
                              { text: 'Unit', datafield: 'unit', width: 40 },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'amount', datafield: 'amount', width: '10%' ,hidden:true},
                              { text: 'brandid', datafield: 'brandid', width: '10%' ,hidden:true},
                              { text: 'stdprice', datafield: 'stdprice', width: '10%' ,hidden:true},
                              { text: 'lbrchg', datafield: 'lbrchg', width: '10%' ,hidden: true},
		 					  { text: 'scopefprice', datafield: 'scopefprice', width: '10%' ,hidden: true},
		 					  { text: 'scopestdcost', datafield: 'scopestdcost', width: '10%' ,hidden: true},
						]
            })
             
            
        /*     $('#newprosearchGrid').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#newprosearchGrid').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#newprosearchGrid').on('rowdoubleclick', function (event) {
        	
        	   $('#datas1').val("0");
        	   $('#serviceGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            
                var rowindex2 = event.args.rowindex;
   
                
                
               
               
               var prodocs=$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
             
              if(parseInt($('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	 // alert("inside");
          		var rows = $("#serviceGrid").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        	 
        	    	
        	    	 
        		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
        			   {
        			   aa=1;
        			   break;
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
        	   
          	  
          	  }
              
              
                  
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "item" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "prdname" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unitid" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "amount"));
 			  $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "stdprice"));
	  		  $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "lbrchg"));
	  		  $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopefprice"));
	  		  $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,$('#newprosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopestdcost"));
           
              $('#datas1').val("1");
              var rows = $('#serviceGrid').jqxGrid('getrows');
             
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#serviceGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                $("#serviceGrid").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="newprosearchGrid"></div>
    
    