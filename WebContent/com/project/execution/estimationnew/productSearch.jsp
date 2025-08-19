<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%> 
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
String scope = request.getParameter("scopeid")==null || request.getParameter("scopeid")==""?"0":request.getParameter("scopeid");
String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
%>
 
       <script type="text/javascript">
             var scopeproduct="<%=scopeproduct%>";
             
			 var prodsearchdata= '<%= DAO.searchProduct(session,prodsearchtype,rrefno,reftype,cldocno,estdate,productname,brandname,id,gridunit,gridprdname,scope,gridcategory,gridssubcategory)%>';
		
			 $(document).ready(function () { 	

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
                            {name : 'prdname', type: 'String'},
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
            
            $("#prosearchGrid").jqxGrid(
            {
                width: 790,
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
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden: true},
                              { text: 'Product', datafield: 'part_no', width: 130 },
                              { text: 'Product Name',datafield:'prdname', width: 356},
                              { text: 'Brand', datafield: 'brandname', width: 140 },
                              { text: 'Amount', datafield: 'amount', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: 80},
                              { text: 'Unit', datafield: 'unit', width: 40 },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden: true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden: true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden: true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden: true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden: true},
                              { text: 'brandid', datafield: 'brandid', width: '10%' ,hidden: true},
		 					  { text: 'stdprice', datafield: 'stdprice', width: '10%' ,hidden: true},
		 					  { text: 'lbrchg', datafield: 'lbrchg', width: '10%' ,hidden: true},
		 					  { text: 'scopefprice', datafield: 'scopefprice', width: '10%' ,hidden: true},
		 					  { text: 'scopestdcost', datafield: 'scopestdcost', width: '10%' ,hidden: true},
						]
            })
             
            
        /*     $('#prosearchGrid').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#prosearchGrid').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearchGrid').on('rowdoubleclick', function (event) {
        	
        	   $('#datas1').val("0");
        	   $('#materialGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            
                var rowindex2 = event.args.rowindex;
   
                
                
               
               
               var prodocs=$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
             
              if(parseInt($('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	 // alert("inside");
          		var rows = $("#materialGrid").jqxGrid('getrows');
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
              
              
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "prdname"));       
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "product" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "prdname")); 
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "brand" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandname"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandname"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "specid"));
              if(parseInt(scopeproduct)==1){
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "amount"));
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "stdprice"));
              } else {
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,0);
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,0);
              }
              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "brandid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandid"));
	  		  $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "lbrchg"));
	  		  $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopefprice"));
	  		  $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopestdcost"));
	  		  $('#materialGrid').jqxGrid('selectcell', rowindex1, 'proname');
	  		
	  		 $("#materialGrid").jqxGrid('ensurerowvisible', rowindex1);
	  		
              $('#datas1').val("1");
              var rows = $('#materialGrid').jqxGrid('getrows');
             
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#materialGrid").jqxGrid('addrow', null, {});
                	} 
                	  
                
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearchGrid"></div>
    
    