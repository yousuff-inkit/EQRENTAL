
 
 <%@page import="com.dashboard.procurment.stocklist1.ClsStocklist1DAO"%>
 <%
 ClsStocklist1DAO searchDAO = new ClsStocklist1DAO(); 
  
     String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
   	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
   	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
   	
   	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
   	

   	
   	System.out.println("---barchval---"+barchval);
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas1;

 if(temp4!='NA')
{ 
	
	 datas1='<%=searchDAO.stockdetlist(barchval,statusselect,psrno,load)%>'; 
	 dat='<%=searchDAO.stockexceldetlistqty(barchval,statusselect,psrno,load)%>'; 
}
else
{ 
	
	datas1;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
        
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
					  
						{name : 'amount', type: 'number'  },
						{name : 'category', type: 'String'  },
						{name : 'brandname', type: 'String'  },
						{name : 'branchname', type: 'String'  },
						{name : 'loc_name', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						
						{name : 'unit', type: 'String'  },
						{name : 'jdeno', type: 'String'  },
						{name : 'bhno', type: 'String'  },

						
						  
						
						],
				    localdata: datas1,
        
        
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
    
    
   
   
    
    $("#stocklistgriddet").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showfilterrow: true,               
        enabletooltips: true, 
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                 
           	         { text: 'Product Id', datafield: 'productid',  width: '6%' }, 
           	         { text: 'Product Name', datafield: 'productname'},
           	   	 	 {text: 'Brand Name', datafield: 'brandname', width: '6%' ,hidden:true },
           	   		{ text: ' Category', datafield: 'category',  width: '13%',hidden:false  },
           	   		
           	   	{ text: ' Subcategory', datafield: 'subcategory',  width: '10%',hidden:true},
           	         { text: ' Branch', datafield: 'branchname',  width: '6%'  },

           	         { text: ' Location', datafield: 'loc_name',  width: '6%'  },
           	   	 	 
           	         { text: ' Qty', datafield: 'qty',  width: '5%',cellsformat:'d2'},
           	         
           	      
           	      
           	   { text: ' Unit', datafield: 'unit',  width: '5%'},
 		         /*   	 { text: 'Amount', datafield: 'amount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}, */
		           	 
           	 { text: ' Jde No', datafield: 'jdeno',  width: '6%'  },
           	 { text: 'BH No', datafield: 'bhno',  width: '6%'  },

 
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    
});


</script>
<div id="stocklistgriddet"></div>