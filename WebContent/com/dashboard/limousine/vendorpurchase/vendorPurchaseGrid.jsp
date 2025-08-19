<%@ page import="com.dashboard.limousine.vendorpurchase.*" %>  
<%
	ClsLimoVendorPurchaseDAO DAO=new ClsLimoVendorPurchaseDAO();
   	String id = request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
	var data=[];
 	var id='<%=id%>';
	if(id=="1"){
 		data='<%=DAO.getVendorPurchaseData(id)%>';
 	}
	$(document).ready(function () {             
	    var source = 
	    {
	    	datatype: "json",    
	        datafields: [
		    	{name : 'doc_no', type: 'String'  },
		        {name : 'voc_no', type: 'String'  },
		      	{name : 'date', type: 'date'},
		      	{name : 'acno', type: 'String'  },
		      	{name : 'account', type: 'String'  },
		      	{name : 'refname', type: 'string'  },
		      	{name : 'vendornetamount', type: 'number'  },
		 		{name : 'description', type: 'String'  },
		 		{name : 'vendorid',type:'string'}
			],
	        localdata: data,  
	        pager: function (pagenum, pagesize, oldpagenum) {
	        }
		};
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    {
	    	loadError: function (xhr, status, error) {
		    	alert(error);    
		    }
		});
	    $("#vendorPurchaseGrid").jqxGrid(
	    { 
	    	width: '100%',
	        height: 260,  
	        source: dataAdapter,
	        showaggregates:true,
	        enableAnimations: true,
	        filtermode:'excel',
	        filterable: true,
	        showfilterrow: true,
	        sortable:true,
	        selectionmode: 'singlerow',
	        columns: [
	        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
					groupable: false, draggable: false, resizable: false,
					datafield: 'sl', columntype: 'number', width: '3%',
					cellsrenderer: function (row, column, value) {
						return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}  
				},
	            { text: 'Doc No', datafield: 'voc_no', width: '5%'},
				{ text: 'Doc No Original', datafield: 'doc_no', width: '4%',hidden:true},
				{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},                   
				{ text: 'Acc.No', datafield: 'account', width: '5%'},
				{ text: 'Acc.No Original', datafield: 'acno', width: '5%',hidden:true},
				{ text: 'Vendor', datafield: 'refname'},
				{ text: 'Vendor Id', datafield: 'vendorid',width:'10%',hidden:true},
				{ text: 'Description', datafield: 'desc1', width: '25%' }, 
				{ text: 'Net Amount', datafield: 'vendornetamount', width: '7%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right' },                          
			]       
		});   
	    $('#vendorPurchaseGrid').on('rowdoubleclick', function (event) {     
			var datafield = event.args.datafield;      
	  		var rowindex = event.args.rowindex;
	  		var vendorid=$('#vendorPurchaseGrid').jqxGrid('getcellvalue',rowindex, "vendorid");
	  		$('#vendorid').val(vendorid);
	        $("#vendorpurchasedetaildiv").load("vendorPurchaseDetailsGrid.jsp?vendorid="+vendorid+"&id=1");
		}); 
	});      
</script>
<div id="vendorPurchaseGrid"></div>         