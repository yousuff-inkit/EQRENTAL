<%@page import="com.dashboard.marketing.contractmgmt.ClsContractMgmtDAO"%>
<%ClsContractMgmtDAO DAO=new ClsContractMgmtDAO();
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%> 
           	  
<script type="text/javascript">
var id='<%=id%>';
var followupdata=[];
if(id=='1')
{ 
	followupdata='<%=DAO.getContractDetailData(docno,id)%>';
} 

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
        	
        	{name : 'grpid' , type: 'String' },
			{name : 'code', type: 'string'  },
			{name : 'subcatid', type: 'string'  },
			{name : 'flname', type: 'string'    },
			{name : 'fleet_no', type: 'string'    },
			{name : 'qty', type: 'string'    },
			{name : 'quoteqty', type: 'String'    },
			{name : 'tarifdocno', type: 'string'    },
			{name : 'rate', type: 'number'    },
			{name : 'hiremode', type: 'string'    },
			{name : 'subtotal', type: 'number'    },
			{name : 'detaildocno', type: 'number'    },
			{name : 'discount', type: 'number'},
			{name : 'maxdiscount', type: 'number'},
			{name : 'total', type: 'number'},
			{name : 'vatperc', type: 'number'},
			{name : 'vatamt', type: 'number'},
			{name : 'nettotal', type: 'number'},				
						],
				    localdata: followupdata,
        
        
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
    
	var dropdownListSource=['Daily', 'Weekly', 'Monthly'];
    
    $("#contractMgmtDetailGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:true,
        columns: [   
                 
        	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
                return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
         		}   
			},
			{ text: 'Code', datafield: 'code', width: '8%',editable:false },
			{ text: 'Code', datafield: 'subcatid', width: '8%',hidden:true },

			{ text: 'Description', datafield: 'flname',width:'36%',editable:false },
			{ text: 'Fleet No', datafield: 'fleet_no', width: '11%',hidden:true },
			{ text: 'Hire Mode', hidden:true,datafield: 'hiremode', width: '16%',columntype:'dropdownlist',initeditor: function (row, cellvalue, editor) {
       			editor.jqxDropDownList({ source: dropdownListSource});
   			} },
			{ text: 'Group Id', datafield: 'grpid', width: '11%',hidden:true },
			{ text: 'Qty', datafield: 'qty', width: '5%',editable:false },
			{ text: 'Quote Qty', datafield: 'quoteqty', width: '5%',hidden:true },
			{ text: 'Rate per Qty', datafield: 'rate', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2' },
			{ text: 'Sub Total', datafield: 'subtotal', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates:['sum'],editable:false},
			{ text: 'Discount', datafield: 'discount', width: '7%' ,align:'right',cellsalign:'right',aggregates:['sum']},
			{ text: 'Total', datafield: 'total', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
			{ text: 'VAT%', datafield: 'vatperc', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false },
			{ text: 'VAT Amt', datafield: 'vatamt', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
			{ text: 'Net Total', datafield: 'nettotal', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
			{ text: 'Max Discount', datafield: 'maxdiscount', width: '16%',hidden:true },
			{ text: 'Tariff Doc No', datafield: 'tarifdocno', width: '16%',hidden:true },
			{ text: 'Detail Doc No', datafield: 'detaildocno', width: '16%',hidden:true },
					 
				]
    });
    
    $("#contractMgmtDetailGrid").on('cellvaluechanged', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // column data field.
    		    var datafield = event.args.datafield;
    		    // row's bound index.
    		    var rowBoundIndex = args.rowindex;
    		    // new cell value.
    		    var value = args.newvalue;
    		    // old cell value.
    		    var oldvalue = args.oldvalue;
    		    
    		    if(datafield=="rate" || datafield=="discount"){
    		    	
    		    	var qty=$('#contractMgmtDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
    		    	var rate=$('#contractMgmtDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'rate');
    		    	var discount=parseFloat($('#contractMgmtDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'discount'));
    				var maxdiscount=parseFloat($('#contractMgmtDetailGrid').jqxGrid('getcellvalue',rowBoundIndex,'maxdiscount'));
    		    	var vatperc=parseFloat($('#hidtaxperc').val());		    	
    		    	
    		    	if(qty!="" && qty!="undefined" && qty!=null && typeof(qty)!="undefined" && rate!="" && rate!="undefined" && rate!=null && typeof(rate)!="undefined"){
    		    		var subtotal=parseFloat(qty)*parseFloat(rate);
    		    		subtotal=subtotal.toFixed(2);
    		    		
    		    		discount=isNaN(discount)? 0 : discount;
    		 		    
    			   		if(discount>maxdiscount){
    			    	  	discount=maxdiscount
    			    	   	$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'discount',discount);
    			    	}
    			    	    
    			    	var afterdisc = (subtotal - discount).toFixed(2);
    			   		var vatamt = (parseFloat(afterdisc)*(vatperc/100)).toFixed(2);
    			   		var nettotal = (parseFloat(afterdisc) + parseFloat(vatamt)).toFixed(2);
    			    
    		    		$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'subtotal',subtotal);
    		    		$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'total',afterdisc);
    		    		$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatperc',vatperc);
    		    		$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatamt',vatamt);
    		    		$('#contractMgmtDetailGrid').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',nettotal);
    		    	}
    		    }
    		});
});

</script>
<div id="contractMgmtDetailGrid"></div>