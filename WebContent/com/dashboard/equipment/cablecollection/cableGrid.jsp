<%@page import="com.dashboard.equipment.cablecollection.*"%>
<%
ClsCableCollectionDAO dao=new ClsCableCollectionDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String collectstatus=request.getParameter("collectstatus")==null?"":request.getParameter("collectstatus");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var cabledata=[];
	
	if(id=='1'){
		cabledata='<%=dao.getCableData(branch,fromdate,todate,temp,collectstatus)%>';
   	}
   	
	/* var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
	} */
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'contractdocno',type:'number'},
                  		{name : 'contractvocno',type:'number'},
                  		{name : 'refname',type:'string'},
                  		{name : 'edate',type:'date'},
                  		{name : 'assetgrpcode',type:'string'},
                  		{name : 'assetgrpname',type:'string'},
                  		{name : 'assetgrpdocno',type:'number'},
                  		{name : 'qty',type:'number'},
                  		{name : 'cablerowno',type:'number'},
                  		{name : 'collectqty',type:'number'}
                  		],
				    localdata: cabledata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#cableGrid").on("bindingcomplete", function (event) {
    	
    	$("#overlay, #PleaseWait").hide();
    });        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#cableGrid").jqxGrid(
    {
        width: '99%',
        height: 535,
        columnsresize:true,
        source: dataAdapter,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       	enabletooltips:true,
       	showaggregates:true,
        showstatusbar:true,
       	sortable:true,
       	
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'Doc No',datafield:'contractvocno',width:'6%'},
       				{ text: 'Doc No',datafield:'contractdocno',width:'10%',hidden:true},
       				{ text: 'Issue Date',datafield:'edate',width:'10%',cellsformat:'dd.MM.yyyy hh:mm'},
       				{ text: 'Client',datafield:'refname',width:'28%'},
					{ text: 'Cable code',datafield:'assetgrpcode',width:'10%'},
       				{ text: 'Cable Name',datafield:'assetgrpname',width:'30%'},
       				{ text: 'Quantity',datafield:'qty',width:'6%',cellsformat:'d0'},
       				{ text: 'Collect.Qty',datafield:'collectqty',width:'6%',cellsformat:'d0'},
       				{ text: 'Cable Doc No',datafield:'cablerowno',width:'8%',cellsformat:'d0',hidden:true},
       				{ text: 'Asset Grp Doc No',datafield:'assetgrpdocno',width:'8%',cellsformat:'d0',hidden:true},
       				
					]

    });
    $('#cableGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
  	  $('#rowindex').val(rowindex1);
  	  $('.selected-contract').text($('#cableGrid').jqxGrid('getcellvalue', rowindex1, "contractvocno"));
  	  $('#cablename').val($('#cableGrid').jqxGrid('getcellvalue', rowindex1, "assetgrpname"));
  		$('#collectqty').val($('#cableGrid').jqxGrid('getcellvalue', rowindex1, "qty"));
      	/* document.getElementById("hidagmtno").value=$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updatecableGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="cableGrid"></div>
<input type="hidden" id="rowindex">