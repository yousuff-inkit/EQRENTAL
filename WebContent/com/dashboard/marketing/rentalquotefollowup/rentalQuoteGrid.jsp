<%@page import="com.dashboard.marketing.rentalquotefollowup.*"%>
<%ClsRentalQuoteFollowupDAO dao=new ClsRentalQuoteFollowupDAO();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var quotedata=[];
var id='<%=id%>';
if(id=="1"){

	quotedata='<%=dao.getQuoteData(id,brhid,fromdate,todate)%>'
}	
	$(document).ready(function () {
    	// prepare the data
    	var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'docno' , type: 'number' },
            	{name : 'branchname' , type: 'string' },
				{name : 'vocno', type: 'number'  },
				{name : 'date', type: 'date'    },
				{name : 'refname', type: 'string'    },
				{name : 'description', type: 'string'    },
				{name : 'contactperson', type: 'string'    },
				{name : 'contactnumber', type: 'string'    },
				{name : 'salesman', type: 'string'    },
				{name : 'processstatus', type: 'string'    },
			//	{name : 'rate', type: 'number'    },
				{name : 'brhid', type: 'number'    },
				{name : 'strprocess',type:'string'},
				{name : 'delcharges', type: 'number'    },
				{name : 'collcharges', type: 'number'    },
				{name : 'vatamt', type: 'number'    },
				{name : 'totalamt', type: 'number'    },
				{name : 'nettotal', type: 'number'    },
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
		
        $("#rentalQuoteGrid").on("bindingcomplete", function (event) {
        	$("#overlay, #PleaseWait").hide();
        });        
        
        
		$("#rentalQuoteGrid").jqxGrid(
        {
        	width: '100%',
            height: 300,
            source: dataAdapter,
            columnsresize: true,
            editable: false,
            enabletooltips:true,
            filterable:true,
            showfilterrow:true,
            enabletooltips:true,
            selectionmode: 'singlerow',
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
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
				{ text: 'Doc No Original', datafield: 'docno', width: '8%',hidden:true },
				{ text: 'Doc No', datafield: 'vocno', width: '4%'},
				{ text: 'Branch', datafield: 'branchname', width: '13%'},
				{ text: 'Date', datafield: 'date',cellsformat:'dd.MM.yyyy',width:'5%' },
				{ text: 'Status',datafield:'strprocess',width:'9%'},
				{ text: 'Client Name', datafield: 'refname', width: '13%'},
				{ text: 'Contact Person', datafield: 'contactperson', width: '7%'},
				{ text: 'Contact Number', datafield: 'contactnumber', width: '6%'},
				{ text: 'Salesman', datafield: 'salesman', width: '6%'},
				{ text: 'Process Status', datafield: 'processstatus', width: '11%',hidden:true},
				{ text: 'Branch Id', datafield: 'brhid', width: '11%',hidden:true},
				{ text: 'Description', datafield: 'description',width:'10%'},
				{ text: 'Delivery', datafield: 'delcharges', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2'},
				{ text: 'Collection', datafield: 'collcharges', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2'},
				{ text: 'VAT', datafield: 'vatamt', width: '4%',align:'right',cellsalign:'right',cellsformat:'d2'},
				{ text: 'Total', datafield: 'totalamt', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2'},
				{ text: 'Value', datafield: 'nettotal', width: '5%',align:'right',cellsalign:'right',cellsformat:'d2'},
				//{ text: 'Rate per Qty', datafield: 'rate', width: '8%',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true },
				
			]
        });
        
        $("#rentalQuoteGrid").on("rowdoubleclick", function (event)
		{
		    var args = event.args;
		    // row's bound index.
		    var boundIndex = args.rowindex;
		    // row's visible index.
		    var visibleIndex = args.visibleindex;
		    // right click.
		    var rightclick = args.rightclick; 
		    // original event.
		    var ev = args.originalEvent;
		    $('#gridindex').val(boundIndex);
		    $('#docno').val($('#rentalQuoteGrid').jqxGrid('getcellvalue',boundIndex,'docno'));
		    $('#vocno').val($('#rentalQuoteGrid').jqxGrid('getcellvalue',boundIndex,'vocno'));
		    var docno=$('#docno').val();
		    $('#rentalquotefollowupdiv').load('rentalQuoteFollowupGrid.jsp?docno='+docno+'&id=1');
		    $('#approvaldiv').load('approvalGrid.jsp?docno='+docno+'&id=1');
		});
        
	});
</script>
<div id="rentalQuoteGrid"></div>
<input type="hidden" name="gridindex" id="gridindex"> 
<input type="hidden" name="docno" id="docno">
<input type="hidden" name="vocno" id="vocno">