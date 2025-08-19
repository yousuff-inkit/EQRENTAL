<%@page import="com.operations.marketing.rentalcontract.*"%>
<%ClsRentalContractDAO dao=new ClsRentalContractDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String quoteno=request.getParameter("quoteno")==null?"":request.getParameter("quoteno");
String hiremode=request.getParameter("hiremode")==null?"":request.getParameter("hiremode");
%>
<script type="text/javascript">
var contractdata=[];
var id='<%=id%>';
if(id=="1"){
	contractdata='<%=dao.getQuoteSaveData(docno, id)%>';
}	
else if(id=="2"){
	contractdata='<%=dao.getRefQuoteData(session,quoteno,hiremode,id)%>';
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
			localdata: contractdata,
            pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
            }
		};
        $("#rentalContractGrid").on("bindingcomplete", function (event) {
			if($('#mode').val()=='A' || $('#mode').val()=='E' || ($('#mode').val()=='view' && $('#docno').val()!='')){
				$('#rentalContractGrid').jqxGrid('selectallrows');
			}
        });
        var dataAdapter = new $.jqx.dataAdapter(source,
        {
        	loadError: function (xhr, status, error) {
	        	alert(error);    
	        }
			            
		});
		var dropdownListSource=['Daily', 'Weekly', 'Monthly'];
		$("#rentalContractGrid").jqxGrid(
        {
        	width: '100%',
            height: 300,
            source: dataAdapter,
            columnsresize: true,
            editable: true,
            enabletooltips:true,
            selectionmode: 'checkbox',
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
				{ text: 'Code', datafield: 'code', width: '8%',editable:false },
				{ text: 'Code', datafield: 'subcatid', width: '8%',hidden:true },
				
				{ text: 'Description', datafield: 'flname',width:'34.7%' },
				{ text: 'Fleet No', datafield: 'fleet_no', width: '11%',hidden:true },
				{ text: 'Hire Mode', hidden:true,datafield: 'hiremode', width: '16%',columntype:'dropdownlist',initeditor: function (row, cellvalue, editor) {
                          editor.jqxDropDownList({ source: dropdownListSource});
                      } },
				{ text: 'Group Id', datafield: 'grpid', width: '11%',hidden:true },
				{ text: 'Qty', datafield: 'qty', width: '5%' },
				{ text: 'Quote Qty', datafield: 'quoteqty', width: '5%',hidden:true },
				{ text: 'Rate per Qty', datafield: 'rate', width: '7%',align:'right',cellsalign:'right',cellsformat:'d2',editable:false },
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
        
        $("#rentalContractGrid").on("celldoubleclick", function (event)
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
		    
		    if(($('#mode').val()=='A' || $('#mode').val()=='E') && $('#cmbreftype').val()=='DIR'){
		    	
		    	if(dataField=="flname" || dataField=="code"){
		    		$('#equipwindow').jqxWindow('open');
		    		$('#gridindex').val(rowBoundIndex);
					innerWindowSearchContent('equipMasterSearch.jsp?id=1','equipwindow'); 
		    	}
		    	if(dataField=="rate"){
		    		var grpid=$('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'grpid');
		    		var cldocno=$('#cldocno').val();
		    		var rentaltype=$('#cmbhiremode').val();
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
        
        $("#rentalContractGrid").on('cellvaluechanged', function (event) 
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
		    	if($('#cmbreftype').val()=='QOT'){
		    		var quoteqty=$('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'quoteqty');
		    		var qty=$('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
		    		
		    		if(quoteqty=="" || quoteqty=="undefined" || quoteqty==null || typeof(quoteqty)=="undefined"){
		    			quoteqty="0";
		    		}
		    		if(qty=="" || qty=="undefined" || qty==null || typeof(qty)=="undefined"){
		    			qty="0";
		    		}
		    		if(parseInt(qty)>parseInt(quoteqty)){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Qty cannot be higher than quoted qty";
		    			return false;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    	}
		    	var qty=$('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
		    	var rate=$('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'rate');
		    	var discount=parseFloat($('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'discount'));
				var maxdiscount=parseFloat($('#rentalContractGrid').jqxGrid('getcellvalue',rowBoundIndex,'maxdiscount'));
		    	var vatperc=parseFloat($('#hidtaxperc').val());		    	
		    	
		    	
		    	if(qty!="" && qty!="undefined" && qty!=null && typeof(qty)!="undefined" && rate!="" && rate!="undefined" && rate!=null && typeof(rate)!="undefined"){
		    		var subtotal=parseFloat(qty)*parseFloat(rate);
		    		subtotal=subtotal.toFixed(2);
		    		
		    		discount=isNaN(discount)? 0 : discount;
		 		    
			   		if(discount>maxdiscount){
			    	  	discount=maxdiscount
			    	   	$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'discount',discount);
			    	}
			    	    
			    	var afterdisc = (subtotal - discount).toFixed(2);
			   		var vatamt = (parseFloat(afterdisc)*(vatperc/100)).toFixed(2);
			   		var nettotal = (parseFloat(afterdisc) + parseFloat(vatamt)).toFixed(2);
			    
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'subtotal',subtotal);
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'total',afterdisc);
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatperc',vatperc);
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'vatamt',vatamt);
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',nettotal);
		    	}
		    }
		});
	});
</script>
<div id="rentalContractGrid"></div>
<input type="hidden" name="gridindex" id="gridindex"> 
<input type="hidden" name="gridlength" id="gridlength">