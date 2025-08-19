<%@page import="com.dashboard.equipment.equipurchaselist.*"%>
<%
ClsEquipurchaselistDAO dao=new ClsEquipurchaselistDAO();   
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var contractdata=[];
	
	if(id=='1'){
		contractdata='<%=dao.getUtilData(branch,fromdate, temp,todate)%>';
   	}
   	var curdesc = window.parent.curdec.value;
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
	}
	 var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
       }  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
        	           {name : 'voc_no',type:'string'},
	                   {name : 'date',type:'date'},
	                   {name : 'vendor',type:'string'},
       		           {name : 'purno',type:'string'},
				       {name : 'reftype',type:'string'},
				       {name : 'doc_no',type:'string'},
				       	{name : 'refvocno',type:'string'},
				       	{name : 'code',type:'string'},
				       	{name : 'rate',type:'number'},
				       	{name : 'nettotal',type:'number'},
				       	{name : 'desc1',type:'string'}
				      
                  		],
				    localdata: contractdata,
        
				   
    
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
    
    
    
    $("#contractGrid").jqxGrid(
    {
        width: '99%',
        height: 500,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       	enabletooltips:true,
       	showaggregates:true,
        showstatusbar:true,
       	sortable:false,
        columns: [
               
		        	  { text: 'SL#', sortable: false, filterable: false, editable: false,
		                 groupable: false, draggable: false, resizable: false,
		                 datafield: 'sl', columntype: 'number', width: '3%',
		                 cellsrenderer: function (row, column, value) {
		                     return "<div style='margin:4px;'>" + (value + 1) + "</div>";
		                 }  
		               },
		       	    { text: 'Date',datafield:'date',width:'8%',cellsformat:'dd.MM.yyyy'},
         			{ text: 'Doc No',datafield:'voc_no',width:'5%'},
         			{ text: 'Vendor',datafield:'vendor',width:'20%'},
         			{ text: 'Doc_No',datafield:'doc_no',width:'7%',hidden:true},
         			{ text: 'Invno',datafield:'purno',width:'10%'},
         			{ text: 'Ref Type',datafield:'reftype',width:'7%'},
         			{ text: 'Refno',datafield:'refvocno',width:'7%'},
         			{ text: 'Currency',datafield:'code',width:'6%'},
         			{ text: 'Rate',datafield:'rate',width:'7%',cellsalign:"right",align:"right",cellsformat:'d'+curdesc,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
         			{ text: 'Total',datafield:'nettotal',width:'10%',cellsalign:"right",align:"right",cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring },
         			{ text: 'Description',datafield:'desc1' }
         			
					]  

    });
    $("#overlay, #PleaseWait").hide();
    $('#contractGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
  	   var docno=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
  	   $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+docno);
      		});	 
    });
</script>
<div id="contractGrid"></div>
