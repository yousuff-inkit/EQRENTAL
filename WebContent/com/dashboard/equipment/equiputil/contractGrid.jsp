<%@page import="com.dashboard.equipment.equiputil.*"%>
<%
ClsEquipUtilDAO dao=new ClsEquipUtilDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String grpby=request.getParameter("grpby")==null?"":request.getParameter("grpby");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var contractdata=[];
	
	if(id=='1'){
		contractdata='<%=dao.getUtilData(branch,date, temp,grpby)%>';
   	}
   	
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
	}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'fleet_no',type:'number'},
                  		{name : 'refname',type:'string'},
                  		{name : 'catid',type:'number'},
                  		{name : 'catname',type:'string'},
                  		{name : 'modelname',type:'string'},
                  		{name : 'total',type:'number'},
                  		{name : 'onhire',type:'number'},
                  		{name : 'ready',type:'number'},
                  		{name : 'offhire',type:'number'},
                  		{name : 'insp',type:'number'},
                  		{name : 'repair',type:'number'},
                  		{name : 'unavailable',type:'number'},
                  		{name : 'minrent',type:'number'},
                  		{name : 'fullrevenue',type:'number'},
                  		{name : 'currentrevenue',type:'number'}
                  		],
				    localdata: contractdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#contractGrid").on("bindingcomplete", function (event) {
    	var grpby='<%=request.getParameter("grpby")==null?"":request.getParameter("grpby")%>';
    	var columnname="";
    	if(grpby==""){
    		columnname="Model";
    	}
    	else if(grpby=="CAT"){
    		columnname="Category";
    	}
    	else if(grpby=="SUBCAT"){
    		columnname="Sub Category";
    	}
    	$('#contractGrid').jqxGrid('setcolumnproperty', 'refname', 'text',columnname);
    	$("#overlay, #PleaseWait").hide();
    });        
    
    

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
        height: 535,
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
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'Category',datafield:'refname',width:'16%'},
       				{ text: 'Total',datafield:'total',width:'6%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'On Hire',datafield:'onhire',width:'6%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'Ready',datafield:'ready',width:'6%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
					{ text: 'Off Hire',datafield:'offhire',width:'6%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'To Be Inspected',datafield:'insp',width:'8%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'Under Repair',datafield:'repair',width:'8%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'Total Unavailable',datafield:'unavailable',width:'8%',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'Util. on MVA',datafield:'utilmva',width:'8%',hidden:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
       				{ text: 'Minimum Rent',datafield:'minrent',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Revenue @100% Util.',datafield:'fullrevenue',width:'12%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Billing per current Util.',datafield:'currentrevenue',width:'12%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Total MVA',datafield:'totalmva',width:'8%',hidden:true}
       				
					]

    });
    $('#contractGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
  	  $('#rowindex').val(rowindex1);
      	/* document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="contractGrid"></div>
<input type="hidden" id="rowindex">