<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.alternativeitems.ClsAlternativeItemsDAO" %>
<%ClsAlternativeItemsDAO DAO=new ClsAlternativeItemsDAO(); %>                
<%   
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim(); 
	String brch = request.getParameter("brch")==null?"":request.getParameter("brch").trim();    
	String from = request.getParameter("from")==null?"":request.getParameter("from").trim(); 
	String doc = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
	String cond = request.getParameter("cond")==null?"":request.getParameter("cond").trim();
	String wqty = request.getParameter("wqty")==null?"":request.getParameter("wqty").trim();
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;      
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;  
    }
       
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">        
     var bomdata;
     var temp='<%=cond%>';
    
    	 bomdata='<%=DAO.viewload(id,doc,wqty)%>';
     
     
	$(document).ready(function () {
	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [                  
	                    {name : 'uom', type: 'String'  },
	                    {name : 'pid', type: 'String'  },
	                    {name : 'psrno', type: 'String'  },
	                    {name : 'mpsrno', type: 'String'  },
						{name : 'pdesc', type: 'String'  },
						{name : 'brandname', type: 'String'  },
						{name : 'category', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						{name : 'pdesc', type: 'String'  },
						{name : 'department', type: 'String'  },
						{name : 'deppsrno', type: 'String'  },
						{name : 'deppartno', type: 'String'  },
						{name : 'depproduct', type: 'String'  },
						],  
				    localdata: bomdata,            
            
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
   /*  var cellclassname = function (row, column, value, data) {
		 if (data.confirm ==1) {          
            return "yellowClass";
        }
    }; */

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
   
   
    $("#jqxviewGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,
        enabletooltips:true,                          
        pagermode: 'default',   
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,       
                      groupable: false, draggable: false, resizable: false,    
                      datafield: 'sl', columntype: 'number', width: '4%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";   
                      }  
                    },
                   { text: 'Psrno', datafield: 'psrno',  width: '5%'},
                   { text: 'Psrno', datafield: 'mpsrno',hidden:true},
	               { text: 'Product ID', datafield: 'pid',  width: '8%'},    
	               { text: 'Product Name', datafield: 'pdesc'}, 
	               { text: 'Unit', datafield: 'uom',  width: '3%'}, 
	               { text: 'Brand Name', datafield: 'brandname',  width: '10%'}, 
	               { text: 'Category', datafield: 'category',  width: '10%'},
	               { text: 'Sub Category', datafield: 'subcategory',  width: '10%'},
	               { text: 'Department', datafield: 'department',  width: '5%'},
	               { text: 'Psrno', datafield: 'deppsrno',  width: '5%'},
	               { text: 'Product ID', datafield: 'deppartno',  width: '5%'},
	               { text: 'Product Name', datafield: 'depproduct'},
			   ]   		 
    });     
    $("#overlay, #PleaseWait").hide();   
      
});
</script>
<div id="jqxviewGrid"></div>