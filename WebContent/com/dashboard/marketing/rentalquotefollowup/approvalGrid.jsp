<%@page import="com.dashboard.marketing.rentalquotefollowup.*"%>
<%ClsRentalQuoteFollowupDAO dao=new ClsRentalQuoteFollowupDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var approvaldata=[];
var id='<%=id%>';
if(id=="1"){
	approvaldata='<%=dao.getPreApprovalData(docno, id)%>';
}	
	$(document).ready(function () {
    	// prepare the data
    	var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'grpid' , type: 'String' },
				{name : 'code', type: 'string'  },
				{name : 'flname', type: 'String'    },
				{name : 'fleet_no', type: 'String'},
				{name : 'qty', type: 'string'    },
				{name : 'tarifdocno', type: 'string'    },
				{name : 'rate', type: 'number'    },
				{name : 'itemcount', type: 'number'    },
				{name : 'calcdocno', type: 'number'    },
				{name : 'subcatid', type: 'number'    },
				
			],
			localdata: approvaldata,
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
		
		$("#approvalGrid").jqxGrid(
        {
        	width: '100%',
            height: 250,
            source: dataAdapter,
            columnsresize: true,
            editable: true,
            enabletooltips:true,
            selectionmode: 'singlecell',
            //pagermode: 'default',
                
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
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
				{ text: 'Code', datafield: 'code', width: '20%' },
				{ text: 'Description', datafield: 'flname',width:'62%' },
				{ text: 'Equip No', datafield: 'fleet_no', width: '10%' },
				{ text: 'Group Id', datafield: 'grpid', width: '11%',hidden:true},
				{ text: 'Qty', datafield: 'qty', width: '5%' ,hidden:true},
				{ text: 'Rate per Qty', datafield: 'rate', width: '16%',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true },
				{ text: 'Tariff Doc No', datafield: 'tarifdocno', width: '16%',hidden:true },
				{ text: 'Calc Doc No', datafield: 'calcdocno', width: '16%',hidden:true },
				{ text: 'Sub Category Id', datafield: 'subcatid', width: '16%',hidden:true },
				
			]
        });
        
		$("#approvalGrid").on("celldoubleclick", function (event)
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
			
			$('#fleetindex').val(rowBoundIndex);
		
			if(dataField=="fleet_no"){
				$('#equipSearchGrid').jqxGrid('clear');
				$('#approvalGrid').jqxGrid('clearselection');
				$('#approvalGrid').jqxGrid('render');
				$('#modalequip').modal('show'); 
			}	
		});
	});
</script>
<div id="approvalGrid"></div>
<input type="hidden" class="form-control" id="fleetindex" name="fleetindex">
