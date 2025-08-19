<%@page import="com.operations.marketing.rentalquote.*"%>
<%ClsRentalQuoteDAO dao=new ClsRentalQuoteDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var quotedata=[];
var id='<%=id%>';
if(id=="1"){
	quotedata='<%=dao.getQuoteData(docno, id)%>'
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
				{name : 'tarifdocno', type: 'string'    },
				{name : 'rate', type: 'number'    },
				{name : 'hiremode', type: 'string'},
				{name : 'subtotal', type: 'number'},
				{name : 'discount', type: 'number'},
				{name : 'maxdiscount', type: 'number'},
				{name : 'total', type: 'number'},
				{name : 'vatperc', type: 'number'},
				{name : 'vatamt', type: 'number'},
				{name : 'nettotal', type: 'number'},
			],
			localdata: quotedata,
            pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
            }
		};
            
        var dataAdapter = new $.jqx.dataAdapter(source,
        {
        	loadError: function (xhr, status, error) {
	        	alert(error);    
	        }
			            
		});
		var dropdownListSource=['Daily', 'Weekly', 'Monthly'];
		$("#rentalQuoteGrid").jqxGrid(
        {
        	width: '100%',
            height: 300,
            source: dataAdapter,
            columnsresize: true,
            editable: true,
            enabletooltips:true,
            selectionmode: 'singlecell',
            //pagermode: 'default',
            showaggregates:true,
            showstatusbar:true,    
            //Add row method
            handlekeyboardnavigation: function (event) {
                /*var cell = $('#jqxgridquote').jqxGrid('getselectedcell');
                if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 13) {                                                        
                        var commit = $("#jqxgridquote").jqxGrid('addrow', null, {});
                        num++;                           
                    }
                }*/
            },
                
            columns: [
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
				{ text: 'Code', datafield: 'code', width: '8%' },
				{ text: 'Code', datafield: 'subcatid', width: '8%',hidden:true },
				{ text: 'Description', datafield: 'flname',width:'32%' },
				{ text: 'Fleet No', datafield: 'fleet_no', width: '11%',hidden:true },
				{ text: 'Hire Mode', datafield: 'hiremode', width: '6%',columntype:'dropdownlist',initeditor: function (row, cellvalue, editor) {editor.jqxDropDownList({ source: dropdownListSource});} },
				{ text: 'Group Id', datafield: 'grpid', width: '11%',hidden:true },
				{ text: 'Qty', datafield: 'qty', width: '5%' },
				{ text: 'Rate per Qty', datafield: 'rate', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false },
				{ text: 'Sub Total', datafield: 'subtotal', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
				{ text: 'Discount', datafield: 'discount', width: '7%' ,align:'right',cellsalign:'right',aggregates:['sum']},
				{ text: 'Total', datafield: 'total', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
				{ text: 'VAT%', datafield: 'vatperc', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false },
				{ text: 'VAT Amt', datafield: 'vatamt', width: '6%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
				{ text: 'Net Total', datafield: 'nettotal', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false,aggregates:['sum'] },
				{ text: 'Max Discount', datafield: 'maxdiscount', width: '16%',hidden:true },
				{ text: 'Tariff Doc No', datafield: 'tarifdocno', width: '16%',hidden:true },
				
			]
        });
        
        $("#rentalQuoteGrid").on("celldoubleclick", function (event)
		{
		    // event arguments.
		    var args = event.args;
		    // row's bound index.
		    var rowBoundIndex = args.rowindex;
		    // row's visible index.
		    var rowVisibleIndex = args.visibleindex;
		    // right click.
		    var rightClick = args.rightclick; 
		    // original event.
		    var ev = args.originalEvent;
		    // column index.
		    var columnIndex = args.columnindex;
		    // column data field.
		    var dataField = args.datafield;
		    // cell value
		    var value = args.value;
		    
		    if($('#mode').val()=='A' || $('#mode').val()=='E'){
		    	if(dataField=="code"){
		    		$('#equipwindow').jqxWindow('open');
		    		$('#gridindex').val(rowBoundIndex);
					innerWindowSearchContent('equipMasterSearch.jsp?id=1','equipwindow'); 
		    	}
		    	if(dataField=="rate"){
		    		var grpid=$('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'grpid');
		    		var cldocno=$('#cldocno').val();
		    		var rentaltype=$('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'hiremode');
		    		if(grpid=="" || grpid=="undefined" || grpid==null || typeof(grpid)=="undefined"){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Please select equipment";
		    			return false;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		if(cldocno=="" || cldocno=="undefined" || cldocno==null || typeof(cldocno)=="undefined" || cldocno=="0"){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Please select client";
		    			return false;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		if(rentaltype=="" || rentaltype=="undefined" || rentaltype==null || typeof(rentaltype)=="undefined" || rentaltype=="0"){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Please select Hire mode";
		    			return false;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		$('#tariffwindow').jqxWindow('open');
		    		$('#gridindex').val(rowBoundIndex);
		    		var branch=$('#brchName').val();
					innerWindowSearchContent('tariffSearchGrid.jsp?grpid='+grpid+'&branch='+branch+'&cldocno='+cldocno+'&id=1&rentaltype='+rentaltype,'tariffwindow'); 
		    	}
		    }
		    
		});
        
        $("#rentalQuoteGrid").on('cellvaluechanged', function (event) 
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
		    
		    if(datafield=="qty" || datafield=="rate" || datafield=="discount"){
		    	var qty=$('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
		    	var rate=$('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'rate');
		    	var discount=parseFloat($('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'discount'));
				var maxdiscount=parseFloat($('#rentalQuoteGrid').jqxGrid('getcellvalue',rowBoundIndex,'maxdiscount'));
		    	var vatperc=parseFloat($('#hidtaxperc').val());		    	
		    	
		    	if(qty!="" && qty!="undefined" && qty!=null && typeof(qty)!="undefined" && rate!="" && rate!="undefined" && rate!=null && typeof(rate)!="undefined"){
		    		var subtotal=parseFloat(qty)*parseFloat(rate);
		    		subtotal=subtotal.toFixed(2);
		    				    		
		    	    discount=isNaN(discount)? 0 : discount;
		    
		    	    if(discount>maxdiscount){
		    	    	discount=maxdiscount
		    	    	$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'discount',discount);
		    	    }
		    	    
		    		var afterdisc = (subtotal - discount).toFixed(2);
			   		var vatamt = (parseFloat(afterdisc)*(vatperc/100)).toFixed(2);
			   		var nettotal = (parseFloat(afterdisc) + parseFloat(vatamt)).toFixed(2);
			    
		    		$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'subtotal',subtotal);
		    		$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'total',afterdisc);
		    		$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatperc',vatperc);
		    		$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatamt',vatamt);
		    		$('#rentalQuoteGrid').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',nettotal);
		    	}
		    }
		});
	});
	
</script>
<div id="rentalQuoteGrid"></div>
<input type="hidden" name="gridindex" id="gridindex"> 
<input type="hidden" name="gridlength" id="gridlength">