<%@ page import="com.dashboard.invoices.clientwiseinvoicedetails.*" %>
<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
// String rentaltype = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
// String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 //String cmbtariftype = request.getParameter("cmbtariftype")==null?"":request.getParameter("cmbtariftype").trim();
 // String clstatuss = request.getParameter("clstatuss")==null?"0":request.getParameter("clstatuss").trim();

  ClientWiseInvoiceDetailDAO cild=new ClientWiseInvoiceDetailDAO();
  
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var temp4='<%=branchval%>';
//alert(temp4);
var invoicedata;
var invoiceexceldata;
if(temp4!='NA')
{ 

  	invoiceexceldata='<%=cild.invoicelistExcel(branchval,fromDate,toDate,cldocno)%>';    
	  invoicedata='<%=cild.invoicelist(branchval,fromDate,toDate,cldocno)%>';


}
else
{
     invoiceexceldata;
	invoicedata;
	
	} 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      {name : 'fleet_no' , type: 'string' },
                  		{name : 'pono' , type: 'int' },
						{name : 'description', type: 'String'  },
						{name : 'agmtno', type: 'String'    },
						{name : 'client', type: 'String'  },
						
						{name : 'rentalinvno', type: 'number'  },
						{name : 'rentaldate', type: 'date'  },
						{name : 'rentamt', type: 'number'  },
						{name : 'renttax', type: 'number'  },
						{name : 'renttotal', type: 'number'  },
						{name : 'salikdate', type: 'date'  },
						{name : 'salikinvno',type:'number'},
						{name :'salikamt',type:'number'},
						{name :'saliktax',type:'number'},
						{name :'saliktotal',type:'number'},
						{name :'trafficdate',type:'date'},
						{name :'trafficinvno',type:'number'},
						{name : 'trafficamt',type:'number'},
						{name : 'traffictax', type: 'number'  },

						{name :'traffictotal',type:'number'},
						{name :'insrdate',type:'date'},
						{name :'insrinvno',type:'number'},
						{name :'insramt',type:'number'},
						{name : 'insrtax',type:'number'},
						{name : 'insrtotal',type:'number'},
						{name : 'damagedate',type:'date'},
						{name : 'damageinvno',type:'number'},
						{name : 'damageamount',type:'number'},
						{name : 'damagetax',type:'number'},
						{name : 'damagetotal',type:'number'},
						{name : 'branch', type: 'String'    },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'cldocno',type:'String'},
						
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.status)==7){
        	return "yellowClass"; 
        }
        else{
        	
        };
          }; 
          
          
          
          $('#detailInvoiceGrid').on('bindingcomplete', function (event) {
        	  
        	  
        var chk= $('#detailInvoiceGrid').jqxGrid('getcellvalue', 0,"chk") ;
        
        if(parseInt(chk)==1)
        	{
        	 $('#detailInvoiceGrid').jqxGrid('hidecolumn', 'vat');
        	}
        	  
        	  
        	    
                	 
        	  
        	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailInvoiceGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,

        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
					    groupable: false, draggable: false, resizable: false,pinned:true,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
					  
					    { text: 'Client', datafield: 'client', width: '18%' , pinned:true},
					    { text: 'Agreement No', datafield: 'agmtno', width: '8%' ,pinned:true},
                        { text: 'Fleet No', datafield: 'fleet_no', width: '5%' ,pinned:true},
						{ text: 'PO No', datafield: 'pono', width: '5%',pinned:true},  						
      					{ text: 'Description', datafield: 'description', width: '18%',pinned:true},
						{ text: 'Invno', datafield: 'rentalinvno', width: '10%',columngroup:'Rental Invoices' },
						{ text: 'Date', datafield: 'rentaldate', width: '10%' , cellsformat:'dd.MM.yyyy',columngroup:'Rental Invoices',aggregates: ['sum1'],aggregatesrenderer:rendererstring1, },
						{ text: 'Amount', datafield: 'rentamt', width: '10%' ,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Rental Invoices',cellsalign:'right',align:'right'},
						{ text: 'Tax', datafield: 'renttax', width: '10%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Rental Invoices',cellsalign:'right',align:'right'},
						{ text: 'Total', datafield: 'renttotal', width: '10%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Rental Invoices',cellsalign:'right',align:'right'},
						{ text: 'Date', datafield: 'salikdate', width: '10%'  , cellsformat:'dd.MM.yyyy',columngroup:'Salik Invoices' },
						{ text: 'Invno', datafield: 'salikinvno', width: '10%' ,columngroup:'Salik Invoices'},
						{ text: 'Amount', datafield: 'salikamt', width: '10%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Salik Invoices',cellsalign:'right',align:'right'},
						{ text: 'Tax', datafield: 'saliktax', width: '10%',cellsformat:'d2',columngroup:'Salik Invoices',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Total', datafield: 'saliktotal', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,columngroup:'Salik Invoices'},
						{ text: 'Date', datafield: 'trafficdate', width: '10%',cellsformat:'dd.MM.yyyy',columngroup:'Traffic Invoices'},
						{ text: 'Invno', datafield: 'trafficinvno', width: '10%',cellsalign:'right',align:'right',columngroup:'Traffic Invoices'},
						{ text: 'Amount', datafield: 'trafficamt', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,columngroup:'Traffic Invoices'},
						{ text: 'Tax',datafield: 'traffictax', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Traffic Invoices'},
						{ text: 'Total',datafield: 'traffictotal', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup:'Traffic Invoices'},
						{ text: 'Date',datafield: 'insrdate', width: '10%',cellsformat:'dd.MM.yyyy',columngroup:'Insurence Excess'},
						{ text: 'Invno', datafield: 'insrinvno', width: '10%',columngroup:'Insurence Excess'},
						{ text: 'Amount', datafield: 'insramt', width: '10%',columngroup:'Insurence Excess',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						
			 			{ text: 'Tax', datafield: 'insrtax', width: '10%',columngroup:'Insurence Excess',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Total', datafield: 'insrtotal', width: '10%',columngroup:'Insurence Excess',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Date', datafield: 'damagedate', width: '10%',cellsformat:'dd.MM.yyyy',columngroup:'Damage And Repair Cost' },
						{ text: 'Invno', datafield: 'damageinvno', width: '10%',columngroup:'Damage And Repair Cost'},
						{ text: 'Amount', datafield: 'damageamount', width: '10%',columngroup:'Damage And Repair Cost',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Tax', datafield: 'damagetax', width: '10%',columngroup:'Damage And Repair Cost',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Total', datafield: 'damagetotal', width: '10%',columngroup:'Damage And Repair Cost',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsalign:'right',align:'right'},
						{ text: 'Branch', datafield: 'branch', width: '12%' ,hidden:true},
						{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy'  ,hidden:true},
						{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true  },
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true}
					],
    
    columngroups: 
		  [
		    { text: 'Rental Invoices', align: 'center', name: 'Rental Invoices',width: '20%' },
		    { text: 'Salik Invoices', align: 'center', name: 'Salik Invoices',width: '20%' },
		    { text: 'Traffic Invoices', align: 'center', name: 'Traffic Invoices',width: '20%' },
		    { text: 'Insurence Excess', align: 'center', name: 'Insurence Excess',width: '20%' },
		    { text: 'Damage And Repair Cost', align: 'center', name: 'Damage And Repair Cost',width: '20%' }
		    
		 
		  ]

    });

    $("#overlay, #PleaseWait").hide(); 
    var rows=$("#detailInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#detailInvoiceGrid").jqxGrid("addrow", null, {});	
    }
	var showfleet=$('#detailInvoiceGrid').jqxGrid('getcellvalue',0,'showfleet');
   	if(showfleet=="1"){
   		$('#detailInvoiceGrid').jqxGrid('setcolumnproperty', 'perfleet', 'hidden', false);
   	}
   	else{
   		$('#detailInvoiceGrid').jqxGrid('setcolumnproperty', 'perfleet', 'hidden', true);
   	}
});

	
	
</script>
<div id="detailInvoiceGrid"></div>