  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.barcodegenerator.ClsbarcodeGeneratorsDAO"%>
<%
	ClsbarcodeGeneratorsDAO DAO= new ClsbarcodeGeneratorsDAO();
%>
 <%
    String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	String hidsmodel = request.getParameter("hidsmodel")==null?"0":request.getParameter("hidsmodel").trim();
	String hidsbrand = request.getParameter("hidsbrand")==null?"0":request.getParameter("hidsbrand").trim();
  	String hidyom = request.getParameter("hidyom")==null?"0":request.getParameter("hidyom").trim();
  	String hidspec1 = request.getParameter("hidspec1")==null?"0":request.getParameter("hidspec1").trim();
	String hidspec2 = request.getParameter("hidspec2")==null?"0":request.getParameter("hidspec2").trim();
  	String hidspec3 = request.getParameter("hidspec3")==null?"0":request.getParameter("hidspec3").trim();
  	
  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
  	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
  	String hidcat = request.getParameter("hidcat")==null ?"0":request.getParameter("hidcat").trim();
  	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
  	
  	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
  	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
  	String suitid = request.getParameter("suitid")==null?"0":request.getParameter("suitid").trim();
  	String hidsubmodel = request.getParameter("hidsubmodel")==null?"0":request.getParameter("hidsubmodel").trim();
  	

  	
  	String load = request.getParameter("load")==null?"NA":request.getParameter("load").trim();
  	
  	
  	//System.out.println("====hidbrand====="+hidbrand);
  	//System.out.println("====hidtype====="+hidtype);
  	//System.out.println("====hidproduct====="+hidproduct);
  //	System.out.println("====hidcat====="+hidcat);
  //	System.out.println("====hidsubcat====="+hidsubcat);
	//System.out.println("====hidept====="+hidept);
	
	
 // 	System.out.println("====load====="+load);
	 
	 
	 
 %> 
           	  
 <style>
 
  

 .sl
  {
      background-color:#FCEFCE;
  }
  
 .prd
  {
      background-color:#ffe0cc;
  }
  
 .pr
  {
      background-color:#EBEBC1;
  }
  
    
   .advanceClass5
  {
      background-color: #FCC4F7;
  }
   .advanceClass4
  {
       background-color: #efd4f7;
  }
   .advanceClass3
  {
     
      background-color: #C4F3F5        ;
  }
   .advanceClass2
  {
      background-color:/*  #bed9f4; */ #CFECF1    ;  
  }
   .advanceClass1
  {
      background-color:   #eff4be;  ;
  }
   .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }     
 </style>
<script type="text/javascript">
 var temp4='<%=type%>';
var partdata;
var temps='';
	if(temp4!="0"){
	  partdata='<%=DAO.partSearch(session,type,hidsbrand,hidsmodel,hidyom,hidspec1,hidspec2,hidspec3,hidbrand,hidtype,
			  hidcat,hidsubcat,hidproduct,branchid,hidept,suitid,hidsubmodel,load )%>';
	}
	else{
		partdata;
	}

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     

						{name : 'doc_no', type: 'String'  },
                        {name : 'product', type: 'String'  },
                        {name : 'pdesc', type: 'String'  },
                        {name : 'type', type: 'String'  },
						{name : 'brand', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'cat', type: 'String'  },
						{name : 'scat', type: 'String'  },
						{name : 'dept', type: 'String'  },
						{name : 'sbrand', type: 'String'},
						{name : 'smodel', type: 'String'},
						{name : 'submodel', type: 'String'},
						{name : 'branch', type: 'String'},
						{name : 'yomfrm', type: 'String' },
						{name : 'yomto', type: 'String' },
						{name : 'esize', type: 'string'   },
						{name : 'bsize1', type: 'string'   },
						{name : 'bsize2', type: 'string'   },
						{name : 'bsize3', type: 'string'   },
						{name : 'csize1', type: 'string'   },
						{name : 'csize2', type: 'string'   },
						{name : 'csize3', type: 'string'   },
						{name : 'stkqty', type: 'number'   },
						
						{name : 'fixingprice', type: 'number'   },
						{name : 'lbrchg', type: 'number'   },
						
						{name : 'clrprice', type: 'number'   },
						{name : 'barcode', type: 'string'   },
						
						
						
						],
				    localdata: partdata,
        
        
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
    
    
   
   
    
    $("#Searchgrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
      
        enableAnimations: true,
        filterable: true,
        showfilterrow: true,
        filtermode:'excel',
        columnsresize:true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  
/*                   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false  ,cellclassname:'advanceClass1',
                      datafield: 'sl', columntype: 'number',pinned: true, width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'doc_no', datafield: 'doc_no',  width: '10%' ,hidden:true},
                      
                    { text: 'Branch', datafield: 'branch',  width: '12%' ,cellclassname:'advanceClass',hidden:true },
           	         { text: 'Product Code', datafield: 'product',pinned: true,  width: '13%'  ,cellclassname:'balanceClass'}, 
					 { text: 'Description', datafield: 'pdesc',pinned: true  ,cellclassname:'balanceClass'},
					 { text: 'Type',datafield: 'type' , width: '10%' ,cellclassname:'sl',hidden:true  },
					 { text: 'Department',datafield: 'dept', width: '10%' ,cellclassname:'sl' ,hidden:true },
				     { text: 'Brand',datafield: 'brand',pinned: true, width: '12%' ,cellclassname:'sl' },
					 { text: 'Category', datafield: 'cat', width: '13%'  ,cellclassname:'advanceClass4',hidden:true},
					 { text: 'SubCategory', datafield: 'scat', width: '13%' ,cellclassname:'advanceClass4',hidden:true},
					 { text: 'Stock Qty', datafield: 'stkqty',  width: '6%',cellsformat:'d2' ,cellclassname:'advanceClass5',hidden:true },
					 { text: 'Barcode', datafield: 'barcode',  width: '10%',cellclassname:'advanceClass4'  },
					 
					 { text: 'Selling Price', datafield: 'fixingprice',  width: '10%',cellsformat:'d2' ,cellclassname:'advanceClass5',cellsalign: 'right', align:'right'  },
					 { text: 'Fixing Price', datafield: 'lbrchg',  width: '10%',cellsformat:'d2' ,cellclassname:'advanceClass5' ,cellsalign: 'right', align:'right' },
					 { text: 'Clear Price', datafield: 'clrprice',  width: '10%',cellsformat:'d2' ,cellclassname:'advanceClass5' ,cellsalign: 'right', align:'right' },
					  */
					 
			           { text: 'SL#', sortable: false, filterable: false, editable: false,
	                      groupable: false, draggable: false, resizable: false   ,
	                      datafield: 'sl', columntype: 'number' , width: '4%',
	                      cellsrenderer: function (row, column, value) {
	                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                      }  
	                    },
	                    { text: 'doc_no', datafield: 'doc_no',  width: '10%' ,hidden:true},
	                      
	                    { text: 'Branch', datafield: 'branch',  width: '12%',hidden:true },
	           	         { text: 'Product Code', datafield: 'product' ,  width: '13%'   }, 
						 { text: 'Description', datafield: 'pdesc'   },
						 { text: 'Type',datafield: 'type' , width: '10%' ,hidden:true  },
						 { text: 'Department',datafield: 'dept', width: '10%'   ,hidden:true },
					     { text: 'Brand',datafield: 'brand' , width: '12%'   },
						 { text: 'Category', datafield: 'cat', width: '13%'  ,hidden:true},
						 { text: 'SubCategory', datafield: 'scat', width: '13%'  ,hidden:true},
						 { text: 'Stock Qty', datafield: 'stkqty',  width: '6%',cellsformat:'d2' ,hidden:true },
						 { text: 'Barcode', datafield: 'barcode',  width: '10%'   },
						 
						 { text: 'Selling Price', datafield: 'fixingprice',  width: '10%',cellsformat:'d2' ,cellsalign: 'right', align:'right'  },
						 { text: 'Fixing Price', datafield: 'lbrchg',  width: '10%',cellsformat:'d2'  ,cellsalign: 'right', align:'right' },
						 { text: 'Clear Price', datafield: 'clrprice',  width: '10%',cellsformat:'d2'  ,cellsalign: 'right', align:'right' },
						 
						 	 
					 
 				]
   
    });
    
    $('#Searchgrid').on('rowclick', function (event) {
        var rowindex1 = event.args.rowindex;
        $("#btngenate").attr('disabled', false );
        $("#cmbtype").attr('disabled', false );
        document.getElementById("psrno").value = $('#Searchgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
    
    });
    
    if(temps=="cal")
    	{
    $('#Searchgrid').jqxGrid('showcolumn', 'stkqty');
    	}
    else
    	{
    $('#Searchgrid').jqxGrid('hidecolumn', 'stkqty');
    	}
	
    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="Searchgrid"></div>