  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.barcodegeneratorgrn.ClsbarcodeGeneratorsgrnDAO"%>
<%
	ClsbarcodeGeneratorsgrnDAO DAO= new ClsbarcodeGeneratorsgrnDAO();
%>
 <%
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

var partdata;
var temp4='<%=load%>';
if(temp4=="load")
	{
	  partdata='<%=DAO.grnlistsearch(load)%>';  

	}
	
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     

						{name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'psrno', type: 'String'  },
						{name : 'part_no', type: 'String'  },
						{name : 'productname', type: 'String'  },
                     //   {name : 'description', type: 'String'  },
                       	{name : 'qty', type: 'number'   },
						{name : 'barcode', type: 'string'   },
						{name : 'jdeno', type: 'String'  },
						{name : 'bhno', type: 'String'  },

						
						
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
    
    
   
   
    
    $("#Searchgrid1").jqxGrid(
    {
        width: '100%',
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
	                    { text: 'Doc no', datafield: 'voc_no',  width: '7%' },
	                      
	                    { text: 'Date', datafield: 'date',  width: '7%',cellsformat:'dd.MM.yyyy'},
	                    { text: 'Part No', datafield: 'part_no' ,   width: '7%', }, 
	                    { text: 'psrno', datafield: 'psrno'  ,hidden:true  }, 
	                    { text: 'Product Name', datafield: 'productname'    }, 
						// { text: 'Description', datafield: 'description'   },
						 { text: 'Quantity', datafield: 'qty',  width: '6%',cellsformat:'d2'  },
						 { text: 'Barcode', datafield: 'barcode',  width: '6%'   },
						 { text: 'Jde No', datafield: 'jdeno',  width: '6%'   },
						 { text: 'BH No', datafield: 'bhno',  width: '6%'   },

						 
						 
						 	 
					 
 				]
   
    });
    
    $('#Searchgrid1').on('rowclick', function (event) {
        var rowindex1 = event.args.rowindex;
        $("#btngenate").attr('disabled', false );
        $("#cmbtype").attr('disabled', false );
        document.getElementById("psrno").value = $('#Searchgrid1').jqxGrid('getcellvalue',rowindex1, "psrno");
    
    });
    
  
    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="Searchgrid1"></div>