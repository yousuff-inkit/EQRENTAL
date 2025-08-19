<%@page import="com.dashboard.marketing.contractmgmt.ClsContractMgmtDAO"%>
<%ClsContractMgmtDAO DAO=new ClsContractMgmtDAO();
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var quotedata=[];
var id='<%=id%>';
if(id=="1"){
	quotedata='<%=DAO.getContractData(id,brhid,fromdate,todate)%>'
}	
	$(document).ready(function () {
    	// prepare the data
    	var source =
        {
        	datatype: "json",
            datafields: [
				{name : 'date', type: 'date'},
            	{name : 'voc_no' , type: 'number'},
            	{name : 'branchname' , type: 'string'},
				{name : 'reftype', type: 'string'},
				{name : 'refno', type: 'string'},
				{name : 'clientname', type: 'string'},
				{name : 'lpono', type: 'string'},
				{name : 'lpodate', type: 'date'},
				{name : 'description', type: 'string'},
				{name : 'salesman', type: 'string'},
				{name : 'totalamt', type: 'number'},
				{name : 'assetid', type: 'string'},
				{name : 'brhid', type: 'number'},
            	{name : 'doc_no' , type: 'number'},
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
		
        $("#contractMgmtGrid").on("bindingcomplete", function (event) {
        	$("#overlay, #PleaseWait").hide();
        });        
        
        
		$("#contractMgmtGrid").jqxGrid(
        {
        	width: '100%',
            height: 500,
            source: dataAdapter,
            columnsresize: true,
            editable: false,
            enabletooltips:true,
            filterable:true,
            showfilterrow:true,
            enabletooltips:true,
            selectionmode: 'singlerow',
            //pagermode: 'default',
                
            columns: [
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
				{ text: 'Doc No', datafield: 'voc_no', width: '5%'},
				{ text: 'Branch', datafield: 'branchname', width: '13%'},
				{ text: 'Date', datafield: 'date',cellsformat:'dd.MM.yyyy',width:'5%'},
				{ text: 'Ref Type',datafield:'reftype',width:'3%'},
				{ text: 'Ref No',datafield:'refno',width:'3%'},
				{ text: 'Client Name', datafield: 'clientname', width: '15%'},
				{ text: 'LPO No', datafield: 'lpono', width: '7%'},
				{ text: 'LPO Date', datafield: 'lpodate',cellsformat:'dd.MM.yyyy',width:'5%'},
				{ text: 'Description', datafield: 'description',width:'16%'},
				{ text: 'Salesman', datafield: 'salesman', width: '8%'},
				{ text: 'Asset Id', datafield: 'assetid', width: '10%'},
				{ text: 'Total Amount', datafield: 'totalamt', width: '6%',align:'right',cellsalign:'right',cellsformat:'d2'},
				{ text: 'brhid', datafield: 'brhid',hidden:true},
				{ text: 'doc_no', datafield: 'doc_no',hidden:true},
			]
        });
        
        $("#contractMgmtGrid").on("rowdoubleclick", function (event)
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
		    
		    
		    $('#docno').val($('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		    $('#vocno').val($('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'voc_no'));
		    $('#brhid').val($('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
		    
		    $('.textpanel p').text('Contract #'+$('#vocno').val());					
		    $('#contracttitle').html('Contract #'+$('#vocno').val());					
		    $('#lpono').val($('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'lpono'));
		    $('#lpodate').jqxDateTimeInput('setDate',$('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'lpodate'));
		    
		    var formattedDate = new Date($('#contractMgmtGrid').jqxGrid('getcellvalue',boundIndex,'date'));
		    var d = formattedDate.getDate();
		    var m =  formattedDate.getMonth();
		    m += 1;
		    var y = formattedDate.getFullYear();
		    var docdate=(d + "." + m + "." + y);
		    
		    getTaxper(docdate);
		    
		    $('#contractmgmtdetaildiv').load('contractMgmtDetailGrid.jsp?docno='+$('#docno').val()+'&id=1');
		});
        
	});
	
	function getTaxper(date){
		var x = new XMLHttpRequest();
	    x.onreadystatechange = function(){
		    if (x.readyState == 4 && x.status == 200) {
			    var items = x.responseText.trim();
			    $('#hidtaxperc').val(items);
		    }
	    }
	   x.open("GET", "getTaxper.jsp?date="+date, true);
	   x.send();
	}

</script>
<div id="contractMgmtGrid"></div>
<input type="hidden" name="gridindex" id="gridindex"> 
<input type="hidden" name="docno" id="docno">
<input type="hidden" name="vocno" id="vocno">
<input type="hidden" name="brhid" id="brhid">
<input type="hidden" id="hidtaxperc"/>