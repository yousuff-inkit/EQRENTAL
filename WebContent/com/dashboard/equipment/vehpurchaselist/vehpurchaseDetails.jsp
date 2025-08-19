<%@page import="com.dashboard.equipment.vehpurchaselist.ClsvehpurchaselistDAO " %>
<%ClsvehpurchaselistDAO  cpd=new ClsvehpurchaselistDAO (); %>
<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
ClsvehpurchaselistDAO  pdao=new ClsvehpurchaselistDAO ();
%>

<script type="text/javascript">   
var vahreqdata; 
   $(document).ready(function () { 	
	   
	   vahreqdata='<%=cpd.gridsearchrelode(branch,fromdate, temp,todate)%>';           
	   
       var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	if(typeof(value)=="undefined" || typeof(value)=="NaN" || value==null){
       		value=0;
       	}
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
       } 
       var rendererstring1=function (aggregates){
          	var value=aggregates['sum1'];
          	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
          }      
    // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'regno',type:'string'},
                	        {name : 'voc_no',type:'string'},
	                        {name : 'date',type:'date'},
	                        {name : 'vendor',type:'string'},
     						{name : 'brand', type: 'string'  },
     						{name : 'model', type: 'string'   },
     						{name : 'color', type: 'string'   },
     						{name : 'prch_cost',type:'number'},
     				      	{ name: 'addicost', type: 'number' },  
     				     	{ name: 'price', type: 'number' },  
     						{name : 'chaseno', type: 'string'   },
     						{name : 'enginno', type: 'string'   },
     						{name : 'fleet_no', type: 'string'   },
     						{name : 'puchdate', type: 'string'   }
     						
                 ],
                 localdata: vahreqdata,
                
                
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
            
            $("#vehpurchasedirgrid").jqxGrid(
            {
            	width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                showfilterrow:true,
                filterable: true,
                editable: true,
               //disabled:true,
               localization: {thousandsSeparator: ""},
                statusbarheight: 20,
                selectionmode: 'singlecell',
                pagermode: 'default',

                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                              }  
                            },
                            { text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
                 			{ text: 'Doc No',datafield:'voc_no',width:'7%'},
                 			{ text: 'Vendor',datafield:'vendor',width:'20%'},
                        	{ text: 'Fleet', datafield: 'fleet_no', width: '9%',editable: false},
                        	{ text: 'Regno', datafield: 'regno', width: '9%',editable: false},
							{ text: 'Brand', datafield: 'brand', width: '10%',editable: false},	
							{ text: 'Model', datafield: 'model', width: '13%',editable: false},
							{ text: 'Color', datafield: 'color', width: '9%' },
							{ text: 'Chassis No', datafield: 'chaseno', width: '10%', }, 
							{ text: 'Engine No', datafield: 'enginno', width: '10%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Purchase Cost', datafield: 'prch_cost', width: '10%' ,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						    { text: 'Additional Cost', datafield: 'addicost', width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Price', datafield: 'price', width: '10%' ,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Puchdate', datafield: 'puchdate', width: '10%',hidden:true }
				              ]
              
   });
   
           
            $("#overlay, #PleaseWait").hide();
          
        });
   
   
   
  
    
    </script>
    
     
       
    <div id="vehpurchasedirgrid"></div>
    