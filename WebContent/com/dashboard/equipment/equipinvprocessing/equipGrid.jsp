<%@page import="com.dashboard.equipment.equipinvprocessing.*"%>
<%
ClsEquipInvProcessingDAO dao=new ClsEquipInvProcessingDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String periodupto=request.getParameter("periodupto")==null?"":request.getParameter("periodupto");
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var equipdata=[];
	
	if(id=='1'){
		equipdata='<%=dao.getEquipData(contractdocno, periodupto, brhid, temp)%>';  
   	}

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'fleet_no',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'displayinvdate',type:'date'},
                  		{name : 'invdate',type:'date'},
                  		{name : 'invtodate',type:'date'},
                  		{name : 'rate',type:'number'},
                  		{name : 'breakamt',type:'number'},
                  		{name : 'amount',type:'number'},
                  		{name : 'vatamt',type:'number'},
                  		{name : 'daysused',type:'number'},
                  		{name : 'netamount',type:'number'},
                  		{name : 'hiremode',type:'string'},
                  		{name : 'vatpercent',type:'number'},
                  		{name : 'calcdocno',type:'number'},
                  		{name : 'assetid',type:'String'}
                  		
                  		],
				    localdata: equipdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#equipGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#equipGrid").jqxGrid(
    {
        width: '99%',
        height: 200,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
       enabletooltips: true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'AssetId',datafield:'assetid',width:'8%'},
       				{ text: 'Equip No',datafield:'fleet_no',width:'6%'},
       				{ text: 'Equip Name',datafield:'flname'},
       				{ text: 'Inv.From Date',datafield:'invdate',width:'8%',cellsformat:'dd.MM.yyyy',hidden:true},
       				{ text: 'Inv.From Date',datafield:'displayinvdate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Inv.To Date',datafield:'invtodate',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Hire Mode',datafield:'hiremode',width:'8%'},
       				{ text: 'Days Used',datafield:'daysused',width:'6%'},
					{ text: 'Rate',datafield:'rate',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Break Amount',datafield:'breakamt',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Amount',datafield:'amount',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'VAT',datafield:'vatamt',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Net Amount',datafield:'netamount',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'VAT Percent',datafield:'vatpercent',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
       				{ text: 'Calc Doc No',datafield:'calcdocno',width:'8%',hidden:true},
					]

    });
	 $("#overlay, #PleaseWait").hide();

    $('#equipGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	/* document.getElementById("hidagmtno").value=$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateequipGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="equipGrid"></div>