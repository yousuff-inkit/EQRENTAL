<%@page import="com.dashboard.equipment.delposting.*" %>
<%ClsDelPostingDAO dao = new ClsDelPostingDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String type=request.getParameter("type")==null?"":request.getParameter("type");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var type='<%=type%>';
var floordata=[];
if(id=="1"){
	floordata='<%=dao.getDelPostingData(id, brhid, type)%>';
}
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
	$(document).ready(function(){
		
        var source =
        {
            datatype: "json",
            datafields: [
						{name : 'contractdocno' , type: 'string'},
						{name : 'client' , type: 'string'},
                      	{name : 'vendor' , type: 'string'},
                      	{name : 'invno' , type: 'string'},
                      	{name : 'invdate' , type: 'date'},
						{name : 'gatepassno' , type: 'string'},
 						{name : 'amount', type: 'number'},
 						{name : 'vat', type: 'number'},
 						{name : 'netamt', type: 'number'},
 						{name : 'fleet' , type: 'string'},
 						{name : 'driver' , type: 'string'},
						{name : 'date', type: 'date'},
						{name : 'time' , type: 'string'},
						{name : 'km', type: 'number'},
						{name : 'fuel' , type: 'number'},
						{name : 'address' , type: 'string'},
						{name : 'remarks' , type: 'string'},
						{name : 'cpudocno' , type: 'string'},
						{name : 'vndid' , type: 'string'},
						{name : 'docno' , type: 'string'},
 					
             ],
             localdata: floordata,
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
        };
               
        
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    //selectionmode: 'checkbox',
                  	editable:false,
                    altrows:true,
                    sortable:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:true,
					enabletooltips:true,
					
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Cont No',datafield: 'contractdocno', width: '3%',cellclassname: cellclassname},
						{ text: 'Client',datafield: 'client', width: '10%',cellclassname: cellclassname},
    					{ text: 'Vendor',datafield: 'vendor', width: '10%',cellclassname: cellclassname},
    					{ text: 'Inv No',datafield: 'invno', width: '3%',cellclassname: cellclassname},
    					{ text: 'Inv Date',datafield: 'invdate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname}, 					
						{ text: 'Gate In-Pass',datafield: 'gatepassno', width: '5%',cellclassname: cellclassname},
						{ text: 'Amount',datafield: 'amount', width: '4%',cellsformat: 'd2',align:'right',cellsalign:'right',cellclassname: cellclassname},
    					{ text: 'VAT',datafield: 'vat', width: '3%',cellsformat: 'd2',align:'right',cellsalign:'right',cellclassname: cellclassname},
    					{ text: 'Net Amt',datafield: 'netamt', width: '4%',cellsformat: 'd2',align:'right',cellsalign:'right',cellclassname: cellclassname},
    					{ text: 'Fleet',datafield: 'fleet', width: '4%',cellclassname: cellclassname},
    					{ text: 'Driver',datafield: 'driver', width: '6%',cellclassname: cellclassname},
    					{ text: 'Date',datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
    					{ text: 'Time',datafield: 'time', width: '3%',cellsformat:'HH:mm',cellclassname: cellclassname},
    					{ text: 'Km',datafield: 'km', width: '3%',align:'right',cellsalign:'right',cellclassname: cellclassname},
    					{ text: 'Fuel',datafield: 'fuel', width: '3%',align:'right',cellsalign:'right',cellclassname: cellclassname},
						{ text: 'Address',datafield: 'address', width: '10%',cellclassname: cellclassname},
    					{ text: 'Remarks',datafield: 'remarks', cellclassname: cellclassname},
    					{ text: 'CPU Doc No.',datafield: 'cpudocno',hidden:type == "POST" ? false : true, width: '5%',cellclassname: cellclassname},
    					{ text: 'vndid',datafield: 'vndid', hidden:true, cellclassname: cellclassname},
						{ text: 'docno',datafield: 'docno', hidden:true, cellclassname: cellclassname},
						
    	              ]
                });

				$('#floorMgmtGrid').on('rowdoubleclick', function (event) 
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
				   
				    $('.textpanel p').text(' Inv No :'+$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'invno')+' , Vendor : '+$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'vendor'));
				    $('#docno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno'));
				    $('#cpudocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'cpudocno'));
					$('#date').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'date'));

				    $('#invno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'invno'));
				    $('#invdate').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'invdate'));
				    $('#gatepassno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'gatepassno'));
				   
				    var date = $("#date").val();
					
					$('#rowindex').val(boundIndex);
				  
				});
	});
</script>
<div id="floorMgmtGrid"></div>
<input type="hidden" id="rowindex" name="rowindex">
