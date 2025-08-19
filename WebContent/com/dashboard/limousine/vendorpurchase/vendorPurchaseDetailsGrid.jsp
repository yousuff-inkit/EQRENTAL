<%@ page import="com.dashboard.limousine.vendorpurchase.*" %>  
<%ClsLimoVendorPurchaseDAO DAO=new ClsLimoVendorPurchaseDAO(); %>         
<%
String vendorid=request.getParameter("vendorid")==null || request.getParameter("vendorid")==""?"":request.getParameter("vendorid").trim();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"":request.getParameter("id").trim();
%>
<script type="text/javascript">  
	var detaildata=[];   
	var id='<%=id%>';
	if(id=="1"){
		detaildata='<%=DAO.getVendorPurchaseDetailData(vendorid,id)%>';
	}
	$(document).ready(function () { 	
		var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
		}
	               
	    // prepare the data
	    var source =
	    {
	    	datatype: "json",
	        datafields: [
	        	{name : 'pickupdate',type:'date'},
		        {name : 'pickuptime',type:'string'},
		        {name : 'pickuplocation',type:'string'},
		        {name : 'dropofflocation',type:'string'},
		        {name : 'bookdocno',type:'number'},
		        {name : 'bookvocno',type:'number'},
		        {name : 'docname',type:'string'},
		        {name : 'jobtype',type:'string'},
		        {name : 'vendoramountold',type:'number'},
		        {name : 'vendoramount',type:'number'},
		        {name : 'vendordiscount',type:'number'},
		        {name : 'vendornetamount',type:'number'},
		        {name : 'tax',type:'number'},
		        {name : 'vendortaxtotal',type:'number'}
			],              
	        localdata: detaildata,
	        pager: function (pagenum, pagesize, oldpagenum) {
	        	// callback called when a page or page size is changed.
	        }
		};
		$('#vendorPurchaseDetailsGrid').on('bindingcomplete', function (event) {
     		var vendortax=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',0,'tax');
			var chkinclusive=0;
			if(document.getElementById("chkinclusive").checked==true){
				chkinclusive=1;
			}
			else{
				chkinclusive=0;
			}
			var rows=$('#vendorPurchaseDetailsGrid').jqxGrid('getrows');
			if(vendortax==1){
				if(chkinclusive==1){
					for(var i=0;i<rows.length;i++){
						var vendornetamount=0.0;
						var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
						var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
						vendornetamount=vendoramount-vendordiscount;
						vendornetamount.toFixed(2);
						var finalamount=(vendornetamount/105)*100;
						finalamount.toFixed(2);
						var taxamount=vendornetamount-finalamount;
						taxamount.toFixed(2);
						var updatedvendoramount=0.0;
						updatedvendoramount=finalamount+vendordiscount;
						updatedvendoramount.toFixed(2);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',updatedvendoramount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',finalamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',taxamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',vendornetamount);
					}
				}
				else if(chkinclusive==0){
					for(var i=0;i<rows.length;i++){
						var vendornetamount=0.0;
						var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
						var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
						vendoramount.toFixed(2);
						vendordiscount.toFixed(2);
						vendornetamount=vendoramount-vendordiscount;
						vendornetamount.toFixed(2);
						var taxamount=vendornetamount*(5/100);
						taxamount.toFixed(2);
						var finalamount=vendornetamount+taxamount;
						finalamount.toFixed(2);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',vendoramount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',taxamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',vendornetamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',finalamount);
					}
				}
			}
			else{
				for(var i=0;i<rows.length;i++){
					var vendornetamount=0.0;
					var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
					var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
					vendornetamount=vendoramount-vendordiscount;
					vendornetamount.toFixed(2);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',vendoramount);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',vendornetamount);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',0.0);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',vendornetamount);
				}
			}
 		});
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    {
	    	loadError: function (xhr, status, error) {
		    	alert(error);    
		    }
		});
		
		$("#vendorPurchaseDetailsGrid").jqxGrid(
	    {
	    	width: '100%',
	        height: 302,
	        source: dataAdapter,
	        showaggregates:true,
	        showstatusbar:true,
	        editable: true,
	        columnsresize: true,
	        statusbarheight: 25,
	        selectionmode: 'checkbox',
	        columns: [
	        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
	            	groupable: false, draggable: false, resizable: false,
	                datafield: 'sl', columntype: 'number', width: '4%',
	                cellsrenderer: function (row, column, value) {
	                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                }  
	            },
	            { text: 'Type',datafield:'jobtype',width:'7%',editable:false},
				{ text: 'Booking # Original', datafield: 'bookdocno', width: '6%',editable:false,hidden: true},
				{ text: 'Booking #', datafield: 'bookvocno', width: '6%' ,editable: false},
				{ text: 'Job Name', datafield: 'docname', width: '5%',editable: false},
				{ text: 'Pickup Date', datafield: 'pickupdate', width: '8%',cellsformat:'dd.MM.yyyy',editable:false },
				{ text: 'Pickup Time', datafield: 'pickuptime', width: '6%',cellsformat:'HH:mm',editable:false },
				{ text: 'Pickup Location', datafield: 'pickuplocation', width: '15%',editable:false },
				{ text: 'Dropoff Location', datafield: 'dropofflocation', width: '16%',editable:false },
				{ text: 'Amount', datafield: 'vendoramountold', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',editable:false ,hidden:true },
				{ text: 'Amount', datafield: 'vendoramount', width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',editable:false  },
				{ text: 'Discount', datafield: 'vendordiscount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable: true},
				{ text: 'Net Total', datafield: 'vendornetamount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
				{ text: 'Tax', datafield: 'vendortaxamount', width: '6%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false},
				{ text: 'Grand Total', datafield: 'vendortaxtotal', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
			]   
		});
		$("#vendorPurchaseDetailsGrid").on('cellendedit', function (event) 
		{
		    // event arguments.
		    var args = event.args;
		    // column data field.
		    var dataField = event.args.datafield;
		    // row's bound index.
		    var rowBoundIndex = event.args.rowindex;
		    // cell value
		    var value = args.value;
		    // cell old value.
		    var oldvalue = args.oldvalue;
		    // row's data.
		    var rowData = args.row;
		    
		    var vendortax=$('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',0,'tax');
			var chkinclusive=0;
			if(document.getElementById("chkinclusive").checked==true){
				chkinclusive=1;
			}
			else{
				chkinclusive=0;
			}
			var rows=$('#vendorPurchaseDetailsGrid').jqxGrid('getrows');
			if(vendortax==1){
				if(chkinclusive==1){
					for(var i=0;i<rows.length;i++){
						var vendornetamount=0.0;
						var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
						var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
						vendornetamount=vendoramount-vendordiscount;
						vendornetamount.toFixed(2);
						var finalamount=(vendornetamount/105)*100;
						finalamount.toFixed(2);
						var taxamount=vendornetamount-finalamount;
						taxamount.toFixed(2);
						var updatedvendoramount=0.0;
						updatedvendoramount=finalamount+vendordiscount;
						updatedvendoramount.toFixed(2);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',updatedvendoramount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',finalamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',taxamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',vendornetamount);
					}
				}
				else if(chkinclusive==0){
					for(var i=0;i<rows.length;i++){
						var vendornetamount=0.0;
						var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
						var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
						vendoramount.toFixed(2);
						vendordiscount.toFixed(2);
						vendornetamount=vendoramount-vendordiscount;
						vendornetamount.toFixed(2);
						var taxamount=vendornetamount*(5/100);
						taxamount.toFixed(2);
						var finalamount=vendornetamount+taxamount;
						finalamount.toFixed(2);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',vendoramount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',taxamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',vendornetamount);
						$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',finalamount);
					}
				}
			}
			else{
				for(var i=0;i<rows.length;i++){
					var vendornetamount=0.0;
					var vendoramount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendoramountold'));
					var vendordiscount=parseFloat($('#vendorPurchaseDetailsGrid').jqxGrid('getcellvalue',i,'vendordiscount'));
					vendornetamount=vendoramount-vendordiscount;
					vendornetamount.toFixed(2);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendoramount',vendoramount);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendornetamount',vendornetamount);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxamount',0.0);
					$('#vendorPurchaseDetailsGrid').jqxGrid('setcellvalue',i,'vendortaxtotal',vendornetamount);
				}
			}
		});
	});          
</script>  
<div id="vendorPurchaseDetailsGrid"></div>