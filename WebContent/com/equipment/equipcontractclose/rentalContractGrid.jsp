<%@page import="com.equipment.equipcontractclose.*"%>
<%ClsEquipContractCloseDAO dao=new ClsEquipContractCloseDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
%>
<script type="text/javascript">
var contractdata=[];
var id='<%=id%>';
if(id=="1"){
	contractdata='<%=dao.getContractSaveData(docno, id)%>';
}	
else if(id=="2"){
	contractdata='<%=dao.getContractEquipData(contractdocno,id)%>';
}
	$(document).ready(function () {
    	// prepare the data
    	var source =
        {
        	datatype: "json",
            datafields: [
            	{name:'calcdocno',type:'string'},
            	{name:'fleet_no',type:'string'},
            	{name:'assetid',type:'string'},
            	{name:'flname',type:'string'},
            	{name:'startdate',type:'date'},
            	{name:'starttime',type:'date'},
            	{name:'enddate',type:'date'},
            	{name:'endtime',type:'date'},
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
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
				{ text: 'Code', datafield: 'code', width: '8%',editable:false,hidden:true },
				{ text: 'Code', datafield: 'subcatid', width: '8%',hidden:true },
				{ text: 'Fleet No', datafield: 'fleet_no', width: '8%'},
				{ text: 'AssetId', datafield: 'assetid', width: '8%'},
				{ text: 'Description', datafield: 'flname'},
				{ text: 'Start Date', datafield: 'startdate',columntype:'datetimeinput',cellsformat:'dd.MM.yyyy',width: '8%',editable:false},
				{ text: 'Start Time', datafield: 'starttime',columntype:'datetimeinput',cellsformat:'HH:mm',width: '8%',editable:false},
				
				
				
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
		    
		    if(datafield=="qty" || datafield=="rate"){
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
		    	if(qty!="" && qty!="undefined" && qty!=null && typeof(qty)!="undefined" && rate!="" && rate!="undefined" && rate!=null && typeof(rate)!="undefined"){
		    		var subtotal=parseFloat(qty)*parseFloat(rate);
		    		subtotal=subtotal.toFixed(2);
		    		$('#rentalContractGrid').jqxGrid('setcellvalue',rowBoundIndex,'subtotal',subtotal);
		    	}
		    }
		});
	});
</script>
<div id="rentalContractGrid"></div>
<input type="hidden" name="gridindex" id="gridindex"> 
<input type="hidden" name="gridlength" id="gridlength">